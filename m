Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4128DC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BAD24788
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="cMCJJdzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BAD24788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGDAqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:46:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39992 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeGDAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:46:50 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so5700485ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=q7B9BxPImoBI25WZBJ4/oMsnAas7Nvxdvn9src+gQnI=;
        b=cMCJJdzxtZaYZ0dGh6u+N7LraPDnmesYsAU1eaQjmlDGOXntU2Cz3+QNY7lU8FzPQG
         z8hupyFIBqdFWR0ttmBMGOVbLH1BzK3eHKmKg22LgF8bmzv9MAQSnGJEklG4Hc6Pi52U
         /Vda8X5bCxU10MCn3DFkXTKiKLNmqpf5CzhJc2I8msqvlLvga7hbTxoJ2ZNYwNIk1A/F
         n4pf/vHzN5fB5wBKxJbBhEufAyFayU0RFkZ2YrV5IBpLv78JDO1nNrDqwmnY6QSTEd6R
         /QsEw1moiST0+GoEODwk5Z55hn9IyuzVfBiycivx6PbZiDxdTLFo2q64dQeg+aO/ByKw
         CbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=q7B9BxPImoBI25WZBJ4/oMsnAas7Nvxdvn9src+gQnI=;
        b=hsUBH868OIbPeIBXJ42TiQCUP2jK9HWhc3ZZv9L0aOsjDGR/pQaPMezpoSW0wuRk0G
         5hz5jtCZyYUpo/Ugpi/U/7liuAm+Pw1C4Ptjwl44ymOGzac4QNJeNzwvPsCoX1eopmkr
         UPVphIvDfLB0MvLqikKVlYEQe6A3wZFIGs5/6RQvVJ7nr1qCizOCP7oPkaj5bAKHJG/W
         k8Irnp5Wuj9zg2Fx9T8pDKsfhteOvocdE9TqTR0rUmCn+vLCSXzoEcSdW1A8f/JUtvHN
         FOOqWNQfixzzA0wihkTUH4faMLiqlJ7AES4JR7qMkj6cXLKjIg4fdtk0PRWA4EAHD0H4
         rOtw==
X-Gm-Message-State: APt69E1KpjjVi3OfAm/yOKuDv0Cb26VZrUX9n68DlYPodfOlLHlyJ1GQ
        CGQB/5dxqt+R3DWrZPj2OQhy5wSFj4U=
X-Google-Smtp-Source: AAOMgpcrw40YX9dFTVzl6Be9yle7NgfY1ShrOfGSfci1uE03loTOAbFNyOZuZwn8es4liDkK9Iwqfw==
X-Received: by 2002:a02:4f1b:: with SMTP id c27-v6mr12539874jab.39.1530665209802;
        Tue, 03 Jul 2018 17:46:49 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.139.101])
        by smtp.googlemail.com with ESMTPSA id n194-v6sm1260857itg.1.2018.07.03.17.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 17:46:49 -0700 (PDT)
To:     clg@kaod.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        andrew@aj.id.au, jacek.anaszewski@gmail.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Fix platform data in leds-pca955x.c
Message-ID: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
Date:   Tue, 3 Jul 2018 19:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have some questions about recent changes to leds-pca955x.c since 4.13:

How is non-of platform data supposed to work now? Commit ed1f4b9676a8 switched
struct led_platform_data *pdata in the _probe() function to a locally defined
structure that platform data can't provide because it's not in any header it
can #include.

This is disguised by dev_get_platdata() returning a void * so changing the type
of pdata the returned pointer is assigned to didn't require a new typecast,
instead existing board definitions still compile but quietly break at runtime.
(Specifically the SH7760 board I use at work broke in the pdata->num_leds !=
chip->bits sanity check, and then userpace sees an empty /sys/class/leds and I
started start digging because "huh"?)

Why did the type change, anyway? The generic led_platform_data it was
using before has all the fields the device tree's actually initializing, at
least if you use flags for the new gpio stuff.

Commit 561099a1a2e9 added CONFIG_LEDS_PCA955X_GPIO, but the initialization
code adds gpio logic outside this config symbol: probe only calls
devm_led_classdev_register() within a case statement that depends on setting the
right "this is not GPIO" value.

The "GPIO" indicator could have been a flag in the existing LED structure's
flags field, but instead of a bit it's #defining three symbols. The
PCA955X_TYPE_* macros with the new type constants only exist in the device tree
header. Strangely, the old default "this is an LED" value isn't zero, zero is
PCA955X_TYPE_NONE which is unused (never set anywhere in the tree), and would
cause the LED to be skipped: you have to set a field platform data can't
access, using a macro platform data probably doesn't have, in order for
devm_led_classdev_register() to get called on that LED at all. Why?

