Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199880-1519729730-2-9093799607936272609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519729729; b=Tdt0fqTxIv9xcWn2D8tH19woMbWxpTHSVkOjVyYAbjoqy9R
    6EaQHA8Iobdt1rIaPuERHQ/B7C+oKzS0X0hGk4wqyOVV21ilAV8Zbue7XWOnMdrA
    GaqpC9bHxTzZ1+6owVorl4Vtq+megu+rCUWnVuXCRf3K+/3HanVM/w/p8uzOZtkb
    e6FAwUdcBZcuyWneNzOTFzzAi+UycqvXoMKDDCKt1OjQG5qQc8o5YPxfhdd6KkjY
    kWQ1j4ZvECDEt+PcZdZVYih1VagPMteBtF7cTa/QQ3aspGe3JLwwU9B4Ah4vTQ+Z
    IkW673KDbPaCs220NhnEWyyvaJ45VD34+Pbhs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519729729; bh=oGRnn5gt
    G7kLjtCy0HEr5WE4rfanyjajb4WKhUjU6Xk=; b=eWGNar/FoSEg2RUbORi4c/np
    sT4veKXHAO4h7b3WNjZpIpnZ3CejxjeMtRc6TLmiRLMKItZ0fRksAr0FNAiUcdU+
    MU1evCRkPAksdOevYH8K0wiH8ZPYishkuycjJv651qvEb8cYDsqpGNlwFDEC0z+c
    BaQOGYhf211LaNDwGOw7R9ApG+H8oPP7KaGTn2hXPHiaxkAkYT0uJwOkknZtT4p1
    sqr38x5tmSnvJKx3zyCU1kMP4oj4o2M9V1g41ALeIe/0XIDt1JWoXldeZoy1Qlqi
    h7qheMj1s9eqYwjJilALqUePNP/1VDmkaL4mjVNj0LEmvYaCwTethBSultSxVw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=AOawLqZq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=AOawLqZq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeB0LIV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:08:21 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:53472 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeB0LIS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 06:08:18 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180227110816epoutp0422aff2c6e86d48491b8b6518ac9d9cfc~XKhtRFHHQ1864818648epoutp04N
