Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39DD8C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB613208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EIAKoW/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB613208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935953AbeFNBUp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:20:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:55138 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbeFNBUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:20:42 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180614012040epoutp04d9d1bfb4e16a4726c49e9a175b5fcd3f~34iN3rhTB2397623976epoutp04S;
        Thu, 14 Jun 2018 01:20:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180614012040epoutp04d9d1bfb4e16a4726c49e9a175b5fcd3f~34iN3rhTB2397623976epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528939240;
        bh=Jm/idsQJC710EriEx0axPvMnOb1hLS/jlUZBPz3jOqU=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=EIAKoW/3gX3TCvdrYClTxLPuACjE/UJWALtpCE9+h5XzBgLLKfVND6wF8IhBLzJDi
         zclhfXXAdFpMG2UySxNp111LXi/2ZopDpC7/BvbG8rZDYoK5c1k6mKRNzgO0u24RXE
         3ldpYoZACwi197M+7e2U7WpkhZ+aVWXi01E/LcHw=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180614012038epcas1p2824bf248df3530974c87750e08fe6b92~34iL0ung_1550915509epcas1p2g;
        Thu, 14 Jun 2018 01:20:38 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.DE.04217.6E2C12B5; Thu, 14 Jun 2018 10:20:38 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180614012037epcas2p254335fda52b9a97e747f27ec9f60fe11~34iLh34w32325723257epcas2p2g;
        Thu, 14 Jun 2018 01:20:37 +0000 (GMT)
X-AuditID: b6c32a45-441ff70000001079-29-5b21c2e6aaef
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.05.04192.5E2C12B5; Thu, 14 Jun 2018 10:20:37 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAA004UEH2DBK30@mmp1.samsung.com>; Thu, 14 Jun 2018 10:20:37 +0900 (KST)
Message-id: <5B21C2E5.2090004@samsung.com>
Date:   Thu, 14 Jun 2018 10:20:37 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Roger Quadros <rogerq@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com, linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bug with dwc3 id detect and regulators
In-reply-to: <941bfd38-e975-e460-81aa-ce8d90c7a3f5@ti.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHO7tzu4qr43J10LR5I8LR1l5cu0aKoMUoDaEv1Yh1cZdNcpvt
        bpJWVGSt5io1CrHSCguxiDItU8jcLNNVmGZvZh8SbQay8H1U0LZb5KfzvPzOn+f58+CYMBiV
        gBda7LTNQhURvBjuQ2+qRjruSdHJR7sE5MLDWQ45MHuY7B9z88jWXwM8crD9Co+83HCeS7q/
        SsjOt9uycO3cbDVXeyfQh2nLq9v52pnyE5i258Mjjna6OTmft4febKIpA20T05YCq6HQYswg
        tu/UZ+vVG+UKqSKd1BBiC2WmM4ic3Hzp1sKi0DSEuIQqcoRK+RTDEBsyN9usDjstNlkZewah
        UyiUMoVcI1MqQ69q7yalOoTso02Tc9NY8djGg0Oj97BjoFfmAtE4gmmo9X0d5gIxuBC2AXS7
        rZ/DJvMA+eoquP+oprMXAdvoAOi9uwYLNwQwDi1c+BKCcByDq1H3wP5wGYOpyD9TzWX5EYCq
        AkHA8hJ040ZnJObCtcj5/Fkk5oXqnf4PvHC8DKagoYXRSF0Ed6HH9XP8sFA8vAzQxLeJiCoG
        fQDVnTkRFaaWQxVqHA5ERo2Gm9DV+peRHRAc5qGx3il+eDwEc1BD01F2neXoe08Ln40T0XjT
        fcDyToBm/GHRcFIJ0I++BxyWUqHx6y4Ou9xSdNr7+6+oAJ0+JWQRLZp/4fzrUTdAwUAPqARJ
        tYtsqv1vU+0im64BrAmsoIsZs5FmlMUKGUOZGYfFKCuwmptB5OwkW9pAzetcD4A4IGIF95JT
        dMIoqoQpNXsAwjEiXrDDL9YJBQaqtIy2WfU2RxHNeIA65HIVliAqsIaO2GLXK9RKlUpFqjXp
        Knk6sVIAPkKdEBopO72fpotp279/HDw64RioGEwKtjwVNcaK1qxq2W3O8sbdHlO+a526G1dR
        ZoDtJ39+4ua1vnH2PngUq+8q3ZDos/ulxxtTfT/6Ds3XDpWnBEcOT9Y8OfCKvyLN9tHgzT0X
        2+voOJC9etD9+UimUiJY46jnr+uIhzeTnl261e/K7Cbu7BguaViiSTvZnLde+prgMiZKIcFs
        DPUHcsMCdIwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jAd2nhxSjDdbN0rT4se0rk8WlrzUW
        F572sFls/XOJzeLyrjlsFrOX9LNY9DzSsth/xcuBw+Pb10ksHmven2L2aJm0i93jS0szs8fx
        G9uZPD5vkgtgi+KySUnNySxLLdK3S+DKePvtM3PBU7OKq483MDcwntTrYuTkkBAwkVjVO5Wx
        i5GLQ0hgJ6PEzt6fbCAJXgFBiR+T77F0MXJwMAvISxy5lA1hqktMmZILUX6fUWLF+l9MEOVa
        EosW7WcEsVkEVCXajx0Fs9mA4vtf3AAbyS+gKHH1x2NGkDmiAhES3ScqQeaICMxklHi+bT0r
        iMMscBrI+XaVBaRBWMBYYsXt9ywQ244wShz9+QgswSlgJTF3/hmmCYwCs5DcOgvh1lkIty5g
        ZF7FKJlaUJybnltsVGCUl1quV5yYW1yal66XnJ+7iREY+NsOa/XvYHy8JP4QowAHoxIPb4Ky
        YrQQa2JZcWXuIUYJDmYlEV6/FwrRQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5ak
        ZqemFqQWwWSZODilGhjZ+bW7srM81nV3lnMeDBCt41M8ySwx6XToITVN5U8xInYLp0rxL896
        YRz0b8abvlBGm94dKl9si2YL1AVeu9lfGX72qK7qtfV3WZ/8/hfY5dn44u5e9Z7vEqtlY89b
        BbHbWSaeXZnsufj3D8dbyRaH/2xgzj1gvnGJwZk957cIHLc+zyCqrq3EUpyRaKjFXFScCAAf
        cSAheAIAAA==
