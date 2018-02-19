Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-256280-1519050774-2-10756878931920791100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519050772; b=uEIYrBzoL7sN93bsxLh34WOPZgbdDHT/Wra33OhwvvGKt/W
    gtxKvIVz1/Y7Sc4rnDkeXYnOhXPO4LP/C2pnwcBlQU9ID4Vx/sVavLJN/49bWgcb
    I4J9ykU3daG7EUYNUqo2LIvWCDF4/Rghcwd9mjxS4pplk5V7gSmNQ8u0SvGD7kUR
    ySPPJgTwUAre4J8bezf1Pqm9U/048Uid3PwoNpN5R59PHKz7jIchmNp/tGnn2gcX
    0tJ/x+iahaxWXIzQEqamo82X16ABUf6/ZX+xl9X5Oyxq2VRF8uIPqcjnst852QKf
    T+CO+lpM1zid7UYklNT2MznlvVX/F95zdb5hBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519050772; bh=o6qnSpICLYIriYRbj+ZY2rk/Lv
    1Zeff5qFXYahEWOgM=; b=N/D2LQ4+RLrJYXV79up+klc57yj0hSDXHfh0d6Eabt
    DMowv9xUe6Jd/sHEtQjXTYZJco1aolHcOxBbrd6yVSi0NKxLPp/6/AK7nakoQhU2
    x/exy95jNm+KOTkzoD++S28zWODMA9fc02vAkVaewQ4IGJztsEjEBmw8Jm9Akhb4
    tE1Q3FwJ05YLUj6pgCq6uuB3VVdLpcHwbH1CyyFscdzZusbxbom8ttyiwpU1FycQ
    BzZ4iPFx0PqhzedBzUNXGGtrH3tkwbP+vcuI2iaRAPk56bYMclSNpvgDX9gC8Oj2
    pNfiBAzu1C1vt/aIRA5gWZwn1Flf0rUpfDBXr20RyqmQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q6j/6UWW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q6j/6UWW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeBSOcj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 09:32:39 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38825 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbeBSOcg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 09:32:36 -0500
X-Google-Smtp-Source: AH8x2276B9A77kA6rqlTGHGKP3nj5y7w9mfmdBDA0DsvfLvxqrITIz+w60PR+ewF8BuWUYjdy6PEAA==
Date: Mon, 19 Feb 2018 08:32:34 -0600
From: Rob Herring <robh@kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: add bindings for Samsung
 micro-USB 11-pin connector
Message-ID: <20180219143234.5k47c5sihqwuwwqw@rob-hp-laptop>
References: <20180215103920.32017-1-a.hajda@samsung.com>
 <CGME20180215103926eucas1p2f13dcf5aa4e102e7f0145c976a60bc72@eucas1p2.samsung.com>
 <20180215103920.32017-3-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215103920.32017-3-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 11:39:16AM +0100, Andrzej Hajda wrote:
> Samsung micro-USB 11-pin connector beside standard micro-USB pins,
> has pins dedicated to route MHL traffic.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  .../connector/samsung,usb-connector-11pin.txt      | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
> 
> diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
> new file mode 100644
> index 000000000000..c8ef1ad6732f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
> @@ -0,0 +1,51 @@
> +Samsung micro-USB 11-pin connector
> +==================================
> +
> +Samsung micro-USB 11-pin connector is an extension of micro-USB connector.
> +It is present in multiple Samsung mobile devices.
> +It has additional pins to route MHL traffic simultanously with USB.
> +
> +The bindings are superset of usb-connector bindings for micro-USB connector[1].
> +
> +Required properties:
> +- compatible: must be: "samsung,usb-connector-11pin", "usb-b-connector",
> +- type: must be "micro".
> +
> +Optional properties:
> +- label: symbolic name for the connector.

This is already defined in [1] so you don't need it here.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +Required nodes:
> +- any data bus to the connector should be modeled using the OF graph bindings
> +  specified in bindings/graph.txt, unless the bus is between parent node and
> +  the connector. Since single connector can have multpile data buses every bus
> +  has assigned OF graph port number as follows:
> +    0: High Speed (HS),
> +    3: Mobile High-Definition Link (MHL), specific to 11-pin Samsung micro-USB.
> +
> +[1]: bindings/connector/usb-connector.txt
> +
> +Example
> +-------
> +
> +Micro-USB connector with HS lines routed via controller (MUIC) and :
> +
> +muic-max77843@66 {
> +	...
> +	usb_con: connector {
> +		compatible = "samsung,usb-connector-11pin", "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@3 {
> +				reg = <3>;
> +				usb_con_mhl: endpoint {
> +					remote-endpoint = <&sii8620_mhl>;
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 2.16.1
> 
