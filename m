Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3903807-1520838188-2-16690765195531579093
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
    t=1520838188; b=Gw3Quk+Lwn5QOzCA1Zp7N7HiZs4RsWDuh835UMD5DL8XJ3I
    MzMagmtbr6EAhbi9zf5EKg4p2mh4spCV78xFWNPFe85A3OlqrpUYVAhG5YS3mgVG
    EfosyERDG/tR/CDNNs7tF2VmZeFgtixB/2KJ8YIvi0lk/c1pYgiR3FwfsPAocL7O
    tckHApXPi4oDmHtCsTfjPJ1MKUXnrpFgwiTEIK1YHH6aJkkbropRM4zxjunEP1d3
    yTkXYTYjJE3DjpIP9zPVY+TX3LeNC465Puk7l18y7aA0/BkNKWSwE+ew/D3KV9/H
    At3iq3N5P2aCqubttsJ5FJ2eizJ4Bn/fC8KL90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520838188; bh=ZidxyDAl
    ffczaTaFxXAmlfMkn+Iojiyf/ZoD1Uw2KAs=; b=B/7+NM77B0A0pLX+Ir5XOpHo
    KB3n5ANDURfSVyxnyB9Yy0O4pAvOrguDGP70gwdihV+jdxCQqSyK9E86YX3SXjnL
    YbqSHF6AdEckznUUbJ05trFAlDLVVpfmu1V7OjYvx0LXQcHZNUbSTjD1Gstdda0w
    ljDRl2KmwEQ45nl2HCvv8FnqiuEvMV1avudmN7k7499ZAkheiDibChJfSmwcYyp1
    Jc3qadj0GNkigzPId/lKENkfZtXz2nPxxJ/VR3XWPikha5dqJzB7OR0uQsV1R7HG
    SobICSK1S7xRhlT9qm5AWpe6cwCXceDYuHQrI0c/jQOlI7fMDUbILFcMDXPzLw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=bdDWug0x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=bdDWug0x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCLHDE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 03:03:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46364 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbeCLHDB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 03:03:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180312070259euoutp01100cdff26b1dfd014450db5dbf9a7bfa~bGkQv55-K1500415004euoutp01Q
X-AuditID: cbfec7f4-b4fc79c0000043e4-67-5aa62621e30a
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
To: Roger Quadros <rogerq@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
Date: Mon, 12 Mar 2018 08:02:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTYRTGe7/bPrXZ52bslFE0KXKWlkW9dBGDgi8QjOiiQ6qVH1bqss1L
        N0osbeVdCk2t5WXmpZhN07ILpdZIrRmatsAWpRnV6o8WGKXl/Ir873fOeZ73nAdelpR9omez
        +7VJgk6riVcynlTz4x+2JfMXVquXvv6iwukGJ41vFJtpPOAaobGx4xmN+75/ZXChI5/CNluD
        BJ8tqJJgy7t+Gve2ljG42HafwBXVGSS+3jEowaaB5wTOuNchwdlvVWEcf+3yNcT35uYQfKnh
        Is1b6s4yvCPLSvCNVSf53KY6xFtfthD8N8vczR5qz7UxQvz+FEEXHLrbc1+n00Qm2hcfdlSd
        ZtLQJf9zyIMFbgV8HmxnziFPVsbVIMjPrEVi4ULQnZdFicU3BHd+u9A/y12DgRAHVxGk9Zho
        sXAisFeNEG6VnNsC9ke/KDf7cifgU0GpxC0iuVoKMgZrSPeA4QJgrNHOuFnKhcLt4cxJM8Ut
        ALOxdLI/k4uE8gvDSNT4wJOLQ5OPenCrwdbXKnEzyc2DFmcZKbICXg0ZJ88DroCF88aKv3dv
        gA+VLxiR5fDR2iQReQ78vm0kRD4G9g/plGg2IHD8PPPXsAbarc8ncrITGwLA3BosttdBfWUz
        5W4D5w0vnT7iDd5Q2FxEim0pGDJlono+OJ7eJEVWgKnnO5OP/EumJCuZkqZkSpqS/3uvIKoO
        KYRkfUKsoA/RCqlBek2CPlkbG7T3YIIFTXzBrnGr6xZq/bWnDXEsUk6XFltMahmtSdEfSWhD
        wJJKX+lHslotk8ZojhwVdAd36ZLjBX0b8mMppUK6c9EJtYyL1SQJcYKQKOj+TQnWY3Yakm9c
        PCCPSDqFXdsD2X5VlN8Bw7TUkI7AkTjVWESXl7Y46PWjset0TmScAjaZWhxMY2BeeH799OyV
        x70a3i+PMJevb1/3pqy/cNWs8DCCqi06FKpOd25NDZ2xQ0n4RXWORz4Y7Rv13ZZ8ZjT9szJu
        yKfxYfQljc0nepm0uzwsRqGk9Ps0y1SkTq/5AyfLTi1+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7oKasuiDJ5O0bZo6njLarFxxnpW
        i+tfnrNazD9yjtXiytf3bBaT7k9gsTh/fgO7RefEJewWmx5fY7W4vGsOm8WM8/uYLBYta2W2
        WHvkLrvF0usXmSxa9x5ht+h5pOUg4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1Yxehy/sZ3J4/MmuQDOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
        lNSczLLUIn27BL2MU2+XMhfc1Km4v6SFrYFxrnIXIyeHhICJxJ6ODqYuRi4OIYGljBJXH21k
        hUiIS+ye/5YZwhaW+HOtiw2i6DWjxIbpW5lAEsICQRI3j/5hAUmICDQwSnx8eJ4VxGEWWM0i
        sWFLBzNcy+wvGxhBWtgENCX+br7JBmLzCthJ7HzaBjaKRUBVYv382WBxUYEIic6V81kgagQl
        Ts58AmZzClhJnL+yix3EZhZQl/gz7xIzhC0vsf3tHChbXOLWk/lMExiFZiFpn4WkZRaSlllI
        WhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjPxtx35u3sF4aWPwIUYBDkYlHt4Zm5ZG
        CbEmlhVX5h5ilOBgVhLhfcW8LEqINyWxsiq1KD++qDQntfgQoynQcxOZpUST84FJKa8k3tDU
        0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA+OMya8FUo6uPGk9K/lD/eX7
        vg77ZsgcPNOyVu0zq0nVZ97knAsHPM2fvb9rXfP6yE/TLi6Zhb8PXvn1tWfa+WfOyt2X730I
        uD3Nm8/+99ltfgJeBYennHslev5C9cxXvU5H3GKZWFdseH7446JuZ16L7X1uO/oOuIr5lHxu
        KQ56EhkXpXlLR3OzEktxRqKhFnNRcSIAE++efhIDAAA=
