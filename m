Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A93BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2423DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hXRbOCwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2423DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeGELQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:16:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38110 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbeGELQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:16:32 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0CA595C1B73;
        Thu,  5 Jul 2018 13:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530789391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6rXoiLaLikbA++QuZcMI60eDsm7+fNmkAnZkb+3c7w=;
        b=hXRbOCwQ0x/1nuGByjKugog4/WHkQETOyNJB30eaen/WvNfbHtb96NzJGuPlvCA1Uqcg+I
        TMdN3mWWkF3Sf46GRkR7KYoTZyUyV7mgQ0ADRyZU7Kqgf+USGYsxvqEN3TYL7wZc9KqJAs
        58YI7v4yMWU6aX5b4hquEaHgTZhMPHY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 13:16:31 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>, michael@amarulasolutions.com,
        rmk+kernel@armlinux.org.uk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
In-Reply-To: <AM0PR04MB42119E8C29A48E9CDA0F116F80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-2-stefan@agner.ch>
 <AM0PR04MB42119E8C29A48E9CDA0F116F80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <318c0d9a93679df5abddeeef499f95c4@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
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
         BAYES_HAM(-3.00)[99.99%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2018 04:52, A.s. Dong wrote:
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan@agner.ch]
>> Sent: Thursday, June 28, 2018 4:13 PM
>> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
>> michael@amarulasolutions.com; rmk+kernel@armlinux.org.uk; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
>> <stefan@agner.ch>
>> Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
>>
>> The field support_vsel is currently only used in the device tree case. Get rid
>> of it. No change in behavior.
>>
> 
> I'm not sure if it's quite necessary to remove it as it's used to bypass
> 100Mhz above pad settings look up which is meaningless if user claims
> no 1-8 v support.
> 
> If you remove it, probably you still need better check the quirk for
> Pad state look up.

There should be really no change in behavior, just simplifying code:

If no-1-8-v is set, SDHCI_QUIRK2_NO_1_8_V will be set in any case.

If no-1-8-v is not set, SDHCI_QUIRK2_NO_1_8_V will be set depending on
whether pinctrl states are available

This has been the case before and after this change.

--
Stefan

> 
> Regards
> Dong Aisheng
> 
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
>>  include/linux/platform_data/mmc-esdhc-imx.h | 2 --
>>  2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
>> esdhc-imx.c
>> index 6f444731754d..20a420b765b3 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct
>> platform_device *pdev,
>>  			     &boarddata->tuning_start_tap);
>>
>>  	if (of_find_property(np, "no-1-8-v", NULL))
>> -		boarddata->support_vsel = false;
>> -	else
>> -		boarddata->support_vsel = true;
>> +		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>
>>  	if (of_property_read_u32(np, "fsl,delay-line", &boarddata-
>> >delay_line))
>>  		boarddata->delay_line = 0;
>>
>>  	mmc_of_parse_voltage(np, &host->ocr_mask);
>>
>> -	/* sdr50 and sdr104 need work on 1.8v signal voltage */
>> -	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
>> -	    !IS_ERR(imx_data->pins_default)) {
>> +	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default))
>> {
>>  		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data-
>> >pinctrl,
>>
>> 	ESDHC_PINCTRL_STATE_100MHZ);
>>  		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data-
>> >pinctrl,
>> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h
>> b/include/linux/platform_data/mmc-esdhc-imx.h
>> index 7daa78a2f342..640dec8b5b0c 100644
>> --- a/include/linux/platform_data/mmc-esdhc-imx.h
>> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
>> @@ -34,7 +34,6 @@ enum cd_types {
>>   * @cd_gpio:	gpio for card_detect interrupt
>>   * @wp_type:	type of write_protect method (see wp_types enum above)
>>   * @cd_type:	type of card_detect method (see cd_types enum above)
>> - * @support_vsel:  indicate it supports 1.8v switching
>>   */
>>
>>  struct esdhc_platform_data {
>> @@ -43,7 +42,6 @@ struct esdhc_platform_data {
>>  	enum wp_types wp_type;
>>  	enum cd_types cd_type;
>>  	int max_bus_width;
>> -	bool support_vsel;
>>  	unsigned int delay_line;
>>  	unsigned int tuning_step;       /* The delay cell steps in tuning
>> procedure */
>>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning
>> procedure */
>> --
>> 2.18.0
