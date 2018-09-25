Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471AAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89ED20645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fni5/dlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89ED20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeIYOlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:41:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52640 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIYOkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:40:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id l7-v6so7600482wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFI8WECuN/ZFQdfkQ5lbyeNuTEikpxj/+7dDPBgcU2k=;
        b=fni5/dlmdPBUqW0BCWuqyH1vGzQ2RG3Lybj6v0yZoimi7jcO/ZoR65ReAjUSU0xljE
         +afDm/YNiRoPoGjgOLOFu02Ur1oWvEmgOYQqITQPS2ahnzxnI9HOnMUWLuvPbqKWmqXy
         0uwuLLVS22ITWIJJN72sgJ8CkN0cGo6HWvmywDOkqUtlo2ASzSxSn2gJ0KTW65lYmeXK
         512rWt8HmbH0PPyVGf6sLogVanF82hAfMkNoVa5sL3fqKJ1Ltit/t86F/eVvdTqgSNzB
         W2Btknw2RQROKPCAiamqg2dSQ2/8Oj2gsYrwP2Qzy6fFL9RBOHDYACfinpTXutSIgo8Q
         T5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFI8WECuN/ZFQdfkQ5lbyeNuTEikpxj/+7dDPBgcU2k=;
        b=kAocnZyX9hQOspgWszS6ZRbjP7W+ncX66mLU5Ll0sgVfZr3z0KOngGiseJZnPBAwGG
         dDgzPM2P+ATU/6tuJ14EIAeh+VA+eX6qWtJthhts9t4frKEo95Y5cDkKgfZJdOE5afQO
         kKFmp5OmHzVWaA7Zjixdy62NglAnxr880vM5gzDrBLUgWlTUyVgAF2NRLcfARe3Vn2ql
         zOnDEM09R7KvCZ27GeXrb0ZtOu66dmOqmlAyx+fdrzAY8kFnG6JCHFgmo7pTMFTOyeu/
         ZWsVGLsX3bp2bj78lz7sDzZAdAkgipbc8sIRjfVqh+a5IBZ334E8PIhA1GNjnr1HaPSZ
         4bcA==
X-Gm-Message-State: ABuFfoj7WIM9UoQ+Wp5Wsl4pmVrC09h/vpDQrH585idf+pZsXBkPEixB
        KoWoCbga1EqVBqRxtJE6QO8=
X-Google-Smtp-Source: ACcGV61DRbKaCFd/fOaEpfdvCs4pG+/3RhZ06w4rTalC2GW24RVZMJ0r4GkxYAeBuut7fY7RxqdrJw==
X-Received: by 2002:a1c:8942:: with SMTP id l63-v6mr1050194wmd.66.1537864458576;
        Tue, 25 Sep 2018 01:34:18 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 94-v6sm2115538wrc.10.2018.09.25.01.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:34:17 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] staging: bcm2835-camera: Clean up completed TODO
Date:   Tue, 25 Sep 2018 09:33:58 +0100
Message-Id: <20180925083401.22533-4-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bcm2835-camera driver to remove a TODO and an unused header
include. These were made unnecessary in

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Aymen Qader (2):
  staging: bcm2835-camera: Update TODO
  staging: bcm2835-camera: Remove unused header

--
v2: Make commit message clearer
v3: Separate patch into two, clean up commit messages

 drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
 2 files changed, 7 deletions(-)

-- 
2.17.1

