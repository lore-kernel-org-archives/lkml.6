Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1EDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744F62404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcJUMuWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744F62404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeGEUxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35361 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754503AbeGEUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:53:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id h40-v6so2127285wrh.2;
        Thu, 05 Jul 2018 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sQ1jDaHkOk8JX80f6SciKOANPovE9zNRGx/jrnEJayM=;
        b=qcJUMuWAGFfnBfKihw7S2qe9uc1mE7lNCk/oH+lCrfZOCbZk5tyrzDKhNeShW5ZBoK
         P76r87sWKjs3sVL+m9KmE9VX/oCEh1EG9G6oK3+r4hiCH80AeSseiaqlh0ZokjxLiNmZ
         f7euu0Chvm2cpZgeED1ASlBXztBscrjgsL7yRCVN0SwtBbd6skQHz3zth+8yZX+g95i8
         ojoV9cFhmzamuDgVlR3xJO9G4YAE2NXQPc7dddNzAUbJCC1rK/hUUwJTMkMbPzlcnxb2
         M3c471Cjd2UvpeWDt28lqhVwC39Pyn7QGcHlOFd8ic95PbKCPqRN/XMH1/G/Lfx0xcEG
         4bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQ1jDaHkOk8JX80f6SciKOANPovE9zNRGx/jrnEJayM=;
        b=ofPXVxdVmxAI61aefpQ4fSN4uw/BCLAww8w1Umb1w1OcgBVPV3Fd2KF/6tYhtiH35q
         pCCNHjqP99lAqqa2yZJ7jJcdzXrGWopSlp6z6/H6nRVRs+0AW2qUhiuiktlprOm4rjPE
         8PZXLxouXbIyUvGG4X/1++a61aEt6+oZWoiO5tr94rEgVIwQcNpAY8cOL+yqmAdr9NOE
         yLhPoxyf1nFqKDu3Plz+f6u1g8BMQKLXMzfSpO9+/2cg7cghTd5ePvsZ73eKrYNGkVYF
         EG6voCxTgpjAkhp8ggkFAY1gbkwvLC5a4rCeB/S9SdDqGC+pWUNTd/oruZq7Kuk/vB5M
         eTDQ==
X-Gm-Message-State: APt69E3unAJ5qpKoP/1fIV0iIhSRPELqS39BKKBRPBGpsX4ckwtC7uIc
        KGFvEhUb//gxQZeXsltSCTf8c32h
X-Google-Smtp-Source: AAOMgpcNsA1mrqHTJXb4JtO8HA6nvBFskkXSArgUQk131XlgbsI6UjHLBykzzhe8Qh9Jmi23BrvR6w==
X-Received: by 2002:adf:9736:: with SMTP id r51-v6mr5381902wrb.5.1530823994899;
        Thu, 05 Jul 2018 13:53:14 -0700 (PDT)
Received: from [192.168.1.18] (chi28.neoplus.adsl.tpnet.pl. [83.31.6.28])
        by smtp.gmail.com with ESMTPSA id y13-v6sm16427172wrc.55.2018.07.05.13.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 13:53:14 -0700 (PDT)
Subject: Re: [PATCH] Fix platform data in leds-pca955x.c
To:     Rob Landley <rob@landley.net>, clg@kaod.org, pavel@ucw.cz,
        andrew@aj.id.au, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <828a80f4-69cc-c99a-9b10-6772989935e1@gmail.com>
Date:   Thu, 5 Jul 2018 22:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

On 07/04/2018 02:46 AM, Rob Landley wrote:
> I have some questions about recent changes to leds-pca955x.c since 4.13:
> 
> How is non-of platform data supposed to work now? Commit ed1f4b9676a8 switched
> struct led_platform_data *pdata in the _probe() function to a locally defined
> structure that platform data can't provide because it's not in any header it
> can #include.

That is clear omission. Nonetheless, I like the i2c_board_info related
solution, proposed by Andy. Would you mind checking that approach?

Best regards,
Jacek Anaszewski

