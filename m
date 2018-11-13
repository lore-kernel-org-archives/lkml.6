Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0993C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B012720868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GTHEUxqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B012720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbeKMKxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:53:38 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42382 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:53:38 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 18ADD24E069C;
        Mon, 12 Nov 2018 16:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542070679; bh=JBAtCZKMhaaos5LoXb0234KyWwNHGgnu2qmzhcc175c=;
        h=From:To:CC:Subject:Date:References:From;
        b=GTHEUxqIfEyHe62Gff96TOAhqMUH6z8KlPy86N/UVY4XE08wULg7R9hzB4SKUoMty
         Gcazmm5NZHzLOiINlqLoeqaH0jlfOGnjn++g1ceZUIUfCEs3R5PbH4G9AE1kg9zON0
         ARB8bPRAZc/+pW1zQfNIv7wUfmzHlZI3B/WZhZMYTGP0ka6JGYEkKyx6ZRYxf/IMgl
         SpeyJJxzMvOTE3dtW6o5Qkpj8LHwoSB3dQLT9K4iJtP6MScP+Y8eN+D+MAsMleXOdN
         j6sQsF3yASna4WSFSkhm5ZbtIcNWeYrglqKAh3fhdTJltCTDIJ9O4s9UpVEQ/WUKvR
         sVHsm3WtgivRA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 18D4B3919;
        Mon, 12 Nov 2018 16:57:55 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 12
 Nov 2018 16:57:55 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Greg Hackmann" <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "gxt@pku.edu.cn" <gxt@pku.edu.cn>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v4 6/6] arch: Move initrd= parsing into
 do_mounts_initrd.c
Thread-Topic: [PATCH v4 6/6] arch: Move initrd= parsing into
 do_mounts_initrd.c
Thread-Index: AQHUdVsG6LD9rqw+mkiEXoDtFpj/vg==
Date:   Tue, 13 Nov 2018 00:57:54 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A592A33@us01wembx1.internal.synopsys.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-7-f.fainelli@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
 <05f56763-1530-933d-2ce3-3653ad4c685f@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A592A0B@us01wembx1.internal.synopsys.com>
 <04d6d0cb-8e60-88a0-061e-62c7c70024c5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 4:52 PM, Florian Fainelli wrote:=0A=
> On 11/12/18 4:40 PM, Vineet Gupta wrote:=0A=
>> On 11/12/18 4:38 PM, Florian Fainelli wrote:=0A=
>>>>>  #ifdef CONFIG_BLK_DEV_INITRD=0A=
>>>>> -	if (initrd_start)=0A=
>>>>> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);=
=0A=
>>>>> +	if (phys_initrd_size) {=0A=
>>>>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);=0A=
>>>>> +		initrd_start =3D (unsigned long)__va(phys_initrd_start);=0A=
>>>>> +		initrd_end =3D initrd_start + phys_initrd_size;=0A=
>>>>> +	}=0A=
>>>>>  #endif=0A=
>>>> The common code now uses phys_initrd*, and you also use the same in AR=
C code, do=0A=
>>>> we still need the initrd_* setting here ?=0A=
>>>> ARC semantics was using them as PA anyways.=0A=
>>> Yes, the generic initrd code expects initrd_start/end to be virtual=0A=
>>> addresses, which we now directly derive from phys_initrd_start, that=0A=
>>> should really be equivalent.=0A=
>> So we can skip this explicit setting above - ARC arch code doesn't acces=
s the virt=0A=
>> initrd_start=0A=
> OK, you are saying we could just have the generic initrd code do this=0A=
> assignment instead of having each architecture do it, is that a correct=
=0A=
> understanding? =0A=
=0A=
Correct !=0A=
=0A=
> If so, I suppose it could be done, whether as of this=0A=
> patch series or as a follow-up, either way is fine with me.=0A=
=0A=
If it is not too much trouble, I'd prefer this now. I should have chimed ea=
rlier.=0A=
=0A=
> One possible caveat is if __va() and __phys_to_virt() behave differently=
=0A=
> (e.g: because of CONFIG_DEBUG_VIRTUAL or other things).=0A=
=0A=
=0A=
Thing is, after your patches, we don't use the vanilla initrd_xxx in arch c=
ode any=0A=
longer. So this becomes just an implementation detail, which core code may =
or=0A=
maynot need and if it does, this needs to work already w/o having to set an=
ything=0A=
in arch code. Agree ?=0A=
=0A=
Thx,=0A=
-Vineet=0A=
