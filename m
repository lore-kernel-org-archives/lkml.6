Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9537EC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1372087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJoO0J0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1372087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeKTU4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:56:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44070 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeKTU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:56:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so1414206edd.11;
        Tue, 20 Nov 2018 02:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kM11siRp0GzvOSEzz7qYIN1IWeAfzttozUagYM9elkg=;
        b=gJoO0J0ROVkaDfPrpCQCaH4Y0IAPCCutZmALNaxZxAM6neYeXXV0PIOjOYxUCNNR9k
         zvwe60E/VigNkzNzjA4Cg/vQpDA+eIKuAaMHbVDdzRrNVOC3gFbg28dCIAEGlLjLZG1d
         oJQFBDnLJJ3UDNFeCPI2TlcCCCpzEgJwMARQWrILXFT4kDjzBVRu25wdvWKiVdFH4JQX
         4n6AjvEevNfS5ByNJo/mpu4xCdCCitti7xbYwJWE32ZoHrul/g0qGNHdXt/vwyIvhLRr
         96nHG5Xk3SJy6pw+ztbJfR4gKaOHh7DkCqvhOmnwdvj/+zwcMozPjR9gFMfzWdu/cKcY
         T1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kM11siRp0GzvOSEzz7qYIN1IWeAfzttozUagYM9elkg=;
        b=nc6GYxf4orakEoSTLU7L2dX6SQFrB41BujaS6WpJHXdnSFzcnXjoBlY+EhShclTJGv
         JQJjzRhFn5u9uI6kicB8ELYx0lviupq8XvYtd2xLHmmhGBAKz+q5+WtwPc6NjVrQPjwY
         j9XPzVAbsiDh2HeSI8nBlkwso3A+4hUkpO/jwc7VyZDqUUE2IDu09TYnBt3FF1ubZVip
         0PsajT29wxwb1FJyF0Vl6AePheik3p6Wv2fmD4qMrZrNler3n6rILWmyVnC2WNg9nXOV
         Z6Zf/X5qCBQkFxxyiBD2nO0p1PHFAQ+n0ZClP7CG74a3fAcvgVFUV50RsTLqx36+XG55
         oAZA==
X-Gm-Message-State: AGRZ1gIbcb6K2aC259GtwoFaqMRjhmWgrfaU3Ko7CuCCEwL9+owfgs/w
        iaPEW2hiMDg1QsYYGUb8vC8=
X-Google-Smtp-Source: AJdET5e7sRc5H7AfPwS3Zaz4S5yt7qdTOYJJ5YOyA9Nxn6jy0GY0TjqRolgqKWO/t/FZjyNoZt6V7Q==
X-Received: by 2002:a17:906:1a49:: with SMTP id j9-v6mr1567071ejf.45.1542709706767;
        Tue, 20 Nov 2018 02:28:26 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id w31sm10081173edw.82.2018.11.20.02.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:28:26 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT7629 soc
 platform
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        ryder.lee@mediatek.com
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
 <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <7bc1777c-fb24-d150-c13f-658c2a33cd71@gmail.com>
Date:   Tue, 20 Nov 2018 11:28:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2018 09:41, Leilk Liu wrote:
> This patch adds a DT binding documentation for the MT7629 soc.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index 7940940..6cc4e87 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -6,6 +6,7 @@ Required properties:
>      - mediatek,mt2712-spi: for mt2712 platforms
>      - mediatek,mt6589-spi: for mt6589 platforms
>      - mediatek,mt7622-spi: for mt7622 platforms
> +    - mediatek,mt7629-spi: for mt7629 platforms

That's ok, as you add support in the driver. As it actually doesn't change
anything in the driver itself you could just describe the binding as something like:
" mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms

This way the driver will just probe the driver using the fallback (mt7622)
compatible, but if you realize in the future that you will need to distinguish
between the two SoCs, you can add a mt7629 compatible.

Just as information for the future :)

Regards,
Matthias
