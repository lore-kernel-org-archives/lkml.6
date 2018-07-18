Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38766ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E582075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="ZzzYk9BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E582075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeGRJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:22:22 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:58496 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeGRJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:22:22 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id EC637B007D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:45:31 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1531903526; x=1532767527; bh=HRo5eBHk99TLufa++rXJawckAe5js8rYTKP
        Jf3SOR/8=; b=ZzzYk9BKT47nGFYSnaHL23b4W/oodBfHOpM+KEq2UCuT2WbG54+
        kePNe7//SmuP0+T+o9j52AVAq2rw9HGA2atCndxqMfqEMMnK64gBzER8Yqu7nSZ3
        Xg8JQ8LkGWN5B4GCNu9u/PGBnQw25IjERpL8zQdH5jsd+98RPnx9w8KE=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Dy_m-gllOsd for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 10:45:26 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 0510AB002CE;
        Wed, 18 Jul 2018 10:45:25 +0200 (CEST)
Subject: Re: [PATCH 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180716213302.GA2751@piout.net>
 <20180718084118.79540-1-giulio.benetti@micronovasrl.com>
 <20180718084118.79540-2-giulio.benetti@micronovasrl.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <9bc8a049-8f43-b9b1-8926-5521ff26077a@micronovasrl.com>
Date:   Wed, 18 Jul 2018 10:45:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718084118.79540-2-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please discard this patchset as I didn't add v7 to series.
Sorry.

Giulio

Il 18/07/2018 10:41, Giulio Benetti ha scritto:
> m41txx chips can hold a calibration value to get correct clock bias.
> 
> Add offset handling (ranging between -63ppm and 126ppm) via sysfs.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>   drivers/rtc/rtc-ds1307.c | 77 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 0162a600ff1b..b2ef9defc349 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -114,6 +114,20 @@ enum ds_type {
>   #	define RX8025_BIT_VDET		0x40
>   #	define RX8025_BIT_XST		0x20
>   
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		0x80
> +#	define M41TXX_BIT_FT		0x40
> +#	define M41TXX_BIT_CALIB_SIGN	0x20
> +#	define M41TXX_M_CALIBRATION	0x1f
> +
> +/* negative offset step is -2.034ppm */
> +#define M41TXX_NEG_OFFSET_STEP_PPB	2034
> +/* positive offset step is +4.068ppm */
> +#define M41TXX_POS_OFFSET_STEP_PPB	4068
> +/* Min and max values supported with 'offset' interface by M41TXX */
> +#define M41TXX_MIN_OFFSET	((-31) * M41TXX_NEG_OFFSET_STEP_PPB)
> +#define M41TXX_MAX_OFFSET	((31) * M41TXX_POS_OFFSET_STEP_PPB)
> +
>   struct ds1307 {
>   	enum ds_type		type;
>   	unsigned long		flags;
> @@ -146,6 +160,9 @@ struct chip_desc {
>   
>   static int ds1307_get_time(struct device *dev, struct rtc_time *t);
>   static int ds1307_set_time(struct device *dev, struct rtc_time *t);
> +static int ds1337_read_alarm(struct device *dev, struct rtc_wkalrm *t);
> +static int ds1337_set_alarm(struct device *dev, struct rtc_wkalrm *t);
> +static int ds1307_alarm_irq_enable(struct device *dev, unsigned int enabled);
>   static u8 do_trickle_setup_ds1339(struct ds1307 *, u32 ohms, bool diode);
>   static irqreturn_t rx8130_irq(int irq, void *dev_id);
>   static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t);
> @@ -155,6 +172,8 @@ static irqreturn_t mcp794xx_irq(int irq, void *dev_id);
>   static int mcp794xx_read_alarm(struct device *dev, struct rtc_wkalrm *t);
>   static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t);
>   static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled);
> +static int m41txx_rtc_read_offset(struct device *dev, long *offset);
> +static int m41txx_rtc_set_offset(struct device *dev, long offset);
>   
>   static const struct rtc_class_ops rx8130_rtc_ops = {
>   	.read_time      = ds1307_get_time,
> @@ -172,6 +191,16 @@ static const struct rtc_class_ops mcp794xx_rtc_ops = {
>   	.alarm_irq_enable = mcp794xx_alarm_irq_enable,
>   };
>   
> +static const struct rtc_class_ops m41txx_rtc_ops = {
> +	.read_time      = ds1307_get_time,
> +	.set_time       = ds1307_set_time,
> +	.read_alarm	= ds1337_read_alarm,
> +	.set_alarm	= ds1337_set_alarm,
> +	.alarm_irq_enable = ds1307_alarm_irq_enable,
> +	.read_offset	= m41txx_rtc_read_offset,
> +	.set_offset	= m41txx_rtc_set_offset,
> +};
> +
>   static const struct chip_desc chips[last_ds_type] = {
>   	[ds_1307] = {
>   		.nvram_offset	= 8,
> @@ -228,10 +257,17 @@ static const struct chip_desc chips[last_ds_type] = {
>   		.irq_handler = rx8130_irq,
>   		.rtc_ops = &rx8130_rtc_ops,
>   	},
> +	[m41t0] = {
> +		.rtc_ops	= &m41txx_rtc_ops,
> +	},
> +	[m41t00] = {
> +		.rtc_ops	= &m41txx_rtc_ops,
> +	},
>   	[m41t11] = {
>   		/* this is battery backed SRAM */
>   		.nvram_offset	= 8,
>   		.nvram_size	= 56,
> +		.rtc_ops	= &m41txx_rtc_ops,
>   	},
>   	[mcp794xx] = {
>   		.alarm		= 1,
> @@ -973,6 +1009,47 @@ static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
>   				  enabled ? MCP794XX_BIT_ALM0_EN : 0);
>   }
>   
> +static int m41txx_rtc_read_offset(struct device *dev, long *offset)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	unsigned int ctrl_reg;
> +	u8 val;
> +
> +	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
> +
> +	val = ctrl_reg & M41TXX_M_CALIBRATION;
> +
> +	/* check if positive */
> +	if (ctrl_reg & M41TXX_BIT_CALIB_SIGN)
> +		*offset = (val * M41TXX_POS_OFFSET_STEP_PPB);
> +	else
> +		*offset = -(val * M41TXX_NEG_OFFSET_STEP_PPB);
> +
> +	return 0;
> +}
> +
> +static int m41txx_rtc_set_offset(struct device *dev, long offset)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	unsigned int ctrl_reg;
> +
> +	if ((offset < M41TXX_MIN_OFFSET) || (offset > M41TXX_MAX_OFFSET))
> +		return -ERANGE;
> +
> +	if (offset >= 0) {
> +		ctrl_reg = DIV_ROUND_CLOSEST(offset,
> +					     M41TXX_POS_OFFSET_STEP_PPB);
> +		ctrl_reg |= M41TXX_BIT_CALIB_SIGN;
> +	} else {
> +		ctrl_reg = DIV_ROUND_CLOSEST(abs(offset),
> +					     M41TXX_NEG_OFFSET_STEP_PPB);
> +	}
> +
> +	return regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL,
> +				  M41TXX_M_CALIBRATION | M41TXX_BIT_CALIB_SIGN,
> +				  ctrl_reg);
> +}
> +
>   /*----------------------------------------------------------------------*/
>   
>   static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
> 
