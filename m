Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114892-1519140279-2-9530529149352838582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519140278; b=w8NuVZAUZ5HHXihgVP29exTc20phfsUk0cy7FCq+CXhgAEc
    t+91GUp/9VjUvIgi6nn2cmL87TONQw7vKZx9Cul0sg+uOCBpHEudIt7kNjJWsz6G
    7xgvBOblm16DohALf9OlVeNpVUOdEuXYW75vpZPeBiqOHHclT6leQA77GlZzG29E
    H89eSumhjwuwTdb14p+6gOzAhjEHAiIsdl8byxqhYrdu2kQ9CnPasQmZDyXUq2yx
    6I6qYIJs5u7Hc03Kis5KgNdh+iGS6/z56jLlRzha5tbR1r0Pyh26YidEe91Ic0rU
    g0MsGAVM3SpX8+ZlAiu6UlqrhuSpGeyUV3o2E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519140278; bh=c9lxPqtod8rklsKtrW8BGJnK7oLdqOZUc3sfKJ
    bbJ3g=; b=pEhefqa3wOdBKZwPO6HN+qN76dQW+sH24hoTJTwl3VMYCcx8XZaeMU
    SvBdDbyimkqedbNDiPPdHQOgWd+7xu9zFACiRDvr2TL1n97A5daHN2FS/B4CDYnL
    9/c870LaLzhEBcRO1ZOW/vc7pbgmuLzIvoRII6UwH3+bczEqAG0xDDTr2p5jUtlf
    W7dhCNh/e3k94SFVw5KImZvqe01I0Qt7IoNGN06VpHspIvhSO+l8DbJsjsUTIWqS
    tmsSKtmucVtB8yWRak+D8Y6+dJkUu6j5DRbx96IOjZVNwdJKmS8UX9R89kYj87ew
    UYM04JgfF4sz4sn9VbX8ajrNpbJWCDow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBTPYW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 10:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbeBTPYS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Feb 2018 10:24:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0372179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227yVv18GhMMSiATZHOrlKZ1oATmssEGrgoIrKMRfNpQJ0zv92QzWpbGfMiOBXJP6Az32ekGRRUMgCbHxWeQk0g=
MIME-Version: 1.0
In-Reply-To: <d5d38789-4d28-dce7-054f-f91bd82275cc@samsung.com>
References: <20180215103920.32017-1-a.hajda@samsung.com> <CGME20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71@eucas1p1.samsung.com>
 <20180215103920.32017-2-a.hajda@samsung.com> <20180219142847.3rnvtai6msjlyj5b@rob-hp-laptop>
 <d5d38789-4d28-dce7-054f-f91bd82275cc@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Feb 2018 09:23:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjZvRU56fdxArnmDVsAyim9zhU84BsxkUy-Yin19E7cQ@mail.gmail.com>
Message-ID: <CAL_JsqKjZvRU56fdxArnmDVsAyim9zhU84BsxkUy-Yin19E7cQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: add bindings for USB physical connector
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 2:10 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 19.02.2018 15:28, Rob Herring wrote:
>> On Thu, Feb 15, 2018 at 11:39:15AM +0100, Andrzej Hajda wrote:
>>> These bindings allow to describe most known standard USB connectors
>>> and it should be possible to extend it if necessary.
>>> USB connectors, beside USB can be used to route other protocols,
>>> for example UART, Audio, MHL. In such case every device passing data
>>> through the connector should have appropriate graph bindings.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>> v3:
>>> - removed MHL port (samsung connector will have separate bindings),
>>> - added 2nd example for USB-C,
>>> - improved formatting
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
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>
>>> dt-bindings: add bindings for USB physical connector v3
>>> ---
>>>  .../bindings/connector/usb-connector.txt           | 74 ++++++++++++++++++++++
>>>  1 file changed, 74 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> new file mode 100644
>>> index 000000000000..1efda92639da
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> @@ -0,0 +1,74 @@
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
>>> +
>>> +Optional properties:
>>> +- label: symbolic name for the connector,
>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>>> +  non-standard (large) connector sizes: "mini", "micro".
>> The smaller connectors are standard too. Perhaps "non-fullsize connector
>> sizes".
>
> The word "standard" is used in specs, but your description looks better,
> maybe even shorter version would work: "non-fullsize connectors:".

Sure.

>> We're missing a micro-AB connector, but I think those are actually
>> pretty rare. Most phones are micro-B connectors, but do both host and
>> device.
>>
>>> +
>>> +Required nodes:
>>> +- any data bus to the connector should be modeled using the OF graph bindings
>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>>> +  the connector. Since single connector can have multpile data buses every bus
>>> +  has assigned OF graph port number as follows:
>>> +    0: High Speed (HS), present in all connectors,
>>> +    1: Super Speed (SS), present in SS capable connectors,
>> This should also say endpoint 0 is USB-SS, endpoint 1 (and higher?) is
>> Alternate Mode. And show in the example.
>
> What if there is SS mux before, which muxes USB-SS and DP lines. In my
> case the mux is located in USB-PHY (it is 2nd example below).
> In such case there is only one graph connection to SS port and this
> connection will handle both USB-SS and AltMode traffic.

Ah yes, good point.

> Anyway from USB-C connector's point of view, there is no distinction
> which lines are USB-SS, which are AltMode. In fact platform decides in
> real time about muxing of SS and AltMode signals, as it depends on
> cable/plug orientations. Maybe instead of mapping endpoint numbers to
> SS/AltMode, we should map them to SS1/SS2 lines if necessary(???).
>
> To be sure of your intentions. Do you want to model simple SS muxes as a
> part of USB-C connector?

That was, but you are right. That should be part of whatever device
does the muxing.

Given you need a uC just to manage the USB-C connector, I'd guess
there isn't any simple case like just a GPIO to control a mux.

>
>>> +    2: Sideband use (SBU), present in USB-C.
>>> +
>>> +Examples
>>> +--------
>>> +
>>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>>> +
>>> +muic-max77843@66 {
>>> +    ...
>>> +    usb_con: connector {
>>> +            compatible = "usb-b-connector";
>>> +            label = "micro-USB";
>>> +            type = "micro";
>>> +    };
>>> +};
>>> +
>>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort:
>> Having SBU to DP but no DP video path connection is wrong.
>
> But it is real hardware :)
> As I said earlier, DP video lines are connected to mux in USB3-PHY.
> I can add this explanation to the description to make it clear.

Okay.

Rob
