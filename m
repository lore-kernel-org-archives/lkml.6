Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B319020645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6tm8oYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B319020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeIYOks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:40:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33207 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeIYOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:40:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id f10-v6so1339791wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eeliq4KMWeAJl+kxPR9XD/o5gZyt72pWxg8IcQlJEZc=;
        b=I6tm8oYol8yAWLyjxvBzAmofymWyUf/xWf4XBFLtll3tW1sj/CPQum//gHaQ6Cj8fh
         H65BQaCFfVuw357XYvr7hRkSMUqwEXzDjWGeuI2HxRIiqWty7xYLFGth9A1roY7bEKtp
         +yzCICTKBnT1crfFw3L6cDMBiecKtECEJi4UoioPxSL+WGUywXGt7av/Kflya2sArTLa
         B8TCC9cKdPDQf4QZv3LQdidCKjA4X0JrlZyOrsc528d/Xk0ig+fDtbeDCUo4bGJZJM8k
         wJh+cXjo57jAHOMA88wqLMzjsp3h0kJKW+UbywSxU9qdzidecomhamB3o2pSxvODVen7
         OA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eeliq4KMWeAJl+kxPR9XD/o5gZyt72pWxg8IcQlJEZc=;
        b=USEG0nq63xWjPMYC/Kht83MPdon1B2GMqbU9z/sSd1KmQYzXc0toYd8JC/I7tsV297
         5YVHFz6KzdUlvwvw3pdayqF7RHtvwKUy/bIqgRnLhRUyzMI2CYpeec7BXxhrALrCwCzP
         Llxh/ZsyfJSyiVAG8P2U04WViFJ4AAvRFXR5ptlvcah17t7+ULhmGR08odjV5SjdW8ye
         g3VtA19XhHCt6lLdQm2q3WhBoximgZOWNMUi5TzzDTdG8teZkrtDw8Upr1GEgoaKXTJB
         P07hSg1xGXoR0el0TINzQk7Rt6Q+6bHRIFO93X0E5vc5hX4JlI3dLHFXZ6cUyPXreNiN
         A8kw==
X-Gm-Message-State: ABuFfoiAooQa11rYUrbrd1XIK8U6QfvRwY+BWsqNSDZdXQyElB9oYcwj
        9foSMGzXyjwNbjTlrBI70ys=
X-Google-Smtp-Source: ACcGV606c7ON5+HzyNzI+t8C8TcAcutzaYkIcvGCKyV120t7ACQ1/LZO2U5YsD3So/mFCiECgoOehA==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr1926992wrh.223.1537864459747;
        Tue, 25 Sep 2018 01:34:19 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 94-v6sm2115538wrc.10.2018.09.25.01.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:34:19 -0700 (PDT)
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
Subject: [PATCH v3 1/2] staging: bcm2835-camera: Update TODO
Date:   Tue, 25 Sep 2018 09:33:59 +0100
Message-Id: <20180925083401.22533-5-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the TODO item to remove manual cache flushing from bulk_receive.
This was previously done in this commit:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/TODO | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index cefce72d814f..6c2b4ffe4996 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
 hardware can do.  If we exposed the native padding requirements
 through the V4L2 "multiplanar" formats, the firmware would have one
 less copy it needed to do.
-
-3) Port to ARM64
-
-The bulk_receive() does some manual cache flushing that are 32-bit ARM
-only, which we should convert to proper cross-platform APIs.
-
-- 
2.17.1

