Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACAEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515E22087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="pC243/6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515E22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeIXQHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:07:30 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54844 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXQHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:07:30 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C837C8364F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 22:06:09 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1537783569;
        bh=UJ4/6K28w5aR3QsehUlYCbYi2kakI3CFR31K9gIs9f0=;
        h=From:To:CC:Subject:Date:References;
        b=pC243/6GeIGpLli8bAhYzzFdy1nquMMTpCYzVJPlXe/hpzfeFzQOenZBKVbegu4/5
         PBjU04dH+40QhomwzCDT0VX0tKkUbrrgpupAUcb1HYDIoQav26SdhxGNDDGj3YKlta
         2iIKwkEdlADfvkM5r+4Xb7ElCfKtUdPBtnzT8YDc=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ba8b7100001>; Mon, 24 Sep 2018 22:06:08 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 24 Sep 2018 22:06:09 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 24 Sep 2018 22:06:09 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Olof Johansson <olof@lixom.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ylefloch@online.net" <ylefloch@online.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
Thread-Topic: [PATCH v5] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
Thread-Index: AQHUJJOYtPQMfuhSv0GqI5ViUnwscA==
Date:   Mon, 24 Sep 2018 10:06:09 +0000
Message-ID: <63e0f13b8081419a813fba4c4d6faa8b@svr-chch-ex1.atlnz.lc>
References: <20180726034856.20743-1-chris.packham@alliedtelesis.co.nz>
 <8736u3jhc3.fsf@bootlin.com> <20180924095332.lrfobc5dhxahm6g5@localhost>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/18 21:54, Olof Johansson wrote:=0A=
> On Fri, Sep 21, 2018 at 12:05:48PM +0200, Gregory CLEMENT wrote:=0A=
>> Hi Chris,=0A=
>>   =0A=
>>   On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.=
nz> wrote:=0A=
>>=0A=
>>> We need to maintain backwards compatibility with device trees that don'=
t=0A=
>>> define an enable method. At the same time we want the device tree to be=
=0A=
>>> able to specify an enable-method and have it stick.=0A=
>>>=0A=
>>> Previously by having smp assigned in the DT_MACHINE definition this=0A=
>>> would be picked up by setup_arch() and override whatever=0A=
>>> arm_dt_init_cpu_maps() had configured. Now we move the initial=0A=
>>> assignment of default smp_ops to a dt_fixup and let=0A=
>>> arm_dt_init_cpu_maps() override that if the device tree defines an=0A=
>>> enable-method.=0A=
>>>=0A=
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>>=0A=
>> I made several tests on an Armada XP based board: OpenBlock AX3: I=0A=
>> modify the enable-method in the decvice tree, and I confirm that without=
=0A=
>> your patch it is not taken into account whereas with this patch the=0A=
>> enable-method is applied form the device tree. I also didn't see any=0A=
>> regression with the original dtb.=0A=
>>=0A=
>> So I added my:=0A=
>> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>=0A=
>>=0A=
>> and applied on mvebu/soc=0A=
> =0A=
> Hi,=0A=
> =0A=
> Looks like this broke non-SMP. Not a huge deal, but please apply this as=
=0A=
> closely as possible on top of the previous patch (or squash it in).=0A=
> =0A=
> =0A=
> - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< - 8< -=
=0A=
> =0A=
> =0A=
> =0A=
>  From 3190d9502607995c7aecce79beec36714574d494 Mon Sep 17 00:00:00 2001=
=0A=
> From: Olof Johansson <olof@lixom.net>=0A=
> Date: Mon, 24 Sep 2018 02:37:31 -0700=0A=
> Subject: [PATCH] ARM: mvebu: fix !SMP build=0A=
> =0A=
> Wrap set_smp_ops() in CONFIG_SMP.=0A=
> =0A=
> Fixes: d6ec59de9a0a8 ("ARM: mvebu: use dt_fixup to provide fallback for e=
nable-method")=0A=
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> Signed-off-by: Olof Johansson <olof@lixom.net>=0A=
> ---=0A=
>   arch/arm/mach-mvebu/board-v7.c | 2 ++=0A=
>   1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v=
7.c=0A=
> index 5bbde5e..0b10acd 100644=0A=
> --- a/arch/arm/mach-mvebu/board-v7.c=0A=
> +++ b/arch/arm/mach-mvebu/board-v7.c=0A=
> @@ -147,7 +147,9 @@ static void __init mvebu_dt_init(void)=0A=
>   =0A=
>   static void __init armada_370_xp_dt_fixup(void)=0A=
>   {=0A=
> +#ifdef CONFIG_SMP=0A=
>   	smp_set_ops(smp_ops(armada_xp_smp_ops));=0A=
> +#endif=0A=
>   }=0A=
>   =0A=
>   static const char * const armada_370_xp_dt_compat[] __initconst =3D {=
=0A=
> =0A=
=0A=
Makes sense to me.=0A=
=0A=
Gregory, do you want me to send a v6 or are you able to squash this in?=0A=
