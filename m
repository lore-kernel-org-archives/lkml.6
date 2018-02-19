Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-260568-1519050548-2-16728231085685371810
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
    t=1519050547; b=gKZ11NdaUWmAFv+3Lm3J22FdWAd/1IMYkvtSh319MuMYfVa
    FmktVla1Rul5gUPqeiEGqZEsvrZCMh5febnKbTMXg4SNfAgMieAOGxvnFO+dH87Y
    0iIiuyiNpkWqCNx1RrpHEw2pRKWzPMzclsfxIpHOL3JMmbsWk4Syd/oLwJbSvjX+
    DPCztvoX8aRGcGcTlAQH0cNJ4SmC7DF7UPk9a9hQqR+PiFBo6k3R/VUtGWQC2qNI
    cxOdJeOI5Tu9MokyN1pX3IoOLZ6wuGVCDrDh3eNLcoZ3AhO3/3Tjg2dwvcEZpPDm
    jEqEOWk1lFILv5yxM0OiRqieEEsn3KGaSGrPpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519050547; bh=F2BAhZ1TBly8BkkIJggYFiZeiu
    siFtWEJMihDqeK0/A=; b=TtVVGRd90HcfArPnAnp2AZxD4gdJSzyzh2KkF4Uqxv
    n7ITWrYvzINZyokC/EAkjbhjlJWWZs73ij5bLLLZp1qNifn8i53AuG2ChfKtV2iD
    Rwgeqx+Y0s7F8h5S30rqob6Q+CK8GO3qGPO8bDuyXu/s8wU2nMh0zvh6Hq7Yq0Ql
    xqqPizkcNmJ7wyUWijTVl/G4Yh0GHVQSKNBCtTrZjivSOmWweZHwYbQO7oGnLBqw
    dPVxfaNyVdcTWY6L8HYZyLJ5Fgkul0hYqVcrj2HyVmZr1D1ARsxZyMcKA8qOleN3
    BaHl3XHhfsOPjM22ynxAuH7EreMpOCtVbJN04OMYm4Bg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oIexRveS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oIexRveS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBSO2v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 09:28:51 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45798 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeBSO2t (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 09:28:49 -0500
X-Google-Smtp-Source: AH8x227OTsdZira58nhAd+soRrxT/Tz0RjBpqR5GX6lFl7ylHzHhiRETXVYjkXuLKP9CYPqnpYR/qg==
Date: Mon, 19 Feb 2018 08:28:47 -0600
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
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: add bindings for USB physical
 connector
Message-ID: <20180219142847.3rnvtai6msjlyj5b@rob-hp-laptop>
References: <20180215103920.32017-1-a.hajda@samsung.com>
 <CGME20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71@eucas1p1.samsung.com>
 <20180215103920.32017-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215103920.32017-2-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 11:39:15AM +0100, Andrzej Hajda wrote:
> These bindings allow to describe most known standard USB connectors
> and it should be possible to extend it if necessary.
> USB connectors, beside USB can be used to route other protocols,
> for example UART, Audio, MHL. In such case every device passing data
> through the connector should have appropriate graph bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v3:
> - removed MHL port (samsung connector will have separate bindings),
> - added 2nd example for USB-C,
> - improved formatting
> v2:
> - moved connector type(A,B,C) to compatible string (Rob),
> - renamed size property to type (Rob),
> - changed type description to be less confusing (Laurent),
> - removed vendor specific compatibles (implied by graph port number),
> - added requirement of connector being a child of IC (Rob),
> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>   by USB Controller in runtime, downside is that device is not able to
>   report its real capabilities, maybe better would be to make it optional(?)),
> - assigned port numbers to data buses (Rob).
> 
> Regards
> Andrzej
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> dt-bindings: add bindings for USB physical connector v3
> ---
>  .../bindings/connector/usb-connector.txt           | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> new file mode 100644
> index 000000000000..1efda92639da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -0,0 +1,74 @@
> +USB Connector
> +=============
> +
> +USB connector node represents physical USB connector. It should be
> +a child of USB interface controller.
> +
> +Required properties:
> +- compatible: describes type of the connector, must be one of:
> +    "usb-a-connector",
> +    "usb-b-connector",
> +    "usb-c-connector".
> +
> +Optional properties:
> +- label: symbolic name for the connector,
> +- type: size of the connector, should be specified in case of USB-A, USB-B
> +  non-standard (large) connector sizes: "mini", "micro".

The smaller connectors are standard too. Perhaps "non-fullsize connector 
sizes".

We're missing a micro-AB connector, but I think those are actually 
pretty rare. Most phones are micro-B connectors, but do both host and 
device.

> +
> +Required nodes:
> +- any data bus to the connector should be modeled using the OF graph bindings
> +  specified in bindings/graph.txt, unless the bus is between parent node and
> +  the connector. Since single connector can have multpile data buses every bus
> +  has assigned OF graph port number as follows:
> +    0: High Speed (HS), present in all connectors,
> +    1: Super Speed (SS), present in SS capable connectors,

This should also say endpoint 0 is USB-SS, endpoint 1 (and higher?) is 
Alternate Mode. And show in the example.

> +    2: Sideband use (SBU), present in USB-C.
> +
> +Examples
> +--------
> +
> +1. Micro-USB connector with HS lines routed via controller (MUIC):
> +
> +muic-max77843@66 {
> +	...
> +	usb_con: connector {
> +		compatible = "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +	};
> +};
> +
> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort:

Having SBU to DP but no DP video path connection is wrong.

> +
> +ccic: s2mm005@33 {
> +	...
> +	usb_con: connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				usb_con_hs: endpoint {
> +					remote-endpoint = <&max77865_usbc_hs>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				usb_con_ss: endpoint {
> +					remote-endpoint = <&usbdrd_phy_ss>;
> +				};
> +			};
> +			port@2 {
> +				reg = <2>;
> +				usb_con_sbu: endpoint {
> +					remote-endpoint = <&dp_aux>;
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 2.16.1
> 
