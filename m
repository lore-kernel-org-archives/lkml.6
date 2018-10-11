Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33735C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E040C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aaTa5ITa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E040C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJKWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:42:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37383 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJKWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:42:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181011151513euoutp0234aaedffed3748c9c3d27344a164dcc9~clr2YVKju1621516215euoutp021
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 15:15:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181011151513euoutp0234aaedffed3748c9c3d27344a164dcc9~clr2YVKju1621516215euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539270913;
        bh=GzL0kVTco9/Epbn8T5lCP41krBEbSFhQD4nirgzcqUY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aaTa5ITa92CS1Ke+eicNgVKjNSpbbBK14SYivJ67J7SNNo0MYoDAFFedISQ+0MWSD
         lvQhdNomWoCGAeQc8M3SihxfzNcgeMeFMB2EfuSPByIcrm4CBnVd1PNbMIhegyhpGw
         /1ffhhUknC75W/JX8dP8ArgHOU9bWpu1MCk20lyw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181011151513eucas1p2527118d8019afdd1fd142d339b62b0eb~clr2B34HE1182611826eucas1p2e;
        Thu, 11 Oct 2018 15:15:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.6E.04441.0096FBB5; Thu, 11
        Oct 2018 16:15:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181011151511eucas1p12974c808cb514a13417f67b4a8a54e98~clr0yD0pW1512915129eucas1p1M;
        Thu, 11 Oct 2018 15:15:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181011151511eusmtrp2b3b3cf48e8146e6306115230d1923e65~clr0hXOsi0907609076eusmtrp2F;
        Thu, 11 Oct 2018 15:15:11 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-32-5bbf690043b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.76.04284.FF86FBB5; Thu, 11
        Oct 2018 16:15:11 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181011151511eusmtip14fd62c4c3f992dee98bc1a1c045a1016~clr0OFI483241032410eusmtip13;
        Thu, 11 Oct 2018 15:15:11 +0000 (GMT)
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 11 Oct 2018 17:15:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011143531.7195-1-linus.walleij@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7qMmfujDU4uZLSY+vAJm8W3Kx1M
        FlP+LGeyuLxrDpsDi8fOWXfZPTat6mTzuHNtD5vH501yASxRXDYpqTmZZalF+nYJXBlv/2xg
        LjilVPHj01nWBsat0l2MnBwSAiYSCxdcZO9i5OIQEljBKLHzwR4o5wujxOvTK9hAqoQEPjNK
        vJirA9Ox5PN3qKLljBIXt31kg3DeM0r0zb7LDlIlLOAs8b7zJiOILSJQIrGkbReYzSygIPHr
        3iZWEJtNwFCi620X2AYWAVWJH/+XAcU5OEQFYiR+77IGCfMKCEqcnPmEBcTmFLCVeLWhjx1i
        jLzE9rdzmCFscYlbT+YzQRzXzS6x4lU6RG+ZxMX2RjaIuIvE1jebmSFsYYlXx7ewQ9gyEv93
        gvRyAdnNjBLtM2axQzg9jBJb5+yA6raWOHz8IthxzAKaEut36YOYEgKOEktXmUCYfBI33gpC
        nMMnMWnbdGaIMK9ER5sQxAw1iVnH18FtPXjhEvMERqVZSJ6cheSxWUgem4WwdgEjyypG8dTS
        4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHL63/FPOxi/Xko6xCjAwajEwxsguy9aiDWxrLgy
        9xCjBAezkgiv/gygEG9KYmVValF+fFFpTmrxIUZpDhYlcd5l8zZGCwmkJ5akZqemFqQWwWSZ
        ODilGhiTzKwZ1v++di7ZPvDHlHiXnTtliyteJ1b5c5iyiqXasO+cvfVG53w500DbZuGfj1+1
        Fmubrzh6ZL76oi65O+aqz/p27fmQOHle/fJrDzgCa85e0RY6Ub36bFnuyvCgisik3r8tz64J
        7zp2wn/9xPyaxr3njp4uWXXk/Lf4zFMmRu2PSydcPuymxFKckWioxVxUnAgAWkJ8DycDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7r/M/ZHG3z6rGox9eETNotvVzqY
        LKb8Wc5kcXnXHDYHFo+ds+6ye2xa1cnmcefaHjaPz5vkAlii9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLe/tnAXHBKqeLHp7OsDYxbpbsYOTkk
        BEwklnz+zt7FyMUhJLCUUeJt1xMmiISMxMlpDawQtrDEn2tdbBBFbxklLlxaAJYQFnCWeN95
        kxHEFhEokfiwfyc7iM0soCDx694mVoiGCYwS299vAytiEzCU6HoLMomTg1fATqK9cxKYzSKg
        KvHj/zKwoaICMRJHJ7dA1QhKnJz5hAXE5hSwlXi1oQ9qgbrEn3mXmCFseYntb+dA2eISt57M
        Z5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmA8bTv2c/MO
        xksbgw8xCnAwKvHw/pDaFy3EmlhWXJl7iFGCg1lJhFd/BlCINyWxsiq1KD++qDQntfgQoynQ
        cxOZpUST84GxnlcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgVHT
        fmahwUVu0djvVhrTfuwROtTmMO+cX4eLkeHKu4mFeaqqs/b+sz8cLbmxf0PO5PAnlmd5dR8a
        /P8xNeNba/1PJRleNneG/MYn9hvTyyrDnVni7vt8Nu06H3tglV/BFtuMgnjvB21Rfl1Ps+44
        79ff9l91idcBSc14kT/vFzDqLL1afy7YUYmlOCPRUIu5qDgRAGgq45G9AgAA
