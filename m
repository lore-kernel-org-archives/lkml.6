Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3640711-1522827152-2-17167236947405863398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522827152; b=Iemep3Ga21A3IEH/zmUi8eDubhFQ5OR4IDV7uADaHx2rVL5V5m
    qlZwvBMhhs7sL27APdQfFc8nTffEhSIh3sv4YkctS5pOWKztkiQl4kPn5NjZrcCX
    rKy4Us8iN6aU4J5aQyMA6C0IhkD5auBFhW+OH+7lK//h2YJ3Vf7bqhj7KqJ9Yobc
    lFigMUWSYZKHMMZosHXXfJk4p1s7bcX9nIB9+YA8QB9CEg9OGs4RU+TV6WPiiqzU
    qIjTTri/hbQYLiRT9NpLhJSgqzqFS7W5eaWauEF0WcwoPa3HVFE6peshDAv6oh68
    GXqNm0htJ5k+Bpm5yeDPHU5go8ajTMrdUqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522827152; bh=HbtCWNaxhfrAUv7Cbo7IFBPABohrFJuDapsuloeDcb
    c=; b=BnbMoN+g4Z8AWjeVPMwjRQ+A6mG0NIQ6S+QqPMBHkgjtN0AwTUtaEj8igA
    tOJT/rd2SSg5ZJF4A+3G7AXS4kXVseXlTEjcxLjkr+Dc4+RI32cRxD6aZ31U4alf
    dUroUA7heIuEM9Ft2oTZ3TKLNZMaQizSTsq4evD1Us/WjLcCHZnQFlAxGTsaztql
    1qK9OWaZR6dCR8iV0tbGXAj9nSvZOvj2p//H6eL4OXHNd65PAlICwHgnS/PAqx+o
    WFKikQITuPaEvAhnzmGk5jZz/JnyBgdIW9wQtIOkJiL8XEGgmHCFdVSbadEF/NwQ
    4uMo5hzHK4uQb+byHOnIPOH/bXFg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=cXLpIfu6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=cXLpIfu6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG2tq1p3oR10Q36vN7fv8gh2j9EK7keHYvY80olF/VRAB/GMLDYS4lApMb2JfIXFXNmy9OOkSsG+Uf9I/OVdhIHnRDm4Ner+w7mJCMGCCel4uWj6MR4h
    hb5DihFS2OX2hb3Sxc8ErmMPIZu49CffJIYj165vcsse7M8s6+2dwzWh1WSrSLsDHrgtoKv4JN2t6qk/9I7wYpBADohrzxpFkc/EYSlbyVfbJqQ3qMNKW5Yq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=09CjQJU8wGVpPHk8s-UA:9
    a=ZLrHXWeNoli3yZFC:21 a=r93GzhdFKCLOrhCR:21 a=QEXdDO2ut3YA:10
    a=EmdIgSArK1UA:10 a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeDDHcS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 03:32:18 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36860 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDHcQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 03:32:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w347W28Z012932
X-Nifty-SrcIP: [209.85.213.45]
X-Google-Smtp-Source: AIpwx481Ghuxn40R6HnlTtffMdi68KI0+sAb7SSG9/RKtGseVhT3GHR0C5UFjQbhJ8ptCq269bpFA52X9Asaz1RbUSE=
MIME-Version: 1.0
In-Reply-To: <87po3fcxs4.fsf@linux.intel.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
 <87vad7cz2i.fsf@linux.intel.com> <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
 <87po3fcxs4.fsf@linux.intel.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 16:31:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpFZYK-f4j7sJpur-u43bK1gsz_eS1wurTq7C+n6pHAw@mail.gmail.com>
Message-ID: <CAK7LNATpFZYK-f4j7sJpur-u43bK1gsz_eS1wurTq7C+n6pHAw@mail.gmail.com>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-04 15:04 GMT+09:00 Felipe Balbi <felipe.balbi@linux.intel.com>:
>
> Hi,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>> 2018-04-04 14:36 GMT+09:00 Felipe Balbi <felipe.balbi@linux.intel.com>:
>>>
>>> Hi,
>>>
>>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>> Currently, DWC3 core IP (drivers/usb/dwc3/core.c)
>>>> can take only one PHY phandle for each of SS, HS.
>>>> (phy-names DT property is "usb2-phy" and "usb3-phy" for each)
>>>
>>> We never had any other requirements :-)
>>>
>>>> The DWC3 core IP is provided by Synopsys,
>>>> but some SoC-dependent parts (a.k.a glue-layer)
>>>> are implemented by SoC venders.
>>>>
>>>> The number of connected PHY instances are SoC-dependent.
>>>>
>>>> If you look at generic drivers such as
>>>>   drivers/usb/host/ehci-platform.c
>>>> the driver can handle arbitrary number of PHY instances.
>>>>
>>>> However, as mentioned above, DWC3 core allows only one PHY phandle
>>>> for each SS/HS.
>>>> This can result in a strange DT structure.
>>>>
>>>> For example, Socionext PXs3 SoC is integrated with 2 instances of DWC3.
>>>>
>>>> The instance 0 of DWC3 is connected with 2 super-speed PHYs.
>>>
>>> why 2 super-speed phys? Is this a two-port host-only implementation?
>>
>>
>> Socionext SoCs only support the host-mode.
>>
>>
>> The instance 0 has 2 ports.
>> In our integration, 1 SS PHY is needed for each port.
>> That's why it needs 2 SS PHYs.
>>
>> Each DWC3 instance is connected with
>> multiple HS PHYs and multiple SS PHYs,
>> depending on the number of ports.
>
> in that case, you shouldn't need dwc3 at all. A Host-only dwc3 is xHCI
> compliant. If you really don't have the gadget block, there's no need
> for you to use dwc3. Just use xhci-plat directly.

Sorry, I was misunderstanding.

Some of our SoCs support gadget,
so we need to use the dwc3 driver.


>>>> Is this OK?
>>>
>>> I don't know, I need a bit more details about your integration :-)
>>
>>
>> I can send a patch.
>>
>> My concern is the following commit.
>> I do not know which parts are using this lookups.
>
> Samsung SoCs, probably ;-)
>
> Anyway, if your IP really is host-only, then you don't need dwc3 for
> anything. Just go for xHCI directly. If xHCI needs to be extended when
> it comes to PHY, then you can discuss with Mathias Nyman :-)
>
> --
> balbi



-- 
Best Regards
Masahiro Yamada
