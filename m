Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bDM3AoU4HltINgAAmS7hNA
	; Mon, 11 Jun 2018 08:54:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EBB176074D; Mon, 11 Jun 2018 08:54:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BAevhXkh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5923D601D2;
	Mon, 11 Jun 2018 08:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5923D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeFKIx7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:53:59 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:26478 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeFKIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:53:56 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5B8raLJ003330;
        Mon, 11 Jun 2018 03:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528707216;
        bh=W22i9QK1e3xvBpYyxjHt/haPVQqAC+1VS6Q9Lg7MBG8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BAevhXkhjYhVj3jSXESF2O6sgrUHSCq8+yFfdA4ISWg5YrRifMV55IqU7wJxgo45b
         qbPkMAfdVfwbb9pNp46rS2rjOq29pEIath43L0xboONVypXAlK0igyiHgAJm5CESC7
         atVrnqMzVZvnCAvCTWvfxhZA0nmsiy3deF9Guq3s=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B8rZpX002121;
        Mon, 11 Jun 2018 03:53:36 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 11
 Jun 2018 03:53:35 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 11 Jun 2018 03:53:35 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B8rWa3016627;
        Mon, 11 Jun 2018 03:53:33 -0500
Subject: Re: Bug with dwc3 id detect and regulators
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        <kernel@pyra-handheld.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <FE91CFE8-B9E6-4A14-8F5A-4D6AB0955290@goldelico.com>
From: Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <941bfd38-e975-e460-81aa-ce8d90c7a3f5@ti.com>
Date: Mon, 11 Jun 2018 11:53:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <FE91CFE8-B9E6-4A14-8F5A-4D6AB0955290@goldelico.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chanwoo,