X-AuditID: b6c32a35-879ff70000001031-7e-5a953c1faaca
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A953C21.5020007@samsung.com>
Date: Tue, 27 Feb 2018 20:08:17 +0900
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
In-reply-to: <20180227071134.28063-7-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmvq68zdQogx9/1SxurTvHatHU8ZbV
        YuOM9awW848AuVe+vmezmHR/AovF+fMb2C06Jy5ht9j0+BqrxeVdc9gsZpzfx2SxaFkrs8WC
        l7dYLNYeuctusfT6RSaL1r1H2B0EPNbMW8Pocbmvl8ljdsdMVo9NqzrZPO53H2fy2Lyk3qNv
        yypGj8+b5AI4olJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
        dN0yc4A+UFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZGemZGMdaGZkC
        lSSkZlzbc4ip4K1ORevHxYwNjJNUuhg5OSQETCR2X9jH1MXIxSEksINR4tXZ7WwQzndGid5z
        +1hhqq4uXckOYgsJbGCUONxYBGLzCghK/Jh8j6WLkYODWUBe4silbJAws4CmxNbd69kh5txj
        lFh2dgs7RL2WxJcDqxhBbBYBVYnlq0CWcXKwAcX3v7gBZvMLKEpc/fEYrEZUIEJi5/xvYINE
        BFoYJXY0L2MBcZgFVrJIrJvZDHadsEAy0HWvwbo5BSwlNu/fzQxSJCGwjF3i6PfDbBAvuEj0
        7b/DCGELS7w6DnISB5AtLXHpqC1EfTujRPveeVDNUxglzl2/xwTRYCzxbGEXE8RzfBLvvvaw
        QjTzSnS0CUGUeEic2/QUaqajxPkz0RDv72aUmPRwBesERrlZSCE2CxFis5BCbAEj8ypGsdSC
        4tz01GLDAkO94sTc4tK8dL3k/NxNjOBEq2W6g3HKOZ9DjAIcjEo8vDPkpkQJsSaWFVfmHmKU
        4GBWEuFduXhylBBvSmJlVWpRfnxRaU5q8SFGU2CAT2SWEk3OB2aBvJJ4QxNLAxMzI2D6sjQ0
        VBLnDQhwiRISSE8sSc1OTS1ILYLpY+LglGpg3PHQqnx+q372fWOVgwwP2YykzW8G/T+9Z0HR
        7zov90MvprUyvHur6GovafxY3t+4mc/0tsOHOBXZXcqBjYrXQsrKvy7s/Lmqd6fIFffEV2/W
        /pXc8Vfyp/pS8d0xh+fPN2PjmsDml196kCf5yocPX9aeCfjnELwnbNmOp+rKNjNOf5ILcZuu
        osRSnJFoqMVcVJwIAN9LuMfKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t9jQV15m6lRBh+/ClvcWneO1aKp4y2r
        xcYZ61kt5h8Bcq98fc9mMen+BBaL8+c3sFt0TlzCbrHp8TVWi8u75rBZzDi/j8li0bJWZosF
        L2+xWKw9cpfdYun1i0wWrXuPsDsIeKyZt4bR43JfL5PH7I6ZrB6bVnWyedzvPs7ksXlJvUff
        llWMHp83yQVwRHHZpKTmZJalFunbJXBlXNtziKngrU5F68fFjA2Mk1S6GDk5JARMJK4uXcne
        xcjFISSwjlFi5duf7CAJXgFBiR+T77F0MXJwMAvISxy5lA0SZhZQl5g0bxEzRP0DRom7Zz6z
        QtRrSXw5sIoRxGYRUJVYvmo7G4jNBhTf/+IGmM0voChx9cdjRpCZogIREt0nKkHmiAi0MUps
        n7GLEWLBahaJuV/BjhMWSJZ42bCVEWLZbqBlS9eADeIUsJTYvH838wRGgVlIbp2FcOssJLcu
        YGRexSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kRGGPbDmv17WC8vyT+EKMAB6MSD+8M
        uSlRQqyJZcWVuYcYJTiYlUR4Vy6eHCXEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTE
        ktTs1NSC1CKYLBMHp1QD45qQIiOzHrX0T4W5BWbGUZO/+vnJl17n/lu16O8FpoO1Zozz5e56
        Ss7auWVpp+uzjAc9uokN3Os4uK5P+d3cMluW/aRq5/PYDUxLVLiXtXvXrS9+IcfzLKFfN362
        ySb2xzXFGns+mL1VKpy7/OW60/dbbn7eLD1tWVGTsdvKPc1ySufbV29rV2Ipzkg01GIuKk4E
        AAKKJB2tAgAA
X-CMS-MailID: 20180227110815epcas1p398e3ee781ba3dfd62308d1266f0850a7
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-RootMTR: 20180227071142eucas1p10203dac2558db034a4a3287220213601
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
        <20180227071134.28063-7-a.hajda@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018년 02월 27일 16:11, Andrzej Hajda wrote:
