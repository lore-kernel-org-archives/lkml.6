Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA06C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CB42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyUIL3J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CB42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLCPqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:46:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37444 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeLCPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:46:06 -0500
Received: by mail-yw1-f65.google.com with SMTP id h193so5559095ywc.4;
        Mon, 03 Dec 2018 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LeNuq4Ictyztt6BD7eGXxvqob9tPczvYy3DDYKDFgN8=;
        b=HyUIL3J5o5Jc5eSw+0QB2BANOohINH2dLY4TWxQWYvtNgHghi7K+Gt4rA+QQaIgfty
         EFNFFldYrXTH5b5+nOqQYsAnFBt1brClepdylEzGCM4ydjFw0ZDs1WtJcBCIjPrs+2zE
         R0C3YhQFH7LijsueFTRJ1X7rqOF72eoHwpHGjl0k8OUxQtWB+IlEd2AKGSkJP5eRkyOe
         swpsI1eb4kTk3iTWxGI0xfAXqs8c0MVarBuOpRiKTbBtP8nr2nKSkgTGzC6iWlqc9lhe
         XeJsSRUDptZFQbqzjMY82+Np+iKAZf1gyBAun1Z0ABRpX2jNi3x5G1Ah7L5+y0Pu7cXL
         KQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LeNuq4Ictyztt6BD7eGXxvqob9tPczvYy3DDYKDFgN8=;
        b=knm49l+2xIM8tSv/yj2UtNQ6FfMD55ik1eYfw8POB79lbh2Mz8+zh39bd0aUhdu6Oh
         NhV7ROZtE+tUWPSugZOHhfM13jtMqb1/ev4LOtq+8mwzUqW/Pw5bNSM887RN37lDn+nV
         FPKhOdy3lFun7GcZQ8L/8IH3rYM4bV81wXqil3su+RCTXfyYm/a/dpardYBSrxqPUcL6
         MzdkEO2Rba5WTVVhrWBeBO0AZBc3jv1f/hRBwm6xFz/4v3UKXKbVpNXKJGVwv98mmY5s
         6VBbwBLHwUQXSx24ulA6YLRMgtyS0mFsHXiBsMq8qSlrshrhoeA44Cw52IeFGAHUgFnJ
         tCdA==
X-Gm-Message-State: AA+aEWZY3ifwioFgUCvxj7h8gdH1jSXxeNehmJcjJw7qGxG1NNhMrmH+
        YbT8aU7gvMJ8PjtEUBxk8g==
X-Google-Smtp-Source: AFSGD/VLqICDJ8SJXOtASqGEtI5NblnTP8foHTGFxeTLkjy/YzPm7proBxQBL0xltdXI3UWhhyOOCA==
X-Received: by 2002:a81:ed2:: with SMTP id 201mr16287284ywo.257.1543851964179;
        Mon, 03 Dec 2018 07:46:04 -0800 (PST)
Received: from 960 ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id w2sm11864782ywl.10.2018.12.03.07.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 07:46:03 -0800 (PST)
Message-ID: <eaa9d7a8898df9487031995429ff11892c9cd0ca.camel@gmail.com>
Subject: Re: [PATCH v8 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 03 Dec 2018 10:46:01 -0500
In-Reply-To: <s5hftvezupj.wl-tiwai@suse.de>
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
         <20181129235742.14332-3-ayman.bagabas@gmail.com>
         <s5hftvezupj.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 13:00 +0100, Takashi Iwai wrote:
> On Fri, 30 Nov 2018 00:57:37 +0100,
> Ayman Bagabas wrote:
> > This driver adds support for missing hotkeys on some Huawei
> > laptops.
> > Laptops such as the Matebook X have non functioning hotkeys.
> > Whereas
> > newer laptops such as the Matebook X Pro come with working hotkeys
> > out
> > of the box.
> > 
> > Old laptops, such as the Matebook X, report hotkey events through
> > ACPI
> > device "\WMI0". However, new laptops, such as the Matebook X Pro,
> > does not have this WMI device.
> > 
> > All the hotkeys on the Matebook X Pro work fine
> > without this patch except (micmute, wlan, and huawei key). These
> > keys
> > and the brightness keys report events to "\AMW0" ACPI device. One
> > problem is that brightness keys on the Matebook X Pro work without
> > this
> > patch. This results in reporting two brightness key press
> > events one is captured by ACPI and another by this driver.
> > 
> > A solution would be to check if such event came from the "\AMW0"
> > WMI driver
> > then skip reporting event. Another solution would be to leave this
> > to user-space to handle. Which
> > can be achieved by using "hwdb" tables and remap those keys to
> > "unknown".
> > This solution seems more natural to me because it leaves the
> > decision to
> > user-space.
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> 
> The new patch looks much better than the previous one, thanks for
> working on it.
> 
> Just a few comments:
> 
> > +struct huawei_wmi_priv {
> > +	struct input_dev *idev;
> > +	struct led_classdev cdev;
> > +	acpi_handle handle;
> 
> Is this handle set in anywhere?  I couldn't see it in your patch.
> If it's supposed to be NULL, passing NULL explicitly makes your
> intention clearer.
> 
> 
> > +static int huawei_wmi_leds_setup(struct wmi_device *wdev)
> > +{
> > +	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +	acpi_status status;
> > +
> > +	// Skip registering LED subsystem if no ACPI method was found.
> > +	status = acpi_get_handle(priv->handle, "\\_SB.PCI0.LPCB.EC0",
> > &priv->handle);
> > +	if (ACPI_FAILURE(status))
> > +		return 0;
> > +
> > +	if (acpi_has_method(priv->handle, "SPIN"))
> > +		priv->acpi_method = "SPIN";
> > +	else if (acpi_has_method(priv->handle, "WPIN"))
> > +		priv->acpi_method = "WPIN";
> > +	else
> > +		return 0;
> > +
> > +	priv->cdev.name = "platform::micmute";
> > +	priv->cdev.max_brightness = 1;
> > +	priv->cdev.brightness_set_blocking =
> > huawei_wmi_micmute_led_set;
> > +	priv->cdev.default_trigger = "audio-micmute";
> > +	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > +	priv->cdev.dev = &wdev->dev;
> 
> What about suspend/resume?
> When the driver is bound wit HD-audio, the HD-audio will restore the
> state at resume, so it would work.  But, by providing the LED class
> device, it is supposed to work even without HD-audio, so it might
> make
> sense to pass LED_CORE_SUSPENDRESUME, too.

Besides that, is there anything needed for wmi_device suspend/resume?

> 
> 
> > +static int __init huawei_wmi_init(void)
> > +{
> > +	if (!(wmi_has_guid(WMI0_EVENT_GUID) ||
> > wmi_has_guid(AMW0_EVENT_GUID))) {
> > +		pr_debug("Compatible WMI GUID not found\n");
> > +		return -ENODEV;
> > +	}
> 
> This is superfluous when you implement with wmi_driver.
> In theory, the supported GUID can be added dynamically via sysfs,
> too.
> 

I left it that way so it doesn't insert the module if these GUIDs were
not found. Should I drop that and use module_wmi_driver instead?

> 
> thanks,
> 
> Takashi

