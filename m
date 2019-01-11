Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA02C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3B62146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547192779;
	bh=OQTtl5nBooU1fvICzXgQqo5OqARVAOrCAkQLoQ1IKdI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KTru6w0tCGyClKNmIyXckZGcLzwJWgdlz8QNcQvr7JDHleq9pfhzOi7cKcefjcFs+
	 hInHRZWjk0oahCXqJgI2IpV0STdCF3L6LwpfkQYEB6f3WVy5hmGxNK7VmLfaEyS1ni
	 uFkgiWIHaCKUJh0ku4k20MPzQbMCj2e7dN+NjA1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfAKHqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:46:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35645 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfAKHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:46:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so1378648wmt.0;
        Thu, 10 Jan 2019 23:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p7l960C6hgsMnp4ATmccsLtV2cK3xs6YZYI45kJUrsI=;
        b=nTfv9wSTJINAXQBJpD50fZyF/JF3pBleBT1SIrCk+RpdS4QLZ5bzOVcezwsh0OCElK
         K7N/8B0gFu1TQ+/XnFV+YYuaby9gVctHHaHQ7nm8ZkKfD+Lp4SmtO+bXgiFOxzMTaarq
         Pf4XJf7d/1D+TEvKU7qhOEm7hGAPVcnVVv+ULwiMSy6eenX1NjjlLezBSlbVgGbuUj6B
         tAatEa793vTJJbctp6ZlRJJyCw6WjPsb5h/zDZrNpYM0BPAfRVG0RiHt/bPlGkIY73Ny
         4/yW2J4veAbBUGdkHkIncVjVTUUZX7Md8P8EMy7gIxa36Kv6zpvbmh9+8FKz6iuqPKBT
         sYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=p7l960C6hgsMnp4ATmccsLtV2cK3xs6YZYI45kJUrsI=;
        b=qc5w20twUxqww2+2CUNt5y5KSRN2BMnXsfX0XF/GKl/vkfl5SAQvj/uIt4rdACsctt
         nd/OHJgYVH/OqTEegUzb+oc7OCtrz2yNdtEkBLaUMGMicjpiytrRQaUZZG19IUTisa+q
         Mm3txNhglHjCt6byYhhodt/mydGQI0szliuYz7DHcf0JUXYwDVvCivzk2yE7bPr2W4IV
         RFVQ5HX7V8dbhv41l8pjGBJOrxAiZu4UNVppFE5mbdTTr8gsP2zqY/VArjZzuuruhc19
         9kVwBeBXcoTCLdzK8xkEtdCRfhlcStZu136q4KfZcm64OuQV/tD/vb+gfIrHrVKENL4c
         N4Zg==
X-Gm-Message-State: AJcUukclPGndlIW5vE+Tx9mxufsp7uXbHJmjkfDA9HTTQUb6IC/v8wv+
        k06I7PlncVBurqZ3dpFYSg4=
X-Google-Smtp-Source: ALg8bN5jCeROQmjVI59GoGSO/33m9r4h1YQglilkyIoghm6qGmEaW2yyMpU2Lg7Onu9G8Kfp0wxMMg==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr1252361wma.9.1547192776832;
        Thu, 10 Jan 2019 23:46:16 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a17sm62770747wrs.58.2019.01.10.23.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 23:46:16 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:46:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fix
Message-ID: <20190111074614.GA68053@gmail.com>
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

   # HEAD: b12f5440d8ca02e8f9ab4f1461f9214295cc4f66 Merge branch 'linus' into efi/urgent, to resolve conflict

A single fix that adds an annotation to resolve a kmemleak false 
positive.

 Thanks,

	Ingo

------------------>
Qian Cai (1):
      efi: Let kmemleak ignore false positives


 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..7ac09dd8f268 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/kmemleak.h>
 
 #include <asm/early_ioremap.h>
 
@@ -1026,6 +1027,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	kmemleak_ignore(rsv);
+
 	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
