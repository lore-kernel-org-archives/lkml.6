Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E19ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7D420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Gla3uuXd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2INEFPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbeGSSjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:39:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41853 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbeGSSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:39:53 -0400
Received: by mail-vk0-f68.google.com with SMTP id o82-v6so2987221vko.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JLh42h7N0fb7RZFrGDe7SIo6sjO85tyCmjrBY6aR5So=;
        b=Gla3uuXdLkYpmii6HFZzQFZGTqRKYOKlg4sOIlFMvnQCqS7RTx3TNDXEI9wYf/crmh
         5Tiq90Nx0vy+E6ovxHtC0MtlcqzZ98/ePm7/s8iP+WXS1Sj+zCJ1/LCBSeazBsZN6XVP
         iAA/zubpARhgWJY/wOzYeXK4th6RzLbd4jezsBK6wl+wlYA0mSwypglq/eb9I4phe3W2
         WqmiRuPl0h26frTmX67/E32TLV0bMW/UckvJtDadSbH8JBOflr7YnDEzXCddAnLrgVyC
         xry5WynfTxi3UZzw1ujuRoaKRHXwlSjBXNErhlpg/nQ05PdXBkrM3J9q4HZQ6IvKFFrU
         otcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JLh42h7N0fb7RZFrGDe7SIo6sjO85tyCmjrBY6aR5So=;
        b=e2INEFPcofJBfcQNWqU/861BcmblMSXtIaaWI4RBCFrA75ooU5yjqkVADnV0mWkg0+
         sdv0ke1eW6BBHc03jvwjwx/QdiLQpBTQZ3/DarT5gkpwF7UBZ3nADlAzp/FG2Vx8EfGI
         7JGStxljbxb1fofF+2W2HrTZiR7s8YFbQUQvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JLh42h7N0fb7RZFrGDe7SIo6sjO85tyCmjrBY6aR5So=;
        b=mGoUldxTOoa3WyKEsYAOlrYt4isjeGR/nAUqU7t+k7oRmy4+LgBDHwW3rfsxhCTMDJ
         gSezVdZXZF76qEUen1b9pykW8TeeMP392M2mQiPzEcKxPdzFtpP6EicfBhygJJsFtxDE
         fUacBygpOrWEMfOf56G1NUGZ/4KnsC61H+vbe3r0Xycpk1oCp26ObGGKzTwhQxdsOxAB
         xgMFN/FpmP7CgmsDxL3LZfiwo8BlHwy7vlLeOBscnu1bYPcjwoLB5d9MQgaAZ8PUMo4f
         Eb2l7HwS/10mTkDBW7blRVkyoJHPmleeaedBbBdggb9ox5iky1QnkPbSKjLwWojj2J4e
         mKPQ==
X-Gm-Message-State: AOUpUlFQ8SlcJFX2psuil9Y6QIsEvyLxPp91ZOZAm21cpRJS1KZeyhZK
        AAKbq+R8UPeHBPizXEM4zYHuEtA6+nv1ny7XYYiW3Q==
X-Google-Smtp-Source: AAOMgpcCkbSNKtAezJQ/AUCNjPiK2CoIjAwtfrI2QiIaqqFgcu9ajpw1vHUa/5FLdaY1GOruODBhggZIJGg8xZcV6Yc=
X-Received: by 2002:a1f:acc4:: with SMTP id v187-v6mr6121803vke.32.1532022936693;
 Thu, 19 Jul 2018 10:55:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 10:55:35 -0700 (PDT)
In-Reply-To: <6248e3cc-f458-7dec-143c-7d2aeccde590@codeaurora.org>
References: <20180718180431.48580-1-dianders@chromium.org> <20180718180431.48580-3-dianders@chromium.org>
 <6248e3cc-f458-7dec-143c-7d2aeccde590@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 Jul 2018 10:55:35 -0700
X-Google-Sender-Auth: xilub6Qa0Be_BgCCq9fKvs8v-ZQ
Message-ID: <CAD=FV=XrxNgXq1BcMQaQGsb-cHeckxr2LcCKSZxcgX-ikWv4uA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
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