X-CMS-MailID: 20180614012037epcas2p254335fda52b9a97e747f27ec9f60fe11
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180611085358epcas2p31227dd481046041532c7fc7a00c8e088
References: <FE91CFE8-B9E6-4A14-8F5A-4D6AB0955290@goldelico.com>
        <CGME20180611085358epcas2p31227dd481046041532c7fc7a00c8e088@epcas2p3.samsung.com>
        <941bfd38-e975-e460-81aa-ce8d90c7a3f5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 2018년 06월 11일 17:53, Roger Quadros wrote:
> Chanwoo,
> 
> On 11/06/18 11:33, H. Nikolaus Schaller wrote:
>> Hi Tony,
>> another bug...
>>
>> [  174.540313] BUG: scheduling while atomic: kworker/0:4/1327/0x00000002
>> [  174.547353] Modules linked in: omapdrm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm drm_panel_orientation_quirks bnep bluetooth ecdh_generic usb_f_ecm g_ether usb_f_rndis u_ether libcomposite configfs ipv6 arc4 wl18xx wlcore mac80211 panel_boe_w677l snd_soc_omap_hdmi_audio snd_soc_dmic cfg80211 dwc3 snd_soc_omap_abe_twl6040 snd_soc_twl6040 leds_gpio wwan_on_off connector_hdmi omapdss encoder_tpd12s015 cec pwm_omap_dmtimer omapdss_base pwm_bl generic_adc_battery ehci_omap wlcore_sdio dwc3_omap bmp280_spi snd_soc_ts3a227e crtouch_mt leds_is31fl319x tsc2007 bq2429x_charger bq27xxx_battery_i2c bq27xxx_battery ina2xx as5013 tca8418_keypad twl6040_vibra palmas_pwrbutton gpio_twl6040 palmas_gpadc usb3503 bmp280_i2c bmc150_accel_i2c w2cbw003_bluetooth bmc150_magn_i2c bmp280 bmc150_accel_core
>> [  174.624601]  bmc150_magn bno055 industrialio_triggered_buffer kfifo_buf industrialio snd_soc_omap_mcbsp snd_soc_omap_mcpdm snd_soc_omap snd_pcm_dmaengine [last unloaded: syscopyarea]
>> [  174.642327] CPU: 0 PID: 1327 Comm: kworker/0:4 Tainted: G        W         4.17.0-letux+ #2408
>> [  174.651541] Hardware name: Generic OMAP5 (Flattened Device Tree)
>> [  174.658004] Workqueue: events_power_efficient palmas_gpio_id_detect
>> [  174.664780] [<c01106ec>] (unwind_backtrace) from [<c010c058>] (show_stack+0x10/0x14)
>> [  174.673109] [<c010c058>] (show_stack) from [<c074ba68>] (dump_stack+0x7c/0x9c)
>> [  174.680881] [<c074ba68>] (dump_stack) from [<c0154050>] (__schedule_bug+0x60/0x84)
>> [  174.689006] [<c0154050>] (__schedule_bug) from [<c075e3c0>] (__schedule+0x50/0x694)
>> [  174.697217] [<c075e3c0>] (__schedule) from [<c075eab4>] (schedule+0xb0/0xcc)
>> [  174.704790] [<c075eab4>] (schedule) from [<c0761e58>] (schedule_timeout+0x354/0x3d4)
>> [  174.713100] [<c0761e58>] (schedule_timeout) from [<c075f544>] (wait_for_common+0x118/0x158)
>> [  174.722064] [<c075f544>] (wait_for_common) from [<c05de908>] (omap_i2c_xfer+0x354/0x48c)
>> [  174.730749] [<c05de908>] (omap_i2c_xfer) from [<c05d8410>] (__i2c_transfer+0x238/0x550)
>> [  174.739350] [<c05d8410>] (__i2c_transfer) from [<c05d87ac>] (i2c_transfer+0x84/0xb4)
>> [  174.747685] [<c05d87ac>] (i2c_transfer) from [<bf15b1f0>] (bq24296_i2c_reg8_read.constprop.8+0x54/0x64 [bq2429x_charger])
>> [  174.759465] [<bf15b1f0>] (bq24296_i2c_reg8_read.constprop.8 [bq2429x_charger]) from [<bf15b8f4>] (bq24296_update_reg+0x28/0xf8 [bq2429x_charger])
>> [  174.773437] [<bf15b8f4>] (bq24296_update_reg [bq2429x_charger]) from [<c0493b2c>] (_regulator_do_disable+0x100/0x238)
>> [  174.784804] [<c0493b2c>] (_regulator_do_disable) from [<c0493cec>] (_regulator_disable+0x88/0x120)
>> [  174.794404] [<c0493cec>] (_regulator_disable) from [<c0493db4>] (regulator_disable+0x30/0x60)
>> [  174.803556] [<c0493db4>] (regulator_disable) from [<bf1950c8>] (dwc3_omap_set_mailbox+0x84/0xf8 [dwc3_omap])
>> [  174.814124] [<bf1950c8>] (dwc3_omap_set_mailbox [dwc3_omap]) from [<bf195198>] (dwc3_omap_id_notifier+0x14/0x1c [dwc3_omap])
>> [  174.826149] [<bf195198>] (dwc3_omap_id_notifier [dwc3_omap]) from [<c014e458>] (notifier_call_chain+0x40/0x68)
>> [  174.836867] [<c014e458>] (notifier_call_chain) from [<c014e4a0>] (raw_notifier_call_chain+0x14/0x1c)
>> [  174.846661] [<c014e4a0>] (raw_notifier_call_chain) from [<c063bda4>] (extcon_sync+0x54/0x19c)
>> [  174.855804] [<c063bda4>] (extcon_sync) from [<c014874c>] (process_one_work+0x244/0x464)
>> [  174.864386] [<c014874c>] (process_one_work) from [<c0148f20>] (worker_thread+0x2c0/0x3ec)
>> [  174.873156] [<c0148f20>] (worker_thread) from [<c014cef4>] (kthread+0x134/0x150)
>> [  174.881087] [<c014cef4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>>
>> It turns out that extcon_sync() holds a spinlock while sending its notifiers and this
>> is ending up in our regulator.en/disable() which wants to use blocking i2c.
>>
>> Do you see similar things on the OMAP5EVM when using OTG mode?
>> The Palmas SMPS10 is also handled through i2c. Or is this magically hidden by regmap?
>>
>> Well, as a workaround, I can make the regulator.en/disable() in the bq2429x driver
>> just trigger a worker, but IMHO it is not expected for regulator ops to be spinlock safe.
>>
>> So I think extcon should not spinlock (which might be against the extcon design) or
> 
> I think this something that should be addressed in the Extcon layer.
> Do you really need to call the raw_notifier_call_chain() function with spinlock held in extcon_sync()?
> if yes why?

To reduce the latency of notification is important of extcon.

So, extcon used the spinlock before calling the notifier_call_chain
to prevent the scheduled out for a moment. Also, the notifier_call
calls the registered notifier function sequentially. It means that
if some registered notifier function spends a lot of time,
the next registered notifier might receive the notification
with a delay. So, extcon used the spinlock. Unitl now, 

But, as you commented and previously, sometimes it caused the similar issues.
(To fix similar issues, the consumer device used the workqueue)

I will call notifier function without spinlock as following
and I'll consider the other way to notify the changed state to consumer device
with broadcasting way.

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 8bff5fd18185..1e35b8ca3951 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
                return index;
 
        spin_lock_irqsave(&edev->lock, flags);
-
        state = !!(edev->state & BIT(index));
+       spin_unlock_irqrestore(&edev->lock, flags);
 
        /*
         * Call functions in a raw notifier chain for the specific one
@@ -448,6 +448,8 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
         */
        raw_notifier_call_chain(&edev->nh_all, state, edev);
 
+       spin_lock_irqsave(&edev->lock, flags);
+

> 
> I think we don't want to call all notifiers in atomic context as this would keep interrupts disabled
> for quite some time and is suboptimal.
> 
>> dwc3_omap_set_mailbox should move dis/enabling regulator to some worker thread so
>> that they can block.
>>
>> The best would be to make dwc3_omap_set_mailbox call regulator_enable_deferred(omap->vbus_reg, 0)
>> but that function does not exist.
>>
>> Any ideas?
>>
>> BR,
>> Nikolaus
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
