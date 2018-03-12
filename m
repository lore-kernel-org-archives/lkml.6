Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-111126-1520851312-2-18242387728366710040
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
    t=1520851312; b=gDsmFWRMQB9z1Nda4UDkAfrwe7dfcJsowgy+CK17Vjt5pU9
    FtCxrRaWJlH8pZYfP9JMaDTrDq2t4absaefQsIII+kPjmJqOFb6dEZWNxfpQWhvu
    sKM3JFWU0kjdnY++JTXr4bufVRvbMGiHPVwfXVfNe5TTEpQdLcgSYgcMBm3QeNXV
    KPn/MeCRaTjHLG8E0F44EuuU1KRalJgVfA7tpVicR9oFSzg+flmA7qE+rqG3HsD6
    qGbLwusoTOI9RteSXao6UNioPhpiwN16+CX5lb5CkDyB5sjLLHR5WpYEnSVZjz0i
    5noiHDHr183pm7waYkDEXM9SINg+q7OGYoZLaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520851312; bh=B1rrzFtT9sXZlnUc3DEBSzjRJ1yf1VbYSvBIHOHwOQc=; b=L
    Z1RsCWJkHLNuIjUulq1KnpCm52CeWrDN05ew5dnPFubmP5NMX0v8maf2iCIlVq92
    +BBb+HpoIMan1FstOZ3gN1MLkhXvZ5icPAsMRhCuSHyVqQmox7U6HljTg+Hgo8kW
    Qbrbox4XTYPhWCltsrrHL/R/BLSsHquVzo0A8KEg/Jg1GnzluZQ8udPaQ+ddrkhY
    mxO/ZxwKGcDFKk95YDPtGz999a0VZ88oPlUNHc+SFHBhEn2PFPE1QA3bwch91cU3
    AFWGvvlEtndoi+eazvc6+X0GMhT5/1YLn06X3uy4AvZVJSieOuqFHojCHhY+APmH
    rhO94Pe8yIbUEtUtC8G0g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=qJqUCha4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=qJqUCha4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCLKlj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 06:41:39 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:59428 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeCLKlf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 06:41:35 -0400
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
        <linux-samsung-soc@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
 <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
 <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <12da0d00-9ab3-3752-793b-e487666f35a3@ti.com>
Date: Mon, 12 Mar 2018 12:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andrezej,

Why don't you have any of the USB maintainers in to/cc?

Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
Felipe Balbi <balbi@kernel.org> (maintainer:USB GADGET/PERIPHERAL SUBSYSTEM)

On 12/03/18 09:02, Andrzej Hajda wrote:
> On 09.03.2018 11:24, Roger Quadros wrote:
>> Hi,
>>
>> On 27/02/18 09:11, Andrzej Hajda wrote:
>>> These bindings allow to describe most known standard USB connectors
>>> and it should be possible to extend it if necessary.
>>> USB connectors, beside USB can be used to route other protocols,
>>> for example UART, Audio, MHL. In such case every device passing data
>>> through the connector should have appropriate graph bindings.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>> v4:
>>> - improved 'type' description (Rob),
>>> - improved description of 2nd example (Rob).
>>> v3:
>>> - removed MHL port (samsung connector will have separate bindings),
>>> - added 2nd example for USB-C,
>>> - improved formatting.
>>> v2:
>>> - moved connector type(A,B,C) to compatible string (Rob),
>>> - renamed size property to type (Rob),
>>> - changed type description to be less confusing (Laurent),
>>> - removed vendor specific compatibles (implied by graph port number),
>>> - added requirement of connector being a child of IC (Rob),
>>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>>   by USB Controller in runtime, downside is that device is not able to
>>>   report its real capabilities, maybe better would be to make it optional(?)),
>>> - assigned port numbers to data buses (Rob).
>>>
>>> Regards
>>> Andrzej
>>> ---
>>>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>>>  1 file changed, 75 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> new file mode 100644
>>> index 000000000000..e1463f14af38
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt

Should this lie in  bindings/usb/connector?

