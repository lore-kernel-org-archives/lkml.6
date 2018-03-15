Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68257-1521111810-2-16150450127250746272
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
    t=1521111809; b=YTxzn3qUEfhaw/OEGOpX7kbKZEZQqh7otRJTA92ohYOQX67
    qPg3QRk+4LL74WPnHyRoyiEx9c3zQitk9I9DkhslZXI1bDcNCe3thIUjX7zB5xvp
    1eT+aT2v/VlPZ1LZXxZsjJ97P2Fpj7TFcWAY7Y3BkoDpLg3IecNcxDQ8nAAQBBuD
    pJC3rAEdABYVM6q2aqK3VD4EY3iqdb2+SDG5Tk8kgEn/1nYrw5xZ27wfDX6qFiYf
    mJEXkT3FIBNgMJ66bcM6xndsqg2GXT6kOe11pHdvW/EHo1J+wL0lBysAAIGIaREs
    bz3VpvWYTBTqXT6Fbiu8fOv5d33z8Bn0tLqdZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1521111809; bh=0UqXPYuv
    KmwDk3MGAikbTHzZxYvHUUeRaJ6GCjtqZLw=; b=pfCWkGrW2iq4nnw2FlvN723k
    /IYh7URLfwi4NhOIa4CB7oDPTffIuoncMV4C0i7j6yls38LwhfYDQAkaDJyQmybU
    scnoMC0wjcRNli068ZOk1S1vlckcosTQt4IeBhFsPltLgkL87mSiYL2/Za4aReVR
    FgwnMjnNwd8LuKAZnDBFus/vl5NHebCwTex46A/r3ri/jfAK59MPJkk/jM/sqpXG
    zeA6hMm0LiW1mM1SV+dX+pfEe+ro0Sc77Bw0b6Zq0t65Q1iagzrs8FzdiWzgsHN+
    8BRi85x9CnIG86eXTBBwJyE7zzIgfZKl9RMxuGBCTQH8hgt5B7E8dMvHG6JDGA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=vei4xP2s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=vei4xP2s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeCOLDT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 07:03:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52135 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeCOLDK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 07:03:10 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180315110306euoutp026fc6f20f617403a3d04122f9c2fdb766~cExxvokU00454904549euoutp02D
X-AuditID: cbfec7f4-b4fc79c0000043e4-23-5aaa52e6b700
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
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <0e53a355-cb9f-bab0-997d-207f683a4fbc@samsung.com>
Date: Thu, 15 Mar 2018 12:02:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12da0d00-9ab3-3752-793b-e487666f35a3@ti.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMcRjH+3x/d+v4urSexZgrmwwR5iPEH2ZfG8uaTbLh6KvMlbqrVCzJ
        ypVY+Vl3JdH142RH+XmbkNMJuW4snY3bKr+yo6asqOj6Mv33et7v5/k8z3v7cKTiJx3A7U1I
        FjUJKrWSkVG3mofs8z9EmqIXGo1hOFvnpvH1YjONm3O7Wfy6/yONy60vaPxq4BuDj142M/iU
        q5DCdvs1FucVVbK4vqudxi8tpQwutjcS+FJVDomvWt+y2PjaQeCce1YWF3TOXaMQ6i7UIeHl
        yROEYNCV0EK9KY8R7pfVsYLruI0QGioPCydvmJBg67hNCN/rZ2ySRctWxojqvamiJiR8pyyu
        /ZUZJR5ZnfblQTuZhRpD85E3B/wS6LMN0vlIxin4GgTtujZKKvoR/LY7GKn4jsBQ8Rz9G6k6
        5yQloxpB1u8mJBVuBDU6z2PenC8fCc7Hw5SHp/KZ8KXIwHqaSH6EAvcZM+sxGD4YRhqcjIfl
        fDg0Xy8bX0Hxs6HV3TjOfnwUVJx9j6SeKdBS0j3+qDcfBs4jFaSHSX4m3HaX/mV/eNNdTniW
        AW/kwGAy/r17LXT1VhES+0KP7QYr8XR4drqAkvggOD9lU9KwDoHr1zFGMlbAI5tjLBo3tiEY
        zJYQSV4FT0YfUx4Z+EnQ4Z4i3TAJTt06T0qyHHS5Cql7Frhab5IS+4OxbYApRIH6Ccn0E9Lo
        J6TR/997EVEm5C+maONjRW1ognhggVYVr01JiF2we398PRr7kc9Gbf13kGV4VxPiOaT0kXcE
        1kYraFWqNj2+CQFHKqfKXUljkjxGlZ4havbv0KSoRW0TmsZRSn/59jmZ0Qo+VpUs7hPFRFHz
        zyU474AslE/N2z4Sfrd28R1Fh2/nNnVXX2/O/Za3UUOxG2paFUORjSlLzZsLfgYtr0ZfiVH1
        Z3FPQEaG42H1j8iDBU9GkN4666nZ55s6f2NwhBi2wSsjaVC3OygwafK6UPmVtIbqQz3rsy1+
        lMtrS+hpx6remGXJJYffWSMsucO6xVt7fA4YlJQ2TrVoLqnRqv4AZVf6SI0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42I5/e/4Xd0nQauiDE7t0LFo6njLarFxxnpW
        i2NtT9gtrn95zmox/8g5VosrX9+zWTQvXs9mMen+BBaL8+c3sFt0TlzCbrHp8TVWi8u75rBZ
        zDi/j8li0bJWZou1R+6yWyy9fpHJonXvEXaLnkdaDkIea+atYfS43NfL5DG7Yyarx6ZVnWwe
        ++euYfe4332cyWPzknqPvi2rGD2O39jO5PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWF
        npGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrUr6xkLGu0rXh+4xtzAuM+oi5GTQ0LARGLZ
        tJvMXYxcHEICSxklLk7tZYdIiEvsnv+WGcIWlvhzrYsNoug1o8Srp/sZQRLCAkESN4/+YQFJ
        iAg0MEp8fHieFcRhFmhklZi88hIjRMsFJol/Xc1gs9gENCX+br7JBmLzCthJHNs4F2wUi4Cq
        xNm3+8BsUYEIic6V81kgagQlTs58AmZzClhJ3GxcCDaHWUBd4s+8S1C2vMT2t3OgbHGJW0/m
        M01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAtbDv2c/MO
        xksbgw8xCnAwKvHw3lBeGSXEmlhWXJl7iFGCg1lJhPd+IVCINyWxsiq1KD++qDQntfgQoynQ
        cxOZpUST84EpK68k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA2P0
        m7/m2QlPEl2brh6d8XLSqZmV6078vl12wqK9xqWXcX5RhP3Z2MB5h142NRVxha50iDxWstFw
        1evo+L+7lGT+P7OYt93A4I6Tz3azI3tdjqXtnMLbxX3hBWuaXNKV+vayKZPYZq7NP+1SY7F1
        QoeVzbdtZhMn3AuJTJAxqmsraO+SyUrc+FOJpTgj0VCLuag4EQDaZ+RoIQMAAA==
