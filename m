Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F805C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE31218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cqbnMi1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeLRSZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:25:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47722 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbeLRSZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:25:59 -0500
Received: from zn.tnic (p200300EC2BD1780024767CD486D27DCB.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:2476:7cd4:86d2:7dcb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BAAD1EC0B8E;
        Tue, 18 Dec 2018 19:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545157558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9I63SAo6y+881Ngerv21c3SchaSp+tkCpfE9R0acAII=;
        b=cqbnMi1MLkH9T0OJ0IZYnTXzjXv/GsZNuK71ucRPbbVYGnfjz5Z9a5G7ckUSCf38CeHMc/
        JIqNjxj9Z3B2f0UrLobYkzPmbw78oc28CKgcxx3GK832cvaj+jDN3Mf9lvRGssnPm+lbil
        yMKjs3QJVqyTQuiw/aKlVlxps7ku3QA=
Date:   Tue, 18 Dec 2018 19:25:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH] x86/mce: Restore MCE injector's module name
Message-ID: <20181218182546.GA21386@zn.tnic>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205165711.GA23186@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205165711.GA23186@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aaand one more fix ontop... Yeah, renames are nasty. :-\

---
From: Borislav Petkov <bp@suse.de>

It was mce-inject.ko but it turned into inject.ko since the containing
source file got renamed. Restore it.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 765759765ab7..9f020c994154 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -5,7 +5,9 @@ obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= intel.o
 obj-$(CONFIG_X86_MCE_AMD)	+= amd.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
-obj-$(CONFIG_X86_MCE_INJECT)	+= inject.o
+
+mce-inject-y			:= inject.o
+obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
 
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
 
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