On Thu, Jul 19, 2018 at 4:04 AM, Taniya Das <tdas@codeaurora.org> wrote:
> Hi Doug,
>
> Please find my comments inline.
>
> On 7/18/2018 11:34 PM, Douglas Anderson wrote:
>>
>> Add both the interface and core clock.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>   drivers/clk/qcom/gcc-sdm845.c | 73 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> index 0f694ed4238a..2ee96f9bc217 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -162,6 +162,20 @@ static const char * const gcc_parent_names_10[] = {
>>         "core_bi_pll_test_se",
>>   };
>>   +static const struct parent_map gcc_parent_map_9[] = {
>> +       { P_BI_TCXO, 0 },
>> +       { P_GPLL0_OUT_MAIN, 1 },
>> +       { P_GPLL0_OUT_EVEN, 6 },
>> +       { P_SLEEP_CLK, 7 },
>
>
> SRC 7 has 'core_bi_pll_test_se' and not 'sleep_clk'.
>
> Please use the 'gcc_parent_map_0'

Are you sure?  I'm looking at a doc showing the bitfields of
GCC_QSPI_CORE_CFG_RCGR.  It says:

0x0: bi_tcxo.
0x1: gpll0_out_main.
0x6: gpll0_out_even.
0x7: sleep_clk.

This contrasts with other clocks using 'gcc_parent_map_0' (for
instance "gcc_qupv3_wrap0_s0_clk_src") where 0x7 is simply not listed
in my doc.

...so either my doc is wrong or yours is.  Any way to resolve that?


>> +};
>> +
>> +static const char * const gcc_parent_names_9[] = {
>> +       "bi_tcxo",
>> +       "gpll0",
>> +       "gpll0_out_even",
>> +       "core_pi_sleep_clk",
>> +};
>> +
>>   static struct clk_alpha_pll gpll0 = {
>>         .offset = 0x0,
>>         .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
>> @@ -358,6 +372,31 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src =
>> {
>>         },
>>   };
>>   +static const struct freq_tbl ftbl_gcc_qspi_core_clk_src[] = {
>> +       F(19200000, P_BI_TCXO, 1, 0, 0),
>> +       F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
>> +       F(75000000, P_GPLL0_OUT_EVEN, 4, 0, 0),
>> +       F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
>
>
> Is SW planning to use this frequency?

At the moment I actually am using it.  I haven't done signal analysis,
but in quick testing I couldn't properly read the SPI at faster than a
25 MHz SPI bus which translates to 100 MHz here.  Interestingly, it
seems like folks in your boot team came to the same conclusion since I
see them setting this bus to 100 MHz at
<https://review.coreboot.org/#/c/coreboot/+/25392/25/src/soc/qualcomm/sdm845/bootblock.c>
too.


>> +       F(150000000, P_GPLL0_OUT_EVEN, 2, 0, 0),
>
>
> F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),

Sure.  For my edification, is there a reason to use main vs. even?


>> +       F(300000000, P_GPLL0_OUT_EVEN, 1, 0, 0),
>
>
> F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),

No problem.


>> +       F(400000000, P_GPLL0_OUT_MAIN, 1.5, 0, 0),

No problem.


> Please remove this, the Max supported frequency is 300MHz.
>>
>> +       { }
>> +};
>> +
>> +static struct clk_rcg2 gcc_qspi_core_clk_src = {
>> +       .cmd_rcgr = 0x4b008,
>> +       .mnd_width = 0,
>> +       .hid_width = 5,
>> +       .parent_map = gcc_parent_map_9,
>> +       .freq_tbl = ftbl_gcc_qspi_core_clk_src,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "gcc_qspi_core_clk_src",
>> +               .parent_names = gcc_parent_names_9,
>> +               .num_parents = 4,
>> +               .ops = &clk_rcg2_floor_ops,
>
>
> Could we use the rcg2_ops instead?

I'd rather not.  Any reason why you think that'd be a good idea?

Specifically imagine that we have a SPI flash chip that's rated to run
at a max of 20 MHz.  In the device tree we'd ideally want to specify:

  spi-max-frequency = <20000000>;

It appears that we need to run the SPI core as 4 times the rate of the
SPI bus, so we'd try to set this clock to 80 MHz.  If we round up
we'll end up at 100 MHz or 150 MHz for the SPI core and have a SPI bus
rate of 25 MHz or 37.5 MHz.  That would violate the whole idea of
"spi-max-frequency".  It's much better to round down to 75 MHz.


In general I've always seen that for safety it's always better the
round clocks down and round voltage up, so I was actually confused by
the fact that most of the clocks in this file used rcg2_ops instead of
clk_rcg2_floor_ops...  I'd be curious if we should we change more of
them to clk_rcg2_floor_ops.  As a random example I'll take
"gcc_sdcc2_apps_clk_src".  If someone happened to have a full sized SD
slot and put an MMC card in then you'd be in trouble.  Why?

For MMC a valid rate to request is 52000000.  When the SD card core
requests this you'll round up to 100 MHz.  Oops.  That makes the card
not work.

I just happen to have a micro to full size adapter at my desk and a
2GB MMC card and I can confirm that's a true bug that prevents this
card from enumerating.  Changing this to a clk_rcg2_floor_ops fixes
it.  True that it's unlikely anyone will really plug a MMC card into
this slot, but I fail to see the advantage of rounding up when
rounding down is safer.


-Doug