>>> @@ -0,0 +1,75 @@
>>> +USB Connector
>>> +=============
>>> +
>>> +USB connector node represents physical USB connector. It should be
>>> +a child of USB interface controller.
>>> +
>>> +Required properties:
>>> +- compatible: describes type of the connector, must be one of:
>>> +    "usb-a-connector",
>>> +    "usb-b-connector",
>>> +    "usb-c-connector".
>> compatible should be just "usb-connector"
>>
>> Type should be a property
>>
>> type: type of usb connector "A", "B", "AB", "C"
>> AB is for dual-role connectors.
> 
> I have proposed such property (and size also) in my first RFC [1]. Rod
> did not like it :)
> 
> [1]: https://marc.info/?l=devicetree&m=150660411515233&w=2
> 

This is what Rob says here https://patchwork.kernel.org/patch/9976043/
"We did "type" for hdmi-connector, but I think I'd really prefer 
compatible be used to distinguish as least where it may matter to s/w. 
In the HDMI case, they all are pretty much the same, just different 
physical size."

So the question is. Does it matter to this particular software implementation
if it is type A,B,C connector?
If yes, how?

Type A will never have any alternate function. It is always dedicated to USB.

Also does the size "full", "micro", "mini" matter to software?

> 
>>
>> micro super-speed and high-speed connectors are different. How do you differentiate that?
> 
> I am aware of it, and property differentiating it was also in my earlier
> iterations.
> If there will be need to differentiate such connectors, adding property
> max-speed or max-mode would do the thing.

USB controller binding (bindings/usb/generic.txt) has the speed.
I don't think there is any value for replicating it for the connector. Maybe it could
be added later if needed.

> 
>>
>>> +
>>> +Optional properties:
>>> +- label: symbolic name for the connector,
>> Why do you need label? We can't maintain consistency as people will put creative names there.
>> Device/bus driver could generate a valid label.
> 
> It follows convention for other connectors: HDMI, DVI, ....
> 
>>
>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>>> +  non-fullsize connectors: "mini", "micro".
>> type is misleading. Type is usually A/B/C. It should be size here instead.
> 
> As you can see in discussion for previous iterations it follows
> convention already established for other connectors.
> 
>>
>> size: size of the connector if not standard size. "mini", "micro"
>>
>> If not specified it is treated as standard sized connector.
>> e.g. for Type-C there is no mini/micro. so size doesn't have to be specificed
> Few lines above it is described: should be specified in case of USB-A,
> USB-B non-fullsize connectors.
> 
>>
>> What about Type-C connector?
>>> +
>>> +Required nodes:
>>> +- any data bus to the connector should be modeled using the OF graph bindings
>> s/modeled/modelled
> 
>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>>> +  the connector. Since single connector can have multpile data buses every bus
>> s/multpile/multiple
> 
> OK, I will fix both typos.
> 
>>
>>> +  has assigned OF graph port number as follows:
>>> +    0: High Speed (HS), present in all connectors,
>>> +    1: Super Speed (SS), present in SS capable connectors,
>>> +    2: Sideband use (SBU), present in USB-C.
>>> +
>>> +Examples
>>> +--------
>>> +
>>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>>> +
>>> +muic-max77843@66 {
>>> +	...
>>> +	usb_con: connector {
>>> +		compatible = "usb-b-connector";
>>> +		label = "micro-USB";
>>> +		type = "micro";
>>> +	};
>>> +};
>>> +
>>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
>>> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
>>> +
>>> +ccic: s2mm005@33 {
>>> +	...
>>> +	usb_con: connector {
>>> +		compatible = "usb-c-connector";
>>> +		label = "USB-C";
>> The label is not consistent with the earlier example.
> 
> Why?

Because 1st example is "<size>-USB" and second one is "USB-<type>".

How is label going to be used? Is it being presented to end user?
If yes it should indicate what's important to the user. i.e. its function. e.g. "USB-MHL"
or "USB-DisplayPort"

> 
> Regards
> Andrzej
> 
>>
>>> +
>>> +		ports {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +
>>> +			port@0 {
>>> +				reg = <0>;
>>> +				usb_con_hs: endpoint {
>>> +					remote-endpoint = <&max77865_usbc_hs>;
>>> +				};
>>> +			};
>>> +			port@1 {
>>> +				reg = <1>;
>>> +				usb_con_ss: endpoint {
>>> +					remote-endpoint = <&usbdrd_phy_ss>;
>>> +				};
>>> +			};
>>> +			port@2 {
>>> +				reg = <2>;
>>> +				usb_con_sbu: endpoint {
>>> +					remote-endpoint = <&dp_aux>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>>
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
