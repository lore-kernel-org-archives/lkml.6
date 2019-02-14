Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D5AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0252229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJpr5xvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407323AbfBNOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46119 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439324AbfBNOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so7026983qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Al89NpupvfZvzBikplZ0PcauK1wQlzW/uE8qgbOT/SY=;
        b=pJpr5xvtUAjUJWpURhnPcWNTSV61J+pt4ZvWEWqt2dhyoDdRLyOfpnydSu3hiyOE4t
         byJLhaumPjfJZC/mz+3u+af6gynVCSCLBoeNPkZLsUCQpBl1HmhbBRQ79L0ALWEyw1Mc
         /kftsyY+4LQCpggccbtPJ/vAC4RW+LLEaZvQe1dEvw4CMiCPF+kcHhBPmQI3U2TiyNgT
         f7hkeGPUhCKhGWdrMZCkoqi0e7anvPePWhQJp2F16K4MVLOrZZnaIUDpqat8Ja8aflGh
         8pa/7zlxlNjE+y/krS/ASmgb9chS0t4t52/6bUvhkMz/nN2zr5WQanfcCeq5myKYCKCa
         AWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Al89NpupvfZvzBikplZ0PcauK1wQlzW/uE8qgbOT/SY=;
        b=ZAHAefWlhDRxrjmuiXzWsO57BkkTpZ7BXrQmpuQR8GtYrZgG/2UyGsMtu6QcUSkrkH
         53KrQcrq/a3DiAF8HFWBUKF+Lo7+tMafbsdHpFOTAWj9OXnjT385ZvZHKHeBzOCNJu7n
         m49baTZsBq7uu+ltT03lDubFn25CcJa1Xc1JsxcGQplgDE3w6m6ze1XjDun8BbIh1mR2
         nB9CCoQu359Uu+DZIrYWD7KXxF0RARubZV7ooOKHavlvClnc1iZiEgoaADvhzb75x8BR
         zjjaHeWFyZf6tv+GdvPshpnhuSKaEAzp7+xBvHX42iEu8yXJDFrwEwCqKBEBUzwLwKBr
         9meA==
X-Gm-Message-State: AHQUAuYh1UtTRp6511gh2P/IUiiuJa0on5Ha0hT8S7gI5TA0W2vrAQ02
        I50eOoXFFU0iVAr/Ty11TXaDRQ==
X-Google-Smtp-Source: AHgI3IY6xdj32cNiqp1cqU8Z6po4iX/FAASpw8YLC1v6uJLVWZOQ1fH4NVxIE5gQXqiqY6Tq4n5zGg==
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr3172793qve.246.1550155785194;
        Thu, 14 Feb 2019 06:49:45 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:44 -0800 (PST)
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
Subject: [PATCH 4.9 09/16] ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
Date:   Thu, 14 Feb 2019 09:49:23 -0500
Message-Id: <20190214144930.27539-10-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 5df7a99bdd0de4a0480320264c44c04543c29d5a upstream.

In vfp_preserve_user_clear_hwstate, ufp_exc->fpinst2 gets assigned to
itself. It should actually be hwstate->fpinst2 that gets assigned to the
ufp_exc field.

Fixes commit 3aa2df6ec2ca6bc143a65351cca4266d03a8bc41 ("ARM: 8791/1:
vfp: use __copy_to_user() when saving VFP state").

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index df3fa52c0aa3..00dd8cf36632 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -579,7 +579,7 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
 	 */
 	ufp_exc->fpexc = hwstate->fpexc;
 	ufp_exc->fpinst = hwstate->fpinst;
-	ufp_exc->fpinst2 = ufp_exc->fpinst2;
+	ufp_exc->fpinst2 = hwstate->fpinst2;
 
 	/* Ensure that VFP is disabled. */
 	vfp_flush_hwstate(thread);
-- 
2.17.1

