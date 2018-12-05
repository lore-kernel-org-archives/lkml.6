Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14161C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D7220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkhd4E1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D7220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeLENe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:34:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLENe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:34:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so19740974wrb.2;
        Wed, 05 Dec 2018 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r1OA3q6YJs/OPuN8QenAuS1r1CZLv2kBy91Ys95FEjo=;
        b=Vkhd4E1VzK2VItiAapmpyqlSukxTetzj4w+daM4C+WsjsvdNbaZJgYbMAS+VeaHS3V
         1Fg75cZciw6g3DQkP2L/XHQ43jRZ31a7C69Q2YOLQBvw/V2dDL7j4Mp7DJKF97sJ07IQ
         3uiuRY27IBO9skqZRmCoNuooF1qDPpKgY0RFAGY/F44UITiQuLiiTGRX3180+S2ahvcO
         UMG321H0y7BdiIj4+FBvyzxLnPksZ10CIzHJrRmX6VBvpUu5SNf5pBSEombpYsAQdcJP
         c5tHQCzS5dYUaKCDivb1kcB6a4DD1wqCzSFb+JZUuRBQiz7NLIm0DWqxZe7VbpmH4FWw
         MJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1OA3q6YJs/OPuN8QenAuS1r1CZLv2kBy91Ys95FEjo=;
        b=NGHEe8IiNU/Mc6U+ycNIlx++jiYgdS6YHlb7ILc1V6H97lokJPsQdpCmMzixDNUVmO
         JYSPnZOXszjNMrsLy5w3yjEPb/UbK+JxtKd+Hi65gmBv2UA7fdDY56Wh1Wn4/Dw98eVL
         9HbgFWQgW8Oaq2JYIyqgTmepm+ZEzF8+EkVGuPMIm9ekRgROZVkLCnS2hT5Dm0/6cFn7
         tEcRkEedLvI+B2/YmT2P0idQBipjpDod2pLVpSOEAEmYexpThBRKm3zIu7n4hujyLQq6
         vXaKpQYNPqquXLQCkzMOmipScTx5prztgpN2UggY2pypml66KbyzHouaCm/+LSwDOOhi
         e+ow==
X-Gm-Message-State: AA+aEWalPakbIZvgxnz6Xb4o9eJh9v9za7udxnbooL23q8dKlhDf1Nrj
        p79D9d2QNXQwRG/JcTwGTq8=
X-Google-Smtp-Source: AFSGD/WyITv68sP7IEVoA/+0sFX+0YObzMyUUWwoNLyHpppMlYEfCrqa6tdUun1KMxx/+dIfyZs8FA==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr21833150wrd.294.1544016863771;
        Wed, 05 Dec 2018 05:34:23 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id c13sm44328386wrb.38.2018.12.05.05.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 05:34:23 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     masonccyang@mxic.com.tw,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
 <CAMuHMdV-Ca5sderSKmdbtovKrd-Z7piwVZbwDtB6vVXPa8Q5AA@mail.gmail.com>
 <8e667f91-70bd-795c-094f-23c919c3802c@gmail.com>
 <CAMuHMdXF9PtWgjUKaTomkr4X_00HARQ_1uZPROWUr910HLVMCA@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <941aca45-185a-fb99-f5d1-d12b3bcad6de@gmail.com>
