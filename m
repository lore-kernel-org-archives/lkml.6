Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F09C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E6520875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL4E2Y2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E6520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeFUCvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:51:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45573 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbeFUCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:51:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so692682pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbZ4iG8NrUveF14o3ldVqKVNDeoM3gpFyZrvnVrJiZM=;
        b=qL4E2Y2N3TpN2LhuhYuZIkZBt2kfrpP6l3bb/EO0W0fBmwfike+QmyESPA/1s+C17d
         CQNZDkUjK5Ml6zMPrKimOJsot4F2olSRBRGoN/Z1REE+ya9h0xBXgQcz+lkV2e1ItX10
         9pxk3Tm77nCUznB/jmiCW26BU5SQJMuU5Dn54HE5npBS6/S82kCOJZX1mr6+Csfuul4A
         ZA/7RnL6F5fti77S6BIeJZiXQhrlfNHN0jg5zY6UXKkIx6tLlp69emUvRcnsYXYUGjwf
         SO9kAvm63VIfINANBaplArpOZQUgQb2RFlvvV/oMJO67+t+0sryjESi8EyDY/kTzIrt4
         jy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZbZ4iG8NrUveF14o3ldVqKVNDeoM3gpFyZrvnVrJiZM=;
        b=NLDCMq1eiQc6MY0ZjY03GsvqjUcsMnD9KXzsvhIJWEfnSTv+SSVQP5Mh2Tn2uYLsGN
         R6UBS01ar8fM1yCUBDOhxh2/GkTW+UvpnIAMHkqvGbgCmwwvpOPnv0/X8I7j06CO7y1B
         B6OK1c5uyz65Lj2FbtNXOD7Rw2MI+/gfgqPVSNruT4b8KDBFQmECXMcnwlIM3hJz+SGw
         WOnbOB0+UyS66ozEQ0f3j+4gMjAvo9lS64C95jzDyABfyALzxMszCDB8WvS+fRnWLRGC
         L4g0u3+wgal0XZA07wAmqdIy2qcR999yqhs1Pp8BP9RHiWtguZZaAtnCODxafFpB3xbF
         VSKg==
X-Gm-Message-State: APt69E2cJ9a4z+7H8xQqoFBfZIaok29DhweOo1UUpEEyvjytCoqH+Xht
        M/B580cVE90uInXHvarA6f5rHA==
X-Google-Smtp-Source: ADUXVKKdwy0AiWNIcBrzocEST8Zf4rCHq6G7j8oXM2BVvKDLxaET7QlCAQC046DME8JbLl7JjWj9ww==
X-Received: by 2002:a65:5c84:: with SMTP id a4-v6mr681101pgt.431.1529549511016;
        Wed, 20 Jun 2018 19:51:51 -0700 (PDT)
Received: from toy ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id z28-v6sm6814362pfl.169.2018.06.20.19.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 19:51:50 -0700 (PDT)
Date:   Thu, 21 Jun 2018 10:51:41 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/1] arm64/mm: move
 {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata section
Message-ID: <20180621025141.GB11276@toy>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180620085755.20045-1-yaojun8558363@gmail.com>
 <20180620085755.20045-2-yaojun8558363@gmail.com>
 <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Jun 20, 2018 at 12:09:49PM +0200, Ard Biesheuvel wrote:
> On 20 June 2018 at 10:57, Jun Yao <yaojun8558363@gmail.com> wrote:
> > Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
> > section. And update the swapper_pg_dir by fixmap.
> >
> 
> I think we may be able to get away with not mapping idmap_pg_dir and
> tramp_pg_dir at all.

I think we need to move tramp_pg_dir to .rodata. The attacker can write
a block-mapping(AP=01) to tramp_pg_dir and then he can access kernel
memory.

> As for swapper_pg_dir, it would indeed be nice if we could keep those
> mappings read-only most of the time, but I'm not sure how useful this
> is if we apply it to the root level only.

The purpose of it is to make 'KSMA' harder, where an single arbitrary
write is used to add a block mapping to the page-tables, giving the
attacker full access to kernel memory. That's why we just apply it to
the root level only. If the attacker can arbitrary write multiple times,
I think it's hard to defend.

> > @@ -417,12 +421,22 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
> >
> >  void __init mark_linear_text_alias_ro(void)
> >  {
> > +       unsigned long size;
> > +
> >         /*
> >          * Remove the write permissions from the linear alias of .text/.rodata
> > +        *
> > +        * We free some pages in .rodata at paging_init(), which generates a
> > +        * hole. And the hole splits .rodata into two pieces.
> >          */
> > +       size = (unsigned long)swapper_pg_dir + PAGE_SIZE - (unsigned long)_text;
> >         update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
> > -                           (unsigned long)__init_begin - (unsigned long)_text,
> > -                           PAGE_KERNEL_RO);
> > +                           size, PAGE_KERNEL_RO);
> > +
> > +       size = (unsigned long)__init_begin - (unsigned long)swapper_pg_end;
> > +       update_mapping_prot(__pa_symbol(swapper_pg_end),
> > +                           (unsigned long)lm_alias(swapper_pg_end),
> > +                           size, PAGE_KERNEL_RO);
> 
> I don't think this is necessary. Even if some pages are freed, it
> doesn't harm to keep a read-only alias of them here since the new
> owner won't access them via this mapping anyway. So we can keep
> .rodata as a single region.

