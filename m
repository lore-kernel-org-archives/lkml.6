Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66378C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B52D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e/4HsODb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T5bnp1Nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B52D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeFTG0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:26:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFTG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:26:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C2186085F; Wed, 20 Jun 2018 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529475998;
        bh=kHiwzXPmoL/9oz/ZwI7jorfKe3RA1ydbmPA9iFqucK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e/4HsODbgHKsJV2CxFk3Dq3k28TLwmvqxuCAYioE4QMTcyDTokEKleJgBsT1FFkym
         sA5AjxrteU88ksGn19EnSEFdnj6CSk+F+pwNkDb8otzoquJ0GRPyuhAvxEFh+SHt6f
         fL0/n/+Y+h3y4eFKraZOBLgtPW585nuiezruuzXQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 70AD860791;
        Wed, 20 Jun 2018 06:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529475997;
        bh=kHiwzXPmoL/9oz/ZwI7jorfKe3RA1ydbmPA9iFqucK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T5bnp1NzRPpOBD1s3SXMM0f3BDzBkoxzG0z1qmE+AVF5NJAubAYwYFEfr187MbBjo
         sRMcskdDcWnersDqVDXEdFVyzatYklA5sT4RRyrQTHAsZfpfXC3m3HBwOc/08lvVzY
         DOHeMpXXZNaVjbP1ZixiM2JcmA8dJ+qklmfUVdzA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jun 2018 11:56:37 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH V3 4/7] backlight: qcom-wled: Rename PM8941* to WLED3
In-Reply-To: <20180619231126.GH15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-5-git-send-email-kgunda@codeaurora.org>
 <20180619231126.GH15126@tuxbook-pro>
Message-ID: <ef852ddeb4557e036ee76e13355cfeb4@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-20 04:41, Bjorn Andersson wrote:
> On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
> 
>> Rename the PM8941* references as WLED3 to make the
>> driver generic and have WLED support for other PMICs.
>> 
> 
> Looks good, just three minor comments below.
> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  drivers/video/backlight/qcom-wled.c | 248 
>> ++++++++++++++++++------------------
>>  1 file changed, 125 insertions(+), 123 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 0b6d219..812f3cb 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -18,77 +18,79 @@
>>  #include <linux/regmap.h>
>> 
>>  /* From DT binding */
>> -#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
>> +#define WLED_DEFAULT_BRIGHTNESS				2048
>> 
>> -#define PM8941_WLED_REG_VAL_BASE		0x40
>> -#define  PM8941_WLED_REG_VAL_MAX		0xFFF
>> +#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>> +#define WLED3_CTRL_REG_VAL_BASE				0x40
>> 
>> -#define PM8941_WLED_REG_MOD_EN			0x46
>> -#define  PM8941_WLED_REG_MOD_EN_BIT		BIT(7)
>> -#define  PM8941_WLED_REG_MOD_EN_MASK		BIT(7)
>> +/* WLED3 control registers */
>> +#define WLED3_CTRL_REG_MOD_EN				0x46
>> +#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
>> +#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>> 
>> -#define PM8941_WLED_REG_SYNC			0x47
> 
> These are in address order, any reason why WLED3_SINK_REG_SYNC moved
> down?
> 
Actually, this is a sink specific register. That's why moved it to
under the /* WLED3 sink specific registers */
>> -#define  PM8941_WLED_REG_SYNC_MASK		0x07
>> -#define  PM8941_WLED_REG_SYNC_LED1		BIT(0)
>> -#define  PM8941_WLED_REG_SYNC_LED2		BIT(1)
>> -#define  PM8941_WLED_REG_SYNC_LED3		BIT(2)
>> -#define  PM8941_WLED_REG_SYNC_ALL		0x07
>> -#define  PM8941_WLED_REG_SYNC_CLEAR		0x00
>> +#define WLED3_CTRL_REG_FREQ				0x4c
>> +#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
>> 
>> -#define PM8941_WLED_REG_FREQ			0x4c
>> -#define  PM8941_WLED_REG_FREQ_MASK		0x0f
>> +#define WLED3_CTRL_REG_OVP				0x4d
>> +#define  WLED3_CTRL_REG_OVP_MASK			0x03
>> 
>> -#define PM8941_WLED_REG_OVP			0x4d
>> -#define  PM8941_WLED_REG_OVP_MASK		0x03
>> +#define WLED3_CTRL_REG_ILIMIT				0x4e
>> +#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
>> 
>> -#define PM8941_WLED_REG_BOOST			0x4e
>> -#define  PM8941_WLED_REG_BOOST_MASK		0x07
>> +/* WLED3 sink registers */
>> +#define WLED3_SINK_REG_SYNC				0x47
>> +#define  WLED3_SINK_REG_SYNC_MASK			0x07
>> +#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
>> +#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
>> +#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
>> +#define  WLED3_SINK_REG_SYNC_ALL			0x07
>> +#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>> 
> [..]
>> -struct pm8941_wled_config {
>> -	u32 i_boost_limit;
>> +struct wled_config {
>> +	u32 boost_i_limit;
>>  	u32 ovp;
>>  	u32 switch_freq;
>>  	u32 num_strings;
>> -	u32 i_limit;
>> +	u32 string_i_limit;
> 
> Changing the members in this struct seems unrelated.
> 
Changed the members, to have resemblance with the IPCAT and
better readability .
>>  	bool cs_out_en;
>>  	bool ext_gen;
>>  	bool cabc_en;
>>  };
>> 
> [..]
>> -MODULE_DESCRIPTION("pm8941 wled driver");
>> +MODULE_DESCRIPTION("qcom wled driver");
> 
> I would prefer if this was "Qualcomm WLED driver".
> 
Sure. I will change it in the next series.
>>  MODULE_LICENSE("GPL v2");
> 
> Regards,
> Bjorn
