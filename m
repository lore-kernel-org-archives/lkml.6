Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF81C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1C92229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dh8U3TBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbfBNOuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:35 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45394 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439329AbfBNOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so7052715qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+x6L8QagNW3CuUu/ag15Af/EDUw9eLjI6Wngv/1/8I=;
        b=dh8U3TBwa38qeMRCMFTA1fUE5EDhj2RU58iy0u72q2fpD7O7mLoTkPzIrhtqN37929
         6a6Cm+iL5S93vb0oLM38HX6kVjNOvkoUGMqaZtB/Y/HTUcfWPpupzTxEhA/WviL7bk+1
         kTjIhuJ3IRheJJpvOnwAno/sTDLlnZHgZ62SAdVl/kgfZWVzchOX1krmLFkNCxSlA8eD
         oSHZmRg5ObAr0TpeM+fNdhN/DSI1M60JZzptaw+FcfgXbfrNb1kl80guxgNPRk/MRQYo
         qWRRoTk3stRoFDS1rrrzYrfmdRIj9OEDropr0nRDh6k2oU8Qox+6y9SiWCG8/Ab2OTTw
         vxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+x6L8QagNW3CuUu/ag15Af/EDUw9eLjI6Wngv/1/8I=;
        b=cpHvA/HTCNWf58otsWCRX8yTLw+81AAuYOvr7l/x9ni9rgpQpoibLYpqi0kqEyercl
         T5TdZPcZDSz05//C33ORIsTOVs9YL6vFqoA+H693oSKvEmLUr8hBK73Gu/bO8xELKuPm
         ZL8zUoQZg2ebVxfTEcJW0XlxyUm4F4ca7AakIXsIH7lWbekPbVMWIbp6Dv9RGqqbe0Co
         RSQV/wH/pDCtXBRd7Ahen2sL1sEy4tzch63innnM2fI76J80RxpURwjXHDHYW/wEOpdZ
         hOwk8m/l8YrzP6kRIteglpYsgWTj0KTKDb7OVGBiy2rLPwnhR05/qduEY8pYqDRnce5t
         PNYw==
X-Gm-Message-State: AHQUAuYmkCGQwvsksxdsg2c2MTKYVOTeCL4zppLcPpLNUWzAIsPHTAHZ
        uXAfqfAD8gbcWMpSqMRx3ks1ww==
X-Google-Smtp-Source: AHgI3IYcG97BfMxpNuc4KngAngOmKS4qSzW8ZYnZOTNl5EQYIZJraMkm8t+KiQ4aSY8epygCim8lKg==
X-Received: by 2002:ac8:162b:: with SMTP id p40mr3259244qtj.326.1550155786555;
        Thu, 14 Feb 2019 06:49:46 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:45 -0800 (PST)
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
Subject: [PATCH 4.9 10/16] ARM: make lookup_processor_type() non-__init
Date:   Thu, 14 Feb 2019 09:49:24 -0500
Message-Id: <20190214144930.27539-11-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
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