X-CMS-MailID: 20180315110301eucas1p2f6e2b87e3b2238497296d68d69cae88d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180315110301eucas1p2f6e2b87e3b2238497296d68d69cae88d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
X-RootMTR: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
        <20180227071134.28063-2-a.hajda@samsung.com>
        <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
        <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
        <12da0d00-9ab3-3752-793b-e487666f35a3@ti.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12.03.2018 11:41, Roger Quadros wrote:
> Andrezej,
>
> Why don't you have any of the USB maintainers in to/cc?
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> Felipe Balbi <balbi@kernel.org> (maintainer:USB GADGET/PERIPHERAL SUBSYSTEM)

Serious omission, sorry for that.

>
> On 12/03/18 09:02, Andrzej Hajda wrote:
>> On 09.03.2018 11:24, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 27/02/18 09:11, Andrzej Hajda wrote:
>>>> These bindings allow to describe most known standard USB connectors
>>>> and it should be possible to extend it if necessary.
>>>> USB connectors, beside USB can be used to route other protocols,
>>>> for example UART, Audio, MHL. In such case every device passing data
>>>> through the connector should have appropriate graph bindings.
>>>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>> v4:
>>>> - improved 'type' description (Rob),
>>>> - improved description of 2nd example (Rob).
>>>> v3:
>>>> - removed MHL port (samsung connector will have separate bindings),
>>>> - added 2nd example for USB-C,
>>>> - improved formatting.
>>>> v2:
>>>> - moved connector type(A,B,C) to compatible string (Rob),
>>>> - renamed size property to type (Rob),
>>>> - changed type description to be less confusing (Laurent),
>>>> - removed vendor specific compatibles (implied by graph port number),
>>>> - added requirement of connector being a child of IC (Rob),
>>>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>>>   by USB Controller in runtime, downside is that device is not able to
>>>>   report its real capabilities, maybe better would be to make it optional(?)),
>>>> - assigned port numbers to data buses (Rob).
>>>>
>>>> Regards
>>>> Andrzej
>>>> ---
>>>>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>>>>  1 file changed, 75 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> new file mode 100644
>>>> index 000000000000..e1463f14af38
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> Should this lie in  bindings/usb/connector?


I guess this is question for DT people. For me both locations are OK.

