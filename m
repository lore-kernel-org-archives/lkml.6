Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA401625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A714020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoPD5voJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A714020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeG3TUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:20:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36106 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3TUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:20:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so291884wmc.1;
        Mon, 30 Jul 2018 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c1m7245wVc6zS28x+yEXh1g0ncBYuj4jquQ2QzJUh+M=;
        b=eoPD5voJFO2j4Eb/yf4OX3ZAVMEQMwwUOx1AmdZfw3Jwf7C8QUrirj3BthtneWxRH/
         SrLXj9Cu2jLJhFKXwxwsNXkxOYXoHpN+tVwCLv6e85rw1OPsNV/fcWZtS7gqKs2DBvnI
         3NRMVFtXT4z+nir1syuNsLDIVj36bSXFLSw6qKt6G+r7lPswDEi55mM3JkePz1qRpDIC
         KXjNGV4fns16AuUffbKQFjPez5ZlEkZifUrvIrS4CZporViX2BO3PlVFj3GwMQzLcmVK
         CretHEBZFLCkSnb82OdtGOwUn8s8oUj9SyDrMtPSYLd9vORGzwBojTIHcU4KXuh/wq9h
         Aa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=c1m7245wVc6zS28x+yEXh1g0ncBYuj4jquQ2QzJUh+M=;
        b=FnV3d5bbmWSZ7SOSenPNXpLDjZdb/aUDl6rqRezQvwYxwB2NMAYiql8jelQoCXJeL3
         v19VR88FlcwmSB/dR0RlvuELVKikisG97fpfX0XS3psbK/f/xcx93KL6amXXKPR8n9MT
         b7Ks1tJegBW14+6/OXB4pZFsMd8J+F0jrR7kG/E5Av8Xouwj23YMR/xvZN5+5+abQeDn
         V0e4ZV0lqimLa8KPGdpPuFLANTBuFRsOzVsiA0TFS9O35K9S2ruQNhMYAWFj0RDYx6qZ
         POAe7+/R/2qQxm7P3c92f6ZIG8WQrb58SnajtunJ76CIe48BBwAqKnO642i/IsCLj+3b
         34yQ==
X-Gm-Message-State: AOUpUlFLnaoS6YuIK2doUGtGjstm/iCsFb/lnT2iWpWDiIa5c7EeldcC
        ve107MZ+psSfY8PdjDuYrxE=
X-Google-Smtp-Source: AAOMgpcY1ZFRCdzYbb/Zkb76hQzY0OUFvaWf9Od4IGZjyKhvjo/e+vWQ6wE0JjrjC9wZIS2u/Amq9g==
X-Received: by 2002:a1c:5f56:: with SMTP id t83-v6mr178354wmb.27.1532972687147;
        Mon, 30 Jul 2018 10:44:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t70-v6sm170396wmt.30.2018.07.30.10.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:44:46 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:44:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] EFI fix
Message-ID: <20180730174444.GA1285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 9b788f32bee6b0b293a4bdfca4ad4bb0206407fb x86/efi: Access EFI MMIO data as unencrypted when SEV is active

An UEFI variables fix for SEV guests.

 Thanks,

	Ingo

------------------>
Brijesh Singh (1):
      x86/efi: Access EFI MMIO data as unencrypted when SEV is active


 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77873ce700ae..5f2eb3231607 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active())
+	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
