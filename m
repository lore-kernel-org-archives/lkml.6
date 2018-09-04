Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD43C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451512077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mQ/3vt8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451512077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIDWjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:39:45 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42626 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:39:44 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CDFF610C1572;
        Tue,  4 Sep 2018 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536084810; bh=rV+M4azNBU5vZ7Q02FBeWJ+8WVxBTOO9uvxEsar2vsU=;
        h=From:To:CC:Subject:Date:References:From;
        b=mQ/3vt8DT7YxNNEZXiZWtmzjY/dwaz5rfHePZfkjKIyP2/ulDR7ge6GN0tU+XuUvS
         WgUveUxJykYg9WNZ6g6SDtwtflDLQFfyslKzBHjm0g/8iTpa2TFlpP0P1IiLw1cwhT
         O4BgIAxqHGt5kzb/EePDRK/N9TAHIVY7a/NdRUBPk2JpcmMIcA59D1SgUGT+f1zKof
         15o8K4sY4ymETC/Yk7lb3BzOe9YVkgvJh+wvUwSrqOsQb1QH9X0kuO/KoBc6KPRsVM
         VftC6W/NAM93Sws5xDLCCjFoLrJuauBlVHajQ6OpsNm26PiIgXbALIn/TpxQQw8eCV
         aX19dUZqNpJgQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id B59134EBA;
        Tue,  4 Sep 2018 11:13:29 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 4 Sep 2018 11:13:29 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUKCIcL8IFt0D6VUGgJAndTq4yWQ==
Date:   Tue, 4 Sep 2018 18:13:28 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B09164B@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com>
 <1534180089.3962.68.camel@synopsys.com>
 <81ddd506-1f7e-db82-4c77-ff08b1c15dd3@synopsys.com>
 <1534963226.3962.215.camel@synopsys.com>
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

Hi,=0A=
=0A=
On 08/22/2018 11:40 AM, Eugeniy Paltsev wrote:=0A=
>=0A=
>> Reading kernel/dma/* I see what you mean. We check @ioc_enable at the ti=
me of=0A=
>> registering the dma op for coherent vs. non coherent case, so there's co=
mmon vs.=0A=
>> ARC versions of alloc/free for coherent vs. noncoherent.=0A=
> Just to be sure that we understand both each other and source code correc=
tly: =0A=
> - In coherent case we use dma_direct_* ops which doesn't use ARC alloc fu=
nctions (arch_dma_{alloc|free})=0A=
> - In non-coherent case we use dma_noncoherent_* ops which uses ARC alloc =
functions (arch_dma_{alloc|free})=0A=
=0A=
Right I see that.=0A=
=0A=
>> But then I'm curious why=0A=
>> do we bother to check the following in new arch_dma_(alloc|free) at all.=
=0A=
>>=0A=
>> 	if (attrs & DMA_ATTR_NON_CONSISTENT)=0A=
>>=0A=
>> Isn't it supposed to be NON_CONSISTENT always given the way new code wor=
ks ?=0A=
> DMA_ATTR_NON_CONSISTENT flag is not related to IOC topic.=0A=
> It is a flag which we can pass to dma_{alloc|free}_attrs function from dr=
iver side.=0A=
>=0A=
> According to documentation:=0A=
>   DMA_ATTR_NON_CONSISTENT: Lets the platform to choose to return either=
=0A=
>   consistent or non-consistent memory as it sees fit.=0A=
=0A=
Right I'd them mixed up. But then in case of direct dma ops, the attr is si=
mply=0A=
ignored in dma_alloc_attrs() -> dma_direct_alloc(). User always gets cohere=
nt memory.=0A=
=0A=
>=0A=
> We check this flag in arch_dma_alloc (which are used in non-coherent case=
) to=0A=
> skip MMU mapping if we are advertised that consistency is not required.=
=0A=
>=0A=
> So, actually we can get rid of this flag checking in arch_dma_alloc and =
=0A=
> simply always do MMU mapping to enforce non-cachability and return=0A=
> non-cacheable memory even if DMA_ATTR_NON_CONSISTENT is passed.=0A=
> But I don't sure we want to do that.=0A=
>=0A=
> BTW: dma_alloc_coherent is simply dma_alloc_attrs with attrs =3D=3D 0.=0A=
>=0A=
=0A=