This is especially odd since if you did want to skip an LED, there was already a
way to indicate that: by giving it an empty string as a name. (It doesn't seem
to have come up, but it's the obvious way to do it.) Except commit 390c97dc6e34
deals with that by writing the index number as a string to the platform data
struct. Leaving aside "why did you do that?", isn't the platform data supposed to
be in a read only section when it's actual platform data? And since the probe
function then immediately copies the data into the another structure, can't we
just fill out the other one directly without overwriting our arguments?

As for the lifetime rules, the local pca955x_led (writeable copy initialized from
the read-only platform data) had the name[] array locally living in the
struct, but the device tree commits added char *default_trigger pointing to
external memory. Is there a reason this is now inconsistent?

Here's the patch I whipped up at work today (applied to v4.14) that undid enough
of this to make the driver work again with platform data on the board we ship:


From: Rob Landley <rob@landley.net>

The LED driver changes that went into 4.14 to add device tree support broke
non-device-tree support.

Signed-off-by: Rob Landley <rob@landley.net>

 leds-pca955x.c |   46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 9057291..c1df4f1 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -134,11 +134,6 @@ struct pca955x_led {
 	const char		*default_trigger;
 };
 
-struct pca955x_platform_data {
-	struct pca955x_led	*leds;
-	int			num_leds;
-};
-
 /* 8 bits per input register */
 static inline int pca95xx_num_input_regs(int bits)
 {
@@ -367,24 +362,25 @@ static int pca955x_gpio_direction_output(struct gpio_chip *gc,
 #endif /* CONFIG_LEDS_PCA955X_GPIO */
 
 #if IS_ENABLED(CONFIG_OF)
-static struct pca955x_platform_data *
+static struct led_platform_data *
 pca955x_pdata_of_init(struct i2c_client *client, struct pca955x_chipdef *chip)
 {
 	struct device_node *np = client->dev.of_node;
 	struct device_node *child;
-	struct pca955x_platform_data *pdata;
+	struct led_platform_data *pdata;
 	int count;
 
 	count = of_get_child_count(np);
 	if (!count || count > chip->bits)
 		return ERR_PTR(-ENODEV);
 
+	/* Never freed, can be called multiple times with insmod/rmmod */
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
 	pdata->leds = devm_kzalloc(&client->dev,
-				   sizeof(struct pca955x_led) * chip->bits,
+				   sizeof(struct led_platform_dat) * chip->bits,
 				   GFP_KERNEL);
 	if (!pdata->leds)
 		return ERR_PTR(-ENOMEM);
@@ -401,11 +397,10 @@ pca955x_pdata_of_init(struct i2c_client *client, struct pca955x_chipdef *chip)
 		if (of_property_read_string(child, "label", &name))
 			name = child->name;
 
-		snprintf(pdata->leds[reg].name, sizeof(pdata->leds[reg].name),
-			 "%s", name);
+		pdata->leds[reg].name = name;
 
-		pdata->leds[reg].type = PCA955X_TYPE_LED;
-		of_property_read_u32(child, "type", &pdata->leds[reg].type);
+		pdata->leds[reg].flags = PCA955X_TYPE_LED;
+		of_property_read_u32(child, "type", &pdata->leds[reg].flags);
 		of_property_read_string(child, "linux,default-trigger",
 					&pdata->leds[reg].default_trigger);
 	}
@@ -425,7 +420,7 @@ static const struct of_device_id of_pca955x_match[] = {
 
 MODULE_DEVICE_TABLE(of, of_pca955x_match);
 #else
-static struct pca955x_platform_data *
+static struct led_platform_data *
 pca955x_pdata_of_init(struct i2c_client *client, struct pca955x_chipdef *chip)
 {
 	return ERR_PTR(-ENODEV);
@@ -440,7 +435,7 @@ static int pca955x_probe(struct i2c_client *client,
 	struct pca955x_chipdef *chip;
 	struct i2c_adapter *adapter;
 	int i, err;
-	struct pca955x_platform_data *pdata;
+	struct led_platform_data *pdata;
 	int ngpios = 0;
 
 	if (id) {
@@ -502,26 +497,23 @@ static int pca955x_probe(struct i2c_client *client,
 		pca955x_led = &pca955x->leds[i];
 		pca955x_led->led_num = i;
 		pca955x_led->pca955x = pca955x;
-		pca955x_led->type = pdata->leds[i].type;
+		pca955x_led->type = pdata->leds[i].flags;
 
-		switch (pca955x_led->type) {
-		case PCA955X_TYPE_NONE:
-			break;
-		case PCA955X_TYPE_GPIO:
+		if (pca955x_led->type) {
 			ngpios++;
-			break;
-		case PCA955X_TYPE_LED:
+		} else {
 			/*
 			 * Platform data can specify LED names and
 			 * default triggers
 			 */
 			if (pdata->leds[i].name[0] == '\0')
-				snprintf(pdata->leds[i].name,
-					sizeof(pdata->leds[i].name), "%d", i);
-
-			snprintf(pca955x_led->name,
-				sizeof(pca955x_led->name), "pca955x:%s",
-				pdata->leds[i].name);
+				snprintf(pca955x_led->name,
+					sizeof(pca955x_led->name), "pca955x:%d",
+					i);
+			else
+				snprintf(pca955x_led->name,
+					sizeof(pca955x_led->name), "pca955x:%s",
+					pdata->leds[i].name);
 
 			if (pdata->leds[i].default_trigger)
 				pca955x_led->led_cdev.default_trigger =
