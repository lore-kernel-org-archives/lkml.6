Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68257-1521114397-2-8344446760129958301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521114396; b=VeTiyyKujPJH459Nex2u5cHMcvpZm4m1raVjWp9VoHAFtEU
    4r0AXHEFxbOIBF6/Xtqwbg9PBp71/v6PvHDb1kWsd4ivTDOrhxccWZaBw6So9RyS
    AJELDIwaNexfKu9yLnS7um+Q09gL16dJyJ/1MI9Erj3nZ8sggpjJSNCxI7e2VZaz
    Qgi3/Pdi7Zu+T20RUdsKFjp3Kvqx3Lmf8wm+UrI3rc4xOcIZamtdwi3p8ukkI9L0
    BMBKQnShcNvSHhXGl4BdpN8YmpAgrq8KVg5e/WPywUnTMolPs3IrW+NSWmXMdZIX
    muiFcFbOavb2GQyzwKeWgO+Ff3VRdhgC5AzCbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521114396; bh=Uu9OZvFgFYCYIhezjOgcK05+IsbjVbv/7dQQ4ezbNX4=; b=I
    NvDTJMGgP44E/Vm9kEsHxopy4Ty6/G6mguxqKKtOgrHjr1/1O1himFaqRANg2BSa
    +6oluAcHKVDEpgtkNfiyIanuYGLZPU+/iVo9UOE7O06XDIPaRMzW7q6voPm/15H2
    54TgHsJyi8tUb7L8wgn1EvfXyIrylv2/9hzjTVKeKs/Cat3CwMlFXojjzzik7L6/
    L+EUa3+6UqnVLtinjKSNfSex+qFcGXA9UWTx0QPHLw0P05ZHUpdS6gYkkDZHOnHG
    t+A0Bjya1oxdkZU1oIecpvQXT/EC4WpNl3LGciH6ElyVuG8BlOYdNAlUquNKtkdz
    ytO/IO5QWcQZpJOkOoMQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCOLqX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 07:46:23 -0400
Received: from foss.arm.com ([217.140.101.70]:37588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOLqV (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 07:46:21 -0400
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
To: Roger Quadros <rogerq@ti.com>, Andrzej Hajda <a.hajda@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-samsung-soc@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
 <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
 <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
 <12da0d00-9ab3-3752-793b-e487666f35a3@ti.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c3f8cde-4f9a-306f-b4f9-c0bdc76caf1f@arm.com>
Date: Thu, 15 Mar 2018 11:46:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12da0d00-9ab3-3752-793b-e487666f35a3@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/03/18 10:41, Roger Quadros wrote:
[...]
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
>>
>> I have proposed such property (and size also) in my first RFC [1]. Rod
>> did not like it :)
>>
>> [1]: https://marc.info/?l=devicetree&m=150660411515233&w=2
>>
> 
> This is what Rob says here https://patchwork.kernel.org/patch/9976043/
> "We did "type" for hdmi-connector, but I think I'd really prefer
> compatible be used to distinguish as least where it may matter to s/w.
> In the HDMI case, they all are pretty much the same, just different
> physical size."
> 
> So the question is. Does it matter to this particular software implementation
> if it is type A,B,C connector?
> If yes, how?
> 
> Type A will never have any alternate function. It is always dedicated to USB.

In USB spec terms, at least. In reality there are things like the cool 
trick Rockchip SoCs do whereby they can expose the debug UART Rx/Tx 
through the OTG port's D+/D- pins, and that is on a type A connector in 
many products. I'm guessing that's probably beyond the scope of this 
binding, though.

> Also does the size "full", "micro", "mini" matter to software?

If it means the user can look in sysfs to easily correlate logical ports 
with physical connectors that's certainly handy (e.g. on something like 
Odroid-XU where the two USB3 ports are brought out to an A and a 
micro-AB connector respectively).

Robin.
