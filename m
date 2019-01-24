Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0289EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0521872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJHBuy+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfAXPD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:03:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54973 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:03:57 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so5373086ita.4;
        Thu, 24 Jan 2019 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0YSruV0zfArEWaYQ05KJoZcpyD/XdjaK9GK7/fn6DTc=;
        b=KJHBuy+2Z0C/9U2hw1To3m4S9KMNn/auK2jZea1BnQHPb0Tyo8asjKyMkDu3S/Dim7
         90uUxwTsK7cUXhbFymnl00TbsOsXVFR343QmStj/nkLE7H25kEj9W+Gd1wYLjBmlDKFa
         9AydROOBsTVzGby6+sm5s0BLqeGPJr/YcQK6rfb19CrrYOt12LRbr+Des7U7vrGlpbiw
         ODybwu1FGpLnDa3RbHz0cpXVQoRB8GEuBPC6RpxhbUAXry4Wl152fc2JPr+oztp6zwup
         nZFUk95DZ90FxJxbVfQY5aBrNa22CJfzBIqR2sp7uspJUKfoKvYCvWwB9JLQy6Yj6+g4
         yK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0YSruV0zfArEWaYQ05KJoZcpyD/XdjaK9GK7/fn6DTc=;
        b=LYs9DDg4vwCo9y6sF7ZFuU/bujhSDOqGXUCjXgNkjroF23K19WM6ZhQpOfXjjO/Qck
         xKVqAucvaKHi6iQOqr23TJzhBF7PoAMJ34Wr/8crW/2OjwcT1pXrWbBZW5ERzdIJPKcD
         xWm34Y3KVmLbxaYEopd+a4gC21JiGBKFkcCB3Ckw1IHZS5oFvClg3y0N3LG5N/ktkzaH
         nI0mvl/yPYAWZjdGp1cDkuweXbhstN2xiEKMQNmD5vvgXc8XPTB8SeU4XpZjysO/ccps
         dPxJqXrtkTuD327hSHcgQ7RlQ9RUytEpN/OWm6C1ugpU/hytob3nLGX6+rtxymENFzGb
         SBEg==
X-Gm-Message-State: AJcUukdH6ZlKKPpXjmsC3fHK8r11MNaK8jKNK2Dv2+ZfH0k6M0ne+E0j
        40wYFVRAbtAMoma36H2AVEhbLql7N0v6fudpvfw=
X-Google-Smtp-Source: ALg8bN6UpnzpM2exsURx3pfNc3cDMFN2oR6T7jGOMXbMikVSQ3MhDsi2wd3ISz42GlLNQWTnb13ESbYrFQtwUy3VThc=
X-Received: by 2002:a02:104a:: with SMTP id 71mr4077631jay.103.1548342236446;
 Thu, 24 Jan 2019 07:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-3-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-3-ben.whitten@lairdtech.com>
From:   Ben Whitten <benwhitten@gmail.com>
Date:   Thu, 24 Jan 2019 15:03:42 +0000
Message-ID: <CAF3==isTrF7cT5ZNL7CetprgHLN50Zyh2t1ViP6XyBSFtQ_LUA@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 2/4] dt-bindings: lora: sx125x: add basic documentation
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed linux-lpwan

On Thu, 24 Jan 2019 at 14:53, Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> The SX125x family are IQ radio transceivers from Semtech configured over
> SPI, they are typically connected to an SX130x series concentrator howeve=
r
> may be connected to a host directly.
>
> Required properties include the radio number of the host or concentrator
> bus.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v2 -> v3:
> * Renamed example node name to be consistent with concentrator
> v1 -> v2:
> * Dropped spi-max-frequency binding
> * Wording changes to commit and descriptions
> * Added spi wrapper suggested by Rob H
> * Dual licence
> ---
>  .../bindings/net/lora/semtech,sx125x.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx=
125x.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.ya=
ml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> new file mode 100644
> index 000000000000..fe2d2a23c28b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/lora/semtech,sx125x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech IQ modulator/de-modulator transeiver
> +
> +maintainers:
> +  - Andreas F=C3=A4rber <afaerber@suse.de>
> +  - Ben Whitten <ben.whitten@gmail.com>
> +
> +description: |
> +  The SX125x family are transceivers capable of supporting multiple cons=
tant
> +  and non-constant envelope modulation schemes.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - semtech,sx1255
> +        - semtech,sx1257
> +        - semtech,sx1258
> +
> +  reg:
> +    maxItems: 1
> +    description: The chip select on the SPI bus or radio number in conce=
ntrator
> +      , with radio A =3D 0 and radio B =3D 1.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      radio0: radio@0 {
> +        compatible =3D "semtech,sx1257";
> +        reg =3D <0>;
> +      };
> +    };
> --
> 2.17.1
>
