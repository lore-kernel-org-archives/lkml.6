Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D516214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9lO6X0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D516214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeIYOkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:40:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53863 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeIYOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:40:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so12410488wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFI8WECuN/ZFQdfkQ5lbyeNuTEikpxj/+7dDPBgcU2k=;
        b=Q9lO6X0dzah/DNAUgqdbR5rNBwqQ+3b3Xkge0tWXljJRxcHXMqGhr3NPdpqii7+kwm
         zGJVOvdeZoZz51awN8ajTFpXdud95rPhLXO0u6XHV1v4dtvnU53s2t/prgxnX9AXujvw
         CuVN2VgbtzrdnJM1l/k7pDFOjKUnzmAW08DyJ93/vO7b9wBrk0m4LTVA0seJ1P42Bt0y
         sD4VWrRJxDPaqaKc4/fIEICd+qTnxqLXUn4DnJV4L+2kPwmOuk0SMcnxiI4dzKshna+Z
         TCQhi8ibKGak1PdU6e4wr48LWTM+qIrMmKI5lzvdGlrvcZR2zm0+9zGzBzHU839TCwJa
         dYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFI8WECuN/ZFQdfkQ5lbyeNuTEikpxj/+7dDPBgcU2k=;
        b=N6MQjpjn2WFMFWjj82sC0BL0ydqUNF37B0o6icrqKHzvDkvFWDEjCMYi817jWCpxH1
         EVgKs9J8mFNKmCvpv3F/jVPfSeV598UZMbVQSeEQi9FfCsYTaDETR7sBaclLKvzveKRR
         MTAXCLGeWhzCmSJhFnwohcYg11JVLd6kuqUiJtMnmsEUXXjZCNY9zUrdyotKiHNmUzDD
         r6nCyyPW56SooWKLmQFB/NQXBdlVFd1+24goyplO2hImb/u2jevy3U4ru1MMlXLudCjh
         4IqGoBVLPeLoviV5sNmvzjrqvhNGZbRdffPnvsr3fy76j4t3pUeoJ2pZeNzaBCU/1+V+
         EoKw==
X-Gm-Message-State: ABuFfohn8NKuNhbfGAVouL6r6e80tGCoNVrVv3oabScWPPY/jVTREp1s
        mCihfc4gy9CR0gxRjR2F0jU=
X-Google-Smtp-Source: ACcGV61w9Jq+/h0YlWNZGYS9/XT5VJjY9EEjNHzuXK2QjLVODJ1lEtBH3wnZ8MCDlFNIDdtAs3N11Q==
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr1021616wmf.10.1537864452832;
        Tue, 25 Sep 2018 01:34:12 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 94-v6sm2115538wrc.10.2018.09.25.01.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:34:12 -0700 (PDT)
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
Date:   Tue, 25 Sep 2018 09:33:55 +0100
Message-Id: <20180925083401.22533-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924233426.32609-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
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

