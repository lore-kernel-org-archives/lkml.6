Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8263ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6220685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaADhOdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C6220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeGXDB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:01:27 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40032 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388258AbeGXDB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:01:27 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so2686724qtj.7;
        Mon, 23 Jul 2018 18:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+FbNwybTp+4LY7EsX8JAqfYvC/dPKfPP+eA36YVj2nw=;
        b=QaADhOdbJT83nM9H1s1O3Hqb3oggHBVrlopQsT8SnMH+3rwR0BxkDSif8rf7Lod200
         FK306VwS4upCCq3eTOHVLfLthdTHzkF0REXboBp9XzzED7IrCLq+IQPqVajcLZueYPfH
         k2D/lkB8VHlZPW8e477/is9QoeQ6sGxkakhR+yqoPUq5B5kwn3WZSXNIXnakdLVZ0R6P
         OMsnv53kHDhZr6270m7JZVlxKGk5UHfCEJcuPMA0oRTMNk6Q9rt5c89goWDIFnUPwlr4
         6fGdtRDzR0aDy/Gm5v3F/NqDa2CYU7DM9WS4QJ8dVL3fs0o+uoP/kJUuM1Jk3N3pW+61
         Cc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FbNwybTp+4LY7EsX8JAqfYvC/dPKfPP+eA36YVj2nw=;
        b=qg0jpMvcK8ApOjFf17sskj58q4RzxxuTDWAbnlli/TmzZSS9JMMFdCztsTPzuSAuef
         EPOxaSAjKmoGK79MyNsrZa14romOuCOf6Ko7z9NodGlctUhFotLQlBErLWFND8Ftyz9o
         Vz00IjbdEEaCY+UNqcqhfaU2gDoTfOezMI4p+a5RjLNLExrEC84XrVKb4qAgI5heyG5G
         X8U9AD5SeUZ3OOlp95sKIpGi7sgo45a4dtggtOr2HkA/v4KO5o6ob3gYBDrkU2BsEQPc
         TRGUPwTEu58ABrCFxbSc4wCoSBSlT3i4YO/Af5IiEWH3YsU9SYuKX6d8HFxxi4A/5OJc
         CQbg==
X-Gm-Message-State: AOUpUlF+/N9Z9Cwp6M3fQ7WG+iah6Tz133+D2KZ3tmN52Icc2Sukvqog
        seg4tGJK/Yyj/gR0lX+jhc+PLMul0xQC5A==
X-Google-Smtp-Source: AAOMgpcTJYPO07Avof7jFmjdPq3yKGr4hcvnvg3h/rV3yZgvs49C0TSgSaIDwEowcyI+znwKI0fRFw==
X-Received: by 2002:a0c:873d:: with SMTP id 58-v6mr13510915qvh.199.1532397445233;
        Mon, 23 Jul 2018 18:57:25 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::1005? ([2601:153:601:7d2a::1005])
        by smtp.gmail.com with ESMTPSA id j128-v6sm6005673qkc.50.2018.07.23.18.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 18:57:24 -0700 (PDT)
Subject: Re: [PATCH 2/2 v2] Add support for CPCAP regulators on Tegra devices.
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20180723193848.32491-1-pgwipeout@gmail.com>
 <20180723193848.32491-3-pgwipeout@gmail.com> <4588004.Gnq6nbUl2V@dimapc>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <e59e552c-fabb-0251-05b5-2361bf273232@gmail.com>
