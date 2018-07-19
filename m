Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED32206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="De+mWPLV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8VoB3qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED32206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeGSUWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:22:13 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40638 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeGSUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:22:12 -0400
Received: by mail-vk0-f65.google.com with SMTP id s23-v6so4967229vks.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s1YPoIFX3roIUs6tHjkjOZjBAXMjjaZ2a/m4FhQzxso=;
        b=De+mWPLVZemo+6dHdDm+M1BxsVRcGHZeFRsNN03Ro7TQUqHmrl38aKzMGZjEzzfNo0
         8DKHm6vQ4t/ajVkKvKkMQqC2pTFfxwIOIWI1hmj04KnazZ5MGNCtWAWGECQ73gtNYyo2
         3l4u+ZoRF5hG/5LymS44R0OhbJhlMBcJ4QC3A5y/kvf9a4V3GH6wWOo9QqWfDSXhnpsf
         NAx/CZcK4o4p79EPDyKemw0CM1bgSSCeNOHY1jNNMyDQuvFnEwQHen1n26csY+9D+WuZ
         XUahmM9/866u7UQePKFAN+V2UF1hozFHEHz7XZ4C3SKP7jqh3bzqzyK1wCoz7t4i0EPf
         xTBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s1YPoIFX3roIUs6tHjkjOZjBAXMjjaZ2a/m4FhQzxso=;
        b=I8VoB3qxSi8Gxw0Q5MKZY360oXdgAoufYkMW+0EFSbfb0cwL4S6tQyUTLewfdl3OC8
         jmm2U7t59Pbu/eAxrS89aRMvy7v1EDRBOHHeTyEjmdLi7bjrEdnRj0X1ZC3RzFXV96Qg
         1DoyrIIhifBYJu5K3Yi2QGmwjCYYvONUB8TAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=s1YPoIFX3roIUs6tHjkjOZjBAXMjjaZ2a/m4FhQzxso=;
        b=ACW0e00fRG5+0UTQfpD55oHHn2Cu3JqFXRUnS5Pk0Wjmy6siXXKsnhBj4NERzFMPja
         PV1cgUZAm7iMZ3k7/ivBCDjYPN9GI2EcMBGoydCo0kL2iC0YkhijXhiAqp7Qf1okeCV4
         TBSBGFlvzOMkbzwm/lRDhXZoSYxu6MB/jI1G2E+p8l3co2lV5IgyQBkStvKipavwjLmj
         qxyaVQJVbNItV3PXLzmfJvUeGT/lQkBGRyMdldQDs4Ai7yjLg/YBfmo4/BqHNtYhdLj1
         spSJsFT77H0u5vjUMkTVRdsgU7pi9k3d4LL8LGucNGskNhMMQKEL/YcqOhcdhv5LhCgi
         AYYw==
X-Gm-Message-State: AOUpUlHMiu6aZvMwTUWLySZnJV80o3Jd29lgxHIo7Pu7b7BxJSIFCmCN
        hNsd1vJK8auqRlGT9s+CWfXic5r4BnikqT6jPMOZeQ==
X-Google-Smtp-Source: AAOMgpdK15PzXDJhnKOElBdOJvHbm49yvLaqukor5GQ0lwvmKHsMOeRiwdsSxOcRjzJeD4BxOAExmbS+HwSaI/nYudY=
X-Received: by 2002:a1f:8511:: with SMTP id h17-v6mr6737261vkd.69.1532029056339;
 Thu, 19 Jul 2018 12:37:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 12:37:35 -0700 (PDT)
In-Reply-To: <b1a787db-40b2-ab63-124b-84055b91c4a9@codeaurora.org>
References: <20180718180431.48580-1-dianders@chromium.org> <20180718180431.48580-3-dianders@chromium.org>
 <6248e3cc-f458-7dec-143c-7d2aeccde590@codeaurora.org> <CAD=FV=XrxNgXq1BcMQaQGsb-cHeckxr2LcCKSZxcgX-ikWv4uA@mail.gmail.com>
 <b1a787db-40b2-ab63-124b-84055b91c4a9@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 Jul 2018 12:37:35 -0700
