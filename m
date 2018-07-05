Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E3CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666DD24118
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="m/pzTVUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666DD24118
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeGEOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:22:37 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:39942 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeGEOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:22:13 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B3B665C0744;
        Thu,  5 Jul 2018 16:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530800531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zl8ofzRANXLs9Hjce3g4Dyb2rqTheOVa7YgIUa4KqXw=;
        b=m/pzTVUM3tEPQQ3H/QRFwor07caeex72UKvgDRtUFT8vgbknNIMJv8Bt3g3liwRpLZS5s0
        IT0z1hYx2XDU6nxl0Jjcc/nHUnN3xDj3YvtYBC7UbxW5+B8jt2bVHVNtf//uPhl8i1H4xZ
        Rz9h1Q7BPaetvdHVidmDmbD0KxUQIc4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 16:22:10 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
In-Reply-To: <CAPDyKFou773HgPzE29Ynr2MVFcaOhb=+uXBrjL+1H8iWx4jdQw@mail.gmail.com>
References: <20180704150745.21003-1-stefan@agner.ch>
 <CAPDyKFou773HgPzE29Ynr2MVFcaOhb=+uXBrjL+1H8iWx4jdQw@mail.gmail.com>
Message-ID: <3d4064a559e741e05105b11c9e7a831d@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.06 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.96)[99.82%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2018 15:10, Ulf Hansson wrote:
> On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
>> If pinctrl nodes for 100/200MHz are missing, the controller should
>> not select any mode which need signal frequencies 100MHz or higher.
>> To prevent such speed modes the driver currently uses the quirk flag
>> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
>> signaling is required for all faster modes and slower modes use 3.3V
>> signaling only.
>>
>> However, there are eMMC modes which use 1.8V signaling and run below
>> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
>> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
>> the stack has no valid mode to use. In this tenuous situation the
>> kernel continuously prints voltage switching errors:
>>   mmc1: Switching to 3.3V signalling voltage failed
>>
>> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
>> altering the SDHCI capability register. With that the stack is able
>> to select 1.8V modes even if no faster pinctrl states are available:
>>   # cat /sys/kernel/debug/mmc1/ios
>>   ...
>>   timing spec:    8 (mmc DDR52)
>>   signal voltage: 1 (1.80 V)
>>   ...
>>
>> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks, applied for next! Let's see if this turns out okay, then let's
> make it a fix and add a stable tag.
> 
> BTW, would you mind looking up the commit it fixes? Or if there is a
> certain stable release we should target.
> 

The quirk SDHCI_QUIRK2_NO_1_8_V has been used if pinctrl were missing
since support has been added for additional pinctrl states (back around
3.13).

Fixes: ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl state
according to uhs mode")

I guess it won't apply on older kernels since the code which applies the
quirk has been moved around.

--
Stefan

> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 20a420b765b3..e96d969ab2c3 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -312,6 +312,15 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>>
>>                         if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>>                                 val |= SDHCI_SUPPORT_HS400;
>> +
>> +                       /*
>> +                        * Do not advertise faster UHS modes if there are no
>> +                        * pinctrl states for 100MHz/200MHz.
>> +                        */
>> +                       if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
>> +                           IS_ERR_OR_NULL(imx_data->pins_200mhz))
>> +                               val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
>> +                                        | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
>>                 }
>>         }
>>
>> @@ -1157,18 +1166,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>>                                                 ESDHC_PINCTRL_STATE_200MHZ);
>> -               if (IS_ERR(imx_data->pins_100mhz) ||
>> -                               IS_ERR(imx_data->pins_200mhz)) {
>> -                       dev_warn(mmc_dev(host->mmc),
>> -                               "could not get ultra high speed state, work on normal mode\n");
>> -                       /*
>> -                        * fall back to not supporting uhs by specifying no
>> -                        * 1.8v quirk
>> -                        */
>> -                       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>> -               }
>> -       } else {
>> -               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>         }
>>
>>         /* call to generic mmc_of_parse to support additional capabilities */
>> --
>> 2.18.0
>>