Date:   Mon, 23 Jul 2018 21:57:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4588004.Gnq6nbUl2V@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2018 08:27 PM, Dmitry Osipenko wrote:
> On Monday, 23 July 2018 22:38:48 MSK Peter Geis wrote:
>> Added support for the CPCAP power management regulator functions on
>> Tegra devices.
>> Added sw2_sw4 value tables, which provide power to the Tegra core and
>> aux devices.
>> Added the Tegra init tables and device tree compatibility match.
>>
>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>> ---
>>   .../bindings/regulator/cpcap-regulator.txt    |  1 +
>>   drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>> b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt index
>> 675f4437ce92..3e2d33ab1731 100644
>> --- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>> +++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>> @@ -4,6 +4,7 @@ Motorola CPCAP PMIC voltage regulators
>>   Requires node properties:
>>   - "compatible" value one of:
>>       "motorola,cpcap-regulator"
>> +    "motorola,tegra-cpcap-regulator"
>>       "motorola,mapphone-cpcap-regulator"
>>
>>   Required regulator properties:
>> diff --git a/drivers/regulator/cpcap-regulator.c
>> b/drivers/regulator/cpcap-regulator.c index c0b1e04bd90f..cb3774be445d
>> 100644
>> --- a/drivers/regulator/cpcap-regulator.c
>> +++ b/drivers/regulator/cpcap-regulator.c
>> @@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
>>   	{ /* sentinel */ },
>>   };
>>
>> +static struct cpcap_regulator tegra_regulators[] = {
>> +	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
>> +		  0, 0, 0, 0, 0, 0),
>> +	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
>> +		  0xf00, 0x7f, 0, 0x800, 0, 120),
>> +	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
>> +		  0, 0, 0, 0, 0, 0),
>> +	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
>> +		  0xf00, 0x7f, 0, 0x900, 0, 100),
>> +	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
>> +		  0x2a, 0, 0, 0x22, 0, 0),
>> +	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
>> +		  0, 0, 0, 0, 0, 0),
>> +	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
>> +		  0x87, 0x30, 4, 0x7, 0, 420),
>> +	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
>> +		  0x47, 0x10, 4, 0x7, 0, 350),
>> +	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
>> +		  0x87, 0x30, 4, 0x3, 0, 420),
>> +	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
>> +		  0x87, 0x30, 4, 0x5, 0, 420),
>> +	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
>> +		  0x80, 0xf, 0, 0x80, 0, 420),
>> +	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
>> +		  0x17, 0, 0, 0x2, 0, 0),
>> +	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
>> +		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
>> +		  0x87, 0x38, 3, 0x2, 0, 420),
>> +	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
>> +		  0x43, 0x18, 3, 0x1, 0, 420),
>> +	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
>> +		  0xac, 0x2, 1, 0xc, 0, 10),
>> +	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
>> +		  0x23, 0x8, 3, 0x3, 0, 10),
>> +	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
>> +		  0x23, 0x8, 3, 0x3, 0, 420),
>> +	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
>> +		  0x47, 0x10, 4, 0x5, 0, 420),
>> +	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
>> +		  0x20c, 0xc0, 6, 0x8, 0, 420),
>> +	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
>> +		  0xffff, vsim_val_tbl,
>> +		  0x23, 0x8, 3, 0x3, 0, 420),
>> +	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
>> +		  0xffff, vsimcard_val_tbl,
>> +		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
>> +	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
>> +		  0x1, 0xc, 2, 0, 0x1, 500),
>> +	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
>> +		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
>> +		  0x11c, 0x40, 6, 0xc, 0, 0),
>> +	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
>> +		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
>> +		  0x16, 0x1, 0, 0x4, 0, 0),
>> +	{ /* sentinel */ },
>> +};
>> +
>>   static const struct of_device_id cpcap_regulator_id_table[] = {
>>   	{
>>   		.compatible = "motorola,cpcap-regulator",
>> @@ -420,6 +496,10 @@ static const struct of_device_id
>> cpcap_regulator_id_table[] = { .compatible =
>> "motorola,mapphone-cpcap-regulator",
>>   		.data = omap4_regulators,
>>   	},
>> +	{
>> +		.compatible = "motorola,tegra-cpcap-regulator",
>> +		.data = tegra_regulators,
>> +	},
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
> 
> Are those cpcap_regulator values really common for all Tegra's? Probably
> better to name the DT compatible like "motorola,xoom-cpcap-regulator" or
> "motorola,mz602-cpcap-regulator".
> 
> The DT binding documentation should be updated with the new compatible value
> in the Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> 

I see your point, from my research the only other device that ever 
paired a Tegra with a cpcap was the Atrix 4g, and it has completely 
different values.
For now I will change the value to "motorola,xoom-cpcap-regulator", 
since these values are common across the entire Xoom line.
The DT binding documentation was updated as part of this patch, it will 
be adjusted to the new value.

