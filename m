Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80625218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549033989;
	bh=d/FGP4Xb9lbb2DItA5yXdR8+wclJUmpMQqSftxs3rqw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=smegYCx6v9GhiDLqVBZEduzUh94C3Loi2s0KOg6k/fjHzYEAs2aMEcBowRA7Crr5f
	 mP06xRqKFoq9XJetqEXvDVjQIu9VD7wGQ9FIq9xirJHKiVGXHHA2eElqqO2IReV+B1
	 wWqOp7SaQMorKz253Vurm1LCU43f6pE8OD946tu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfBAPNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbfBAPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:13:07 -0500
Received: from [192.168.1.31] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27C921872;
        Fri,  1 Feb 2019 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549033985;
        bh=d/FGP4Xb9lbb2DItA5yXdR8+wclJUmpMQqSftxs3rqw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C2bkJio2YK/1dZfnryMbP+QD5BwWYek0QiZn7fGdoxvUapDWLTsXJaIgL/e5gxtpe
         QAUcBLWLhEFNE/D1+wK8w2dFn1nC7k9K20acUfcrHXJgcQxJYq0YlNau9EJk9VkeXJ
         J1R+3od/kK/WOz7qQEHKdNhwlJHArtgX0bXsB+nA=
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
 <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
Date:   Fri, 1 Feb 2019 09:13:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/19 12:00 AM, Simon Goldschmidt wrote:
> + Marek (as I really want to keep the dts in Linux and U-Boot in sync)

So can you wait until your patch in U-Boot is in?

> On Wed, Jan 30, 2019 at 1:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>>
>>
>> On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
>>> From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>
>>> The documentation for socfpga gen5 says the base address of the sdram
>>> controller is 0xffc20000, while the current devicetree says it is at
>>> 0xffc25000.
>>>
>>> While this is not a problem for Linux, as it only accesses the registers
>>> above 0xffc25000, it *is* a problem for U-Boot because the lower registers
>>> are used during DDR calibration (up to now, the U-Boot driver does not use
>>> the dts address, but that should change).
>>>
>>> To keep Linux and U-Boot devicetrees in sync, this patch changes the base
>>> address to 0xffc20000 and adapts the 2 files where it is currently used.
>>>
>>> This patch changes the dts and 2 drivers with one commit to prevent
>>> breaking the code if dts change and driver change would be split.
>>>
>>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>> ---
>>>
>>>  arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
>>>  arch/arm/mach-socfpga/self-refresh.S | 4 ++--
>>>  drivers/fpga/altera-fpga2sdram.c     | 2 +-
>>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>> index f365003f0..8f6c1a5d6 100644
>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>> @@ -788,9 +788,9 @@
>>>                       reg = <0xfffec000 0x100>;
>>>               };
>>>
>>> -             sdr: sdr@ffc25000 {
>>> +             sdr: sdr@ffc20000 {
>>>                       compatible = "altr,sdr-ctl", "syscon";
>>> -                     reg = <0xffc25000 0x1000>;
>>> +                     reg = <0xffc20000 0x6000>;
>>
>> I don't see the U-Boot device tree having this change. Yes, the
>> documentation does state that the SDR address starts at 0xffc20000, but
>> all of the pertinent registers start at 0x5000 offset. Thus, the
>> starting address should be 0xffc25000.[1]
> 
> You don't see it in U-Boot as I'm working on a patch for that.
> As I wrote in the commit message, U-Boot currently does not use the
> devicetree for the SDR driver, but I want to convert it to do that.
> 
> But before converting, I need to find a clean way to provide the
> register addresses to the driver. That doesn't work with the current dts.
> 
>>
>> [1]
>> https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917
> 
> Well, in [2], you see that the peripheral's address range actually starts
> at 0xffc20000. It's only the public documented registers that start at
> 0xffc25000. I don't know why the lower address range is undocumented.
> Maybe you can help me here?
> 

Yes, the reason these register are not documented is that the ddr
engineers didn't really want anyone outside of their team messing around
with the calibration. These registers, from the limited documentation I
have, are related to the PHY settings. I've been told the calibration
sequence is something of a "black" magic.

Dinh
