Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460DC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3C02089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD+lvhqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3C02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJGAHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:07:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJGAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:07:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so4447779wmb.5;
        Sat, 06 Oct 2018 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mYWIlfxJGNDWZbIqIVWQoaAv4RL99OVSMqmWfILT3Zc=;
        b=RD+lvhqWYAPgjU2NkJ6xzTSV67EbJ7kmnaolxJvB6D6kjPlVXRmVY61e65ANGYlnw3
         rKVg9kvLGMhQfCDY6ULr59+J3tqY2rS8dxZXfuIMyZw9vljFksT0T5jONmQnEr392E5W
         UJ8Ml2QZf/YabSKyJi1dPDQNZP7GgY4MWdA2jskzbyfUxUpm0r8EgFwPs85UDq3Qr0ug
         YkQ1TgK1AUmg8SyBAMAO+agQdt9qD5XAWFh61BKACMiSjxl93l5CSFyJk04y0bfP3W/q
         C8z0oblbn7WIMzWylVhVa6gkfQTvSbdCfyjL8FeM3VmYZiacI9MQY4aPrdGbMUJDg5cy
         8WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYWIlfxJGNDWZbIqIVWQoaAv4RL99OVSMqmWfILT3Zc=;
        b=TaAzvIvS4o3QvsCvDRMnkfTouw65e7k06sWGMgdn449qn7BbF8tohDWSSdycxMieCS
         nBLNRAdKnyWlpVPpdWsDCxs7a6SjL7lSTdpKzBgEF7NpBehHaG+IxiBNglPOJOZaLyM3
         dbZFoxHjwt6I03gWy9/BerD7vIUR/dwsu7dN/JgcP0LpmhZMADqwiJtI1NfOxEnoBdAU
         JE9mq9O3TjfrS53QLMd7GukZ9xFBu9xxwKjwaSdaGGs2h0Zj5aT0z3ocUU+KroQkKPBO
         JPz3ZH9YDKHrf1fw3qmFuUDOO25Ec+i9IZx0ZFAbOXqRNhBSMlV23kcBZX3rV/7fXTBm
         dYPw==
X-Gm-Message-State: ABuFfohm+2XB+6Ou+Jr9OA0erFAdUaCuEUfEs93i+RojvsFyuqF/6oks
        i3iTjQPEWEvvoGgFJPASXCE=
X-Google-Smtp-Source: ACcGV60JArR/7YOjKB8lc0crt8QurMmUPeOKumOdYNRcfOcpXqNC+0fczW7uaFOxnTa1CkpXyJjD9w==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25-v6mr10822704wmj.55.1538845400301;
        Sat, 06 Oct 2018 10:03:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8949440wrt.77.2018.10.06.10.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 10:03:19 -0700 (PDT)
Date:   Sat, 6 Oct 2018 19:03:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/3 v2] x86/mm/doc: Enhance the x86-64 virtual memory
 layout descriptions
Message-ID: <20181006170317.GA21297@gmail.com>
References: <20181006084327.27467-1-bhe@redhat.com>
 <20181006122259.GB418@gmail.com>
 <20181006143821.GA72401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006143821.GA72401@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There's one PTI related layout asymmetry I noticed between 4-level and 5-level kernels:

  47-bit:
> +                                                            |
> +                                                            | Kernel-space virtual memory, shared between all processes:
> +____________________________________________________________|___________________________________________________________
> +                  |            |                  |         |
> + ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
> + ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> + ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
> + ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
> + ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
> + ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
> + ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
> + ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
> + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
> +                  |            |                  |         | vaddr_end for KASLR
> + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
> + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
> +__________________|____________|__________________|_________|____________________________________________________________
> +                                                            |

  56-bit:
> +                                                            |
> +                                                            | Kernel-space virtual memory, shared between all processes:
> +____________________________________________________________|___________________________________________________________
> +                  |            |                  |         |
> + ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
> + ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
> + ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
> + ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
> + ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
> + ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
> + ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
> + ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
> + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
> +                  |            |                  |         | vaddr_end for KASLR
> + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
> + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks

The two layouts are very similar beyond the shift in the offset and the region sizes, except 
one big asymmetry: is the placement of the LDT remap for PTI.

Is there any fundamental reason why the LDT area is mapped into a 4 petabyte (!) area on 56-bit 
kernels, instead of being at the -1.5 TB offset like on 47-bit kernels?

The only reason I can see is that this way is that it's currently coded at the PGD level only:

static void map_ldt_struct_to_user(struct mm_struct *mm)
{
        pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR); 

        if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
                set_pgd(kernel_to_user_pgdp(pgd), *pgd);
}

( BTW., the 4 petabyte size of the area is misleading: a 5-level PGD entry covers 256 TB of 
  virtual memory, i.e 0.25 PB, not 4 PB. So in reality we have a 0.25 PB area there, used up
  by the LDT mapping in a single PGD entry, plus a 3.75 PB hole after that. )

... but unless I'm missing something it's not really fundamental for it to be at the PGD level 
- it could be two levels lower as well, and it could move back to the same place where it's on 
the 47-bit kernel.

The LDT mapping operation is pretty heavy already, and the actual use of the LDT is not 
impacted by where it's mapped, as the LDT is per mm so no remapping is required on context 
switch.

I.e. could we move the LDT over to the same place? This would make an even larger area of the 
address space identical between 47-bit and 56-bit kernels:

                                                            |
                                                            | Identical layout to the 47-bit one from here on:
____________________________________________________________|____________________________________________________________
                  |            |                  |         |
 fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
                  |            |                  |         | vaddr_end for KASLR
 fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
 fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
 ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
 ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
 ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
 ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
 ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
 ffffffff80000000 |-2048    MB |                  |         |
 ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
 ffffffffff000000 |  -16    MB |                  |         |
    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
 ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
 ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
__________________|____________|__________________|_________|___________________________________________________________

And the rest would basically just be 4 areas: the direct-mapping, vmalloc, vmemmap and KASAN 
areas - which are scaled according to whether it's a 47-bit or 56-bit kernel.

Thoughts?

Thanks,

	Ingo
