Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81149222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INlw/sfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436741AbfBMVcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40472 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394804AbfBMVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so4455401qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5XtoX2htZ0Jn0tkRDWU+S8lIEuB+MnkGDKzlpE3hBEI=;
        b=INlw/sfdBet8zDSCENoUwjfxegtQlubL9UmVGQ07agMByfU1HAD3H6h9a1h2loynnp
         zBn7NmrS7lFmiBMIz9STmkRLR4t0EGPGbcfCvbTVmPSrCy2PkE7Z0HkU7OwuAuiOjR3M
         TKMa7VyyFbih1CnDzcjCy6tjIIoJ0owEjYB5s10dv8Di/0rRLxE3y6e9eDMS55JtKNmH
         yub/0NtCqNx75NQSD4oRmEx8hWU7+SaDO+e5P9hWDV4q76VDLGbxTISVejAenTSkwwYl
         t5Z8E35rqVaX7ETno347GhxF/MP/k3KiU2j22qhp/IRz8CY7HuxQgbG1BQxSxnFE+Gng
         kcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5XtoX2htZ0Jn0tkRDWU+S8lIEuB+MnkGDKzlpE3hBEI=;
        b=cFc93khfu/V6WGh9ZoFKIHfNWvrRYTiSSPc4U70rhoWnZ60idydf34GxZu5ihrECwn
         F2xChv3ANn53bZNiQ9unB3qRMovvr/6NXxPnZl8Waxvylp1Mq+HxW6q3tUS86yiQT5z2
         XWhEfr4usSl7Fs5HOK1xUDPGz6RuduT27t+wBxpKArI77yaEBnabIbe/FL8DodcDHOzP
         B4uFRh3EEsnvqFJlwer0ONLLUtGLPWmG3TYXoRJFMnIX60TXtN8vcdyWN1SC+uFw4q/M
         cukFpOJwhxO2q9x4WTEfsurMMInYVxviTtsVixuKdv2fxOgkMPR0t1SZJEbE070V4tro
         vlAA==
X-Gm-Message-State: AHQUAubI4Dq8nMd4L5tG6IAI5LE3JKQtlMYjNkGkRclpfh98sJKR+ik9
        I1JMY8ooNVHKEYUVOekKgTi/fg==
X-Google-Smtp-Source: AHgI3IaAByStjv6V8O35bZXVYKzOSf+ybqp0f4fOFSaCjYM8AkzPrVq89diPIrhoukHRBUh3IUknVw==
X-Received: by 2002:ac8:17e7:: with SMTP id r36mr249071qtk.104.1550093548757;
        Wed, 13 Feb 2019 13:32:28 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:28 -0800 (PST)
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
Subject: [PATCH 4.19 02/17] ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
Date:   Wed, 13 Feb 2019 16:32:08 -0500
Message-Id: <20190213213223.916-3-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
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
index 76fe75d36312..464393d241e1 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -77,8 +77,6 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
 		kframe->magic = IWMMXT_MAGIC;
 		kframe->size = IWMMXT_STORAGE_SIZE;
 		iwmmxt_task_copy(current_thread_info(), &kframe->storage);
-
-		err = __copy_to_user(frame, kframe, sizeof(*frame));
 	} else {
 		/*
 		 * For bug-compatibility with older kernels, some space
@@ -86,10 +84,14 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
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

