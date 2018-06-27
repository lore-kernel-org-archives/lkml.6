Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBD3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60806268FC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bIsnENVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60806268FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeF0CxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 22:53:13 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20323 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeF0CxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 22:53:11 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5R2r3OU006410;
        Wed, 27 Jun 2018 11:53:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5R2r3OU006410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530067984;
        bh=bZG5ie+Fa0rFeKccgJNQzP9/hBo/NgSgAO5lcPcg6CA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bIsnENVe5mgelOtpvB13WpWLKoi1MBPDknn2f5UITaP7cFszp4Lmy0++b37vhrEpP
         bnnRQlPjyfLChMu5qinNdDjQFAOEuoXv/cm+8YAtpLbdPQgU5lDi9FMXVEO7a8h0P1
         DF+8ybMtPHdzPbWxmg5ZYeTJtCXzsRV/IdxXizN7jIdUwVuAMP3AiJdxXOFm8KcdXO
         +TVB0avjVQ7f9D/h0c3yGEJFwzGJW4Hws7+s505NGUI11R9F1GnGH5nMLpCX0RES7I
         bgKyJkTAMGdkT1crqFShpLJJCVLWcgjRi/r4hSgfwHeMjVNBv3C0NhxiLCM9gmJKn5
         IAqsdgPC1ik0w==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id y8-v6so322958uan.3;
        Tue, 26 Jun 2018 19:53:03 -0700 (PDT)
X-Gm-Message-State: APt69E3u+cHcpOZQDPrUtkc/rKIxRJTwSxdnTUbM6SdxT26mgF0x00Ci
        ahFE1uCp0F+v/IHAUp70Me3nabiiI0djvb0j2ro=
X-Google-Smtp-Source: AAOMgpd8LwW8MkTKJF+h4SZQupPJVQCtvXKSExT388cflNUPiwTYuS8+8qsFNIXtsxBONyW5eNht9QGxDAouLW2+Va0=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr2587173uae.140.1530067982728;
 Tue, 26 Jun 2018 19:53:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 19:52:22
 -0700 (PDT)
In-Reply-To: <20180626200928.29aca979@xps13>
References: <20180619120719.26921-1-richard@nod.at> <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
 <3320422.EJ8D6C0VHL@blindfold> <d4fdcd1d-db20-1837-a037-0982a042d357@kernel.org>
 <20180625165506.484e025f@bbrezillon> <CAK7LNATyo+7gauyQcRmNfCs8CagU1XdpHHgREMeTvf4rqxpeNQ@mail.gmail.com>
 <20180626200928.29aca979@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Jun 2018 11:52:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbmNadK=xPcaQ+seRS_YvH5ZP5SX8z74iOyYcJ0Soicw@mail.gmail.com>
Message-ID: <CAK7LNATbmNadK=xPcaQ+seRS_YvH5ZP5SX8z74iOyYcJ0Soicw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-27 3:09 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
> Hi Masahiro,
>
> On Tue, 26 Jun 2018 11:38:21 +0900, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> 2018-06-25 23:55 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>=
:
>> > On Mon, 25 Jun 2018 09:50:18 -0500
>> > Dinh Nguyen <dinguyen@kernel.org> wrote:
>> >
>> >> On 06/22/2018 10:58 AM, Richard Weinberger wrote:
>> >> > Masahiro,
>> >> >
>> >> > Am Freitag, 22. Juni 2018, 16:37:21 CEST schrieb Masahiro Yamada:
>> >> >> Hi Richard,
>> >> >>
>> >> >>
>> >> >> 2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:
>> >> >>> The denali NAND flash controller needs at least two clocks to ope=
rate,
>> >> >>> nand_clk and nand_x_clk.
>> >> >>> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters =
by
>> >> >>> setup_data_interface()") nand_x_clk is used to derive timing sett=
ings.
>> >> >>>
>> >> >>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> >> >>> ---
>> >> >>> Strictly speaking denali needs a ecc_clk too, but AFAIK such a cl=
ock
>> >> >>> is not present on this SoC.
>> >> >>> But my SoCFPGA knowledge is very limited.
>> >> >>>
>> >> >>> Thanks,
>> >> >>> //richard
>> >> >>> ---
>> >> >>>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
>> >> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> >>>
>> >> >>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/s=
ocfpga.dtsi
>> >> >>> index 486d4e7433ed..562f7b375bbd 100644
>> >> >>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> >> >>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> >> >>> @@ -754,7 +754,8 @@
>> >> >>>                         reg-names =3D "nand_data", "denali_reg";
>> >> >>>                         interrupts =3D <0x0 0x90 0x4>;
>> >> >>>                         dma-mask =3D <0xffffffff>;
>> >> >>> -                       clocks =3D <&nand_clk>;
>> >> >>> +                       clocks =3D <&nand_clk>, <&nand_x_clk>;
>> >> >>> +                       clock-names =3D "nand", "nand_x";
>> >> >>
>> >> >>
>> >> >> IMHO, this should be
>> >> >>
>> >> >>                           clocks =3D <&nand_clk>, <&nand_x_clk>, <=
&nand_x_clk>;
>> >> >>                           clock-names =3D "nand", "nand_x", "ecc";
>> >>
>> >> No, it should be just the nand_x and ecc.
>> >>
>> >> There's already a patch to use the nand_x_clk and not the nand_clk.
>>
>>
>> Different people try to fix the problem in different ways.
>>
>> I think it is due to miscommunication across sub-systems.
>
> Is the series named
>
>         mtd: rawnand: denali: add new clocks and improve
>                               setup_data_interface
>
> still valid?

Yes.
I believe V4 is valid.


Information for Dinh Nguyen:

http://patchwork.ozlabs.org/patch/933507/
http://patchwork.ozlabs.org/patch/933487/
http://patchwork.ozlabs.org/patch/933494/
http://patchwork.ozlabs.org/patch/933506/


If he is not convinced, I am open to discussion, though.



> I am about to apply it (patches 2/5 to 5/5) but it looks like the
> discussion is still ongoing.
>
> Thanks,
> Miqu=C3=A8l
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--=20
Best Regards
Masahiro Yamada
