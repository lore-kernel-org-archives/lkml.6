Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680E3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FA525F6E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSeSiNQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FA525F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934566AbeF0O4E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933868AbeF0O4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:56:02 -0400
Received: from [192.168.1.22] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BB825EFB;
        Wed, 27 Jun 2018 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530111361;
        bh=8sK6GdLClZNK93uZBpJ5V9yM8eIfcjf+6F6yicfqJhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nSeSiNQMcLrEoc4C52pmGfc3UWLmyEI6CFOMKcxqWOb6q/rg9TkEvEmSe1PASOu4/
         D1eLJesORQCRKtcvMkSiKp0Ghu5xTGFzv2oNCOHh6h8UoyuquowAejEt3iW7JijYMR
         z0rUR4DPN+4xWt0TXVTBDtaaQaX8ze0IQh1h3g6I=
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marek.vasut@gmail.com>
References: <20180619120719.26921-1-richard@nod.at>
 <CAK7LNASgPa4D0Siyo3mvK_AJ2zaECDXGaMEn-iNzQ9PFXFir+w@mail.gmail.com>
 <3320422.EJ8D6C0VHL@blindfold>
 <d4fdcd1d-db20-1837-a037-0982a042d357@kernel.org>
 <20180625165506.484e025f@bbrezillon>
 <CAK7LNATyo+7gauyQcRmNfCs8CagU1XdpHHgREMeTvf4rqxpeNQ@mail.gmail.com>
 <20180626200928.29aca979@xps13>
 <CAK7LNATbmNadK=xPcaQ+seRS_YvH5ZP5SX8z74iOyYcJ0Soicw@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <333ae81b-af62-ec2e-3311-5487b1cc90c1@kernel.org>
Date:   Wed, 27 Jun 2018 09:55:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATbmNadK=xPcaQ+seRS_YvH5ZP5SX8z74iOyYcJ0Soicw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 06/26/2018 09:52 PM, Masahiro Yamada wrote:
> 2018-06-27 3:09 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
>> Hi Masahiro,
>>
>> On Tue, 26 Jun 2018 11:38:21 +0900, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>
>>> 2018-06-25 23:55 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>>>> On Mon, 25 Jun 2018 09:50:18 -0500
>>>> Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>>
>>>>> On 06/22/2018 10:58 AM, Richard Weinberger wrote:
>>>>>> Masahiro,
>>>>>>
>>>>>> Am Freitag, 22. Juni 2018, 16:37:21 CEST schrieb Masahiro Yamada:
>>>>>>> Hi Richard,
>>>>>>>
>>>>>>>
>>>>>>> 2018-06-19 21:07 GMT+09:00 Richard Weinberger <richard@nod.at>:
>>>>>>>> The denali NAND flash controller needs at least two clocks to operate,
>>>>>>>> nand_clk and nand_x_clk.
>>>>>>>> Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
>>>>>>>> setup_data_interface()") nand_x_clk is used to derive timing settings.
>>>>>>>>
>>>>>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>>>>>> ---
>>>>>>>> Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
>>>>>>>> is not present on this SoC.
>>>>>>>> But my SoCFPGA knowledge is very limited.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> //richard
>>>>>>>> ---
>>>>>>>>  arch/arm/boot/dts/socfpga.dtsi | 3 ++-
>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>>>>>> index 486d4e7433ed..562f7b375bbd 100644
>>>>>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>>>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>>>>>> @@ -754,7 +754,8 @@
>>>>>>>>                         reg-names = "nand_data", "denali_reg";
>>>>>>>>                         interrupts = <0x0 0x90 0x4>;
>>>>>>>>                         dma-mask = <0xffffffff>;
>>>>>>>> -                       clocks = <&nand_clk>;
>>>>>>>> +                       clocks = <&nand_clk>, <&nand_x_clk>;
>>>>>>>> +                       clock-names = "nand", "nand_x";
>>>>>>>
>>>>>>>
>>>>>>> IMHO, this should be
>>>>>>>
>>>>>>>                           clocks = <&nand_clk>, <&nand_x_clk>, <&nand_x_clk>;
>>>>>>>                           clock-names = "nand", "nand_x", "ecc";
>>>>>
>>>>> No, it should be just the nand_x and ecc.
>>>>>
>>>>> There's already a patch to use the nand_x_clk and not the nand_clk.
>>>
>>>
>>> Different people try to fix the problem in different ways.
>>>
>>> I think it is due to miscommunication across sub-systems.
>>
>> Is the series named
>>
>>         mtd: rawnand: denali: add new clocks and improve
>>                               setup_data_interface
>>
>> still valid?
> 
> Yes.
> I believe V4 is valid.
> 
> 
> Information for Dinh Nguyen:
> 
> http://patchwork.ozlabs.org/patch/933507/
> http://patchwork.ozlabs.org/patch/933487/
> http://patchwork.ozlabs.org/patch/933494/
> http://patchwork.ozlabs.org/patch/933506/
> 
> 
> If he is not convinced, I am open to discussion, though.

I wasn't aware of these patches. This patch is staged to go into
v4.17-rc3 through the arm-soc:

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/arch/arm/boot/dts/socfpga.dtsi?h=fixes&id=4eda9b766b042ea38d84df91581b03f6145a2ab0

I think your patch will handle a case where only 1 clock is passed in,
so it should be okay right?

Dinh


