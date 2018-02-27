Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330745-1519733138-2-12879514483184112766
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
    t=1519733137; b=qA+Gzd6JsCMRCc57cuXRr4jYd7p1Dym2qHQcaJksLTftbu9
    r7OJ5pj3MYtLr7vJJe1iRzS8ijG8LpduZbZnOLaE+5QTEZD67pHj3EjSrkTPgegu
    gvpchV+ZXHdGzA+NHGSyimjEAMkVy571hP5epPBUstIhM18EE7xNWcYLf3Sa3D1m
    5bgFVAD6fGu+aCzNROg7+ms3jN7rnpRDkPDx+mO02PgG8qWJWQR947KHCeuCSvSi
    TB0JuVbARVhwwi2PWzkLtlSD6W5THoQwsBlgf10/T9D9vY9Nd6Hlc89jsOEUaCeA
    jn25KQLElmL1iwv6BuzU4MXjWLOTtsAfZ6BhG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1519733137; bh=JuLtg21+
    gpQQSzUyUPcfzyWKyu1xY5KK5Ds0SI1/cJo=; b=mOBQHUSBrGUotOsOQNStA+7V
    oCF96hYGtYs7Zyi6xWADjsOs5e/ID9hbjZrRvuzlR3q01K3K9JfagoYyHJJaoS1p
    GMYQQ+oQQxciTt/RlCy9QYtNjvPhjshpdeKzXLLyv+p9QbjraqI8WRPYqEoS1iV7
    E2AVsEEAfz6++8SsEqc7GuqHT3BzacjIei0yuRuaYWMK+97WADpsbFAWyeSRoDAb
    aC4JjaBldbZ/9vw+aPlfhKZMQBPTX9UkqluHHRXwlCsu9ZR+FcpUfCwMmiULeO4I
    kJjszdi7lGraPBcYIhOdWod+JTbbNQhgOg0DMCdbUMOPNCp9VXWzt7aeuMebZQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=l5dtpI6m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=l5dtpI6m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeB0MFe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 07:05:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46136 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeB0MFb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 07:05:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180227120529euoutp015e705fe736a2a280a0228de61171c390~XLTrI27a30274402744euoutp01j
