Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C26C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A11220861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RP2vpRPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfAVIUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:20:36 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10696 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfAVIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:20:36 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c46d23c0000>; Tue, 22 Jan 2019 00:20:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 00:20:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 22 Jan 2019 00:20:35 -0800
Received: from [10.24.242.22] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 08:20:29 +0000
Subject: Re: kmemleak panic
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sachin Nikam <snikam@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
 <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <96070098-7f05-7eb8-2c5c-9c9da1a45e4a@free.fr>
From:   Prateek Patel <prpatel@nvidia.com>
Message-ID: <b23cec3f-8c18-7e08-39fb-73145526649e@nvidia.com>
Date:   Tue, 22 Jan 2019 13:50:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <96070098-7f05-7eb8-2c5c-9c9da1a45e4a@free.fr>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548145212; bh=lrDDpHxgf5ofoxJYeR80487jD7LYUE/0IkX9apElChc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=RP2vpRPzBOOp2jY65GbSGCZfe+mS7nXkkT3NGrLKyzF+LVkkFg0QlWfDIKltekquO
         Gx6lqM6x2lK2Ti9U7j/G06IwbDyGGBSXIRIbc6/Fc3pBr5pq3Omh0yKw4a8HiZ8/sI
         mpmWkIR1mY0sAu9CW2wfYZk5Q/kqxH29Ufbfyc2esBTUnmgc5sWBSlrKPztjOkyjLx
         37A/PtAwPcZi2C0fcQk/bRaDstouBZoWnifTHhkVjfwuPj0X+kqOGopSuMZc6jU9O+
         aq8AITgqksSgejgXHfk4gx+uPpoUOuk4hGZvFzJuH+i+oLe0/utyIQ4LygNgFzqIzG
         pTXZDJknDatQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/2019 7:24 PM, Marc Gonzalez wrote:
> On 21/01/2019 14:35, Rob Herring wrote:
>
>> On Mon, Jan 21, 2019 at 6:19 AM Robin Murphy wrote:
>>> On 21/01/2019 11:57, Marc Gonzalez wrote:
>>> [...]
>>>> # echo dump=3D0xffffffc021e00000 > /sys/kernel/debug/kmemleak
>>>> kmemleak: Object 0xffffffc021e00000 (size 2097152):
>>>> kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
>>>> kmemleak:   min_count =3D 0
>>>> kmemleak:   count =3D 0
>>>> kmemleak:   flags =3D 0x1
>>>> kmemleak:   checksum =3D 0
>>>> kmemleak:   backtrace:
>>>>        kmemleak_alloc_phys+0x48/0x60
>>>>        memblock_alloc_range_nid+0x8c/0xa4
>>>>        memblock_alloc_base_nid+0x4c/0x60
>>>>        __memblock_alloc_base+0x3c/0x4c
>>>>        early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
>>>>        fdt_init_reserved_mem+0x308/0x3ec
>>>>        early_init_fdt_scan_reserved_mem+0x88/0xb0
>>>>        arm64_memblock_init+0x1dc/0x254
>>>>        setup_arch+0x1c8/0x4ec
>>>>        start_kernel+0x84/0x44c
>>>>        0xffffffffffffffff
>>> OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up wit=
h
>>> the linear map address of a no-map reservation, which unsurprisingly
>>> turns out not to be mapped. Is there a way to tell kmemleak that it
>>> can't scan within a particular object?

Yes,=C2=A0 kmemleak_no_scan() do this which is done in patch=20
https://patchwork.ozlabs.org/patch/995367/

This was done to avoid kmemleak scanning on the blocks which are nomaped=20
and should not have linear mapping created in kernel page table.

>> There was this patch posted[1]. I never got a reply, so it hasn't been a=
pplied.
>>
>> Rob
>>
>> https://patchwork.ozlabs.org/patch/995367/
> It is worth noting that the author's email address appears to be dead.
> <schowdary@nvidia.com>: host hqemgate08.nvidia.com[216.228.121.117] said:
> 550 #5.1.0 Address rejected. (in reply to RCPT TO command)
>
> Adding a few nvidia devs for comment.
