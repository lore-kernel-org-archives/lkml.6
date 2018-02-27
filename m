Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2581406-1519770430-2-14631947215624201889
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
    t=1519770429; b=j87D4N4wCYbi9fBwBC3bH2LE+G7ByhFUwLL/gvEfipTxKGX
    EPBWkF7iJ7Y8IcOibmyCAvkkfZCLlHhthUzz8Zb0zxrmISkp9n1SU1iE0x4gwYzv
    ytbnp8tws+GDNt6uCP75vjUE7+zihPIARmva/HksuegGAFa9ac3CwMjvgjwXSWLN
    er8iRGKTfRdswivJbvTPhu/pgJzIzZi8FmH10U5O/o8Xh7739/6CEnWvoqvZREzD
    oEgBA8IyyFgNc1FAoecphoIUhklFjO+HNrFl808eifTW/UsJscC0YoIcuNKRPLTh
    LKhMaeaUbs76Io/DZhCeQCFcixRTXdAOPY1JHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519770429; bh=q3AZfhve
    KFBfSdA5zOaJy03QIqG5OTF8QWGFAbJZXQE=; b=lGj2UNPuLppu+WnteilB8tiw
    BLIZ0zJd0o6bZM8VVFtwMliJ6xJ0H+RMv2qKkvYaXOgzcawp67994AoDP0ZUb3sO
    Z+1Rn35//nQ3kZUs2azAxfLY/M77Oda7s4gbXFqr/5eaiyHncP4QSQnc5bsw07TT
    RPqIMcceFLX7fBXlTR1ncVrIit/TX7hsd/hLDvdFizkBewhdNZ5sGfag6KAxJ11f
    bvG94ZMejEWGwBm/UdQ/WLLLXXJiQiV5OaLjzJY9LkMD1QLfD9VtOHaZkIj0EwSq
    B4xZS38DK6gdWiY9z3kTWIgVObSizufZlqJaIDSgrtu0WNnNj1AaRsD2rsrS2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=eElJ3BOS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=eElJ3BOS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeB0W0y (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:26:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:57812 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeB0W0w (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 17:26:52 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180227222650epoutp01ff775076cd64a8cc28c54a23273cb8d6~XTyLH9Ohp1383513835epoutp01M
X-AuditID: b6c32a36-c91ff70000001028-2a-5a95db28e31e
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A95DB2B.6000003@samsung.com>
Date: Wed, 28 Feb 2018 07:26:51 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andrzej Hajda <a.hajda@samsung.com>,
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
Subject: Re: [PATCH v5 6/6] drm/bridge/sii8620: use micro-USB cable
 detection logic to detect MHL
In-reply-to: <87dd3281-0471-ab2a-90c6-3f2d4bdf4750@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0wTWRjlzqMzGCvXgnKD0cVJTJQNpdMWHFyLbiQ6if5o4iNasmHHMqGE
        vjJTVEyMRHBtUVFAjSCKIJhQBbUSF1EXgmX5YwrisihGNBIU3zH4IPrHdsbN+u9833fOSc7J
        vTSu+1OTQhe5faLkFpyMZhZx7fay9PSlD4/bDBciem6sI0Jy+/xvSO7KyUsk1xiOjv98fKfh
        ah4fJbjBwcsUF6huobjQxL8kd6+7QcOdHPwL45rP78e5sy/GCK49/IjiWkfvYtz+W2FqNeQv
        nrkI+HtVhzH+lL+O5EPBgIZ/fHAA46+27OWrOoOAnw4tstI2caVDFApEKVV02z0FRe5CC7N+
        Y/6a/MwsA5vOZnPLmVS34BItTO4Ga/raImc0AZO6Q3CWRFdWQZaZjJyVkqfEJ6Y6PLLPwuSx
        rFHPGpbrjUaj3mz6bYUxM0r5XXS0RWpJ7wvzrtaydrIM+H+uBDSNoBmVNzKVYBatg10AHTr2
        AKjDZ4AqOic0lSBeIY32PMHUw2WA/BWtykEL56KZ2nEi5oTDn1B4uDi2xuEyNPWhhlD54wCV
        Xx+iVH4aen5jhoxhAi5BzV9uKj6a6L5n6r6CE+BiNDIzAWJ4HtyKrjd+omJGSbACoK7y84or
        DtsI1FFXrjglQjsaaX2lqOPhKlQx/EzJgGAzhW5P92Bqhlw0WTdAqDgRvRzopNQCFqDhfovK
        PwDQgVtncHU4BlBkdPy72ISeNVViarg56O3HQ6Qq1iL/HzqVwqNIaPK7569o8E6eGv8IhgJT
        YfIoWFT/Q2P1/zdW/0NjZwEeBPNFr+wqFGXWa9TLgksucRfq7R5XCCiPNi2rCzRHNvQBSANm
        ttZRfNymI4UdcqmrDyAaZ5K0bedqbTptgVC6W5Q8+VKJU5T7QGa08Go8ZZ7dE/0Cbl8+a842
        mLOM0feVzbJMstZqzbXpYKHgE4tF0StK/+kwOj6lDLQHnuKNgW1eU7i/NNH6dWm1ZfvYTvPW
        5GtNGfyWr+tyOk5nfL7ZFAwtjPNpO/y9G4O9I08SFr4ZS6Rc4S17k017VjzQbyKmQ3+vizPd
        H+6WDjfk2VucJ1oMWWvG3051/5Jxzra6qEB2wbjXZZPSglXvc4Z6N8u9NQlP26oaZve7GEJ2
        CGwaLsnCN4NwizHKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t9jQV2N21OjDE61iFvcWneO1aKp4y2r
        xcYZ61kt5h8Bcq98fc9mMen+BBaL8+c3sFt0TlzCbrHp8TVWi8u75rBZzDi/j8li0bJWZosF
        L2+xWKw9cpfdYun1i0wWrXuPsDsIeKyZt4bR43JfL5PH7I6ZrB6bVnWyedzvPs7ksXlJvUff
        llWMHp83yQVwRHHZpKTmZJalFunbJXBlrDw3mbXgpUnF0oa1rA2MHdpdjJwcEgImEtf3P2Dq
        YuTiEBJYxyixfcNPFpAEr4CgxI/J94BsDg5mAXmJI5eyIUx1iSlTciHKHzBKPNq5mw2iXEvi
        +e4frCA2i4CqxKJfe8DibEDx/S9ugNn8AooSV388ZgSZIyoQIdF9ohJkjohAG9DaGbsYQWqY
        BVazSMz9qgJiCwskS7xs2AoWFxLoZ5JYuzQLxOYUsJdoufSMcQKjwCwkl85CuHQWwqULGJlX
        MUqmFhTnpucWGxUY5qWW6xUn5haX5qXrJefnbmIERte2w1p9OxjvL4k/xCjAwajEw5uRPTVK
        iDWxrLgy9xCjBAezkgjvysWTo4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47FikkkJ5Ykpqd
        mlqQWgSTZeLglGpgNJvEffHcBlfmc/oVPIVizGWW0tySuolbr+/pj9m2/NB8+dS0zLb7wbrq
        e/85FheKCeXeNn92ffoZk5ZPFVVLu6Vdv74MzjjTZ2+sXsS3ga/Q4rbWr2+VvxnuPlHlPaay
        avtSn/L55W9lpybF7dn10mzlxd9rlu77nZL/+swGn9a5UeVXhT5sUGIpzkg01GIuKk4EAGme
        AOmqAgAA
X-CMS-MailID: 20180227222648epcas1p4af96d554ed48f9ffefa93c52ddd1fb16
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-RootMTR: 20180227071142eucas1p10203dac2558db034a4a3287220213601
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
        <20180227071134.28063-7-a.hajda@samsung.com> <5A953C21.5020007@samsung.com>
        <87dd3281-0471-ab2a-90c6-3f2d4bdf4750@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018년 02월 27일 21:05, Andrzej Hajda wrote:
> On 27.02.2018 12:08, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 02월 27일 16:11, Andrzej Hajda wrote:
>>> From: Maciej Purski <m.purski@samsung.com>
>>>
>>> Currently MHL chip must be turned on permanently to detect MHL cable. It
>>> duplicates micro-USB controller's (MUIC) functionality and consumes
>>> unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
>>> only if it detects MHL cable.
>>>
>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>> v5: updated extcon API
>>>
>>> This is rework of the patch by Maciej with following changes:
>>> - use micro-USB port bindings to get extcon, instead of extcon property,
>>> - fixed remove sequence,
>>> - fixed extcon get state logic.
>>>
>>> Code finding extcon node is hacky IMO, I guess ultimately it should be done
>>> via some framework (maybe even extcon), or at least via helper, I hope it
>>> can stay as is until the proper solution will be merged.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>>  drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 94 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
>>> index 9e785b8e0ea2..62b0adabcac2 100644
>>> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
>>> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
>>> @@ -17,6 +17,7 @@
>>>  
>>>  #include <linux/clk.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/extcon.h>
>>>  #include <linux/gpio/consumer.h>
>>>  #include <linux/i2c.h>
>>>  #include <linux/interrupt.h>
>>> @@ -25,6 +26,7 @@
>>>  #include <linux/list.h>
>>>  #include <linux/module.h>
>>>  #include <linux/mutex.h>
>>> +#include <linux/of_graph.h>
>>>  #include <linux/regulator/consumer.h>
>>>  #include <linux/slab.h>
>>>  
>>> @@ -81,6 +83,10 @@ struct sii8620 {
>>>  	struct edid *edid;
>>>  	unsigned int gen2_write_burst:1;
>>>  	enum sii8620_mt_state mt_state;
>>> +	struct extcon_dev *extcon;
>>> +	struct notifier_block extcon_nb;
>>> +	struct work_struct extcon_wq;
>>> +	int cable_state;
>>>  	struct list_head mt_queue;
>>>  	struct {
>>>  		int r_size;
>>> @@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>>>  	ctx->rc_dev = rc_dev;
>>>  }
>>>  
>>> +static void sii8620_cable_out(struct sii8620 *ctx)
>>> +{
>>> +	disable_irq(to_i2c_client(ctx->dev)->irq);
>>> +	sii8620_hw_off(ctx);
>>> +}
>>> +
>>> +static void sii8620_extcon_work(struct work_struct *work)
>>> +{
>>> +	struct sii8620 *ctx =
>>> +		container_of(work, struct sii8620, extcon_wq);
>>> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>>> +
>>> +	if (state == ctx->cable_state)
>>> +		return;
>>> +
>>> +	ctx->cable_state = state;
>>> +
>>> +	if (state > 0)
>>> +		sii8620_cable_in(ctx);
>>> +	else
>>> +		sii8620_cable_out(ctx);
>>> +}
>>> +
>>> +static int sii8620_extcon_notifier(struct notifier_block *self,
>>> +			unsigned long event, void *ptr)
>>> +{
>>> +	struct sii8620 *ctx =
>>> +		container_of(self, struct sii8620, extcon_nb);
>>> +
>>> +	schedule_work(&ctx->extcon_wq);
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>> +static int sii8620_extcon_init(struct sii8620 *ctx)
>>> +{
>>> +	struct extcon_dev *edev;
>>> +	struct device_node *musb, *muic;
>>> +	int ret;
>>> +
>>> +	/* get micro-USB connector node */
>>> +	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
>>> +	/* next get micro-USB Interface Controller node */
>>> +	muic = of_get_next_parent(musb);
>>> +
>>> +	if (!muic) {
>>> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	edev = extcon_find_edev_by_node(muic);
>>> +	of_node_put(muic);
>>> +	if (IS_ERR(edev)) {
>>> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
>>> +			return -EPROBE_DEFER;
>>> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
>>> +		return PTR_ERR(edev);
>>> +	}
>>> +
>>> +	ctx->extcon = edev;
>>> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
>>> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
>>> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
>> You better to use devm_extcon_register_notifier().
> 
> With devm version I risk that in case of device unbind notification will
> be called after .remove callback, it seems to me quite dangerous. Or am
> I missing something?

If you use the cancel_work_sync() in remove() instead of flush_work(),
you can use the 'devm_extcon_*'.

> 
> Regards
> Andrzej
> 
>>
>>> +	if (ret) {
>>> +		dev_err(ctx->dev, "failed to register notifier for MHL\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
>>>  {
>>>  	return container_of(bridge, struct sii8620, bridge);
>>> @@ -2307,13 +2384,20 @@ static int sii8620_probe(struct i2c_client *client,
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> +	ret = sii8620_extcon_init(ctx);
>>> +	if (ret < 0) {
>>> +		dev_err(ctx->dev, "failed to initialize EXTCON\n");
>>> +		return ret;
>>> +	}
>>> +
>>>  	i2c_set_clientdata(client, ctx);
>>>  
>>>  	ctx->bridge.funcs = &sii8620_bridge_funcs;
>>>  	ctx->bridge.of_node = dev->of_node;
>>>  	drm_bridge_add(&ctx->bridge);
>>>  
>>> -	sii8620_cable_in(ctx);
>>> +	if (!ctx->extcon)
>>> +		sii8620_cable_in(ctx);
>>>  
>>>  	return 0;
>>>  }
>>> @@ -2322,8 +2406,15 @@ static int sii8620_remove(struct i2c_client *client)
>>>  {
>>>  	struct sii8620 *ctx = i2c_get_clientdata(client);
>>>  
>>> -	disable_irq(to_i2c_client(ctx->dev)->irq);
>>> -	sii8620_hw_off(ctx);
>>> +	if (ctx->extcon) {
>>> +		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
>>> +					   &ctx->extcon_nb);
>> Don't need to unregister the notifier if using devm_extcon_register_notifier().
>>
>>> +		flush_work(&ctx->extcon_wq);
>>> +		if (ctx->cable_state > 0)
>>> +			sii8620_cable_out(ctx);
>>> +	} else {
>>> +		sii8620_cable_out(ctx);
>>> +	}
>>>  	drm_bridge_remove(&ctx->bridge);
>>>  
>>>  	return 0;
>>>
>> If you use the resource managed function (devm_extcon_register_notifier), Looks good to me.
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
