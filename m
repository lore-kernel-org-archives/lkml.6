Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F84CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7C720858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RBuN1sJW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bp/QATOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7C720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeGWGyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:54:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbeGWGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:54:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C5A5606CF; Mon, 23 Jul 2018 05:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325313;
        bh=EtY7BSCswnKVaKP1GorHu935jf0ml8B9WzazBgnaN7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RBuN1sJWryn40+Xn4ZcpSmjPBzjH/c5iJEfHZvEOeRxIMjTjf0s0D5LZNb3TP3Glb
         ZqP/1QcJy20EoQGC+vtQfyu2EFOyTsOEi5AhjZtf3TOwdXEh9eCOVGS7uM7Ma84vld
         mCIhtsLaO0ozmi3yrPiCIehNDwHU1Oj7t90MBwYk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6631C602BC;
        Mon, 23 Jul 2018 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325312;
        bh=EtY7BSCswnKVaKP1GorHu935jf0ml8B9WzazBgnaN7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bp/QATOqO2FttD47f5w3syElB8V6/+/CE49eLoe5e+vnfAKqFl2GpCo7Y9RefdMC9
         Kqkq9wD32+jfeME4rqVKh9CzvVQYEsnryPu8tAmT7t5pnjI93L7ePI+VYHkdEsaF0Y
         O2KsWDjEAamqr+5anhzI2vDbg2/WbbLTlBd3IqR8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 11:25:12 +0530
From:   kgunda@codeaurora.org
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
In-Reply-To: <9aff8c23-7c72-eaee-9d59-424cd34be4ac@linaro.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-5-git-send-email-kgunda@codeaurora.org>
 <9aff8c23-7c72-eaee-9d59-424cd34be4ac@linaro.org>