To be honest, I didn't think of this issue at first. I later found a
problem when testing the code on qemu:

[    7.027935] Unable to handle kernel write to read-only memory at virtual address ffff800000f42c00
[    7.028388] Mem abort info:
[    7.028495]   ESR = 0x9600004f
[    7.028602]   Exception class = DABT (current EL), IL = 32 bits
[    7.028749]   SET = 0, FnV = 0
[    7.028837]   EA = 0, S1PTW = 0
[    7.028930] Data abort info:
[    7.029017]   ISV = 0, ISS = 0x0000004f
[    7.029120]   CM = 0, WnR = 1
[    7.029253] swapper pgtable: 4k pages, 48-bit VAs, pgdp =         (ptrval)
[    7.029418] [ffff800000f42c00] pgd=00000000beff6803, pud=00000000beff5803, pmd=00000000beff3803, pte=00e0000040f42f93
[    7.029807] Internal error: Oops: 9600004f [#1] PREEMPT SMP
[    7.030027] Modules linked in:
[    7.030256] CPU: 0 PID: 1321 Comm: jbd2/vda-8 Not tainted 4.17.0-rc4-02908-g0fe42512b2f0-dirty #71
[    7.030486] Hardware name: linux,dummy-virt (DT)
[    7.030708] pstate: 40400005 (nZcv daif +PAN -UAO)
[    7.030880] pc : __memset+0x16c/0x1c0
[    7.030993] lr : jbd2_journal_get_descriptor_buffer+0x7c/0xfc
[    7.031134] sp : ffff00000a8ebbe0
[    7.031264] x29: ffff00000a8ebbe0 x28: ffff80007c104800
[    7.031430] x27: ffff00000a8ebd98 x26: ffff80007c4410d0
[    7.031567] x25: ffff80007c441118 x24: 00000000ffffffff
[    7.031704] x23: ffff80007c41b000 x22: ffff0000090d9000
[    7.031838] x21: 0000000002000000 x20: ffff80007bcee800
[    7.031973] x19: ffff80007c4413a8 x18: 0000000000000727
[    7.032107] x17: 0000ffff89eba028 x16: ffff0000080e2c38
[    7.032286] x15: ffff7e0000000000 x14: 0000000000048018
[    7.032424] x13: 0000000048018c00 x12: ffff80007bc65788
[    7.032558] x11: ffff00000a8eba68 x10: 0000000000000040
[    7.032709] x9 : 0000000000000000 x8 : ffff800000f42c00
[    7.032849] x7 : 0000000000000000 x6 : 000000000000003f
[    7.032984] x5 : 0000000000000040 x4 : 0000000000000000
[    7.033119] x3 : 0000000000000004 x2 : 00000000000003c0
[    7.033254] x1 : 0000000000000000 x0 : ffff800000f42c00
[    7.033414] Process jbd2/vda-8 (pid: 1321, stack limit = 0x        (ptrval))
[    7.033633] Call trace:
[    7.033757]  __memset+0x16c/0x1c0
[    7.033858]  journal_submit_commit_record+0x60/0x174
[    7.033985]  jbd2_journal_commit_transaction+0xf38/0x1330
[    7.034115]  kjournald2+0xcc/0x250
[    7.034207]  kthread+0xfc/0x128
[    7.034295]  ret_from_fork+0x10/0x18
[    7.034718] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
[    7.035104] ---[ end trace 26d65a14ae983167 ]---

/sys/kernel/debug/kernel_page_tables shows that:

---[ Linear Mapping ]---
0xffff800000000000-0xffff800000080000         512K PTE       RW NX SHD AF NG CON     UXN MEM/NORMAL
0xffff800000080000-0xffff800000200000        1536K PTE       ro NX SHD AF NG         UXN MEM/NORMAL
0xffff800000200000-0xffff800000e00000          12M PMD       RW NX SHD AF NG     BLK UXN MEM/NORMAL
0xffff800000e00000-0xffff800000fb0000        1728K PTE       ro NX SHD AF NG         UXN MEM/NORMAL

So I split it into pieces.

Thanks,

Jun