X-Google-Sender-Auth: 5xLjYRPHRK2Vz6bpAf-i7k5lpdU
Message-ID: <CAD=FV=Wh9p0QsM0q2zPtP7nmPEf0G3n_YVc9+g-Zq36o11nAKg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Graham Roff <grahamr@qti.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 19, 2018 at 12:02 PM, Taniya Das <tdas@codeaurora.org> wrote:
>
>
> On 7/19/2018 11:25 PM, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Thu, Jul 19, 2018 at 4:04 AM, Taniya Das <tdas@codeaurora.org> wrote:
>>>
>>> Hi Doug,
>>>
>>> Please find my comments inline.
>>>
>>> On 7/18/2018 11:34 PM, Douglas Anderson wrote:
>>>>
>>>>
>>>> Add both the interface and core clock.
>>>>
>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>> ---
>>>>
>>>>    drivers/clk/qcom/gcc-sdm845.c | 73
>>>> +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 73 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/qcom/gcc-sdm845.c
>>>> b/drivers/clk/qcom/gcc-sdm845.c
>>>> index 0f694ed4238a..2ee96f9bc217 100644
>>>> --- a/drivers/clk/qcom/gcc-sdm845.c
>>>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>>>> @@ -162,6 +162,20 @@ static const char * const gcc_parent_names_10[] = {
>>>>          "core_bi_pll_test_se",
>>>>    };
>>>>    +static const struct parent_map gcc_parent_map_9[] = {
>>>> +       { P_BI_TCXO, 0 },
>>>> +       { P_GPLL0_OUT_MAIN, 1 },
>>>> +       { P_GPLL0_OUT_EVEN, 6 },
>>>> +       { P_SLEEP_CLK, 7 },
>>>
>>>
>>>
>>> SRC 7 has 'core_bi_pll_test_se' and not 'sleep_clk'.
>>>
>>> Please use the 'gcc_parent_map_0'
>>
>>
>> Are you sure?  I'm looking at a doc showing the bitfields of
>> GCC_QSPI_CORE_CFG_RCGR.  It says:
>>
>> 0x0: bi_tcxo.
>> 0x1: gpll0_out_main.
>> 0x6: gpll0_out_even.
>> 0x7: sleep_clk.
>>
>> This contrasts with other clocks using 'gcc_parent_map_0' (for
>> instance "gcc_qupv3_wrap0_s0_clk_src") where 0x7 is simply not listed
>> in my doc.
>>
>> ...so either my doc is wrong or yours is.  Any way to resolve that?
>>
>
> I am not sure of the document you are referring, but the connectivity
> details I have shared are from the design side and they are ones which we
> have to follow.

I'll start up a separate thread about this w/ you and the people I
received the doc from.  It's concerning if the doc we received is
wrong.


>>> F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
>>
>>
>> Sure.  For my edification, is there a reason to use main vs. even?
>>
>
> The frequencies to be generated are also as per design data. These source
> usage depends on timing closure for certain max frequencies.

Sounds a bit like a non-answer, but I guess it's not critical to
understand the mysteries here.



>>>> +static struct clk_rcg2 gcc_qspi_core_clk_src = {
>>>> +       .cmd_rcgr = 0x4b008,
>>>> +       .mnd_width = 0,
>>>> +       .hid_width = 5,
>>>> +       .parent_map = gcc_parent_map_9,
>>>> +       .freq_tbl = ftbl_gcc_qspi_core_clk_src,
>>>> +       .clkr.hw.init = &(struct clk_init_data){
>>>> +               .name = "gcc_qspi_core_clk_src",
>>>> +               .parent_names = gcc_parent_names_9,
>>>> +               .num_parents = 4,
>>>> +               .ops = &clk_rcg2_floor_ops,
>>>
>>>
>>>
>>> Could we use the rcg2_ops instead?
>>
>>
>> I'd rather not.  Any reason why you think that'd be a good idea?
>>
>> Specifically imagine that we have a SPI flash chip that's rated to run
>> at a max of 20 MHz.  In the device tree we'd ideally want to specify:
>>
>>    spi-max-frequency = <20000000>;
>>
>> It appears that we need to run the SPI core as 4 times the rate of the
>> SPI bus, so we'd try to set this clock to 80 MHz.  If we round up
>> we'll end up at 100 MHz or 150 MHz for the SPI core and have a SPI bus
>> rate of 25 MHz or 37.5 MHz.  That would violate the whole idea of
>> "spi-max-frequency".  It's much better to round down to 75 MHz.
>>
>>
>> In general I've always seen that for safety it's always better the
>> round clocks down and round voltage up, so I was actually confused by
>> the fact that most of the clocks in this file used rcg2_ops instead of
>> clk_rcg2_floor_ops...  I'd be curious if we should we change more of
>> them to clk_rcg2_floor_ops.  As a random example I'll take
>> "gcc_sdcc2_apps_clk_src".  If someone happened to have a full sized SD
>> slot and put an MMC card in then you'd be in trouble.  Why?
>>
>> For MMC a valid rate to request is 52000000.  When the SD card core
>> requests this you'll round up to 100 MHz.  Oops.  That makes the card
>> not work.
>>
>> I just happen to have a micro to full size adapter at my desk and a
>> 2GB MMC card and I can confirm that's a true bug that prevents this
>> card from enumerating.  Changing this to a clk_rcg2_floor_ops fixes
>> it.  True that it's unlikely anyone will really plug a MMC card into
>> this slot, but I fail to see the advantage of rounding up when
>> rounding down is safer.
>>
>>
>
> These ops were mostly for SDCC/MMC usage only as this was a requirement of
> rounding the frequency, as the clock framework didn't provide any such API.
> The QSPI should be safe to use the normal rcg ops as the frequency requests
> should be from the table itself. Thus request is to move to use the
> rcg2_ops.

I'm not totally sure I understand what you say here.  I'll try to
break my confusion down:

1. I think you're saying that "clk_rcg2_floor_ops" was introduced
originally for use by SD/MMC.  Is that right?  ...but my example above
shows specifically that SD/MMC is _not_ using "clk_rcg2_floor_ops".


2. I'm confused about you say that the QSPI driver will only be
requesting rates from the table itself.  Does that mean we need to
duplicate the table here in the QSPI driver so the QSPI driver will
only ask for exact rates that it knows the clock driver will be able
to provide?  ...or are you saying that we should always specify SPI
transfer rates in the device tree that we know will be achievable by
the clock driver?  Both of these ideas seem fragile.


I'm still confused about what benefit you think we get for rounding up
for this clock.


-Doug