Date:   Wed, 5 Dec 2018 14:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXF9PtWgjUKaTomkr4X_00HARQ_1uZPROWUr910HLVMCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2018 02:31 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Wed, Dec 5, 2018 at 2:25 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 12/05/2018 02:15 PM, Geert Uytterhoeven wrote:
>>> On Wed, Dec 5, 2018 at 1:57 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 12/05/2018 08:44 AM, masonccyang@mxic.com.tw wrote:
>>>>>> "Marek Vasut" <marek.vasut@gmail.com>
>>>>>> 2018/12/05 上午 10:04
>>>>>> On 12/03/2018 10:18 AM, Mason Yang wrote:
>>>>>>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>>>>>>>
>>>>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>
>>>>>>> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>>>>>>> +{
>>>>>>> +   /*
>>>>>>> +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>>>>>>> +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>>>>>>> +    *   0x0 : the delay is biggest,
>>>>>>> +    *   0x1 : the delay is 2nd biggest,
>>>>>>> +    *   0x3 or 0x6 is a recommended value.
>>>>>>> +    */
>>>>>>
>>>>>> Doesn't this vary by SoC ? I think H3 ES1.0 had different value here,
>>>>>> but I might be wrong.
>>>>>
>>>>> I check the Renesas bare-metal code, mini_monitor v4.01.
>>>>> It set 0x03 or 0x0 and I test them w/ 0x0, 0x3 and 0x6 are all OK.
>>>>
>>>> Shouldn't this somehow use the soc_device_match() then and configure it
>>>> accordingly for various chips ? Like eg. the r8a7795-cpg-mssr driver does.
>>>
>>> Please don't use soc_device_match() for per-SoC configuration, if
>>> you already have of_device_id.data.
>>
>> I mean, the value is different on H3 ES1 and ES2 iirc, that's what
>> soc_device_match() is for, right ?
> 
> Oh, it differs between revisions, too?
> Yes, in that case you need soc_device_match().
> 
>>> BTW, this drivers support r8a7795 only (for now), as per the compatible
>>> value.
>>
>> 77995
> 
> Sorry, typo on my side. So H3 is not yet supported ;-)

It's coming the minute this lands mainline, so we should make it easy to
add.

>>>>>>> +#ifdef CONFIG_RESET_CONTROLLER
>>>>>>
>>>>>> Just make the driver depend on reset controller.
>>>>>
>>>>> ?
>>>>> please refer to
>>>>> https://github.com/torvalds/linux/blob/master/drivers/clk/renesas/renesas-cpg-mssr.c
>>>>>
>>>>> line 124 ~ 126
>>>>
>>>> This seems like a stopgap measure for systems which do not have a reset
>>>> api compatible controller. Geert ?
>>>
>>> So far CONFIG_RESET_CONTROLLER is optional.
>>
>> My understanding is that for this IP, it can well be mandatory, since
>> all the chips have a reset wired to the IP internally.
> 
> That's what I was trying to find out, hence my question about the purpose.
> 
>>>>>>> +         regmap_write(rpc->regmap, RPC_SMWDR0,
>>>>>>> +                 *(u32 *)(tx_buf + pos));
>>>>>>
>>>>>> *(u32 *) cast is probably not needed , fix casts globally.
>>>>>
>>>>> It must have it!
>>>>
>>>> Why ?
>>>
>>> Else you get a compiler warning, as tx_bug is void *.
>>
>> Don't you need some get_unaligned() in that case ? txbuf+pos can well be
>> unaligned if it's void * .
> 
> True, but IIRC, arm64 can handle that, right?
> Don't know about SuperH.

Oh, that's right, there are SH systems with RPC. Right.

>>>>>>> +#ifdef CONFIG_PM_SLEEP
>>>>>>> +static int rpc_spi_suspend(struct device *dev)
>>>>>>> +{
>>>>>>> +   struct platform_device *pdev = to_platform_device(dev);
>>>>>>> +   struct spi_master *master = platform_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +   return spi_master_suspend(master);
>>>>>>
>>>>>> Won't the SPI NOR lose state across suspend ? Is that a problem ?
>>>>>
>>>>> I don't think so.
>>>>> Because when the device is not in operation and CS# is high,
>>>>> it is put in stand-by mode.
>>>>
>>>> Is the power to the SPI NOR retained ?
>>>
>>> Not if PSCI system suspend turns of power to the SoC.
>>
>> And is that a problem ?
> 
> Good question!

That's what we need an answer to :)

-- 
Best regards,
Marek Vasut
