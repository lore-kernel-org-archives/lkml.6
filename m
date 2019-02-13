Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F720C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC76206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9Zi0TCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394878AbfBMVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41037 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436770AbfBMVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so4454953qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4sXTOX89oZ7Fok9OP8IOaBv7K1P43zOxOdwYTTyDzQ=;
        b=W9Zi0TCqR6GLe4u8bTBpGiG8zPTKlOJFU2ckqpfe2s80+2qTWssivV7jHs/ek8sdWO
         rgOvAd6BnlEO0c2l2e/WuwYC2mgjeu2vOOjfvrX3XKnr/PQqQpLYIy5bTrkYZQZJjuy5
         F8vWjPLmbQcJ4fJMDW054jEFOmnnUCvtkHxGNpBg7Xv5d/3bphiKUfGAuKXDxyH7lzg7
         yPHwOdtYmr1CR5lC/R1Jn0Er5t123dslHD1Ve8cuu3zzNxV9+YmHWjjLXmWaLzqWhMne
         /eixw3XbFLElxMoj1TsKUCIshZ8Pvsa8/FhQngugpw+WiP04ZJY+4HGq7ZsmStNgSP1D
         jL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4sXTOX89oZ7Fok9OP8IOaBv7K1P43zOxOdwYTTyDzQ=;
        b=NRrXpNqzZSWPTx7sTIMLkDRrm+R3Aet8dLw14jOU6MRSAipF7i7qoDXFe/Z+TnKJlH
         EWzacFFP3ivkuzDQaBXprn7bmb/fH8Z8424LCaLdlCJhpfbCEqGM3If5Y9JDOeFflPWC
         B7x3LSDVRh1biV+yw9Sifpnq4Kfse7cVXKWsbWlnhq5646pqzR09W989AuYSjTT5zRdZ
         3yDsJ6ogrt18nZ5ydoLo9Pq6ec3LM9PqkAlmDACkEQFalU1tbJxcTY53tNzzibAeFR8D
         yM+TGFu4HTR3/wrxg4z60d04DazQNbb1f64Tevx/aUfagf3wK9UOayZEAnQ8PuVop2xB
         8HDg==
X-Gm-Message-State: AHQUAuapP2KzBsuPmi67zthMx/VEJZA9t1N9djdPz55+utjmICm8/GXr
        Yqo2jiPE8i9iCodlrzqTm7MVyg==
X-Google-Smtp-Source: AHgI3IYAYr9H/+6fuvWVvrJy3jCzz+p2QCsgMb5HgCJHrylCwxqNm8L5th6PKwuKYz/9Joo/5gsZJQ==
X-Received: by 2002:a0c:e486:: with SMTP id n6mr237775qvl.210.1550093559547;
        Wed, 13 Feb 2019 13:32:39 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:38 -0800 (PST)
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
Subject: [PATCH 4.19 10/17] ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
Date:   Wed, 13 Feb 2019 16:32:16 -0500
Message-Id: <20190213213223.916-11-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
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
index 2b287d0d6bc2..66c5e693428a 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -578,7 +578,7 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
 	 */
 	ufp_exc->fpexc = hwstate->fpexc;
 	ufp_exc->fpinst = hwstate->fpinst;
-	ufp_exc->fpinst2 = ufp_exc->fpinst2;
+	ufp_exc->fpinst2 = hwstate->fpinst2;
 
 	/* Ensure that VFP is disabled. */
 	vfp_flush_hwstate(thread);
-- 
2.17.1