> This is disguised by dev_get_platdata() returning a void * so changing the type
> of pdata the returned pointer is assigned to didn't require a new typecast,
> instead existing board definitions still compile but quietly break at runtime.
> (Specifically the SH7760 board I use at work broke in the pdata->num_leds !=
> chip->bits sanity check, and then userpace sees an empty /sys/class/leds and I
> started start digging because "huh"?)
> 
> Why did the type change, anyway? The generic led_platform_data it was
> using before has all the fields the device tree's actually initializing, at
> least if you use flags for the new gpio stuff.
> 
> Commit 561099a1a2e9 added CONFIG_LEDS_PCA955X_GPIO, but the initialization
> code adds gpio logic outside this config symbol: probe only calls
> devm_led_classdev_register() within a case statement that depends on setting the
> right "this is not GPIO" value.
> 
> The "GPIO" indicator could have been a flag in the existing LED structure's
> flags field, but instead of a bit it's #defining three symbols. The
> PCA955X_TYPE_* macros with the new type constants only exist in the device tree
> header. Strangely, the old default "this is an LED" value isn't zero, zero is
> PCA955X_TYPE_NONE which is unused (never set anywhere in the tree), and would
> cause the LED to be skipped: you have to set a field platform data can't
> access, using a macro platform data probably doesn't have, in order for
> devm_led_classdev_register() to get called on that LED at all. Why?
> 
> This is especially odd since if you did want to skip an LED, there was already a
> way to indicate that: by giving it an empty string as a name. (It doesn't seem
> to have come up, but it's the obvious way to do it.) Except commit 390c97dc6e34
> deals with that by writing the index number as a string to the platform data
> struct. Leaving aside "why did you do that?", isn't the platform data supposed to
> be in a read only section when it's actual platform data? And since the probe
> function then immediately copies the data into the another structure, can't we
> just fill out the other one directly without overwriting our arguments?
> 
> As for the lifetime rules, the local pca955x_led (writeable copy initialized from
> the read-only platform data) had the name[] array locally living in the
> struct, but the device tree commits added char *default_trigger pointing to
> external memory. Is there a reason this is now inconsistent?
> 
> Here's the patch I whipped up at work today (applied to v4.14) that undid enough
> of this to make the driver work again with platform data on the board we ship:
> 
> 
> From: Rob Landley <rob@landley.net>
> 
> The LED driver changes that went into 4.14 to add device tree support broke
> non-device-tree support.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> 
>   leds-pca955x.c |   46 +++++++++++++++++++---------------------------
>   1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
> index 9057291..c1df4f1 100644
> --- a/drivers/leds/leds-pca955x.c
> +++ b/drivers/leds/leds-pca955x.c
> @@ -134,11 +134,6 @@ struct pca955x_led {
>   	const char		*default_trigger;
>   };
>   
> -struct pca955x_platform_data {
> -	struct pca955x_led	*leds;
> -	int			num_leds;
> -};
> -
>   /* 8 bits per input register */
>   static inline int pca95xx_num_input_regs(int bits)
>   {
> @@ -367,24 +362,25 @@ static int pca955x_gpio_direction_output(struct gpio_chip *gc,
>   #endif /* CONFIG_LEDS_PCA955X_GPIO */
>   
>   #if IS_ENABLED(CONFIG_OF)
> -static struct pca955x_platform_data *
> +static struct led_platform_data *
>   pca955x_pdata_of_init(struct i2c_client *client, struct pca955x_chipdef *chip)
>   {
>   	struct device_node *np = client->dev.of_node;
>   	struct device_node *child;
> -	struct pca955x_platform_data *pdata;
> +	struct led_platform_data *pdata;
>   	int count;
>   
>   	count = of_get_child_count(np);
>   	if (!count || count > chip->bits)
>   		return ERR_PTR(-ENODEV);
>   
> +	/* Never freed, can be called multiple times with insmod/rmmod */
>   	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>   	if (!pdata)
>   		return ERR_PTR(-ENOMEM);
>   
>   	pdata->leds = devm_kzalloc(&client->dev,
> -				   sizeof(struct pca955x_led) * chip->bits,
> +				   sizeof(struct led_platform_dat) * chip->bits,
>   				   GFP_KERNEL);
>   	if (!pdata->leds)
>   		return ERR_PTR(-ENOMEM);
> @@ -401,11 +397,10 @@ pca955x_pdata_of_init(struct i2c_client *client, struct pca955x_chipdef *chip)
>   		if (of_property_read_string(child, "label", &name))
>   			name = child->name;
>   
> -		snprintf(pdata->leds[reg].name, sizeof(pdata->leds[reg].name),
> -			 "%s", name);
> +		pdata->leds[reg].name = name;
>   
> -		pdata->leds[reg].type = PCA955X_TYPE_LED;
> -		of_property_read_u32(child, "type", &pdata->leds[reg].type);
> +		pdata->leds[reg].flags = PCA955X_TYPE_LED;
> +		of_property_read_u32(child, "type", &pdata->leds[reg].flags);
>   		of_property_read_string(child, "linux,default-trigger",
>   					&pdata->leds[reg].default_trigger);
>   	}
> @@ -425,7 +420,7 @@ static const struct of_device_id of_pca955x_match[] = {
>   
>   MODULE_DEVICE_TABLE(of, of_pca955x_match);
>   #else
> -static struct pca955x_platform_data *
> +static struct led_platform_data *
>   pca955x_pdata_of_init(struct i2c_client *client, struct pca955x_chipdef *chip)
>   {
>   	return ERR_PTR(-ENODEV);
> @@ -440,7 +435,7 @@ static int pca955x_probe(struct i2c_client *client,
>   	struct pca955x_chipdef *chip;
>   	struct i2c_adapter *adapter;
>   	int i, err;
> -	struct pca955x_platform_data *pdata;
> +	struct led_platform_data *pdata;
>   	int ngpios = 0;
>   
>   	if (id) {
> @@ -502,26 +497,23 @@ static int pca955x_probe(struct i2c_client *client,
>   		pca955x_led = &pca955x->leds[i];
>   		pca955x_led->led_num = i;
>   		pca955x_led->pca955x = pca955x;
> -		pca955x_led->type = pdata->leds[i].type;
> +		pca955x_led->type = pdata->leds[i].flags;
>   
> -		switch (pca955x_led->type) {
> -		case PCA955X_TYPE_NONE:
> -			break;
> -		case PCA955X_TYPE_GPIO:
> +		if (pca955x_led->type) {
>   			ngpios++;
> -			break;
> -		case PCA955X_TYPE_LED:
> +		} else {
>   			/*
>   			 * Platform data can specify LED names and
>   			 * default triggers
>   			 */
>   			if (pdata->leds[i].name[0] == '\0')
> -				snprintf(pdata->leds[i].name,
> -					sizeof(pdata->leds[i].name), "%d", i);
> -
> -			snprintf(pca955x_led->name,
> -				sizeof(pca955x_led->name), "pca955x:%s",
> -				pdata->leds[i].name);
> +				snprintf(pca955x_led->name,
> +					sizeof(pca955x_led->name), "pca955x:%d",
> +					i);
> +			else
> +				snprintf(pca955x_led->name,
> +					sizeof(pca955x_led->name), "pca955x:%s",
> +					pdata->leds[i].name);
>   
>   			if (pdata->leds[i].default_trigger)
>   				pca955x_led->led_cdev.default_trigger =
> 

