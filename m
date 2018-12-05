Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68AA2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yoe0igk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68AA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeLEOeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:34:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47246 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:34:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205143404euoutp0200d85496831a8179ecd1d044645751f3~tdmnqzmjK2134921349euoutp02Q
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 14:34:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205143404euoutp0200d85496831a8179ecd1d044645751f3~tdmnqzmjK2134921349euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544020444;
        bh=tQgmyPhfWxlUoT9A/zAP4QR0b6JIMB6ZbPaEx1Hxyq8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Yoe0igk3SYjPpEhkmrJkC+CigiF6K5XJSOeCOIS0Zjh5ALu8p73D7TzmMDlLKTXmE
         6G+YoP2/cRSXPf5Qcd+XHV5cV4egaBFsFWOQRWwGdZO4rwhqsgLbJZkMMVXNxkjgoT
         sRqNivTFWdiCDSbZicnmo817c8vByEojUWnP7M14=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181205143403eucas1p2ed1d24777d93e9a1fe5fbbbd031fa990~tdmmdbxbF0544105441eucas1p2I;
        Wed,  5 Dec 2018 14:34:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.2A.04294.AD1E70C5; Wed,  5
        Dec 2018 14:34:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181205143402eucas1p2a1507dde6c6875783d7fbf654f2050d1~tdmlnjnVp2069120691eucas1p25;
        Wed,  5 Dec 2018 14:34:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205143402eusmtrp21a27cb98e33d1b05d4a8da9913d43384~tdmlTugC21909919099eusmtrp2B;
        Wed,  5 Dec 2018 14:34:01 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-41-5c07e1da93e5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.2B.04284.9D1E70C5; Wed,  5
        Dec 2018 14:34:01 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181205143401eusmtip251de9ea8fe3a7fe7c2de1485b35a0168~tdmk8VfQI1591115911eusmtip2G;
        Wed,  5 Dec 2018 14:34:01 +0000 (GMT)
Subject: Re: [PATCH 11/15 v3] gpio: Add devm_gpiod_unhinge()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0179c784-137d-b37a-1b93-cf2f957730a8@samsung.com>
Date:   Wed, 5 Dec 2018 15:34:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205124721.26624-12-linus.walleij@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3d3uvVqz17nwwb5oiGCUZgqNlFUUNoggCkRKq5mXKW1Tdv1I
        64cgmi4pEUWdH9WSpkKTLs2PGQunOCxEMw0dSQrLNLBJjigSzevV8t855zmH9xx4aULWLgmj
        Mw05jNGg0SnIQHHn4O+Ro55ZKuWYu/mk0t/0VqysmfWSyvESDil/jpeJlNUrVpHyg6ORPE2q
        fZMllLrHPE2pufZyUv3p42tSXdu4htTL3IFL5NXAhHRGl5nHGKNVNwMzPPVvJNmm8Ds2S72o
        CD3cb0IBNOA4WCv5RZpQIC3DrQieW82EQPwIVl90iQSyjOBPXzPaitQ9Wth0WRG0jc5QAvEh
        6LdaJCZE0yE4AXq5ND4gxznQUupAvIfAJQi4SifBH0gcA6ZFE8n7pVgFHstGJzEOh4WhCoKX
        9+AUcHy9x8tSHAxD9V4xjwPwKbAMOCkeE/ggFNsbCAGHgsf7eKM0YI6C7w++kELpczDYVbY5
        IAS+uV9RAt4Haz1bgWIE9+vMlEAqENgbuzfT8dDvfr8xjMCR0OGIFuQzYHJVULwMOAgmF4OF
        EkFQ1VlLCLIUykplgjsCzG7bv2f7RseISqQwb5tm3jbHvG2O+f+7T5C4HYUyuaxey7DHDUx+
        FKvRs7kGbdStLD2H1n/Qu1W3vxs5VtJcCNNIsUs6P0OlyCSaPLZA70JAEwq5tDVhXZKmawoK
        GWPWDWOujmFdaC8tVoRK7+6YuSbDWk0Oc5thshnj1lVEB4QVoVhVau+F60esiXI3qwvPj4y0
        nZ0u8A1fcQ00tOjjWO2hcU+IXZcx4VhKSx5esZ+Yuziqtf0IS3TuLm9Omnoa6V30vayW+Je7
        OnS5say9bae857LMHa8q5bTnW6tqciKm6or6msKXQpLGCj9Hp8TMBzkn5lSX7M8yRoJTbckW
        hZjN0MQcJoys5i9muejyPQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7o3H7LHGCzbbWnxZe4pFoupD5+w
        WVxp3cRo8e1KB5PFlD/LmSwu75rD5sDm8f5GK7vHzll32T02repk87hzbQ+bx/Q5/xk9Pm+S
        C2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4
        NXM/a0GXSsW6RTOZGhj7ZLsYOTkkBEwkZvS/ZO5i5OIQEljKKPFufyMLREJG4uS0BlYIW1ji
        z7UuNoiit4wSzUe2AjkcHMICNhK7NyWB1IgIlEh82L+THaSGWaCVUeLR4xtQDccYJRa1nWYG
        qWITMJToetsF1swrYCdxaxHYFSwCKhIvT/aAlYgKxEhMufwabDGvgKDEyZlPwA7iFLCXWHRk
        HzuIzSygLvFn3iVmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5N
        zy021CtOzC0uzUvXS87P3cQIjLptx35u3sF4aWPwIUYBDkYlHt4XD9hjhFgTy4orcw8xSnAw
        K4nwrrABCvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MCHklcQbmhqaW1gamhubG5tZKInz
        njeojBISSE8sSc1OTS1ILYLpY+LglGpg5Cs/ku5aJXgr7mvGb4acCUtmy/x4/7Gk0rL5hqsH
        W3L/+o0f24rtFyxiV7U4v3vScse4qMcesvdCbHvfRXuYyh1iPiKdLLEienr1bol5rAn/exL4
        bpRsmXew/dq89lsblQO2L+7IYvfb++aFRFxHldj/GwuvcyTK6wl8tdM8qTqH+ah5vdo9JZbi
        jERDLeai4kQAR/YTPtACAAA=