>
>>>> @@ -0,0 +1,75 @@
>>>> +USB Connector
>>>> +=============
>>>> +
>>>> +USB connector node represents physical USB connector. It should be
>>>> +a child of USB interface controller.
>>>> +
>>>> +Required properties:
>>>> +- compatible: describes type of the connector, must be one of:
>>>> +    "usb-a-connector",
>>>> +    "usb-b-connector",
>>>> +    "usb-c-connector".
>>> compatible should be just "usb-connector"
>>>
>>> Type should be a property
>>>
>>> type: type of usb connector "A", "B", "AB", "C"
>>> AB is for dual-role connectors.
>> I have proposed such property (and size also) in my first RFC [1]. Rod
>> did not like it :)
>>
>> [1]: https://marc.info/?l=devicetree&m=150660411515233&w=2
>>
> This is what Rob says here https://patchwork.kernel.org/patch/9976043/
> "We did "type" for hdmi-connector, but I think I'd really prefer 
> compatible be used to distinguish as least where it may matter to s/w. 
> In the HDMI case, they all are pretty much the same, just different 
> physical size."
>
> So the question is. Does it matter to this particular software implementation
> if it is type A,B,C connector?
> If yes, how?

IMHO both approaches can work from S/W POV. As I understood it moving
usb type to compatible was rather matter of devicetree guidelines I am
not aware of. Again question to Rob.

>
> Type A will never have any alternate function. It is always dedicated to USB.
>
> Also does the size "full", "micro", "mini" matter to software?
>
>>> micro super-speed and high-speed connectors are different. How do you differentiate that?
>> I am aware of it, and property differentiating it was also in my earlier
>> iterations.
>> If there will be need to differentiate such connectors, adding property
>> max-speed or max-mode would do the thing.
> USB controller binding (bindings/usb/generic.txt) has the speed.
> I don't think there is any value for replicating it for the connector. Maybe it could
> be added later if needed.
>
>>>> +
>>>> +Optional properties:
>>>> +- label: symbolic name for the connector,
>>> Why do you need label? We can't maintain consistency as people will put creative names there.
>>> Device/bus driver could generate a valid label.
>> It follows convention for other connectors: HDMI, DVI, ....
>>
>>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>>>> +  non-fullsize connectors: "mini", "micro".
>>> type is misleading. Type is usually A/B/C. It should be size here instead.
>> As you can see in discussion for previous iterations it follows
>> convention already established for other connectors.
>>
>>> size: size of the connector if not standard size. "mini", "micro"
>>>
>>> If not specified it is treated as standard sized connector.
>>> e.g. for Type-C there is no mini/micro. so size doesn't have to be specificed
>> Few lines above it is described: should be specified in case of USB-A,
>> USB-B non-fullsize connectors.
>>
>>> What about Type-C connector?
>>>> +
>>>> +Required nodes:
>>>> +- any data bus to the connector should be modeled using the OF graph bindings
>>> s/modeled/modelled
>>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>>>> +  the connector. Since single connector can have multpile data buses every bus
>>> s/multpile/multiple
>> OK, I will fix both typos.
>>
>>>> +  has assigned OF graph port number as follows:
>>>> +    0: High Speed (HS), present in all connectors,
>>>> +    1: Super Speed (SS), present in SS capable connectors,
>>>> +    2: Sideband use (SBU), present in USB-C.
>>>> +
>>>> +Examples
>>>> +--------
>>>> +
>>>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>>>> +
>>>> +muic-max77843@66 {
>>>> +	...
>>>> +	usb_con: connector {
>>>> +		compatible = "usb-b-connector";
>>>> +		label = "micro-USB";
>>>> +		type = "micro";
>>>> +	};
>>>> +};
>>>> +
>>>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>>>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
>>>> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
>>>> +
>>>> +ccic: s2mm005@33 {
>>>> +	...
>>>> +	usb_con: connector {
>>>> +		compatible = "usb-c-connector";
>>>> +		label = "USB-C";
>>> The label is not consistent with the earlier example.
>> Why?
> Because 1st example is "<size>-USB" and second one is "USB-<type>".
>
> How is label going to be used? Is it being presented to end user?

I suppose it could be presented to user, and not-interpreted by S/W.

> If yes it should indicate what's important to the user. i.e. its function. e.g. "USB-MHL"
> or "USB-DisplayPort"

Good idea, to emphasize ports capabilities. I guess it could be most
useful in case of multiple USB ports, they could be then named according
to their visible properties/labels, for example: Front-USB, Green-USB,
USB-1.

Regards
Andrzej

>
>> Regards
>> Andrzej
>>
>>>> +
>>>> +		ports {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +
>>>> +			port@0 {
>>>> +				reg = <0>;
>>>> +				usb_con_hs: endpoint {
>>>> +					remote-endpoint = <&max77865_usbc_hs>;
>>>> +				};
>>>> +			};
>>>> +			port@1 {
>>>> +				reg = <1>;
>>>> +				usb_con_ss: endpoint {
>>>> +					remote-endpoint = <&usbdrd_phy_ss>;
>>>> +				};
>>>> +			};
>>>> +			port@2 {
>>>> +				reg = <2>;
>>>> +				usb_con_sbu: endpoint {
>>>> +					remote-endpoint = <&dp_aux>;
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +};
>>>>

