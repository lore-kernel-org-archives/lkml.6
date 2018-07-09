Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE3B20899
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HitN0QRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE3B20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGIDcA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:32:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45451 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbeGIDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:31:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id i26-v6so1179424pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JcdSlO+Vd+LZVjphZzOLIi3zZFzpRrgtb1ZpuCL41S4=;
        b=HitN0QRK/Mu3qU1gS3lxnqXkxwQmlVUaCtbNzklIGR395yaOivLsPNYwHDKWWWx2li
         EnI4RkabdH2Mh7Jgzgsyv5Rc4GNTxaQePr0DlvYbFvR/kgV2+c2w4WERnwIne3rJuC/Y
         yKfaKOcf27pmDSHEcVI29u2XdXW41ALqUwQL2aVkT+nu7iukx2Ixr/RH+gMmAtGilnxe
         vK3V+H2xLuBTw1k42zfqcbRK+H+AUYqHG1cYu39bGxgi7io2gBUvUn3muRhipar8TeXm
         M0zQCQfvtuf1+zbXbgV+mu2rAD+x3jQlRJG5aIIwGjfxo6toV0qX++8vTbaVtx1wfMNL
         /6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JcdSlO+Vd+LZVjphZzOLIi3zZFzpRrgtb1ZpuCL41S4=;
        b=ahBOXkw4iXFNlH8695XS1IcDY+8+c2GGBWCFeSMssdOa1e1i11DZNqUrMYkmqxlVDw
         X2l6Hb3LZGY80CLFb4oYzN1Q/g254mWLWxIGyNnVucV787NdAyWYCvK9Ei/ZSdhcp23G
         sE4Ei2MZH50miy+sSua4YE2vUcN2tLK1RIJSdXObagcbovQmjxy0j4GIAf7K18ARvc0L
         xadQPd9yqvm22/+kfcugM7ndjHc4JVPOz1r+FvEvpKkiMJxXsE/PGt5Vx5iWz7QbHWPe
         rT9acW+LGGWWaHNi9OHZFmhL7Nj9grTVIGHeqoR18Toe3n6UDj/z7e0Kw4plowJ18erH
         U5ug==
X-Gm-Message-State: APt69E3Fq65lsWpOhKIBja3b+KUubDVHDIf9dJ9FHLrIjVyYB3jfX60t
        OPop0P6FpPlswA/Edw7J4kw=
X-Google-Smtp-Source: AAOMgpdt7k4wSs67mFnWUvj9s9OcVp0qpg7Kr3Yp/USIFEICMydNDRLe27KgO8x9BNsx5MxVtVTmFQ==
X-Received: by 2002:a65:6110:: with SMTP id z16-v6mr12950810pgu.412.1531107118579;
        Sun, 08 Jul 2018 20:31:58 -0700 (PDT)
Received: from [0.0.0.0] (65.49.234.56.16clouds.com. [65.49.234.56])
        by smtp.gmail.com with ESMTPSA id d18-v6sm22077637pfn.118.2018.07.08.20.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 20:31:57 -0700 (PDT)
Subject: Re: [RESEND PATCH v10 2/6] mm: page_alloc: remain
 memblock_next_valid_pfn() on arm/arm64
To:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vacek <neelx@redhat.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-3-git-send-email-hejianet@gmail.com>
 <20180706153709.6bcc76b0245f239f1d1dcc8a@linux-foundation.org>
From:   Jia He <hejianet@gmail.com>
Message-ID: <4895a92f-f4c2-b200-3c7c-4fe8c4596f32@gmail.com>
Date:   Mon, 9 Jul 2018 11:30:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706153709.6bcc76b0245f239f1d1dcc8a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andew
Thanks for the comments

On 7/7/2018 6:37 AM, Andrew Morton Wrote:
> On Fri,  6 Jul 2018 17:01:11 +0800 Jia He <hejianet@gmail.com> wrote:
> 
>> From: Jia He <jia.he@hxt-semitech.com>
>>
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But it causes
>> possible panic bug. So Daniel Vacek reverted it later.
>>
>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>> Daniel said:
>> "On arm and arm64, memblock is used by default. But generic version of
>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>> not always return the next valid one but skips more resulting in some
>> valid frames to be skipped (as if they were invalid). And that's why
>> kernel was eventually crashing on some !arm machines."
>>
>> About the performance consideration:
>> As said by James in b92df1de5,
>> "I have tested this patch on a virtual model of a Samurai CPU
>> with a sparse memory map.  The kernel boot time drops from 109 to
>> 62 seconds."
>>
>> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
>>
> 
> We're making a bit of a mess here.  mmzone.h:
> 
> ...
> #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> ...
> #define next_valid_pfn(pfn)	(pfn + 1)

Yes, ^ this line can be removed.

> #endif
> ...
> #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
> ...
> #else
> ...
> #ifndef next_valid_pfn
> #define next_valid_pfn(pfn)	(pfn + 1)
> #endif
> 
> I guess it works OK, since CONFIG_HAVE_MEMBLOCK_PFN_VALID depends on
> CONFIG_HAVE_ARCH_PFN_VALID.  But it could all do with some cleanup and
> modernization.
> 
> - Perhaps memblock_next_valid_pfn() should just be called
>   pfn_valid().  So the header file's responsibility is to provide
>   pfn_valid() and next_valid_pfn().
> 
> - CONFIG_HAVE_ARCH_PFN_VALID should go away.  The current way of
>   doing such thnigs is for the arch (or some Kconfig combination) to
>   define pfn_valid() and next_valid_pfn() in some fashion and to then
>   ensure that one of them is #defined to something, to indicate that
>   both of these have been set up.  Or something like that.

This is what I did in Patch v2, please see [1]. But Daniel opposed it [2]

As he said:
Now, if any other architecture defines CONFIG_HAVE_ARCH_PFN_VALID and
implements it's own version of pfn_valid(), there is no guarantee that
it will be based on memblock data or somehow equivalent to the arm
implementation, right?
I think it make sense, so I introduced the new config
CONFIG_HAVE_MEMBLOCK_PFN_VALID instead of using CONFIG_HAVE_ARCH_PFN_VALID
how about you ? :-)

[1] https://lkml.org/lkml/2018/3/24/71
[2] https://lkml.org/lkml/2018/3/28/231

> 
> 
> Secondly, in memmap_init_zone()
> 
>> -		if (!early_pfn_valid(pfn))
>> +		if (!early_pfn_valid(pfn)) {
>> +			pfn = next_valid_pfn(pfn) - 1;
>> 			continue;
>> +		}
>> +
> 
> This is weird-looking.  next_valid_pfn(pfn) is usually (pfn+1) so it's
> a no-op.  Sometimes we're calling memblock_next_valid_pfn() and then
> backing up one, presumably because the `for' loop ends in `pfn++'.  Or
> something.  Can this please be fully commented or cleaned up?
To clean it up, maybe below is not acceptable for you and other experts ?
		if (!early_pfn_valid(pfn)) {
#ifndef XXX
			continue;
		}
#else
		pfn = next_valid_pfn(pfn) - 1;
			continue;
		}
#endif

Another way which was suggested by Ard Biesheuvel
something like:
	for (pfn = start_pfn; pfn < end_pfn; pfn = next_valid_pfn(pfn))
	...
But it might have impact on memmap_init_zone loop.

E.g. context != MEMMAP_EARLY, pfn will not be checked by early_pfn_valid, thus
it will change the mem hotplug logic.

Sure, as you suggested, I can give more comments in all the cases of different
configs/arches for this line.

-- 
Cheers,
Jia
