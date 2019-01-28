Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576CC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654C52175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699235;
	bh=r3WcQFCHfzKs37FlboXO9ubyFsttI/Hacgh7vRE9IWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WHkWHnNyAmMGSIJkVOMvEweH1qKKQHoI85bQ+8GsL3oY4q2AQCVNDpGuZQhX27cdq
	 LiMYp82rB77u3NTQwkcgV9uEXUXHdZG54LlKZaa51iVe2vaWTvgRuZSDSaTqehI/Si
	 8AwE4b9BzebxJVtQQabfwWh4OvqYA9vYMAUSiGvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfA1SNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfA1SNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:13:53 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDC921783;
        Mon, 28 Jan 2019 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548699232;
        bh=r3WcQFCHfzKs37FlboXO9ubyFsttI/Hacgh7vRE9IWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wzouWLBsUhqlCcWjqTYmd2pYj52SrP57zZG5hLF9DF0vDdW4lb9Rii407DxHdoZrU
         XMWV1igu6U1dNuV4+le9DcQpY40W2VKDU92AhrNjBBlFlc4yXD9xkdVK8HN4dLi5OE
         /3a+BC58HABxUdcQN/jg1e/epsfCzT7bmG60kzS4=
Received: by mail-qk1-f175.google.com with SMTP id z18so9927639qkj.10;
        Mon, 28 Jan 2019 10:13:52 -0800 (PST)
X-Gm-Message-State: AJcUukd7UERhJUGEeVuEe0QVdjWJzlTPkNoqrg7MBo2PcrcwlTpoJK5p
        uRJ7NR5rVZBXFrkTGrsNmCZLFTbR8WCn0wwrsw==
X-Google-Smtp-Source: ALg8bN5Wx5OfceBxgmkpLoaqUEVx1kMZXvf8JmIGvUojcNXegKW1fONz2Kj2VGON+EPR8CVIp/O1MMhdJB/lkFOkHCI=
X-Received: by 2002:a37:5686:: with SMTP id k128mr19289483qkb.29.1548699231175;
 Mon, 28 Jan 2019 10:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20190128161306.27805-1-ben.whitten@lairdtech.com> <20190128161306.27805-2-ben.whitten@lairdtech.com>
In-Reply-To: <20190128161306.27805-2-ben.whitten@lairdtech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Jan 2019 12:13:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+7D0+Zzd3nR2gHiC3tW7BjmvhC+8g-TyxYxBN5Ryo_yQ@mail.gmail.com>
Message-ID: <CAL_Jsq+7D0+Zzd3nR2gHiC3tW7BjmvhC+8g-TyxYxBN5Ryo_yQ@mail.gmail.com>
Subject: Re: [PATCH lora-next 01/11] dt-bindings: net: lora: sx130x: add power
 lut binding
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-lpwan@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:13 AM Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> Adding power lookup table for the concentrator specified in DT.
>
> These values are calibrated for the hardware and are unique to hardware
> designs and certifications.
>
> First byte is signed power in dBm measured at the rf connector.
> Second byte is unsigned value for DIGITAL gain.
> Third byte is unsigned value for PA gain, 2 bits only.
> Fourth byte is unsigned value for DAC gain, 2 bits only.
> Fifth byte is unsigned value for MIXER gain, 4 bits only.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
>  .../bindings/net/lora/semtech,sx130x.yaml           | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> index 24fad1218735..187fa2090a0b 100644
> --- a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> @@ -37,6 +37,15 @@ properties:
>      maxItems: 1
>      description: A connection of the reset gpio line.
>
> +  power-lut:
> +    description: Power lookup table for the concentrator.
> +      Consisting of maximum 16 entries, each entry having the following format;
> +      First byte is signed power in dBm measured at the rf connector.
> +      Second byte is unsigned value for DIGITAL gain.
> +      Third byte is unsigned value for PA gain, 2 bits only.
> +      Fourth byte is unsigned value for DAC gain, 2 bits only.
> +      Fifth byte is unsigned value for MIXER gain, 4 bits only.

Would you expect this to be a common lora property? If not it should
have a vendor prefix.

Either way, non-standard properties need to reference a type. That
would be 'uint8-matrix' in this case. See the '$ref' in the examples.
Though, I guess I need to add a signed type.

We can write all the free form text above as a schema:

minItems: 1
maxItems: 16
items:
  items:
    - description: ...
      range??
    - description: ...
      range??
    - description: ...
      maximum: 3
    - description: ...
      maximum: 3
    - description: ...
      maximum: 15

> +
>    radio-spi:
>      type: object
>      description: The concentrator can have two radios connected which are
> @@ -83,6 +92,10 @@ examples:
>          reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
>          spi-max-frequency = <8000000>;
>
> +       power-lut =   [ 00 00 00 03 09
> +                       03 00 00 03 0C
> +                       04 00 00 03 0D ];

You may need to write this with '/bits/ 8' syntax so you can bracket
each 5 byte entry. I don't think we can do that with [] notation.

Rob
