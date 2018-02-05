Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1645486-1517811234-2-3961937171205588561
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
    t=1517811233; b=g+uu+iH0PonMzuMgLNiHIIMNEXqbHoowxPrztfhX0bshf+d
    yZ0WP22X6SU16g/LUQ+F9Eu1DZHelD4NPzR59neRKv3N558VD6bmtpr4JpOOeDWt
    OnUp222pKgczp0/FG/p7h/eiT44rh4jcrmhg8ep1DxavfuSgLZDNYrzGVcEoIcXk
    d9GciIGKLBSeLLr8UxNyJRBcmVrT/1ikVD9+pzBD663VYf8kmtOZJnGgEAfWSAG3
    weyHh35H8i3zyJxbEE9fHDpptvvFiGh7FrW+sm4enn1qtESP343Eqh1lBT1a2vcs
    c45trq03ou8g+yW504jNRV6jk4J8cN07XVTz1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517811233; bh=oh1WDpvnh/qzZe+2AYSCyyPLvD
    37OCmTHn2EmLqT6II=; b=d/Khdu4ue8ryHOXkYjgVEDiZNG/l9nAq+aqLnS494E
    5BMkc+Za6PoMFGtej4J6FpO7RPLyovKfvZwNCMsHPLbUv0wvlSiQUsBPIyApNept
    U/F2eU8PB8Ram48svOQTeCablRUTdZ4Iix9MsiHnkJYfK3/u3rLf58MEzBz+mHYD
    8B/+nOP07tCIgK7/O7m73TmYjPrrZNaEKu0hS38G5mZ74BGK/+rVMzoIDZoS9087
    Zf8kQ0aIBDoobpT4gJtLBSaS84dd8jC4dOmRKl8GI7OPWhiH8hNZdr4gPCI6hoEp
    CXEHrYmZ226wJCiIfVyBPFitCL7B7lUgsPQrool0t3HA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W3km9tZt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W3km9tZt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBEGNs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 01:13:48 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33439 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbeBEGIi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Feb 2018 01:08:38 -0500
X-Google-Smtp-Source: AH8x227Euq+9KuObhIqwQLssCp9pd0x8X4oncFmwsZnfz6VxWifTUo/GliLN6+l3A/RpaKLPZbNBQg==
Date: Mon, 5 Feb 2018 00:08:36 -0600
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
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: add bindings for USB physical
 connector
Message-ID: <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
 <20180131134435.12216-2-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131134435.12216-2-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 02:44:31PM +0100, Andrzej Hajda wrote:
> These bindings allow to describe most known standard USB connectors
> and it should be possible to extend it if necessary.
> USB connectors, beside USB can be used to route other protocols,
> for example UART, Audio, MHL. In such case every device passing data
> through the connector should have appropriate graph bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v2:
> - moved connector type(A,B,C) to compatible string (Rob),
> - renamed size property to type (Rob),
> - changed type description to be less confusing (Laurent),
> - removed vendor specific compatibles (implied by graph port number),

How so? More below...

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
> ---
>  .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> new file mode 100644
> index 000000000000..02020f5d760a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -0,0 +1,48 @@
> +USB Connector
> +=============
> +
> +USB connector node represents physical USB connector. It should be
> +a child of USB interface controller.
> +
> +Required properties:
> +- compatible: describes type of the connector, must be one of:
> +    "usb-a-connector", "usb-b-connector", "usb-c-connector",

Nit: one per line.

> +
> +Optional properties:
> +- label: symbolic name for the connector
> +- type: size of the connector, should be specified in case of USB-A, USB-B
> +  non-standard (large) connector sizes: "mini", "micro"
> +
> +Required nodes:
> +- any data bus to the connector should be modeled using the OF graph bindings
> +  specified in bindings/graph.txt, unless the bus is between parent node and
> +  the connector. Since single connector can have multpile data buses every bus
> +  has assigned OF graph port number as follows:
> +    0: High Speed (HS), present in all connectors,
> +    1: Super Speed (SS), present in SS capable connectors,
> +    2: Sideband use (SBU), present in USB-C,
> +    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB

This is un-muxed unlike Type-C where the signals are muxed with USB SS. 
That makes me think the Samsung connector should have its own compatible 
string.

Can we go ahead and define the video modes of Type-C? Normally, if 2 
data streams are mutually exclusive, then they are a single port with 2 
endpoints. So we'd either have 2 endpoints on port 1 or we stick with 
port 3 is always video. We can still know what is mutually exclusive 
based on the compatible. 

> +
> +Example
> +-------
> +
> +muic_max77843@66 {
> +	...
> +	musb_con: connector {
> +		compatible = "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@3 {
> +				reg = <3>;
> +				musb_con_mhl_in: endpoint {
> +					remote-endpoint = <&mhl_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 2.15.1
> 