Message-Id: <20181011151511eucas1p12974c808cb514a13417f67b4a8a54e98~clr0yD0pW1512915129eucas1p1M@eucas1p1.samsung.com>
X-CMS-MailID: 20181011151511eucas1p12974c808cb514a13417f67b4a8a54e98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181011143542epcas1p24f7b9193acf33746a2fc166bf63a8f77
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181011143542epcas1p24f7b9193acf33746a2fc166bf63a8f77
References: <CGME20181011143542epcas1p24f7b9193acf33746a2fc166bf63a8f77@epcas1p2.samsung.com>
        <20181011143531.7195-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-10-11 16:35, Linus Walleij wrote:
> This allows nonexclusive (simultaneous) access to a single
> GPIO line for the fixed regulator enable line. This happens
> when several regulators use the same GPIO for enabling and
> disabling a regulator, and all need a handle on their GPIO
> descriptor.
>
> This solution with a special flag is not entirely elegant
> and should ideally be replaced by something more careful as
> this makes it possible for several consumers to
> enable/disable the same GPIO line to the left and right
> without any consistency. The current use inside the regulator
> core should however be fine as it takes special care to
> handle this.
>
> For the state of the GPIO backend, this is still the
> lesser evil compared to going back to global GPIO
> numbers.
>
> Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

It looks to be fixing the Sii9234 probe issue, but I didn't do any
further tests. I must go out the office and I will be back on Monday.
I think You can add my:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Hi Marek, it would be great if you could try this on top
> of linux-next and report if it solves your problem on the
> Samsung Exynos.
>
> If it does I hope it will apply cleanly on the regulator
> tree.
> ---
>  drivers/gpio/gpiolib.c        | 19 +++++++++++++++++--
>  drivers/regulator/fixed.c     | 13 +++++++++++++
>  include/linux/gpio/consumer.h |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 7c222df8f834..f82a741ff428 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4144,8 +4144,23 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  	 * the device name as label
>  	 */
>  	status = gpiod_request(desc, con_id ? con_id : devname);
> -	if (status < 0)
> -		return ERR_PTR(status);
> +	if (status < 0) {
> +		if (status == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
> +			/*
> +			 * This happens when there are several consumers for
> +			 * the same GPIO line: we just return here without
> +			 * further initialization. It is a bit if a hack.
> +			 * This is necessary to support fixed regulators.
> +			 *
> +			 * FIXME: Make this more sane and safe.
> +			 */
> +			dev_info(dev, "nonexclusive access to GPIO for %s\n",
> +				 con_id);
> +			return desc;
> +		} else {
> +			return ERR_PTR(status);
> +		}
> +	}
>  
>  	status = gpiod_configure_flags(desc, con_id, lookupflags, flags);
>  	if (status < 0) {
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 7d639ad953b6..ccc29038f19a 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -170,6 +170,19 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
>  			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
>  	}
>  
> +	/*
> +	 * Some fixed regulators share the enable line between two
> +	 * regulators which makes it necessary to get a handle on the
> +	 * same descriptor for two different consumers. This will get
> +	 * the GPIO descriptor, but only the first call will initialize
> +	 * it so any flags such as inversion or open drain will only
> +	 * be set up by the first caller and assumed identical on the
> +	 * next caller.
> +	 *
> +	 * FIXME: find a better way to deal with this.
> +	 */
> +	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> +
>  	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
>  	if (IS_ERR(cfg.ena_gpiod))
>  		return PTR_ERR(cfg.ena_gpiod);
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 0f350616d372..f2f887795d43 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -39,6 +39,7 @@ struct gpio_descs {
>  #define GPIOD_FLAGS_BIT_DIR_OUT		BIT(1)
>  #define GPIOD_FLAGS_BIT_DIR_VAL		BIT(2)
>  #define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
> +#define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
>  
>  /**
>   * Optional flags that can be passed to one of gpiod_* to configure direction

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

