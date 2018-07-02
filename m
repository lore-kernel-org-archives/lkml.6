Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F8A21566
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wIg1P4ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F8A21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932811AbeGBBgP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:36:15 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43324 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbeGBBgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:36:10 -0400
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com [209.85.213.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w621a3Lx031880;
        Mon, 2 Jul 2018 10:36:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w621a3Lx031880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530495365;
        bh=97hUKQDK73fpqx1i3Mtz5NbC2U0FKM4MGoqXyCZFltM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wIg1P4ba8WiJqppm1qSBQn9/nGRYMsdDUrCpyicNcCullUthtKDsG9qjuXXlbmSvH
         TSIY4YKrWBQpfjqcl7IvDKHskKHiZrR1k/y0LGN2boyeahO1g3hoqV/68eVVpfGyIH
         f6MtiR5C+oCiJeCKJFhlqejncN9DRZXsUFeglh875xTC5w75AwLEqlTzlVNgFlvQ4M
         GpFQ84usVMlJD90QWXxEd36Pkc5F1C5v9jUDWABMj1T1lmMR3wGvdtrAPm5rZwoCzW
         F9xWTXVsfd2ge1A3sLtS6Rfb56xwMacSFSzk2JVNBq/834I35+IpcogFm+PFl5jXg/
         ixHCF1wvkKNqQ==
X-Nifty-SrcIP: [209.85.213.45]
Received: by mail-vk0-f45.google.com with SMTP id l189-v6so3755609vke.1;
        Sun, 01 Jul 2018 18:36:04 -0700 (PDT)
X-Gm-Message-State: APt69E0FHACu1xng2Ja3uVXnkfuUH6v6KUU4Vf6hFOYSI0XHDJLV3G0f
        tyxH5wVCEPwxFzs/wlgmMP97Q78SD4oubgKUyT8=
X-Google-Smtp-Source: AAOMgpfHl45WVK3qqe2xw/u+2WHB75IX8NQ++XgENdStfRfZMnrOByodv6/330hcHaLuML0Bvyy5Lvau17BVgRxWC8A=
X-Received: by 2002:a1f:88:: with SMTP id 130-v6mr13839412vka.154.1530495363431;
 Sun, 01 Jul 2018 18:36:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 18:35:22 -0700 (PDT)
In-Reply-To: <333ae81b-af62-ec2e-3311-5487b1cc90c1@kernel.org>
References: <20180619120719.26921-1-richard@nod.at> <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
 <3320422.EJ8D6C0VHL@blindfold> <d4fdcd1d-db20-1837-a037-0982a042d357@kernel.org>
 <20180625165506.484e025f@bbrezillon> <CAK7LNATyo+7gauyQcRmNfCs8CagU1XdpHHgREMeTvf4rqxpeNQ@mail.gmail.com>
 <20180626200928.29aca979@xps13> <CAK7LNATbmNadK=xPcaQ+seRS_YvH5ZP5SX8z74iOyYcJ0Soicw@mail.gmail.com>
 <333ae81b-af62-ec2e-3311-5487b1cc90c1@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 2 Jul 2018 10:35:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuCqs5ofKnNCSEYhWanD+u2+5NzB7asaYhqb7BVUW_Fw@mail.gmail.com>
Message-ID: <CAK7LNATuCqs5ofKnNCSEYhWanD+u2+5NzB7asaYhqb7BVUW_Fw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

2018-06-27 23:55 GMT+09:00 Dinh Nguyen <dinguyen@kernel.org>:
> Hi Masahiro,
>
> On 06/26/2018 09:52 PM, Masahiro Yamada wrote:
>> 2018-06-27 3:09 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
>>> Hi Masahiro,
>>>
>>> On Tue, 26 Jun 2018 11:38:21 +0900, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>
>>>> 2018-06-25 23:55 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>>>>> On Mon, 25 Jun 2018 09:50:18 -0500
>>>>> Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>>>
>>>>>> On 06/22/2018 10:58 AM, Richard Weinberger wrote:
>>>>>>> Masahiro,
>>>>>>>
>>>>>>> Am Freitag, 22. Juni 2018, 16:37:21 CEST schrieb Masahiro Yamada:
>>>>>>>> Hi Richard,
>>>>>>>>
>>>>>>>>
>>>>>>>> 2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:
>>>>>>>>> The denali NAND flash controller needs at least two clocks to operate,
>>>>>>>>> nand_clk and nand_x_clk.
>>>>>>>>> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
>>>>>>>>> setup_data_interface()") nand_x_clk is used to derive timing settings.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>>>>>>> ---
>>>>>>>>> Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
>>>>>>>>> is not present on this SoC.
>>>>>>>>> But my SoCFPGA knowledge is very limited.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> //richard
>>>>>>>>> ---
>>>>>>>>>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>>>>>>> index 486d4e7433ed..562f7b375bbd 100644
>>>>>>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>>>>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>>>>>>> @@ -754,7 +754,8 @@
>>>>>>>>>                         reg-names = "nand_data", "denali_reg";
>>>>>>>>>                         interrupts = <0x0 0x90 0x4>;
>>>>>>>>>                         dma-mask = <0xffffffff>;
>>>>>>>>> -                       clocks = <&nand_clk>;
>>>>>>>>> +                       clocks = <&nand_clk>, <&nand_x_clk>;
>>>>>>>>> +                       clock-names = "nand", "nand_x";
>>>>>>>>
>>>>>>>>
>>>>>>>> IMHO, this should be
>>>>>>>>
>>>>>>>>                           clocks = <&nand_clk>, <&nand_x_clk>, <&nand_x_clk>;
>>>>>>>>                           clock-names = "nand", "nand_x", "ecc";
>>>>>>
>>>>>> No, it should be just the nand_x and ecc.
>>>>>>
>>>>>> There's already a patch to use the nand_x_clk and not the nand_clk.
>>>>
>>>>
>>>> Different people try to fix the problem in different ways.
>>>>
>>>> I think it is due to miscommunication across sub-systems.
>>>
>>> Is the series named
>>>
>>>         mtd: rawnand: denali: add new clocks and improve
>>>                               setup_data_interface
>>>
>>> still valid?
>>
>> Yes.
>> I believe V4 is valid.
>>
>>
>> Information for Dinh Nguyen:
>>
>> http://patchwork.ozlabs.org/patch/933507/
>> http://patchwork.ozlabs.org/patch/933487/
>> http://patchwork.ozlabs.org/patch/933494/
>> http://patchwork.ozlabs.org/patch/933506/
>>
>>
>> If he is not convinced, I am open to discussion, though.
>
> I wasn't aware of these patches. This patch is staged to go into
> v4.17-rc3 through the arm-soc:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/arch/arm/boot/dts/socfpga.dtsi?h=fixes&id=4eda9b766b042ea38d84df91581b03f6145a2ab0
>
> I think your patch will handle a case where only 1 clock is passed in,
> so it should be okay right?
>

I should be OK,
but please consider the proper fix for v4.19
as Boris suggested.



-- 
Best Regards
Masahiro Yamada
