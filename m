Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-227334-1519825469-2-3972942157735970042
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519825468; b=Er6/CC/pXxYscbjUOB3aJDeo9IpOlDED8VXQriS3ivdvvzQ
    5PtjD2OWcxgFGcBH+33uNzWTQmMCr4S7ZwveIDT7kTeTvj5SgvFxwlog1/WD4XkJ
    s82ImPMapIFebxNFrPDjmiUkhSSiJNdm1HH+FMvL9+PZWN9vR9ce2qUEAe8TH2xd
    r9dzahUFGjWWbwfhOPKhI7kwWe+bPkU0rK8gKSA/2Dr5Zdt/IYG2uUr2p/Xhjq9T
    quPVupy/8XiOQ52duA4gossEj2fb+ElohbsX21iTfIaB4ImtA8ft8YHT7kAFo0QY
    JZc3GOrrucg3kDHeyUYGEptDVGpSy0MHgIe6dNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1519825468; bh=exai4gAy
    gQ87ckduMDM6FbcAUo5SFhK3RBFlsPZHH+E=; b=NeuyzBh+vspGxbX6bkY9Rlwe
    yrzr6PIAmjeJIgTm+fFzwHZQtroD/3hsXV6YFWI8VQseT6GV5JxF2bfierREmvfv
    8TxuIOWstR+1n0tlOwy+YCHejLaB1B4e7MT5jfK4wL/sCNxOui4jQEzQBOpZ2Zhx
    NJg5emII6ofO3ExnFQ6SlT5IzNftzPJFMLst9afAyv+6K7b2ZuRFOO0hod2QeFFI
    uPtoP1jMUXolfkHasLHPE+3s4gLwc7KeZAptZ7PzKNl7F0dH7bG4n/ClgSDww3Ot
    F76GKep0Y71BdJl8bwG58dZCx/bYkTmSSeD/QYFuPOTKEqUv55zJ1QDtSOGKeg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=AVJRAY6i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=AVJRAY6i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeB1NoX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 08:44:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38005 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeB1NoS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 08:44:18 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180228134415euoutp01334e235be81453484f326013f94f3e8e~XgTMhumug2940029400euoutp01W
X-AuditID: cbfec7f4-b4fc79c0000043e4-a8-5a96b22a126c
Subject: Re: [PATCH v5 6/6] drm/bridge/sii8620: use micro-USB cable
 detection logic to detect MHL
To: Chanwoo Choi <cw00.choi@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Cc: Maciej Purski <m.purski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <54edf1d7-056f-ad75-4d94-e1efa2ffdc1c@samsung.com>
Date: Wed, 28 Feb 2018 14:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A95DB2B.6000003@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURj1zlvmOThxfSV+LZZNC7Zn9ONmCxFBA0UkVsREy2QvjZxJ5qml
        2WqaS5lamY4tY2TZYFnjGCZkYlOThk05aWqkgtqiSJCa2mY9X5H/znfO+fjOuVyO4juZCdxe
        Y5RgMuojNKyKvv90yDVvti1bt7C/fC45kdzDkHs5xQx50/eBIVcdLxjyuv8zS7JaM2jict1V
        kpTM60pia29giLv8EktyXBUKcu1GIkUsn5ppctvxTkkK3rxSkMSHDuVKrC26UoS07vQzCm1e
        ci6jtVlTWG1rmlOhLbl+VJtutyJtr23yBk6nWrZbiNgbI5gWrNipCm/pzmUiG5YebO+to4+h
        c4GpyJMDvBhK7V+ZVKTieFyIYOj7HVoSeNyH4NRZoyz0IqjKuMGmIm5kY6B2puy5iSDziUr2
        9CCo/XmZkoSxOBTqC7pZSRiHExG8zfuukAYK36LhTm4CI7lYPAt+ljSxElbjFVA4+IKWLtB4
        BrSUhUi0D94C+Rc6kWzxhurcjpF0nngOtL//MYIpPAUSSvMoGftCc8fVkVuAMzkw51RScs/V
        0Govo2U8FrqcdqWMJ8Hwg38LaQhqKlIoeTiPwNXlVsiupfDY+YqR0lF/UheXL5Dp5TDguMvI
        zzIGGnu85RBjIOv+RUqm1ZCcxMvuqdBaW/o3ji8UvOxnM9A086hq5lF1zKPqmP/ftSDainyF
        aNEQJoiLjMKB+aLeIEYbw+aH7jfY0J/P9/yXs68Mlf/YVYUwhzRe6krDBR3P6GPEWEMVAo7S
        jFPvicrW8erd+tg4wbR/hyk6QhCr0ESO1viqtwcc0fE4TB8l7BOESMH0T1VwnhOOodLO8xXP
        vOIH+Y62FmfQ+5NFwc/qk+yN/g1tNSGhMass1eus/KOgfCrdNszVZHx1jC+pc1ufdga4k74M
        eJ7efMXP/1vNep3ysMfH46ujK81+x5dYihItJH6TT6rXpvx5G6cHbzwr1jcp4tZOVfpVh9Zt
        2+ofuSbtUOwDj7StjkIcqaHFcH3gbMok6n8DpZZ0D3gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xe7oam6ZFGUz5zmLR1PGW1WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Swm3Z/AYnH+/AZ2i86JS9gtNj2+xmpxedccNosZ5/cxWSxa1sps
        seDlLRaLtUfuslssvX6RyaJ17xF2BwGPNfPWMHpc7utl8pjdMZPVY9OqTjaP+93HmTw2L6n3
        6NuyitHj8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYx7r2eyFlyzrnj8+RJLA+Nkwy5GDg4JAROJ72fVuhi5OIQEljJK3Pn1jL2LkRMo
        Li6xe/5bZghbWOLPtS42iKLXjBIf719mBEkICyRLvGzYygiSEBFoZ5S4eWwdO4jDLLCWReJ2
        035WiJYNTBK/li1gBWlhE9CU+Lv5JhuIzStgJ7HixzkWkDtYBFQl7u0IBgmLCkRIdK6czwJR
        IihxcuYTMJtTQFvi8bM/YDazgLrEn3mXmCFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpm
        IWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDatx37uXkH46WNwYcYBTgYlXh4M7Kn
        RgmxJpYVV+YeYpTgYFYS4U0rmRYlxJuSWFmVWpQfX1Sak1p8iNEU6LeJzFKiyfnARJRXEm9o
        amhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoEx/OBB380fnz/k4644uLl4
        sn3OmyM3G0vWn+nsljMKOPp5vxxXFEujjv6KTUG6moJcv5W2VDG8l+rIkCq1OmRaxfhyVVB5
        Ru6SJQe9z2+c+vBh9KH61G5G2fuB/4Lk7yVMcWx+PfvydFu9ue0XGpXunb8cE2C9OWx64ctJ
        7e/f3OxZWX70rdIjJZbijERDLeai4kQAhDkLEwwDAAA=