X-CMS-MailID: 20181205143402eucas1p2a1507dde6c6875783d7fbf654f2050d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205124846epcas3p1219065f3ca6c30f6e594a31ff3e72636
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205124846epcas3p1219065f3ca6c30f6e594a31ff3e72636
References: <20181205124721.26624-1-linus.walleij@linaro.org>
        <CGME20181205124846epcas3p1219065f3ca6c30f6e594a31ff3e72636@epcas3p1.samsung.com>
        <20181205124721.26624-12-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-12-05 13:47, Linus Walleij wrote:
> This adds a function named devm_gpiod_unhinge() that removes
> the resource management from a GPIO descriptor.
>
> I am not sure if this is the best anglosaxon name for the
> function, no other managed resources have an equivalent
> currently, but I chose "unhinge" as the closest intuitive
> thing I could imagine that fits Rusty Russell's API design
> criterions "the obvious use is the correct one" and
> "the name tells you how to use it".
>
> The idea came out of a remark from Mark Brown that it should
> be possible to handle over management of a resource from
> devres to the regulator core, and indeed we can do that.
>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Make sure to bail out of gpiod_unhinge() if the descritor
>   passed in is NULL or an error pointer.
> - Accept of devres_destroy() returns -ENOENT: if we have
>   nonexclusive GPIOs, we may attempt to remove resource
>   management from the same descriptor multiple times.
> ChangeLog v1->v2:
> - New patch to be able to hand over GPIO descriptors to
>   the regulator core.
> - Mark: feel free to apply this to the regulator tree with
>   the regulator tree with the rest.
> ---
>  Documentation/driver-model/devres.txt |  1 +
>  drivers/gpio/gpiolib-devres.c         | 30 +++++++++++++++++++++++++++
>  include/linux/gpio/consumer.h         | 10 +++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 43681ca0837f..fc4cc24dfb97 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -254,6 +254,7 @@ GPIO
>    devm_gpiod_get_index_optional()
>    devm_gpiod_get_optional()
>    devm_gpiod_put()
> +  devm_gpiod_unhinge()
>    devm_gpiochip_add_data()
>    devm_gpiochip_remove()
>    devm_gpio_request()
> diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
> index a57e968025a8..e9a17ec4de02 100644
> --- a/drivers/gpio/gpiolib-devres.c
> +++ b/drivers/gpio/gpiolib-devres.c
> @@ -346,6 +346,36 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
>  }
>  EXPORT_SYMBOL(devm_gpiod_put);
>  
> +/**
> + * devm_gpiod_unhinge - Remove resource management from a gpio descriptor
> + * @dev:	GPIO consumer
> + * @desc:	GPIO descriptor to remove resource management from
> + *
> + * Remove resource management from a GPIO descriptor. This is needed when
> + * you want to hand over lifecycle management of a descriptor to another
> + * mechanism.
> + */
> +
> +void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(desc))
> +		return;
> +	ret = devres_destroy(dev, devm_gpiod_release,
> +			     devm_gpiod_match, desc);

    devres_destroy(dev, devm_gpiod_release, devm_gpiod_match, &desc);

> +	/*
> +	 * If the GPIO descriptor is requested as nonexclusive, we
> +	 * may call this function several times on the same descriptor
> +	 * so it is OK if devres_destroy() returns -ENOENT.
> +	 */
> +	if (ret == -ENOENT)
> +		return;
> +	/* Anything else we should warn about */
> +	WARN_ON(ret);
> +}
> +EXPORT_SYMBOL(devm_gpiod_unhinge);
> +
>  /**
>   * devm_gpiod_put_array - Resource-managed gpiod_put_array()
>   * @dev:	GPIO consumer
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 348885f2f3d3..8aebcf822082 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -104,6 +104,7 @@ struct gpio_descs *__must_check
>  devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
>  			      enum gpiod_flags flags);
>  void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
> +void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
>  void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
>  
>  int gpiod_get_direction(struct gpio_desc *desc);
> @@ -249,6 +250,15 @@ static inline void gpiod_put(struct gpio_desc *desc)
>  	WARN_ON(1);
>  }
>  
> +static inline void devm_gpiod_unhinge(struct device *dev,
> +				      struct gpio_desc *desc)
> +{
> +	might_sleep();
> +
> +	/* GPIO can never have been requested */
> +	WARN_ON(1);
> +}
> +
>  static inline void gpiod_put_array(struct gpio_descs *descs)
>  {
>  	might_sleep();

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

