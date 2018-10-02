Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9045C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B852089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSKl6N3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B852089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeJBP4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:56:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39581 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJBP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:56:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so1401345wmq.4;
        Tue, 02 Oct 2018 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFwAnrIf8He7C543Be3u26CPMO0haqkMjsQZldSjvow=;
        b=lSKl6N3iYsQ8l20N49Q7ZJUGyPn7XOS1ZWFiaD0Mqt6UBBJESnMGT3PsYR8DytwHMo
         O9Jl+3etKMKhNa8fLhXYh2R5Nnqd35AQng93vH1eEKkguqo75UdqUL0RvKwnJHGbVYrd
         mYgs5ti0wrK5UhbSNhPy1GBycEpPFzhE7mVZ7zyuI6VBx4FO8T6yXeZoYS3nC7Bvm0qq
         1kmvUhDoir+tMBOKOf8yUMRpzsin2hRsuByP9IC18zI50Hxxo4cJn0RTYdSstOB2MS+U
         UgjWRFgCeoPBsANFUOLajKotInrQ19OtEfknvFeq2YKk2d47vECLzMFCu44M2aszUCOa
         +ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFwAnrIf8He7C543Be3u26CPMO0haqkMjsQZldSjvow=;
        b=ZS57NL/gmvWWBqnzFHQd6obcAuE5gLjSbgt3nvkXuKHqoDDRhDDePSKmJdkPSHdAp8
         z809pKkHynnHsQsNiWZEyBa32n7kWV9dFw0qNVtgqBgNnhAZLciQLnIr0IIkQGb5gwhv
         iS++YFDi4pfpldYXahuEJcOOYNjBRTyJNsc0nH0S+WmpdHbt62pDqNoWi3zbXnA4n4Ni
         1DlOhSptpLKMGXKparQEdrJJMjKtwOamrmmJKw2oFDXglRwkXScSIwLCaUcqfvq+tLJq
         4LMGEhno5hH7RgHetz0By+z+y2OLYtUUlx8Xq+vUAWLaED4kV3b/3ZyLRVSRed0Ip5+t
         zqRQ==
X-Gm-Message-State: ABuFfojw5O4q7c22vyjXFsLIdYR1n8vaeWGwyX6qhLK58+oyx8PYRtU6
        yAzEWqZTMnoWLXTBCczBQxGinAwE
X-Google-Smtp-Source: ACcGV61wBW9hnm7ndoGdk9R69ehAK0rr03QS+usOoksjhoUbv2kn2da7oJ6mMsaROdszl4PygvK7oA==
X-Received: by 2002:a1c:2052:: with SMTP id g79-v6mr1262010wmg.42.1538471655575;
        Tue, 02 Oct 2018 02:14:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 195-v6sm1563846wmx.21.2018.10.02.02.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:14:15 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:14:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, thgarnie@google.com,
        corbet@lwn.net
Subject: Re: [PATCH v2 2/3] x86/mm/doc: Clean up the memory region layout
 descriptions
Message-ID: <20181002091412.GE116695@gmail.com>
References: <20180926235823.3567-1-bhe@redhat.com>
 <20180926235823.3567-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926235823.3567-3-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> In Documentation/x86/x86_64/mm.txt, the style of descritions about