X-CMS-MailID: 20180228134409eucas1p125e43e9c481c302f468d0bdeab3fb9ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180228134409eucas1p125e43e9c481c302f468d0bdeab3fb9ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-RootMTR: 20180227071142eucas1p10203dac2558db034a4a3287220213601
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
        <20180227071134.28063-7-a.hajda@samsung.com> <5A953C21.5020007@samsung.com>
        <87dd3281-0471-ab2a-90c6-3f2d4bdf4750@samsung.com>
        <5A95DB2B.6000003@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.02.2018 23:26, Chanwoo Choi wrote:
> Hi,
>
> On 2018년 02월 27일 21:05, Andrzej Hajda wrote:
>> On 27.02.2018 12:08, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 2018년 02월 27일 16:11, Andrzej Hajda wrote:
>>>> From: Maciej Purski <m.purski@samsung.com>
>>>>
>>>> Currently MHL chip must be turned on permanently to detect MHL cable. It
>>>> duplicates micro-USB controller's (MUIC) functionality and consumes
>>>> unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
>>>> only if it detects MHL cable.
>>>>
>>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>> v5: updated extcon API
>>>>
>>>> This is rework of the patch by Maciej with following changes:
>>>> - use micro-USB port bindings to get extcon, instead of extcon property,
>>>> - fixed remove sequence,
>>>> - fixed extcon get state logic.
>>>>
>>>> Code finding extcon node is hacky IMO, I guess ultimately it should be done
>>>> via some framework (maybe even extcon), or at least via helper, I hope it
>>>> can stay as is until the proper solution will be merged.
>>>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>>  drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 94 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
>>>> index 9e785b8e0ea2..62b0adabcac2 100644
>>>> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
>>>> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
>>>> @@ -17,6 +17,7 @@
>>>>  
>>>>  #include <linux/clk.h>
>>>>  #include <linux/delay.h>
>>>> +#include <linux/extcon.h>
>>>>  #include <linux/gpio/consumer.h>
>>>>  #include <linux/i2c.h>
>>>>  #include <linux/interrupt.h>
>>>> @@ -25,6 +26,7 @@
>>>>  #include <linux/list.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/mutex.h>
>>>> +#include <linux/of_graph.h>
>>>>  #include <linux/regulator/consumer.h>
>>>>  #include <linux/slab.h>
>>>>  
>>>> @@ -81,6 +83,10 @@ struct sii8620 {
>>>>  	struct edid *edid;
>>>>  	unsigned int gen2_write_burst:1;
>>>>  	enum sii8620_mt_state mt_state;
>>>> +	struct extcon_dev *extcon;
>>>> +	struct notifier_block extcon_nb;
>>>> +	struct work_struct extcon_wq;
>>>> +	int cable_state;
>>>>  	struct list_head mt_queue;
>>>>  	struct {
>>>>  		int r_size;
>>>> @@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>>>>  	ctx->rc_dev = rc_dev;
>>>>  }
>>>>  
>>>> +static void sii8620_cable_out(struct sii8620 *ctx)
>>>> +{
>>>> +	disable_irq(to_i2c_client(ctx->dev)->irq);
>>>> +	sii8620_hw_off(ctx);
>>>> +}
>>>> +
>>>> +static void sii8620_extcon_work(struct work_struct *work)
>>>> +{
>>>> +	struct sii8620 *ctx =
>>>> +		container_of(work, struct sii8620, extcon_wq);
>>>> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>>>> +
>>>> +	if (state == ctx->cable_state)
>>>> +		return;
>>>> +
>>>> +	ctx->cable_state = state;
>>>> +
>>>> +	if (state > 0)
>>>> +		sii8620_cable_in(ctx);
>>>> +	else
>>>> +		sii8620_cable_out(ctx);
>>>> +}
>>>> +
>>>> +static int sii8620_extcon_notifier(struct notifier_block *self,
>>>> +			unsigned long event, void *ptr)
>>>> +{
>>>> +	struct sii8620 *ctx =
>>>> +		container_of(self, struct sii8620, extcon_nb);
>>>> +
>>>> +	schedule_work(&ctx->extcon_wq);
>>>> +
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static int sii8620_extcon_init(struct sii8620 *ctx)
>>>> +{
>>>> +	struct extcon_dev *edev;
>>>> +	struct device_node *musb, *muic;
>>>> +	int ret;
>>>> +
>>>> +	/* get micro-USB connector node */
>>>> +	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
>>>> +	/* next get micro-USB Interface Controller node */
>>>> +	muic = of_get_next_parent(musb);
>>>> +
>>>> +	if (!muic) {
>>>> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	edev = extcon_find_edev_by_node(muic);
>>>> +	of_node_put(muic);
>>>> +	if (IS_ERR(edev)) {
>>>> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
>>>> +			return -EPROBE_DEFER;
>>>> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
>>>> +		return PTR_ERR(edev);
>>>> +	}
>>>> +
>>>> +	ctx->extcon = edev;
>>>> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
>>>> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
>>>> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
>>> You better to use devm_extcon_register_notifier().
>> With devm version I risk that in case of device unbind notification will
>> be called after .remove callback, it seems to me quite dangerous. Or am
>> I missing something?
> If you use the cancel_work_sync() in remove() instead of flush_work(),
> you can use the 'devm_extcon_*'.

cancel_work_sync() does not prevent works scheduled later from execution
[1] and this scenario is possible with devm_extcon_register_notifier()
and cancel_work_sync().
So we end up with:
    sii8620_remove() calls cancel_work_sync()
...
    notifier(called asynchronously) schedules sii8620_extcon_work()
...
    notifier is removed by devm framework
    sii8620 context is destroyed by devm framework
...
    sii8620_extcon_work is executed on destroyed context !!! BUG !!!

For me it seems that devm_extcon_register_notifier is not safe in this case.

[1]: Since documentation was not clear I have performed live test
confirming my suspicions.

Regards
Andrzej

>
>> Regards
>> Andrzej
>>
>>>> +	if (ret) {
>>>> +		dev_err(ctx->dev, "failed to register notifier for MHL\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
>>>>  {
>>>>  	return container_of(bridge, struct sii8620, bridge);
>>>> @@ -2307,13 +2384,20 @@ static int sii8620_probe(struct i2c_client *client,
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> +	ret = sii8620_extcon_init(ctx);
>>>> +	if (ret < 0) {
>>>> +		dev_err(ctx->dev, "failed to initialize EXTCON\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>  	i2c_set_clientdata(client, ctx);
>>>>  
>>>>  	ctx->bridge.funcs = &sii8620_bridge_funcs;
>>>>  	ctx->bridge.of_node = dev->of_node;
>>>>  	drm_bridge_add(&ctx->bridge);
>>>>  
>>>> -	sii8620_cable_in(ctx);
>>>> +	if (!ctx->extcon)
>>>> +		sii8620_cable_in(ctx);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -2322,8 +2406,15 @@ static int sii8620_remove(struct i2c_client *client)
>>>>  {
>>>>  	struct sii8620 *ctx = i2c_get_clientdata(client);
>>>>  
>>>> -	disable_irq(to_i2c_client(ctx->dev)->irq);
>>>> -	sii8620_hw_off(ctx);
>>>> +	if (ctx->extcon) {
>>>> +		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
>>>> +					   &ctx->extcon_nb);
>>> Don't need to unregister the notifier if using devm_extcon_register_notifier().
>>>
>>>> +		flush_work(&ctx->extcon_wq);
>>>> +		if (ctx->cable_state > 0)
>>>> +			sii8620_cable_out(ctx);
>>>> +	} else {
>>>> +		sii8620_cable_out(ctx);
>>>> +	}
>>>>  	drm_bridge_remove(&ctx->bridge);
>>>>  
>>>>  	return 0;
>>>>
>>> If you use the resource managed function (devm_extcon_register_notifier), Looks good to me.
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>

