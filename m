Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59146C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139F82083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuhX6MOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139F82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbeKFVlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:41:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46824 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:41:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so6110460plz.13;
        Tue, 06 Nov 2018 04:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xoNe6h3XbwDscDo2pSXmXAxi2bIQjuDeRfR11yNYEfE=;
        b=iuhX6MOxMvKOYi3+UFkgh+/7ndB964ANW8431qZ0i4tb7hHEvCLkpKWuG58iA4TnSN
         oYoixd3fFxCxqW0nPL+dBPPihmdDypaK6fo8p9vLpza1a0Lg7UZs4DF0uSpg9BJROQdZ
         FQQnTOLjQa10g0M47YEzWeqAx6iOdUTCmUCExlkdJfUFXnHBvBRbULFveST33X+8FQcG
         MGes4/JTYrLzbvUD4SLFEsQfCsXrH4aLjEV6wOPiM/yGs+OVsCKbZZrJ8CdTfF4ADdb3
         y/W4Z++UCZcacoHzpmXLkUTBamEO9Gz7hoVeFoSmqb/o4IGYgYSHtTr8Q6ANgiamBniY
         0SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xoNe6h3XbwDscDo2pSXmXAxi2bIQjuDeRfR11yNYEfE=;
        b=rknMuVHgoEPoPiWXEBt1q/NdvXLjOz4/jhwlFfF1uQyoS3qRQInqroLZ3/ZCZMXF1l
         CdQ4JdDVGBtpznPhgQLO3cfaBWUFZBiw0RTCOkwwpbX61gN00K+x0tiyrrUaVJxLUiwc
         Wc4rTZ7rqNhf6VYiC8jFAJo3XgSKgRgKXq6rBFVMyFLJp+JLvQBY4JHNnfQ/1V0xQ/CA
         Jswz26/Fw+wjwL1WzRwdzpznXA+G9/TN67r8cjJbZS8qgvJGkGd1mcfeVMSEQo1tWHby
         hRTXR5fRE6VDCPL1USoDs5MUAPGY3pz4EAOIoxmI3JuWiisT3dL7b0ulJ/8WeWmNx3lR
         VhTg==
X-Gm-Message-State: AGRZ1gInKOClBY7poN8HOtlftse93tUd6JyH/irEY0eTdQFNstp7MTCc
        OLp2khf9If76LS5/IdFfWOE=
X-Google-Smtp-Source: AJdET5f5nUrF5sn/KZILW4tADHCWbMsfR+Lbf0Q7qva4od5wsPfo/2wSISmdFP3xRDLvo11lW6xzOQ==
X-Received: by 2002:a17:902:166:: with SMTP id 93-v6mr25684869plb.68.1541506579690;
        Tue, 06 Nov 2018 04:16:19 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.60.19])
        by smtp.gmail.com with ESMTPSA id s141-v6sm4513135pfc.63.2018.11.06.04.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 04:16:17 -0800 (PST)
Date:   Tue, 6 Nov 2018 17:46:14 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux@armlinux.org.uk
Cc:     jrdr.linux@gmail.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] arm/crypto/aes-ce-glue.c: Remove duplicate header
Message-ID: <20181106121614.GA1985@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asm/hwcap.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/arm/crypto/aes-ce-glue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
index d0a9cec73707..5affb8482379 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -10,7 +10,6 @@
 
 #include <asm/hwcap.h>
 #include <asm/neon.h>
-#include <asm/hwcap.h>
 #include <crypto/aes.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
-- 
2.17.1

