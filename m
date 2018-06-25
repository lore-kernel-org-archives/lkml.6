Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E82C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A51925856
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JEmQiJHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A51925856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeFYLuq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:50:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38274 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbeFYLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:50:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id d10-v6so6691156plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r9uFgOoSFe1rF1sWs8l66+cmQxej+n2GzL4GYgUszs0=;
        b=JEmQiJHAIJgIaUWvGFXkk25IAqeuRnizkMrRAbMCoY8YMBKsknxus+/Q2M2vyKkT6a
         CnvqoFzaFQmneJsD4t2flIZMEv2NBjxPkzGnnwudHYD2IdvteGtE9CLo3mZYRwyhqzej
         OWoetUD2ypUo9KbJzxdU2PoOYtQTDhD9z5/tG/TI4qG9okEeqTqty+da0a7aPnjdY9HL
         muOtR9tq01g6rbTcz42DGZl460txwrMrgCpdWKX8VB4WLfY/HdVns6BMp7X647c+5mr4
         eq9g+ulX4nNVoDFqLMEQkawHbwDKHZhjpCf09NAZn6MIPV9e0bb52/JGtTb6dsJQ/5XY
         uwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9uFgOoSFe1rF1sWs8l66+cmQxej+n2GzL4GYgUszs0=;
        b=GeUiWbgI5sKAKAxahLHRKqS5lqiJbzAxmzwhDRb6OAF+Gv1K44WG9uCJuv8s9iYfNh
         zCc3tBx1wHKMJRXiiZDWbei+lk4BN+u2fOx5F9ZsvWx/UHbus9iO7pXbM/ln4SVqjvFl
         MYrs1cAkE5SOJsyBkdXnWkmdMp2KXNLbIlD3NQyuotr/17/6DTcJa1bRlNtXTmVJezBy
         WOJMlv1y7r63FonOqocUCz6y8LnDkt3vnwsjWNWLR912JsLLexIlK4s5E7f7jV0qQwL9
         vAokQDicLQ4u4Ji4CUimbVIX+tvDJbJjb/3UvWgEQwWbV/iZZkdHpH4lKAZb67OVLlu+
         tcdg==
X-Gm-Message-State: APt69E1AOi+gzZ+c13M20krx33FIs8ouKizX+cPRTEEUEnCoRLztyAk9
        ACcFt9nG1t/kBJyyeZm/SGKTEg==
X-Google-Smtp-Source: ADUXVKL+BgBQz1dzASBUnGzde2HH28R+WC+C4/8KdQ8zBaVm3Psa1ZQj2X6TPFGowj/UP6WAo24RIA==
X-Received: by 2002:a17:902:b216:: with SMTP id t22-v6mr12240377plr.199.1529927443883;
        Mon, 25 Jun 2018 04:50:43 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id d23-v6sm35871274pfe.2.2018.06.25.04.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 04:50:43 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A6D3530000F; Mon, 25 Jun 2018 14:50:38 +0300 (+03)
Date:   Mon, 25 Jun 2018 14:50:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] x86/mm: don't free p4d table when it is folded at
 runtime.
Message-ID: <20180625115038.6jezjq3wjqesrl6j@kshutemo-mobl1>
References: <20180625102427.15015-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625102427.15015-1-aryabinin@virtuozzo.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 01:24:27PM +0300, Andrey Ryabinin wrote:
> When the p4d page table layer is folded at runtime, the p4d_free()
> should do nothing, the same as in <asm-generic/pgtable-nop4d.h>.
> 
> It seems this bug should cause double-free in efi_call_phys_epilog(),
> but I don't know how to trigger that code path, so I can't confirm that
> by testing.

+ Baoquan, Matt.

There's other bug in the efi_call_phys_epilog() that prevents the bug from
being triggered.

With the patch below. You can trigger the bug with efi=old_map in kernel
command line + KALSR and CONFIG_X86_5LEVEL=y:

	page:fffff6bec0000000 count:0 mapcount:1 mapping:0000000000000000 index:0x0
	flags: 0x800(reserved)
	raw: 0000000000000800 fffff6bec0000008 fffff6bec0000008 0000000000000000
	raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
	page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
	------------[ cut here ]------------
	kernel BUG at /home/kas/linux/la57/include/linux/mm.h:499!
	invalid opcode: 0000 [#1] PREEMPT SMP
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc2-00037-g6f0d349d922b-dirty #58
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
	RIP: 0010:__free_pages+0x28/0x30
	Code: 00 00 8b 47 34 85 c0 74 15 f0 ff 4f 34 75 09 85 f6 74 06 e9 ca d8 ff ff c3 e9 64 ff ff ff 48
	RSP: 0000:ffffffff9a403e90 EFLAGS: 00000246
	RAX: 000000000000003e RBX: ffffffff9a41d000 RCX: 0000000000000002
	RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000ffffffff
	RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff9092af089000
	R13: ffffffff9a598a80 R14: 0000000000000001 R15: 0000000000000001
	FS:  0000000000000000(0000) GS:ffff9092bfc00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ffff9092bffff000 CR3: 0000000198e1d000 CR4: 00000000000006b0
	Call Trace:
	 efi_call_phys_epilog+0x17d/0x1bb
	 efi_enter_virtual_mode+0x457/0x4ca
	 start_kernel+0x443/0x4dc
	 secondary_startup_64+0xb7/0xc0
	Modules linked in:
	---[ end trace 61e271260b11acdd ]---

I'll send patch for efi_call_phys_epilog().

> 
> Fixes: 98219dda2ab5 ("x86/mm: Fold p4d page table layer at runtime")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org # 4.17

> ---
>  arch/x86/include/asm/pgalloc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
> index ada6410fd2ec..fbd578daa66e 100644
> --- a/arch/x86/include/asm/pgalloc.h
> +++ b/arch/x86/include/asm/pgalloc.h
> @@ -184,6 +184,9 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
>  
>  static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  {
> +	if (!pgtable_l5_enabled())
> +		return;
> +
>  	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
>  	free_page((unsigned long)p4d);
>  }

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e01f7ceb9e7a..77873ce700ae 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -166,14 +166,14 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
                pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
                set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);

-               if (!(pgd_val(*pgd) & _PAGE_PRESENT))
+               if (!pgd_present(*pgd))
                        continue;

                for (i = 0; i < PTRS_PER_P4D; i++) {
                        p4d = p4d_offset(pgd,
                                         pgd_idx * PGDIR_SIZE + i * P4D_SIZE);

-                       if (!(p4d_val(*p4d) & _PAGE_PRESENT))
+                       if (!p4d_present(*p4d))
                                continue;

                        pud = (pud_t *)p4d_page_vaddr(*p4d);
-- 
 Kirill A. Shutemov
