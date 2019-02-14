Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69438C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390CC21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zqofi2n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393926AbfBNCKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41697 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393875AbfBNCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id v10so5173925qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZaysvDZX4O/Bu8vrQvGUNcMZ0ecXD4hClmIQ5jet3M=;
        b=Zqofi2n+I6J25lcFxoU+utTxRN1+3tt6/q5AcD0yTqerFBelxOHNXClBDeDPFWesXN
         z1ejzTUM6KvhBdEgQBM/Y3HXY1BUgvNsqVlKmBYZaOS1N+ZbgNRFMatZ0Ah3lbQsQOul
         Mjo3+wBFgSwGNAzieoKIBXFrTDhNLwQ8Qd0v5L5mWi8mciy4JSUx1i0QDn5FGnJCc2nk
         vNv4Rr6Wf2InTUsczrWWDYcsBGTfyv2ZqxNm17xA4oJkeDx+8MQI4fkDafmDpQFCJU36
         acaaGvZWly6x4cTB+4+Ro7DusNFpyg1CTEU/MIfvOUcLlMEoUOM3QXn5GCTlQlGfvQkb
         egVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZaysvDZX4O/Bu8vrQvGUNcMZ0ecXD4hClmIQ5jet3M=;
        b=p7Dzl0Uj1txwNDW6V3yWd21YsfihzY7TJXNwgQWM2rFUOx7Ee5gn1+YE9PmuTn8qq4
         ULAZd1KBrwm3DnEbdj8UTk9TkbFmZwszSzH2sOiryCT1DFlGmZ/mr+7RY7LTU6frEGnb
         bAgKjndKg4T8bxbWzCUzy9hwqZlp0PXd2d3/Tcnrvabdn1kVBIkiz5dRw9u0uSxk9JOY
         rfHU8nVmSNkdh6U9NW2LcsCbNhtNChS8E4slttE9TGaFKDIRzNAMlGKqcvbDUjrEklCe
         hEczuTPO8AmP6GlEB1jKCP8yTd8UEclF6L51hws+kUffkVHC//0V2J9wBgK/aFd3Gd+T
         qgAA==
X-Gm-Message-State: AHQUAuYZjv/mCjoigqCr5XKwUYfYJPxLFW2h8Tu9PMI9JH1Jp5pGgsqH
        SrSqVtfOzum7m5HsGuUiyaQirw==
X-Google-Smtp-Source: AHgI3IZiSsetuliD1FYf/uzQZwhkfFxbABKBD2LRuA0i/09q02mdj1Hkf3uWB6pr8CJikGqsfr6JJg==
X-Received: by 2002:aed:3ef7:: with SMTP id o52mr1079347qtf.276.1550110227507;
        Wed, 13 Feb 2019 18:10:27 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:26 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 V2 02/17] ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
Date:   Wed, 13 Feb 2019 21:10:07 -0500
Message-Id: <20190214021022.5313-3-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 73839798af7ebc6c8d0c9271ebbbc148700e521f upstream.

When setting a dummy iwmmxt context, create a local instance and
use __copy_to_user both cases whether iwmmxt is being used or not.
This has the benefit of disabling/enabling PAN once for the whole copy
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/signal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 1dc1f39825b6..b12499cc3582 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -76,8 +76,6 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		kframe->magic = IWMMXT_MAGIC;
 		kframe->size = IWMMXT_STORAGE_SIZE;
 		iwmmxt_task_copy(current_thread_info(), &kframe->storage);
-
-		err = __copy_to_user(frame, kframe, sizeof(*frame));
 	} else {
 		/*
 		 * For bug-compatibility with older kernels, some space
@@ -85,10 +83,14 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		 * Set the magic and size appropriately so that properly
 		 * written userspace can skip it reliably:
 		 */
-		__put_user_error(DUMMY_MAGIC, &frame->magic, err);
-		__put_user_error(IWMMXT_STORAGE_SIZE, &frame->size, err);
+		*kframe = (struct iwmmxt_sigframe) {
+			.magic = DUMMY_MAGIC,
+			.size  = IWMMXT_STORAGE_SIZE,
+		};
 	}
 
+	err = __copy_to_user(frame, kframe, sizeof(*kframe));
+
 	return err;
 }
 
-- 
2.17.1

