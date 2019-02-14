Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE87FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE412229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9Zyo6Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407336AbfBNOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:49 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:42625 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439321AbfBNOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:45 -0500
Received: by mail-qt1-f176.google.com with SMTP id b8so7058340qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jAX1WYClvTF68HOuBDHcjdNU9Y05TUeERF66yDaIHEY=;
        b=L9Zyo6Tbln45JAT9duHaa+RG+kna2YWVG18IgdQaCAkBuqKBSBxHfhQYFLpRMM8q1K
         vUa5hlIrngpOLZW+qnMs4VuoUfnCEsQ8QxTdLgJikfw0oKlPGC2wF7N9/vONBVBkHRI8
         PLv/3iQp2q0UUqgl74XpHUyWSiX7XrTCpx2A1g+oIOlkL5BsVShfZejJdh3E113twJaL
         OhOYZRHHWMvpr9PmmDc21N/5M4qbpSzIoNN7B+SPJDKXtYQdPKa0La9A/QihDG27PZRU
         /YtPIr/EcA97zw3ydKdalfgLpb3aR+9hGt9vP+ZVRlPS8dz0moSsZaR4qJHjdEPTh7zZ
         w3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jAX1WYClvTF68HOuBDHcjdNU9Y05TUeERF66yDaIHEY=;
        b=C9t4tiXqZojgk69IcqwnqcfofkKD0SyZ1PmTH9fguMdyWSZvtqeacsHLzHJrqF45yl
         72Sn0014qoNQ2LejwX8+GJOeVpw+CGl8KJvzHwCc0bBsm9tUrz+RhmGuTsyuTG19pA9/
         HiZmmPOD14cDy4ariNmgcnRYgxcq51sSGwuAe2iI8iCYdMKfwtp5g25PIEYukM6KYZH8
         yq7RoENTILjdxNc9B+NUEmUDU6D+Vw1GmpVl9MuT/TAcNScJHHl06Y+x9MpBD8PMhWog
         GVmRGC8y93YhEgYJj9ug/641xy6PV9U1C28MiQcLqW8RqpGZIAxWzmRz7vBUK7q5SbX6
         b9TQ==
X-Gm-Message-State: AHQUAuY/ULAX6CKYa9xv3ftvnzaYD7n+mES3VRXhsVejDz7Hd8Jp5USD
        S9X7i86dsfTN/5L8VEQM9VsY4SROwGA=
X-Google-Smtp-Source: AHgI3IZBiST25lvmOi9NkLs7JajuZ3z+j1YbEwfnS8qIJALn9pNb8XJFarQiroh+0yPSG0KDVtHeoQ==
X-Received: by 2002:a0c:d124:: with SMTP id a33mr3194125qvh.19.1550155783894;
        Thu, 14 Feb 2019 06:49:43 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:43 -0800 (PST)
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
Subject: [PATCH 4.9 08/16] ARM: 8797/1: spectre-v1.1: harden __copy_to_user
Date:   Thu, 14 Feb 2019 09:49:22 -0500
Message-Id: <20190214144930.27539-9-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit a1d09e074250fad24f1b993f327b18cc6812eb7a upstream.

Sanitize user pointer given to __copy_to_user, both for standard version
and memcopy version of the user accessor.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/lib/copy_to_user.S        | 6 +++++-
 arch/arm/lib/uaccess_with_memcpy.c | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index caf5019d8161..970abe521197 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -94,6 +94,11 @@
 
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
+#ifdef CONFIG_CPU_SPECTRE
+	get_thread_info r3
+	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	uaccess_mask_range_ptr r0, r2, r3, ip
+#endif
 
 #include "copy_template.S"
 
@@ -108,4 +113,3 @@ ENDPROC(__copy_to_user_std)
 	rsb	r0, r0, r2
 	copy_abort_end
 	.popsection
-
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 6bd1089b07e0..f598d792bace 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -152,7 +152,8 @@ arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 		n = __copy_to_user_std(to, from, n);
 		uaccess_restore(ua_flags);
 	} else {
-		n = __copy_to_user_memcpy(to, from, n);
+		n = __copy_to_user_memcpy(uaccess_mask_range_ptr(to, n),
+					  from, n);
 	}
 	return n;
 }
-- 
2.17.1