X-AuditID: cbfec7f2-1dbff70000011644-10-5a9549885502
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
Message-ID: <87dd3281-0471-ab2a-90c6-3f2d4bdf4750@samsung.com>
Date: Tue, 27 Feb 2018 13:05:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A953C21.5020007@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGefcdXc1eZ7EHC7V1tEiL+vFBZVFB818/imKQuexLK7dkU9OO
        llrT0NS0PLRmeagtTZ1aKWmwrJmpc1lqJ5ZliYYE5QKJZW4fkv+u+33u53DDyxLSESqAPaJJ
        4LUaVZycFpMPnk/a1+gjCpVru4bmcRf04xRXX1RLcQMTIxRnbO+huNeuHzSX78wlObu9juEy
        8yoYzvKln+L6Wm7QXJG9TcTdrsoguLLRdyRX0/6R4SoHHCIuo7Wd2YoV1TerkaIvJ1ukKNUX
        UwqLOZNWOC/bRIqGinOKnEYzUvyyBO5ileJNh/i4I0m8Niw8Shw7UNzNxPeHJTtzushU9H55
        FvJhAW8AV6NdlIXErBTfRdDT3YoEMYHAXG6hPC4p/oXAMbFlpmP00kzHHQTfOpsJQYwj6Jhy
        Mx6XP46GN5XfaU9hPs5A8L70j7eFwCYS7heneefSOATcDW9pD0twOHy69srLJF4Gjs6HXl6A
        98Gtwq9I8PjBi+Jh0sM+eDUY000iDxM4CNKaSgmBZfBu2OhdBjibhcLm9OmT2GmxA34OHhYy
        +MOYrZEReBFMNc/4LyPobMskBFGAwD7WJxJcG+GpzUF5BhHTV9e2hAnPm2GoyY2E+b4wOO4n
        3OAL+Q+uE8KzBPQXpYJ7MTi7mwiBZVDZ66Jz0ZKSWclKZqUpmZWm5P/eMkSakYxP1KljeN06
        DX8iVKdS6xI1MaHRx9UWNP39Xv61/XyEXK8OWhFmkXyupCiwQCmlVEm6FLUVAUvI50tM5VeV
        UskhVcpJXnv8gDYxjtdZ0UKWlMskkSvPKqU4RpXAH+P5eF47UxWxPgGpKMBNnWjA6VtiIjuG
        roxfS23J2t6Z0szYj04aV/o8TFi/Y2fK3o5IwxOGNKzIFwdd2JbUmxf8KSJqjrUmO/jxxdtn
        6JNbQy/tMeYO//an9/f2l57e9SLoXOCp6K5nVY+SXeW7d4d8cLM9plt1SsPn9PP36iZ9aUOa
        cTj2Y/Lgy/qQpXJSF6tat4rQ6lT/AH5EyHd6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7rtnlOjDDa/4rZo6njLarFxxnpW
        i+tfnrNazD9yjtXiytf3bBaT7k9gsTh/fgO7RefEJewWmx5fY7W4vGsOm8WM8/uYLBYta2W2
        WPDyFovF2iN32S2WXr/IZNG69wi7g4DHmnlrGD0u9/UyeczumMnqsWlVJ5vH/e7jTB6bl9R7
        9G1ZxejxeZNcAEeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsb1mWfZC67pV9zvO8PSwHhbrYuRk0NCwETiZft5pi5GLg4hgaWMEht2X2SFSIhL
        7J7/lhnCFpb4c62LDaLoNaPEg1df2EESwgLJEi8btjKCJEQE2hklbh5bxw7iMAusZZG43bSf
        FaLlFqPExe33WUBa2AQ0Jf5uvskGYvMK2Ek8mHYJzGYRUJW4eGo7mC0qECHRuXI+C0SNoMTJ
        mU/AbE4BbYn5LSuZQGxmAXWJP/MuMUPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKy
        gJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmDEbzv2c8sOxq53wYcYBTgYlXh4Z8hNiRJi
        TSwrrsw9xCjBwawkwrty8eQoId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJqO8knhDU0Nz
        C0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MLYqv/2bOLV906Gah3Dq5+VWW
        VZkFGsat3z+vCv2YVF8mkst6LS0467Wc50V++z4pz/hX8WlGol9y67Zd17BdY5vM/bfQUKxx
        9brc/gXszF6nGjcu/POaafHjf6ZBhv5lv0QWty77rBOxVE8g+JLMxa64dc2l7HO5PfhMwrQ0
        PwYpatT3z1FiKc5INNRiLipOBABRNkYsDgMAAA==
X-CMS-MailID: 20180227120527eucas1p22f55a956a89bd03447dc59a261e1d966
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180227120527eucas1p22f55a956a89bd03447dc59a261e1d966
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-RootMTR: 20180227071142eucas1p10203dac2558db034a4a3287220213601
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
        <20180227071134.28063-7-a.hajda@samsung.com> <5A953C21.5020007@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.02.2018 12:08, Chanwoo Choi wrote:
