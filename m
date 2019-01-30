Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621B0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B1F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NexrhOZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfA3Q2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:28:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfA3Q2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:28:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so179748wmt.0;
        Wed, 30 Jan 2019 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=accfh5WT1jHRMAGwXZn+sQk9d/LfJqCpSutfwrpI8Vs=;
        b=NexrhOZOEa+2rWsYfGMB04hVUhbdZ27nTmAx/uNeu9QT3cTDBK9K+7DGMsC9zIIAdt
         GYmS6JcsEO3wPx7wvLgWFMlPiLsTf+4liH80eUwUujg6r/mV+GzbEdMYcXabaEIQUjyu
         E2t/XwXvpuSlXarwoW1m8Cn++LKbldOQ5zhO10cg5GqXFX/Cd3AVNFmhShlF0yjYhXKu
         Qk8hIl+gFW/TpBLNPZtcF0TSTflb9uTGmeXdkN+VRuMUu28xKaB9cWJh0wYPr4wCi7bc
         YKJcJPGybMtu+iu47giZDOwcOsmXM5cSsCGUHITRxsX4/3sI/gptpimL0YPEiaupq+jY
         33zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=accfh5WT1jHRMAGwXZn+sQk9d/LfJqCpSutfwrpI8Vs=;
        b=sfhFbX/BopZJL2DuqpZmtxiZ2dspYJAvC+11uXvhhnIhUhoxkMQJZttaNEBTUdvoen
         UwMFL0qQgy1/j8E98hx4NJZ06+CU5eIRhNLg2IfQZdd7VrYDdWkR5+9+7dG0lDENLrSF
         ckgD6lv4jOaQioBtyP3mW5Zsy8vf+A5ZlbhRBZdfrFWMxAzWcFclcU/hm11wcgmgo39U
         3DLTWys9D8FN99CljSElfqLm0Jmm73MMfwwsJaUjB0aXLKzZX70K2PhnFF0yx/WDpo1F
         bfgEVygm/e+wyY6hWslbD6kBC7SvEWy9qqzBPW1pgBpcQQModDhN4Y//Y+UUWl7KoTJW
         A7UQ==
X-Gm-Message-State: AHQUAubdZr9WkjS3tR3QIHSh38CLf1Ob4qqKaJ4LHNdJwKn4ccx623Th
        7VQfR5dqvN39xvY6ua4GkiAAEO3t
X-Google-Smtp-Source: AHgI3IZEEBz5zy6cwni0QQdzMi8zm+BcOvr+ODmW5KJ+t48zMVRl6pcBN03B/fW8NmHWhghiN2WVTA==
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr26189787wmb.115.1548865694890;
        Wed, 30 Jan 2019 08:28:14 -0800 (PST)
Received: from ?IPv6:2a02:8071:6a3:700:e52b:4fa:c59b:a6af? ([2a02:8071:6a3:700:e52b:4fa:c59b:a6af])
        by smtp.gmail.com with ESMTPSA id o4sm2075559wrq.66.2019.01.30.08.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 08:28:13 -0800 (PST)
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
 <961ac9bf-d111-2e42-a39b-b26c499afcc0@kernel.org>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <ad197fef-e946-1861-5ace-f4e8e4f1c044@gmail.com>
Date:   Wed, 30 Jan 2019 17:28:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <961ac9bf-d111-2e42-a39b-b26c499afcc0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.01.2019 um 16:50 schrieb Dinh Nguyen:
> 
> 
> On 1/30/19 12:00 AM, Simon Goldschmidt wrote:
>> + Marek (as I really want to keep the dts in Linux and U-Boot in sync)
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
> 
> That's great! Can you elaborate on what is the impetus for converting
> the SDR driver to use the dts?

The initial reason to do so was to move its reset handling from U-Boot 
SPL to the driver itself. Moving from ad-hoc code to using the reset driver.

And when it's being converted to using the reset handle from dts, I 
think it should also use the base address from dts.

Regards,
Simon
