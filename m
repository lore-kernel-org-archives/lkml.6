Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220748-1520591121-2-6166269482320245910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520591121; b=JEj9zN7+S+RyM0jEMckHDPXkuqWEd8v8aZ7hGvdyXrNMAbz
    DY3qs4DS8t3PeslzHNHR+sjVWDc4SFkxEWsOCYzp+/ohSpqYOzRqCvd//VtVgC2X
    tQieV0fwvEkRgW5GQfBuTdsxLt5ywxqIebiT8wxxYEE9x83iQd+EqI7wlAhmpQDq
    2sjim3rFLx1ST4y1vJ/UgA4zyE/I/f2No9DtoENUIrcsOGO+67wxrcBxDVhG2gBC
    6jIWMRbZMp+cVjLrFGg7aX9Rz2FPHOwge+XfK4GCi9ry8mP5FfMHTLBBONBR7pNg
    amtJUYqRFJK7HqbfoOcKSrRjDG7l+FZNr6GMYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520591121; bh=D27noEyjoCjej/bkCBtTeOENnQTy632eE8N6QUWTNdM=; b=V
    O+dbYvPSQRYYbQycJ5t4BiTBLEBYROWPBH/nIsKw3U5qeV6S4/9Q7jw3d7BPRaum
    OQi8SE+vd6veAwkzVeb4ObmZxigHP7+YMXOKif1lYbbSPdhJSmoo6k+BtDBb/1Na
    IWquUyTTE8E90eVW53uQHUrPTBr8Po2d555Yo7j/rrSewPLloL1TtfAqAGG9PNFz
    Q6C0I22/HBqFYlOmTJpUY91aErqhiB96cXX5+2vRhNjYd8G/AqNP5r9vucdtzihc
    Mk1pmUnJZ/OG1dxUpsoTWEIyEZhOanhjDHEG7PXRbrgg2GC50sc7ALXlGaN+mLrp
    sTQS3yA9sSl6TC1Oipp2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Rfv9Wj1V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Rfv9Wj1V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeCIKZS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 05:25:18 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:49100 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeCIKZQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 05:25:16 -0500
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
To: Andrzej Hajda <a.hajda@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <dri-devel@lists.freedesktop.org>, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
Date: Fri, 9 Mar 2018 12:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227071134.28063-2-a.hajda@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 27/02/18 09:11, Andrzej Hajda wrote:
> These bindings allow to describe most known standard USB connectors
> and it should be possible to extend it if necessary.
> USB connectors, beside USB can be used to route other protocols,
> for example UART, Audio, MHL. In such case every device passing data
> through the connector should have appropriate graph bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4:
> - improved 'type' description (Rob),
> - improved description of 2nd example (Rob).
> v3:
> - removed MHL port (samsung connector will have separate bindings),
> - added 2nd example for USB-C,
> - improved formatting.
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
> ---
>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> new file mode 100644
> index 000000000000..e1463f14af38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -0,0 +1,75 @@
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

compatible should be just "usb-connector"

Type should be a property

type: type of usb connector "A", "B", "AB", "C"
AB is for dual-role connectors.

micro super-speed and high-speed connectors are different. How do you differentiate that?

> +
> +Optional properties:
> +- label: symbolic name for the connector,

Why do you need label? We can't maintain consistency as people will put creative names there.
Device/bus driver could generate a valid label.

> +- type: size of the connector, should be specified in case of USB-A, USB-B
> +  non-fullsize connectors: "mini", "micro".

type is misleading. Type is usually A/B/C. It should be size here instead.

size: size of the connector if not standard size. "mini", "micro"

If not specified it is treated as standard sized connector.
e.g. for Type-C there is no mini/micro. so size doesn't have to be specificed

What about Type-C connector?
> +
> +Required nodes:
> +- any data bus to the connector should be modeled using the OF graph bindings

s/modeled/modelled

> +  specified in bindings/graph.txt, unless the bus is between parent node and
> +  the connector. Since single connector can have multpile data buses every bus

s/multpile/multiple

> +  has assigned OF graph port number as follows:
> +    0: High Speed (HS), present in all connectors,
> +    1: Super Speed (SS), present in SS capable connectors,
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
> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
> +
> +ccic: s2mm005@33 {
> +	...
> +	usb_con: connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";

The label is not consistent with the earlier example.

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
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