> From: Maciej Purski <m.purski@samsung.com>
> 
> Currently MHL chip must be turned on permanently to detect MHL cable. It
> duplicates micro-USB controller's (MUIC) functionality and consumes
> unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
> only if it detects MHL cable.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v5: updated extcon API
> 
> This is rework of the patch by Maciej with following changes:
> - use micro-USB port bindings to get extcon, instead of extcon property,
> - fixed remove sequence,
> - fixed extcon get state logic.
> 
> Code finding extcon node is hacky IMO, I guess ultimately it should be done
> via some framework (maybe even extcon), or at least via helper, I hope it
> can stay as is until the proper solution will be merged.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 9e785b8e0ea2..62b0adabcac2 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -17,6 +17,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/extcon.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -25,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_graph.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -81,6 +83,10 @@ struct sii8620 {
>  	struct edid *edid;
>  	unsigned int gen2_write_burst:1;
>  	enum sii8620_mt_state mt_state;
> +	struct extcon_dev *extcon;
> +	struct notifier_block extcon_nb;
> +	struct work_struct extcon_wq;
> +	int cable_state;
>  	struct list_head mt_queue;
>  	struct {
>  		int r_size;
> @@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  	ctx->rc_dev = rc_dev;
>  }
>  
> +static void sii8620_cable_out(struct sii8620 *ctx)
> +{
> +	disable_irq(to_i2c_client(ctx->dev)->irq);
> +	sii8620_hw_off(ctx);
> +}
> +
> +static void sii8620_extcon_work(struct work_struct *work)
> +{
> +	struct sii8620 *ctx =
> +		container_of(work, struct sii8620, extcon_wq);
> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
> +
> +	if (state == ctx->cable_state)
> +		return;
> +
> +	ctx->cable_state = state;
> +
> +	if (state > 0)
> +		sii8620_cable_in(ctx);
> +	else
> +		sii8620_cable_out(ctx);
> +}
> +
> +static int sii8620_extcon_notifier(struct notifier_block *self,
> +			unsigned long event, void *ptr)
> +{
> +	struct sii8620 *ctx =
> +		container_of(self, struct sii8620, extcon_nb);
> +
> +	schedule_work(&ctx->extcon_wq);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int sii8620_extcon_init(struct sii8620 *ctx)
> +{
> +	struct extcon_dev *edev;
> +	struct device_node *musb, *muic;
> +	int ret;
> +
> +	/* get micro-USB connector node */
> +	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
> +	/* next get micro-USB Interface Controller node */
> +	muic = of_get_next_parent(musb);
> +
> +	if (!muic) {
> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
> +		return 0;
> +	}
> +
> +	edev = extcon_find_edev_by_node(muic);
> +	of_node_put(muic);
> +	if (IS_ERR(edev)) {
> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
> +		return PTR_ERR(edev);
> +	}
> +
> +	ctx->extcon = edev;
> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);

You better to use devm_extcon_register_notifier().

> +	if (ret) {
> +		dev_err(ctx->dev, "failed to register notifier for MHL\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
>  {
>  	return container_of(bridge, struct sii8620, bridge);
> @@ -2307,13 +2384,20 @@ static int sii8620_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> +	ret = sii8620_extcon_init(ctx);
> +	if (ret < 0) {
> +		dev_err(ctx->dev, "failed to initialize EXTCON\n");
> +		return ret;
> +	}
> +
>  	i2c_set_clientdata(client, ctx);
>  
>  	ctx->bridge.funcs = &sii8620_bridge_funcs;
>  	ctx->bridge.of_node = dev->of_node;
>  	drm_bridge_add(&ctx->bridge);
>  
> -	sii8620_cable_in(ctx);
> +	if (!ctx->extcon)
> +		sii8620_cable_in(ctx);
>  
>  	return 0;
>  }
> @@ -2322,8 +2406,15 @@ static int sii8620_remove(struct i2c_client *client)
>  {
>  	struct sii8620 *ctx = i2c_get_clientdata(client);
>  
> -	disable_irq(to_i2c_client(ctx->dev)->irq);
> -	sii8620_hw_off(ctx);
> +	if (ctx->extcon) {
> +		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
> +					   &ctx->extcon_nb);

Don't need to unregister the notifier if using devm_extcon_register_notifier().

> +		flush_work(&ctx->extcon_wq);
> +		if (ctx->cable_state > 0)
> +			sii8620_cable_out(ctx);
> +	} else {
> +		sii8620_cable_out(ctx);
> +	}
>  	drm_bridge_remove(&ctx->bridge);
>  
>  	return 0;
> 

If you use the resource managed function (devm_extcon_register_notifier), Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