Message-ID: <cc903e5fb06344731e75f078bdf42401@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 18:53, Daniel Thompson wrote:
> On 09/07/18 11:22, Kiran Gunda wrote:
>> Rename the PM8941* references as WLED3 to make the
>> driver generic and have WLED support for other PMICs.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>> Changes from V3:
>> 	- Changed the MODULE_DESCRIPTION
>> 
>>   drivers/video/backlight/qcom-wled.c | 248 
>> ++++++++++++++++++------------------
>>   1 file changed, 125 insertions(+), 123 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 0b6d219..3cd6e75 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -18,77 +18,79 @@
>>   #include <linux/regmap.h>
>>     /* From DT binding */
>> -#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
>> +#define WLED_DEFAULT_BRIGHTNESS				2048
>>   -#define PM8941_WLED_REG_VAL_BASE		0x40
>> -#define  PM8941_WLED_REG_VAL_MAX		0xFFF
>> +#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>> +#define WLED3_CTRL_REG_VAL_BASE				0x40
>>   -#define PM8941_WLED_REG_MOD_EN			0x46
>> -#define  PM8941_WLED_REG_MOD_EN_BIT		BIT(7)
>> -#define  PM8941_WLED_REG_MOD_EN_MASK		BIT(7)
>> +/* WLED3 control registers */
>> +#define WLED3_CTRL_REG_MOD_EN				0x46
>> +#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
>> +#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>>   -#define PM8941_WLED_REG_SYNC			0x47
>> -#define  PM8941_WLED_REG_SYNC_MASK		0x07
>> -#define  PM8941_WLED_REG_SYNC_LED1		BIT(0)
>> -#define  PM8941_WLED_REG_SYNC_LED2		BIT(1)
>> -#define  PM8941_WLED_REG_SYNC_LED3		BIT(2)
>> -#define  PM8941_WLED_REG_SYNC_ALL		0x07
>> -#define  PM8941_WLED_REG_SYNC_CLEAR		0x00
>> +#define WLED3_CTRL_REG_FREQ				0x4c
>> +#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
>>   -#define PM8941_WLED_REG_FREQ			0x4c
>> -#define  PM8941_WLED_REG_FREQ_MASK		0x0f
>> +#define WLED3_CTRL_REG_OVP				0x4d
>> +#define  WLED3_CTRL_REG_OVP_MASK			0x03
>>   -#define PM8941_WLED_REG_OVP			0x4d
>> -#define  PM8941_WLED_REG_OVP_MASK		0x03
>> +#define WLED3_CTRL_REG_ILIMIT				0x4e
>> +#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
>>   -#define PM8941_WLED_REG_BOOST			0x4e
>> -#define  PM8941_WLED_REG_BOOST_MASK		0x07
>> +/* WLED3 sink registers */
>> +#define WLED3_SINK_REG_SYNC				0x47
>> +#define  WLED3_SINK_REG_SYNC_MASK			0x07
>> +#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
>> +#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
>> +#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
>> +#define  WLED3_SINK_REG_SYNC_ALL			0x07
>> +#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>>   -#define PM8941_WLED_REG_SINK			0x4f
>> -#define  PM8941_WLED_REG_SINK_MASK		0xe0
>> -#define  PM8941_WLED_REG_SINK_SHFT		0x05
>> +#define WLED3_SINK_REG_CURR_SINK			0x4f
>> +#define  WLED3_SINK_REG_CURR_SINK_MASK			0xe0
>> +#define  WLED3_SINK_REG_CURR_SINK_SHFT			0x05
>>   -/* Per-'string' registers below */
>> -#define PM8941_WLED_REG_STR_OFFSET		0x10
>> +/* WLED3 per-'string' registers below */
>> +#define WLED3_SINK_REG_STR_OFFSET			0x10
>>   -#define PM8941_WLED_REG_STR_MOD_EN_BASE		0x60
>> -#define  PM8941_WLED_REG_STR_MOD_MASK		BIT(7)
>> -#define  PM8941_WLED_REG_STR_MOD_EN		BIT(7)
>> +#define WLED3_SINK_REG_STR_MOD_EN_BASE			0x60
>> +#define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
>> +#define  WLED3_SINK_REG_STR_MOD_EN			BIT(7)
>>   -#define PM8941_WLED_REG_STR_SCALE_BASE		0x62
>> -#define  PM8941_WLED_REG_STR_SCALE_MASK		0x1f
>> +#define WLED3_SINK_REG_STR_FULL_SCALE_CURR		0x62
>> +#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	0x1f
>>   -#define PM8941_WLED_REG_STR_MOD_SRC_BASE	0x63
>> -#define  PM8941_WLED_REG_STR_MOD_SRC_MASK	0x01
>> -#define  PM8941_WLED_REG_STR_MOD_SRC_INT	0x00
>> -#define  PM8941_WLED_REG_STR_MOD_SRC_EXT	0x01
>> +#define WLED3_SINK_REG_STR_MOD_SRC_BASE			0x63
>> +#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		0x01
>> +#define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
>> +#define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
>>   -#define PM8941_WLED_REG_STR_CABC_BASE		0x66
>> -#define  PM8941_WLED_REG_STR_CABC_MASK		BIT(7)
>> -#define  PM8941_WLED_REG_STR_CABC_EN		BIT(7)
>> +#define WLED3_SINK_REG_STR_CABC_BASE			0x66
>> +#define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
>> +#define  WLED3_SINK_REG_STR_CABC_EN			BIT(7)
>>   -struct pm8941_wled_config {
>> -	u32 i_boost_limit;
>> +struct wled_config {
>> +	u32 boost_i_limit;
>>   	u32 ovp;
>>   	u32 switch_freq;
>>   	u32 num_strings;
>> -	u32 i_limit;
>> +	u32 string_i_limit;
> 
> This patch implements a grand renaming and I have no objections to
> including change for boost_i_limit and string_i_limit in it. I'd
> prefer it to be mentioned in the patch header though.
> 
> Once that is done:
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Thanks Daneil. I will include it in the patch header in next series.