On 11/06/18 11:33, H. Nikolaus Schaller wrote:
> Hi Tony,
> another bug...
> 
> [  174.540313] BUG: scheduling while atomic: kworker/0:4/1327/0x00000002
> [  174.547353] Modules linked in: omapdrm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm drm_panel_orientation_quirks bnep bluetooth ecdh_generic usb_f_ecm g_ether usb_f_rndis u_ether libcomposite configfs ipv6 arc4 wl18xx wlcore mac80211 panel_boe_w677l snd_soc_omap_hdmi_audio snd_soc_dmic cfg80211 dwc3 snd_soc_omap_abe_twl6040 snd_soc_twl6040 leds_gpio wwan_on_off connector_hdmi omapdss encoder_tpd12s015 cec pwm_omap_dmtimer omapdss_base pwm_bl generic_adc_battery ehci_omap wlcore_sdio dwc3_omap bmp280_spi snd_soc_ts3a227e crtouch_mt leds_is31fl319x tsc2007 bq2429x_charger bq27xxx_battery_i2c bq27xxx_battery ina2xx as5013 tca8418_keypad twl6040_vibra palmas_pwrbutton gpio_twl6040 palmas_gpadc usb3503 bmp280_i2c bmc150_accel_i2c w2cbw003_bluetooth bmc150_magn_i2c bmp280 bmc150_accel_core
> [  174.624601]  bmc150_magn bno055 industrialio_triggered_buffer kfifo_buf industrialio snd_soc_omap_mcbsp snd_soc_omap_mcpdm snd_soc_omap snd_pcm_dmaengine [last unloaded: syscopyarea]
> [  174.642327] CPU: 0 PID: 1327 Comm: kworker/0:4 Tainted: G        W         4.17.0-letux+ #2408
> [  174.651541] Hardware name: Generic OMAP5 (Flattened Device Tree)
> [  174.658004] Workqueue: events_power_efficient palmas_gpio_id_detect
> [  174.664780] [<c01106ec>] (unwind_backtrace) from [<c010c058>] (show_stack+0x10/0x14)
> [  174.673109] [<c010c058>] (show_stack) from [<c074ba68>] (dump_stack+0x7c/0x9c)
> [  174.680881] [<c074ba68>] (dump_stack) from [<c0154050>] (__schedule_bug+0x60/0x84)
> [  174.689006] [<c0154050>] (__schedule_bug) from [<c075e3c0>] (__schedule+0x50/0x694)
> [  174.697217] [<c075e3c0>] (__schedule) from [<c075eab4>] (schedule+0xb0/0xcc)
> [  174.704790] [<c075eab4>] (schedule) from [<c0761e58>] (schedule_timeout+0x354/0x3d4)
> [  174.713100] [<c0761e58>] (schedule_timeout) from [<c075f544>] (wait_for_common+0x118/0x158)
> [  174.722064] [<c075f544>] (wait_for_common) from [<c05de908>] (omap_i2c_xfer+0x354/0x48c)
> [  174.730749] [<c05de908>] (omap_i2c_xfer) from [<c05d8410>] (__i2c_transfer+0x238/0x550)
> [  174.739350] [<c05d8410>] (__i2c_transfer) from [<c05d87ac>] (i2c_transfer+0x84/0xb4)
> [  174.747685] [<c05d87ac>] (i2c_transfer) from [<bf15b1f0>] (bq24296_i2c_reg8_read.constprop.8+0x54/0x64 [bq2429x_charger])
> [  174.759465] [<bf15b1f0>] (bq24296_i2c_reg8_read.constprop.8 [bq2429x_charger]) from [<bf15b8f4>] (bq24296_update_reg+0x28/0xf8 [bq2429x_charger])
> [  174.773437] [<bf15b8f4>] (bq24296_update_reg [bq2429x_charger]) from [<c0493b2c>] (_regulator_do_disable+0x100/0x238)
> [  174.784804] [<c0493b2c>] (_regulator_do_disable) from [<c0493cec>] (_regulator_disable+0x88/0x120)
> [  174.794404] [<c0493cec>] (_regulator_disable) from [<c0493db4>] (regulator_disable+0x30/0x60)
> [  174.803556] [<c0493db4>] (regulator_disable) from [<bf1950c8>] (dwc3_omap_set_mailbox+0x84/0xf8 [dwc3_omap])
> [  174.814124] [<bf1950c8>] (dwc3_omap_set_mailbox [dwc3_omap]) from [<bf195198>] (dwc3_omap_id_notifier+0x14/0x1c [dwc3_omap])
> [  174.826149] [<bf195198>] (dwc3_omap_id_notifier [dwc3_omap]) from [<c014e458>] (notifier_call_chain+0x40/0x68)
> [  174.836867] [<c014e458>] (notifier_call_chain) from [<c014e4a0>] (raw_notifier_call_chain+0x14/0x1c)
> [  174.846661] [<c014e4a0>] (raw_notifier_call_chain) from [<c063bda4>] (extcon_sync+0x54/0x19c)
> [  174.855804] [<c063bda4>] (extcon_sync) from [<c014874c>] (process_one_work+0x244/0x464)
> [  174.864386] [<c014874c>] (process_one_work) from [<c0148f20>] (worker_thread+0x2c0/0x3ec)
> [  174.873156] [<c0148f20>] (worker_thread) from [<c014cef4>] (kthread+0x134/0x150)
> [  174.881087] [<c014cef4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> 
> It turns out that extcon_sync() holds a spinlock while sending its notifiers and this
> is ending up in our regulator.en/disable() which wants to use blocking i2c.
> 
> Do you see similar things on the OMAP5EVM when using OTG mode?
> The Palmas SMPS10 is also handled through i2c. Or is this magically hidden by regmap?
> 
> Well, as a workaround, I can make the regulator.en/disable() in the bq2429x driver
> just trigger a worker, but IMHO it is not expected for regulator ops to be spinlock safe.
> 
> So I think extcon should not spinlock (which might be against the extcon design) or

I think this something that should be addressed in the Extcon layer.
Do you really need to call the raw_notifier_call_chain() function with spinlock held in extcon_sync()?
if yes why?

I think we don't want to call all notifiers in atomic context as this would keep interrupts disabled
for quite some time and is suboptimal.

> dwc3_omap_set_mailbox should move dis/enabling regulator to some worker thread so
> that they can block.
> 
> The best would be to make dwc3_omap_set_mailbox call regulator_enable_deferred(omap->vbus_reg, 0)
> but that function does not exist.
> 
> Any ideas?
> 
> BR,
> Nikolaus
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
