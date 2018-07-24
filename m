Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ejIs0s25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeGXMPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:15:41 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51154 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbeGXMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:15:41 -0400
Date:   Tue, 24 Jul 2018 13:09:34 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 00/18] JZ4780 DMA patchset v3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1532430574.2610.0@smtp.crapouillou.net>
In-Reply-To: <20180723175846.udmjtkx7fsaf52wa@pburton-laptop>
References: <20180721110643.19624-1-paul@crapouillou.net>
        <20180723175846.udmjtkx7fsaf52wa@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532430583; bh=PBGj1BpZp0feTqBaomdzuC/a/PGMi+7d+A74Qs+Cg+0=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ejIs0s25ReYtzT1ysv+Oh/m0zFJ8MPJSXHEAibT/gnX92MVNH2jhOLPbIxRHu3R/w2Zn3Pcw9EXxZS5LmuKfmJP1rS/paQiPyfMj+0zeJnDxwJjM2yE8gkRVHJRUAm5NCe/T1+oQnkySXdAzeO96iDhIGi/X13I22PuHt5srXK8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 23 juil. 2018 =E0 19:58, Paul Burton <paul.burton@mips.com> a=20
=E9crit :
> Hi Paul & Vinod,
>=20
> On Sat, Jul 21, 2018 at 01:06:25PM +0200, Paul Cercueil wrote:
>>  This is the version 3 of my jz4780-dma driver update patchset.
>>=20
>>  Apologies to the DMA people, the v2 of this patchset did not make=20
>> it to
>>  their mailing-list; see the bottom of this email for a description=20
>> of
>>  what happened in v2.
>>=20
>>  Changelog from v2 to v3:
>>=20
>>  - Modified the devicetree bindings to comply with the specification
>>=20
>>  - New patch [06/18] allows the JZ4780 DMA driver to be compiled=20
>> within a
>>    generic MIPS kernel.
>=20
> Would you prefer to take the MIPS .dts changes in patches 16-18=20
> through
> the DMA tree with the rest of the series?

I think it would make sense yes.

> If so then for patches 16-18:
>=20
>     Acked-by: Paul Burton <paul.burton@mips.com>
>=20
> Thanks,
>     Paul
=