> memory region layout is a little confusing:
> 
>  - mix size in TB with 'bits'
>  - sometimes mention a size in the description and sometimes not
>  - sometimes list holes by address, sometimes only as an 'unused hole' line
> 
> So fix them to make them in consistent style.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/x86/x86_64/mm.txt | 76 ++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
> index 5432a96d31ff..fc1da95e629d 100644
> --- a/Documentation/x86/x86_64/mm.txt
> +++ b/Documentation/x86/x86_64/mm.txt
> @@ -1,52 +1,52 @@
>  
>  Virtual memory map with 4 level page tables:
>  
> -0000000000000000 - 00007fffffffffff (=47 bits) user space, different per mm
> -hole caused by [47:63] sign extension
> -ffff800000000000 - ffff87ffffffffff (=43 bits) guard hole, reserved for hypervisor
> -ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
> -ffffc80000000000 - ffffc8ffffffffff (=40 bits) hole
> -ffffc90000000000 - ffffe8ffffffffff (=45 bits) vmalloc/ioremap space
> -ffffe90000000000 - ffffe9ffffffffff (=40 bits) hole
> -ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
> -... unused hole ...
> -ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
> -... unused hole ...
> +0000000000000000 - 00007fffffffffff (=47 bits, 128 TB) user space, different per mm
> +				    hole caused by [47:63] sign extension
> +ffff800000000000 - ffff87ffffffffff (=43 bits, 8 TB) guard hole, reserved for hypervisor
> +ffff880000000000 - ffffc7ffffffffff (=46 bits, 64 TB) direct mapping of all phys. memory (page_offset_base)
> +ffffc80000000000 - ffffc8ffffffffff (=40 bits, 1 TB) unused hole
> +ffffc90000000000 - ffffe8ffffffffff (=45 bits, 32 TB) vmalloc/ioremap space (vmalloc_base)
> +ffffe90000000000 - ffffe9ffffffffff (=40 bits, 1 TB) unused hole
> +ffffea0000000000 - ffffeaffffffffff (=40 bits, 1 TB) virtual memory map (vmemmap_base)
> +ffffeb0000000000 - ffffebffffffffff (=40 bits, 1 TB) unused hole
> +ffffec0000000000 - fffffbffffffffff (=44 bits, 16 TB) kasan shadow memory
> +fffffc0000000000 - fffffdffffffffff (=41 bits, 2 TB) unused hole
>  				    vaddr_end for KASLR
> -fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
> -fffffe8000000000 - fffffeffffffffff (=39 bits) LDT remap for PTI
> -ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
> -... unused hole ...
> -ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
> -... unused hole ...
> -ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
> -ffffffffa0000000 - fffffffffeffffff (1520 MB) module mapping space
> +fffffe0000000000 - fffffe7fffffffff (=39 bits, 512 GB) cpu_entry_area mapping
> +fffffe8000000000 - fffffeffffffffff (=39 bits, 512 GB) LDT remap for PTI
> +ffffff0000000000 - ffffff7fffffffff (=39 bits, 512 GB) %esp fixup stacks
> +ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
> +ffffffef00000000 - fffffffeffffffff (=36 bits, 64 GB) EFI region mapping space
> +ffffffff00000000 - ffffffff7fffffff (=31 bits, 2 GB) unused hole
> +ffffffff80000000 - ffffffff9fffffff (=29 bits, 512 MB)  kernel text mapping, from phys 0
> +ffffffffa0000000 - fffffffffeffffff (~31 bits, 1520 MB) module mapping space
>  [fixmap start]   - ffffffffff5fffff kernel-internal fixmap range
>  ffffffffff600000 - ffffffffff600fff (=4 kB) legacy vsyscall ABI
>  ffffffffffe00000 - ffffffffffffffff (=2 MB) unused hole

Looks mostly good now, but could you please make the right side align vertically as well, like 
I did in the examples I provided previously?

There's zero reason for it to look this disorganized:

> +ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
> +ffffffef00000000 - fffffffeffffffff (=36 bits, 64 GB) EFI region mapping space
> +ffffffff00000000 - ffffffff7fffffff (=31 bits, 2 GB) unused hole
> +ffffffff80000000 - ffffffff9fffffff (=29 bits, 512 MB)  kernel text mapping, from phys 0

I.e. can we do something like:

> +ffffff8000000000 - fffffffeefffffff (~39 bits, ~507 GB) unused hole
> +ffffffef00000000 - fffffffeffffffff (=36 bits,   64 GB) EFI region mapping space
> +ffffffff00000000 - ffffffff7fffffff (=31 bits,    2 GB) unused hole
> +ffffffff80000000 - ffffffff9fffffff (=29 bits,  512 MB) kernel text mapping, from phys 0

?

That not only makes it more readable, but makes typos like the whitespace noise double space in 
the last line more obvious.

Thanks,

	Ingo