X-CMS-MailID: 20180312070257eucas1p2b4d2ea9baf701bef967d426a8bb29ca8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180312070257eucas1p2b4d2ea9baf701bef967d426a8bb29ca8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
X-RootMTR: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
        <20180227071134.28063-2-a.hajda@samsung.com>
        <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09.03.2018 11:24, Roger Quadros wrote:
> Hi,
>
> On 27/02/18 09:11, Andrzej Hajda wrote:
>> These bindings allow to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v4:
>> - improved 'type' description (Rob),
>> - improved description of 2nd example (Rob).
>> v3:
>> - removed MHL port (samsung connector will have separate bindings),
>> - added 2nd example for USB-C,
>> - improved formatting.
>> v2:
>> - moved connector type(A,B,C) to compatible string (Rob),
>> - renamed size property to type (Rob),
>> - changed type description to be less confusing (Laurent),
>> - removed vendor specific compatibles (implied by graph port number),
>> - added requirement of connector being a child of IC (Rob),
>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>   by USB Controller in runtime, downside is that device is not able to
>>   report its real capabilities, maybe better would be to make it optional(?)),
>> - assigned port numbers to data buses (Rob).
>>
>> Regards
>> Andrzej
>> ---
>>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> new file mode 100644
>> index 000000000000..e1463f14af38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -0,0 +1,75 @@
>> +USB Connector
>> +=============
>> +
>> +USB connector node represents physical USB connector. It should be
>> +a child of USB interface controller.
>> +
>> +Required properties:
>> +- compatible: describes type of the connector, must be one of:
>> +    "usb-a-connector",
>> +    "usb-b-connector",
>> +    "usb-c-connector".
> compatible should be just "usb-connector"
>
> Type should be a property
>
> type: type of usb connector "A", "B", "AB", "C"
> AB is for dual-role connectors.

I have proposed such property (and size also) in my first RFC [1]. Rod
did not like it :)

[1]: https://marc.info/?l=devicetree&m=150660411515233&w=2


>
> micro super-speed and high-speed connectors are different. How do you differentiate that?

I am aware of it, and property differentiating it was also in my earlier
iterations.
If there will be need to differentiate such connectors, adding property
max-speed or max-mode would do the thing.

>
>> +
>> +Optional properties:
>> +- label: symbolic name for the connector,
> Why do you need label? We can't maintain consistency as people will put creative names there.
> Device/bus driver could generate a valid label.

It follows convention for other connectors: HDMI, DVI, ....

>
>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>> +  non-fullsize connectors: "mini", "micro".
> type is misleading. Type is usually A/B/C. It should be size here instead.

As you can see in discussion for previous iterations it follows
convention already established for other connectors.

>
> size: size of the connector if not standard size. "mini", "micro"
>
> If not specified it is treated as standard sized connector.
> e.g. for Type-C there is no mini/micro. so size doesn't have to be specificed
Few lines above it is described: should be specified in case of USB-A,
USB-B non-fullsize connectors.

>
> What about Type-C connector?
>> +
>> +Required nodes:
>> +- any data bus to the connector should be modeled using the OF graph bindings
> s/modeled/modelled

>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>> +  the connector. Since single connector can have multpile data buses every bus
> s/multpile/multiple

OK, I will fix both typos.

>
>> +  has assigned OF graph port number as follows:
>> +    0: High Speed (HS), present in all connectors,
>> +    1: Super Speed (SS), present in SS capable connectors,
>> +    2: Sideband use (SBU), present in USB-C.
>> +
>> +Examples
>> +--------
>> +
>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>> +
>> +muic-max77843@66 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-b-connector";
>> +		label = "micro-USB";
>> +		type = "micro";
>> +	};
>> +};
>> +
>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
>> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
>> +
>> +ccic: s2mm005@33 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-c-connector";
>> +		label = "USB-C";
> The label is not consistent with the earlier example.

Why?

Regards
Andrzej

>
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +				usb_con_hs: endpoint {
>> +					remote-endpoint = <&max77865_usbc_hs>;
>> +				};
>> +			};
>> +			port@1 {
>> +				reg = <1>;
>> +				usb_con_ss: endpoint {
>> +					remote-endpoint = <&usbdrd_phy_ss>;
>> +				};
>> +			};
>> +			port@2 {
>> +				reg = <2>;
>> +				usb_con_sbu: endpoint {
>> +					remote-endpoint = <&dp_aux>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>>

