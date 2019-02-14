Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84566222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/DYWxkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405103AbfBNCLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:11:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41714 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404075AbfBNCKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so5174329qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+x6L8QagNW3CuUu/ag15Af/EDUw9eLjI6Wngv/1/8I=;
        b=F/DYWxkh5h75uyvkL5ybYW1+nVHGm/FdHj6VpSwOWKUsc7xtH3gRIP+9XNtAFHwdV9
         tlF12ZIf1DoC8vUTfNIJ3t+DywksctRt2LuXqWoJTaOMfd1n4HKhKCvCh4acdEmgWnXX
         zjSyQiEt98ejoZUgSqBi8LqyjTjS0ZNcpDHmE8DsQCKn2ypMAfZI3OmUyfO5yqWWHlgO
         hIcScjt3Op+I4Jt83tDACO/ttjOzu7wRAu6ejH6xkC0HwHfrh+q+GwCIbJjNXEAPyBgm
         L+FlU2tUC2ycqkP21vMKLw1ffaA3TDPwsdDV5rkXhRtM8x+E6g2+oSE0RFvCgdC3Ig9b
         PMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+x6L8QagNW3CuUu/ag15Af/EDUw9eLjI6Wngv/1/8I=;
        b=UcYxwvCkyCP34/Z1M6/YTAoMaj11gQHI4vKPNi7E6AV9DEpokGlATOv/6zlrsGM5Si
         UxTBl5ihC7ccbW3oCOmBLIzHZWeb4ndcR0SElX6GWJMjK9R79V1h4W2aOKbSlwjfLcvZ
         naGrFwfGkmxqm6FZlAxF50d9WjHj8aOFgdRiFKtIfrrMGl56sEHPD7zSPn1JobLxvwik
         ysMLlSVodni/P7o+49hlud59Gf8yB5+QP0sEaei/Xted61jDHvaj048v6t95ZdYZog9J
         gW11NCHIcIxa3wfzg9uCcZ1myxi6Ndld3XEmNcE2qQhbxXvd1lWIapQhSv3Y0o/G8XIy
         BZ4A==
X-Gm-Message-State: AHQUAuYmZ4Hu8tUZQS/Z9e7saZG0yobMdjUUmH9MvOZZSfEhGXQVw9Vv
        O/HZisG8g3aoGwbMVcSx/gLoBg==
X-Google-Smtp-Source: AHgI3IaVL7hODMtb5WWTu/BbEVFFTfMJCNw9tclqL21xf+smHU/pGBosslZK402W3aslAbHVALQryA==
X-Received: by 2002:ac8:35a7:: with SMTP id k36mr1053958qtb.213.1550110239809;
        Wed, 13 Feb 2019 18:10:39 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:39 -0800 (PST)
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
Subject: [PATCH 4.14 V2 11/17] ARM: make lookup_processor_type() non-__init
Date:   Wed, 13 Feb 2019 21:10:16 -0500
Message-Id: <20190214021022.5313-12-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 899a42f836678a595f7d2bc36a5a0c2b03d08cbc upstream.

Move lookup_processor_type() out of the __init section so it is callable
from (eg) the secondary startup code during hotplug.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/head-common.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 8733012d231f..7e662bdd5cb3 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -122,6 +122,9 @@ __mmap_switched_data:
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
+	__FINIT
+	.text
+
 /*
  * This provides a C-API version of __lookup_processor_type
  */
@@ -133,9 +136,6 @@ ENTRY(lookup_processor_type)
 	ldmfd	sp!, {r4 - r6, r9, pc}
 ENDPROC(lookup_processor_type)
 
-	__FINIT
-	.text
-
 /*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses
-- 
2.17.1

