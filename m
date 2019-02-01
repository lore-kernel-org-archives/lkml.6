Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4FDC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107F121726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6/HaNf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfBAPuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:50:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36366 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBAPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:50:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so7616283wrp.3;
        Fri, 01 Feb 2019 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L6vOcIJpjK9OcozAFWiyHaLssJG+aBVI05aeTxUznjY=;
        b=C6/HaNf1iGGTFZzDcthxq7cOmbMcnMTvN71vugTJoS1Qm8FBERiwQS+sfo0OkeBUBb
         rU3ikZypozX1Aqxx3UrdNb/BrLmIJeMXaebudD3bgb69URsmTIsOGlHOS2BKRUCB3zp6
         U2Y4bM7fsjNBqfBA5SAiHKKMA0yxsfozNpvyjySN5SySi8lHiIAbA+czlKeZ8eboOfkI
         YDRqOEfPXy5O2meBO+Jy8TMVV5Ty17P86L29ToGSuiDpCbMoQCODNsQVr6D38XxcyBck
         8puJHjL9frZkxeQ0C/h81gqO9dyg/uWrD4AD8FuOZTruIa4rbLL0du0IXZSwEaBA2FlK
         Fftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6vOcIJpjK9OcozAFWiyHaLssJG+aBVI05aeTxUznjY=;
        b=nnDbnRaAYiahMBSPIcreOPQ8pC0Ygz8stXmqonZ5O67HO2VHk+Xg1yWiH+kOVCg6Ef
         uHsALU7HNthpfeMT0l1bjbOVPznDNf5v6GT0KRyD8lyw9GObdEIK/QLWKpoLcN8hnkWL
         EO/p6lqXWQJ3VUqMzTcoq+f7LYg83TpCHuVQ5pN9OPa3MYYsY1nBeQsx94rLOil0T5O3
         vEWaC8bY2LzJ0P6KZFbecztL03h+RpBz0dwEuK0n+CUDNyxLCzVM25vc+7zZs8SKvrfc
         PeVx3dlaLAJy6diCGSJiyvxeopHzWvW+NB0zO6Mm82ivTBR9glW5IBPxFMe8bjft86gn
         KWbg==
X-Gm-Message-State: AJcUukfnA7wf2kjq74nzJoP3WvzytwNICpQbpWgFfeRMdvbFTHppGkFr
        FfmMZraJYTG7pDpe8NRL4vM=
X-Google-Smtp-Source: ALg8bN6BgsKNaEZZz0FywYtvgiSMzHhYiFFcfmG7jdjF8mHuDkSihOzCGkU6f7wcf7GSJOv5ngjpZQ==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr38753603wrn.11.1549036232337;
        Fri, 01 Feb 2019 07:50:32 -0800 (PST)
Received: from ?IPv6:2a02:8071:6a3:700:e52b:4fa:c59b:a6af? ([2a02:8071:6a3:700:e52b:4fa:c59b:a6af])
        by smtp.gmail.com with ESMTPSA id r200sm5183583wmb.36.2019.02.01.07.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:50:31 -0800 (PST)
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
 <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
 <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <e7c314cf-294d-e80a-c9f2-b5e183af6af5@gmail.com>
Date:   Fri, 1 Feb 2019 16:50:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <080c0900-4c34-e097-3e0e-4508951b0ddd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.02.2019 um 16:13 schrieb Dinh Nguyen:
> 
> 
> On 1/30/19 12:00 AM, Simon Goldschmidt wrote:
>> + Marek (as I really want to keep the dts in Linux and U-Boot in sync)
> 
> So can you wait until your patch in U-Boot is in?

Well, yes, this could wait. The problem is we wanted to keep Linux and 
U-Boot dts in sync.

I guess I'll just finish preparing my patch for U-Boot changing the dts 
there and then we'll see which part gets pushed first...

> 
>> On Wed, Jan 30, 2019 at 1:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>
>>>
>>>
>>> On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
>>>> From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>>
>>>> The documentation for socfpga gen5 says the base address of the sdram
>>>> controller is 0xffc20000, while the current devicetree says it is at
>>>> 0xffc25000.
>>>>
>>>> While this is not a problem for Linux, as it only accesses the registers
>>>> above 0xffc25000, it *is* a problem for U-Boot because the lower registers
>>>> are used during DDR calibration (up to now, the U-Boot driver does not use
>>>> the dts address, but that should change).
>>>>
>>>> To keep Linux and U-Boot devicetrees in sync, this patch changes the base
>>>> address to 0xffc20000 and adapts the 2 files where it is currently used.
>>>>
>>>> This patch changes the dts and 2 drivers with one commit to prevent
>>>> breaking the code if dts change and driver change would be split.
>>>>
>>>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>>>> ---
>>>>
>>>>   arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
>>>>   arch/arm/mach-socfpga/self-refresh.S | 4 ++--
>>>>   drivers/fpga/altera-fpga2sdram.c     | 2 +-
>>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>>> index f365003f0..8f6c1a5d6 100644
>>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>>> @@ -788,9 +788,9 @@
>>>>                        reg = <0xfffec000 0x100>;
>>>>                };
>>>>
>>>> -             sdr: sdr@ffc25000 {
>>>> +             sdr: sdr@ffc20000 {
>>>>                        compatible = "altr,sdr-ctl", "syscon";
>>>> -                     reg = <0xffc25000 0x1000>;
>>>> +                     reg = <0xffc20000 0x6000>;
>>>
>>> I don't see the U-Boot device tree having this change. Yes, the
>>> documentation does state that the SDR address starts at 0xffc20000, but
>>> all of the pertinent registers start at 0x5000 offset. Thus, the
>>> starting address should be 0xffc25000.[1]
>>
>> You don't see it in U-Boot as I'm working on a patch for that.
>> As I wrote in the commit message, U-Boot currently does not use the
>> devicetree for the SDR driver, but I want to convert it to do that.
>>
>> But before converting, I need to find a clean way to provide the
>> register addresses to the driver. That doesn't work with the current dts.
>>
>>>
>>> [1]
>>> https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917
>>
>> Well, in [2], you see that the peripheral's address range actually starts
>> at 0xffc20000. It's only the public documented registers that start at
>> 0xffc25000. I don't know why the lower address range is undocumented.
>> Maybe you can help me here?
>>
> 
> Yes, the reason these register are not documented is that the ddr
> engineers didn't really want anyone outside of their team messing around
> with the calibration. These registers, from the limited documentation I
> have, are related to the PHY settings. I've been told the calibration
> sequence is something of a "black" magic.

That's exactly how I thought it would be. However, that's not the best 
attitued for getting code into an open source project like U-Boot. For 
example, I wanted to take a look at the code to see if it can be made 
smaller, but that's unnecessary hard if the registers are not documented...

Regards,
Simon
