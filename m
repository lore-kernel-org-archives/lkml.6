Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3419880-1522821487-2-14326543345072640647
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
    1522821486; b=T33BRu/tPYp+ijLA+OH9fsPsXxAdfytnCIoQwaGFYEkCj9eL5a
    Byp6guJSeJcquQt+8V0oBkQTidin/QkGSxJKfA29UDiP2N32vbT5acFzQmPCfiJl
    ix1Yw6iktLM0weCnFd+BvR4tkZUbhssUwf9bPst2OwalW0g2vOud5ue0A9Q5E2/n
    H7I6TFn2nM9JoO9QmATVbVP/zsoWqARYGcdEwSQcJQkYjnSO2Fpwf0KwFY+Vjrcg
    PU46TUdRJg92MixiAnOi4B2ie3rIyGb37e0qdfhNbVMA+9i9ErBNUS1ySrVyV29h
    2KPzuK+Y4KMZyv/Qiqcdv75JF8vEbLw0Ac4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522821486; bh=i8xkSnV7ujZwTFtV4gmaGUeWfrXW6YDA/X4/KvK7Wh
    I=; b=Dm8MVKTMddjS8jNSzkcrOtC5PPEz0P7m9LdZN4S5CTo8U2Pjtz2MNJB0h8
    CXskznPkiYTXz2+1jKflFerJBdGQOLJboJ/rLznTMJpp+/mvyBVeKFof3gpiDbRi
    lu7ajwIjATMhIakclZr2mtDsQFB11izu4wJMN7e/seZhv07497NOXAk7AJXGbpRy
    SfqBSHKqcasyMsfeswceBpbuRJ1XEWDTnWgAqvFDx8e9MLe/PUNdPLyBlPtXeZ/d
    g1164A9L3zmuq3SIoYqy9bWd3uftsVNAnr5+9ZiXNnWYNX+S8z8Lm5m68Q+JOdxE
    QJkNOhLpfs8eVMNmnC1JBxlUK/ig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=L7TnuOMj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=L7TnuOMj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKr9HOC6oJBScjsRlx1BtKTM3ifq4f108mGWdRSQReDpOlT0mYgDs8fyHVLLexD1Kqo4lpzMf+gVVSRe3AVmAczr4tDhSvT69f6LSae5I3TTnEhILGjn
    XMKPYSF6yx/fpPM0aANmaNuIoHq2pt9iSOfJMOaQzhbuCbIxUy+ta/dAgXjp2HqYL91nDs+Z5vjb6Q44sRM8AXwZDE019oep2oUANIhhBmJjw5Pv5kJFo8bd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=c-n4J4-pAAAA:8 a=hD80L64hAAAA:8 a=sozttTNsAAAA:8
    a=VwQbUJbxAAAA:8 a=TVy3zd6uw09PpBrwNSAA:9 a=h9jQG5mjAnnhVaME:21
    a=yIq40M-QgE8lIaMK:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=L0NDqeB7ZLmQzAogN4cw:22 a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeDDF5w (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 01:57:52 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18458 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeDDF5v (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 01:57:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w345vKOm005182
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AIpwx4+6X3zhc0qIiXy6jTIXoSpHZzW+nV9x9av7eLdgYk/UQqv68UVWdrUlJkf9K1I1UII8h18EwlVnSGWN3USEeJw=
MIME-Version: 1.0
In-Reply-To: <87vad7cz2i.fsf@linux.intel.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
 <87vad7cz2i.fsf@linux.intel.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 14:56:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
Message-ID: <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-04 14:36 GMT+09:00 Felipe Balbi <felipe.balbi@linux.intel.com>:
>
> Hi,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>> Currently, DWC3 core IP (drivers/usb/dwc3/core.c)
>> can take only one PHY phandle for each of SS, HS.
>> (phy-names DT property is "usb2-phy" and "usb3-phy" for each)
>
> We never had any other requirements :-)
>
>> The DWC3 core IP is provided by Synopsys,
>> but some SoC-dependent parts (a.k.a glue-layer)
>> are implemented by SoC venders.
>>
>> The number of connected PHY instances are SoC-dependent.
>>
>> If you look at generic drivers such as
>>   drivers/usb/host/ehci-platform.c
>> the driver can handle arbitrary number of PHY instances.
>>
>> However, as mentioned above, DWC3 core allows only one PHY phandle
>> for each SS/HS.
>> This can result in a strange DT structure.
>>
>> For example, Socionext PXs3 SoC is integrated with 2 instances of DWC3.
>>
>> The instance 0 of DWC3 is connected with 2 super-speed PHYs.
>
> why 2 super-speed phys? Is this a two-port host-only implementation?


Socionext SoCs only support the host-mode.


The instance 0 has 2 ports.
In our integration, 1 SS PHY is needed for each port.
That's why it needs 2 SS PHYs.

Each DWC3 instance is connected with
multiple HS PHYs and multiple SS PHYs,
depending on the number of ports.




>> The instance 1 of DWC3 is connected with 1 super-speed PHY.
>
> Are both of these instances incapable of high/full/low-speed
> communication?

Also HS PHYs are connected.


To narrow down the problem,
I picked up the DT snippet only for SS PHY device nodes.




>> @@ -894,8 +894,8 @@ struct dwc3 {
>>         struct usb_phy          *usb2_phy;
>>         struct usb_phy          *usb3_phy;
>>
>> -       struct phy              *usb2_generic_phy;
>> -       struct phy              *usb3_generic_phy;
>> +       unsigned int            num_phys;
>> +       struct phy              **phys;
>>
>>         bool                    phys_ready;
>>
>>
>>
>> Is this OK?
>
> I don't know, I need a bit more details about your integration :-)


I can send a patch.

My concern is the following commit.
I do not know which parts are using this lookups.




commit 08f871a3aca252b15107fc37dedcdacbac80fdb5
Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Wed Nov 19 17:28:23 2014 +0200

    usb: dwc3: host: convey the PHYs to xhci

    On some platforms a PHY may need to be handled also in the
    host controller driver. Exynos5420 SoC requires some "PHY
    tuning" based on the USB speed. This patch delivers dwc3's
    PHYs to the xhci platform device when it's created.

    Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
    Tested-by: Vivek Gautam <gautam.vivek@samsung.com>
    Acked-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

-- 
Best Regards
Masahiro Yamada
