Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D23C20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTUSdQQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D23C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeK1L6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:58:11 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42570 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeK1L6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:58:10 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so14998200vsd.9;
        Tue, 27 Nov 2018 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OiSEm1IAeLz6T0I8T9fttN0cqnpgsxp1y68v25GOIPE=;
        b=WTUSdQQ2sDQt0ud0TjCeOovPNlXnl3lAhul4/G3kaN661fC9a3gKAvu/qgIF9HPk1P
         uYsZ4zwDvDz8+6sFb2jXGGOzHzOhymtbXng7PYZilx/yZyaWPVfu4aSQp5MiUVQarOYj
         Y2aKH1gg6toEe/wKne+ySayeSgeZOhuXnQ1NAet+XhRsnni61aoIRMvtObaOZhsDKagk
         p+V2Wjky+f0IzmShaIHZkfB9Uu5mh5RpeYDtPVBxEn+kSz08VHQRCxe/sY9gQqOoaZV5
         dKWgJJuEtyN9M0RoFnhqYI4WpRd5ZC38ioNNmajzg4paxgVHnDSEwGOM/Xx1+FcF6iwS
         Qujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OiSEm1IAeLz6T0I8T9fttN0cqnpgsxp1y68v25GOIPE=;
        b=KpK9HYFF0UYQ2PmoWwLvJsVLKU3GT/HwkzLnvlLn31L6vnnKTst0TYkTQ0iyh/vam/
         YiH0jHSa66FlcLPr/F1YlBEd2sGPZLFN03eaoStJvFZ/2H0IUZRAPcg6E535rftiH2wN
         8fctqhM02rFAYHLFKABw7Unf0VH4cUMBLKt0gMxKpcvbO3fEWuxtKa2P8JhfxAhJZblg
         VUsv91Ld67apEsWVol130XkBj5eLk7oFXn5BV2QspEef4qSrJelGgeObCPOpf7kILWFU
         70AMjl98DGj5jBKPnr/R1EhmkLZXxsZPcYBGXNWhGzzEm2kuJ6ENSrstsG1QyR7vOpNM
         xong==
X-Gm-Message-State: AGRZ1gIrkLMoUR/HZCmdDe9thYpNlFBWa9sLIGJMD+E6QVhde1vZJOs6
        TgVJGqIifT/yJZVlP2k0jg==
X-Google-Smtp-Source: AJdET5fY/BPGvyWerTF7Mir3Vl/HdpDsqe9zNf2gJETEoF17FyBf3XshVOsRibb6siATqaqTPsGy8g==
X-Received: by 2002:a67:c86:: with SMTP id 128mr15116796vsm.221.1543366706445;
        Tue, 27 Nov 2018 16:58:26 -0800 (PST)
Received: from 960 (c-98-244-175-192.hsd1.ga.comcast.net. [98.244.175.192])
        by smtp.gmail.com with ESMTPSA id p185sm1699589vsd.20.2018.11.27.16.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 16:58:26 -0800 (PST)
Message-ID: <30a2b3bea95199ffc1a81f374deabbfadaeb2c22.camel@gmail.com>
Subject: Re: [PATCH v7 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Tue, 27 Nov 2018 19:58:24 -0500
In-Reply-To: <s5h5zwi7t1s.wl-tiwai@suse.de>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
         <20181127025752.6459-3-ayman.bagabas@gmail.com>
         <s5h5zwi7t1s.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 10:45 +0100, Takashi Iwai wrote:
> On Tue, 27 Nov 2018 03:57:48 +0100,
> Ayman Bagabas wrote:
> > +static const struct key_entry huawei_wmi_keymap[] __initconst = {
> > +		{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
> > +		{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
> > +		{ KE_KEY,    0x284, { KEY_MUTE } },
> > +		{ KE_KEY,    0x285, { KEY_VOLUMEDOWN } },
> > +		{ KE_KEY,    0x286, { KEY_VOLUMEUP } },
> > +		{ KE_KEY,    0x287, { KEY_MICMUTE } },
> > +		{ KE_KEY,    0x289, { KEY_WLAN } },
> > +		// Huawei |M| button
> > +		{ KE_KEY,    0x28a, { KEY_CONFIG } },
> > +		// Keyboard light
> > +		{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
> > +		{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
> > +		{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
> > +		{ KE_END,    0 }
> 
> The indentation looks too deep here.
> 
> > +static int huawei_wmi_micmute_led_set(bool on)
> > +{
> > +	acpi_handle handle;
> > +	char *method;
> > +	union acpi_object args[3];
> > +	struct acpi_object_list arg_list = {
> > +		.pointer = args,
> > +		.count = ARRAY_SIZE(args),
> > +	};
> > +
> > +	handle = ACPI_HANDLE(&inputdev->dev);
> 
> Just wondering whether the ACPI handle is assigned properly for this
> device...

It is, but it returns a handle at "\".

> 
> > +	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
> > +	args[1].integer.value = 0x04;
> > +
> > +	if (acpi_has_method(handle, method =
> > "\\_SB.PCI0.LPCB.EC0.SPIN")) {
> > +		args[0].integer.value = 0;
> > +		args[2].integer.value = on ? 1 : 0;
> > +	} else if (acpi_has_method(handle, method =
> > "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> > +		args[0].integer.value = 1;
> > +		args[2].integer.value = on ? 0 : 1;
> > +	} else {
> > +		dev_err(&inputdev->dev, "Unable to find ACPI
> > method\n");
> > +		return -ENOSYS;
> > +	}
> > +
> > +	acpi_evaluate_object(handle, method, &arg_list, NULL);
> > +
> > +	return 0;
> > +}
> > +
> > +static int micmute_led_set(struct led_classdev *led_cdev,
> > +		enum led_brightness brightness)
> > +{
> > +	int state = brightness != LED_OFF;
> > +	int err;
> > +
> > +	err = huawei_wmi_micmute_led_set(state);
> > +	return err < 0 ? err : 0;
> 
> No need for checking err here, you can return
> huawei_wmi_mute_led_set() directly.
> 
> Or even you can fold two functions into one.

I think folding them make more sense.

> 
> > +static int __init huawei_wmi_init(void)
> > +{
> > +	int err;
> > +
> > +	if (wmi_has_guid(MBX_EVENT_GUID)) {
> > +		event_guid = MBX_EVENT_GUID;
> > +	} else if (wmi_has_guid(MBXP_EVENT_GUID)) {
> > +		event_guid = MBXP_EVENT_GUID;
> > +	} else {
> > +		pr_warn("Compatible WMI GUID not found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	err = huawei_wmi_input_init();
> > +	if (err)
> > +		goto err_input;
> > +
> > +	micmute_led_cdev.brightness =
> > ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > +	err = led_classdev_register(&inputdev->dev, &micmute_led_cdev);
> > +	if (err)
> > +		goto err_leds;
> > +
> > +	return 0;
> 
> Might it be cleaner to implement on top of wmi_driver?
> Then you can create both input and led devices on wmi device.
> 

Done! Now led devices get registered when wmi probes a new device.
Thanks.

> 
> thanks,
> 
> Takashi