> Hi,
>
> On 2018년 02월 27일 16:11, Andrzej Hajda wrote:
>> From: Maciej Purski <m.purski@samsung.com>
>>
>> Currently MHL chip must be turned on permanently to detect MHL cable. It
>> duplicates micro-USB controller's (MUIC) functionality and consumes
>> unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
>> only if it detects MHL cable.
>>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v5: updated extcon API
>>
>> This is rework of the patch by Maciej with following changes:
>> - use micro-USB port bindings to get extcon, instead of extcon property,
>> - fixed remove sequence,
>> - fixed extcon get state logic.
>>
>> Code finding extcon node is hacky IMO, I guess ultimately it should be done
>> via some framework (maybe even extcon), or at least via helper, I hope it
>> can stay as is until the proper solution will be merged.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 94 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
>> index 9e785b8e0ea2..62b0adabcac2 100644
>> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
>> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
>> @@ -17,6 +17,7 @@
>>  
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>> +#include <linux/extcon.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/i2c.h>
>>  #include <linux/interrupt.h>
>> @@ -25,6 +26,7 @@
>>  #include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of_graph.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/slab.h>
>>  
>> @@ -81,6 +83,10 @@ struct sii8620 {
>>  	struct edid *edid;
>>  	unsigned int gen2_write_burst:1;
>>  	enum sii8620_mt_state mt_state;
>> +	struct extcon_dev *extcon;
>> +	struct notifier_block extcon_nb;
>> +	struct work_struct extcon_wq;
>> +	int cable_state;
>>  	struct list_head mt_queue;
>>  	struct {
>>  		int r_size;
>> @@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>>  	ctx->rc_dev = rc_dev;
>>  }
>>  
>> +static void sii8620_cable_out(struct sii8620 *ctx)
>> +{
>> +	disable_irq(to_i2c_client(ctx->dev)->irq);
>> +	sii8620_hw_off(ctx);
>> +}
>> +
>> +static void sii8620_extcon_work(struct work_struct *work)
>> +{
>> +	struct sii8620 *ctx =
>> +		container_of(work, struct sii8620, extcon_wq);
>> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>> +
>> +	if (state == ctx->cable_state)
>> +		return;
>> +
>> +	ctx->cable_state = state;
>> +
>> +	if (state > 0)
>> +		sii8620_cable_in(ctx);
>> +	else
>> +		sii8620_cable_out(ctx);
>> +}
>> +
>> +static int sii8620_extcon_notifier(struct notifier_block *self,
>> +			unsigned long event, void *ptr)
>> +{
>> +	struct sii8620 *ctx =
>> +		container_of(self, struct sii8620, extcon_nb);
>> +
>> +	schedule_work(&ctx->extcon_wq);
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static int sii8620_extcon_init(struct sii8620 *ctx)
>> +{
>> +	struct extcon_dev *edev;
>> +	struct device_node *musb, *muic;
>> +	int ret;
>> +
>> +	/* get micro-USB connector node */
>> +	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
>> +	/* next get micro-USB Interface Controller node */
>> +	muic = of_get_next_parent(musb);
>> +
>> +	if (!muic) {
>> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
>> +		return 0;
>> +	}
>> +
>> +	edev = extcon_find_edev_by_node(muic);
>> +	of_node_put(muic);
>> +	if (IS_ERR(edev)) {
>> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
>> +		return PTR_ERR(edev);
>> +	}
>> +
>> +	ctx->extcon = edev;
>> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
>> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
>> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
> You better to use devm_extcon_register_notifier().

With devm version I risk that in case of device unbind notification will
be called after .remove callback, it seems to me quite dangerous. Or am
I missing something?

Regards
Andrzej

>
>> +	if (ret) {
>> +		dev_err(ctx->dev, "failed to register notifier for MHL\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
>>  {
>>  	return container_of(bridge, struct sii8620, bridge);
>> @@ -2307,13 +2384,20 @@ static int sii8620_probe(struct i2c_client *client,
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = sii8620_extcon_init(ctx);
>> +	if (ret < 0) {
>> +		dev_err(ctx->dev, "failed to initialize EXTCON\n");
>> +		return ret;
>> +	}
>> +
>>  	i2c_set_clientdata(client, ctx);
>>  
>>  	ctx->bridge.funcs = &sii8620_bridge_funcs;
>>  	ctx->bridge.of_node = dev->of_node;
>>  	drm_bridge_add(&ctx->bridge);
>>  
>> -	sii8620_cable_in(ctx);
>> +	if (!ctx->extcon)
>> +		sii8620_cable_in(ctx);
>>  
>>  	return 0;
>>  }
>> @@ -2322,8 +2406,15 @@ static int sii8620_remove(struct i2c_client *client)
>>  {
>>  	struct sii8620 *ctx = i2c_get_clientdata(client);
>>  
>> -	disable_irq(to_i2c_client(ctx->dev)->irq);
>> -	sii8620_hw_off(ctx);
>> +	if (ctx->extcon) {
>> +		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
>> +					   &ctx->extcon_nb);
> Don't need to unregister the notifier if using devm_extcon_register_notifier().
>
>> +		flush_work(&ctx->extcon_wq);
>> +		if (ctx->cable_state > 0)
>> +			sii8620_cable_out(ctx);
>> +	} else {
>> +		sii8620_cable_out(ctx);
>> +	}
>>  	drm_bridge_remove(&ctx->bridge);
>>  
>>  	return 0;
>>
> If you use the resource managed function (devm_extcon_register_notifier), Looks good to me.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>

