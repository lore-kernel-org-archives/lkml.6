Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3367865-1522821946-2-1044935199455253971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522821945; b=J7hLA//fPNQgUeuw+7UY/Nb2Kl7HKWQZby6BH2pKyMMESIydQX
    EOTbOBlrHpfNjHVjxpGp0RQxaltl50dlcEm+yERJjHITQcKmypC1fKtlrt/TJmX4
    VSLQgPLra92fluwKMpY06B/rJGWIY/uNnSq4khDtMIksRqLNgIITq4qazy61j6S+
    +SNwzZ6p7bTEmnRnPqbHMbVrVvjTpDEaErxb8hGY/WFMWZVeAabj5gYakSEzwAEb
    2o/fxP1MMzZE6jTpN3BVb9/TOTTlgX5z6vMRdgXl0mK4FBFOPYzor1f4godGZBbF
    fnPxRPBayqk7PftIbdrkbOGP8Sxl1cOaF/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1522821945; bh=H3qdgkS5o/uF/cd1K5ZaKivDlCU1EAadE30IeMr5oY
    4=; b=E7TuUKYqJKwex512v4Mrpg9jFZxJV8WCcI1JcrAseTySCqEraiSjkB4T0Q
    Z4i6rvInvnvyQ5IUnIuSQxHrslka+5XyulTtU53SuOqbAK1NzPnoZuCNfGQdCpQv
    GCSc7h9XmqjVXO7C8DiltPPAWaVxWrr3UvqNbpwgvzYfOLgzOxLUqpmIMuOuUwap
    wbDfCgirl3sqm3fxLfALgWPrCQ83rsMR1pFGyHB/q4E9Stp/0eEc9gPp4tOq0GZA
    6UZz3hikZUn0ALqBUd6naOw5aec7K/lOVF6DmFA7NMUF4CxZ/T/H7dJjHoGSVL9C
    rOmf3YxbY6jk3OrocC/i0VR7A3Bw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfABlljNQDpV+j4L+jQ3j01xbXKYJi5t+nxCztI62SDAD4tNdxokTJZTEAgw6OoYJacbWKW+YHQ92vNZ2aQLuxpN5CvyoHsDFvnwN5ZhHNXSzr/+rOaKC
    8EjiFSlUcjuzAGyHFQgI74gSRC7G32j6JUKoq0ht/O7ODAT5I0X+tR8eJ8EQcq08e2Qpo9+ZTjX/zdqh5ZijeWl8sXBRQL94wiHeBE/SMfZak27tCxrv6jH0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=c-n4J4-pAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=4FwyAHxBS4OzM0IwyykA:9
    a=6d9TdlnKWSMP8Hgw:21 a=TXkVFoX-Zk_3_g-Y:21 a=EmdIgSArK1UA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeDDGF3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 02:05:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:28373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDGF2 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 4 Apr 2018 02:05:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="188497261"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
In-Reply-To: <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com> <87vad7cz2i.fsf@linux.intel.com> <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
Date: Wed, 04 Apr 2018 09:04:43 +0300
Message-ID: <87po3fcxs4.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> 2018-04-04 14:36 GMT+09:00 Felipe Balbi <felipe.balbi@linux.intel.com>:
>>
>> Hi,
>>
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>> Currently, DWC3 core IP (drivers/usb/dwc3/core.c)
>>> can take only one PHY phandle for each of SS, HS.
>>> (phy-names DT property is "usb2-phy" and "usb3-phy" for each)
>>
>> We never had any other requirements :-)
>>
>>> The DWC3 core IP is provided by Synopsys,
>>> but some SoC-dependent parts (a.k.a glue-layer)
>>> are implemented by SoC venders.
>>>
>>> The number of connected PHY instances are SoC-dependent.
>>>
>>> If you look at generic drivers such as
>>>   drivers/usb/host/ehci-platform.c
>>> the driver can handle arbitrary number of PHY instances.
>>>
>>> However, as mentioned above, DWC3 core allows only one PHY phandle
>>> for each SS/HS.
>>> This can result in a strange DT structure.
>>>
>>> For example, Socionext PXs3 SoC is integrated with 2 instances of DWC3.
>>>
>>> The instance 0 of DWC3 is connected with 2 super-speed PHYs.
>>
>> why 2 super-speed phys? Is this a two-port host-only implementation?
>
>
> Socionext SoCs only support the host-mode.
>
>
> The instance 0 has 2 ports.
> In our integration, 1 SS PHY is needed for each port.
> That's why it needs 2 SS PHYs.
>
> Each DWC3 instance is connected with
> multiple HS PHYs and multiple SS PHYs,
> depending on the number of ports.

in that case, you shouldn't need dwc3 at all. A Host-only dwc3 is xHCI
compliant. If you really don't have the gadget block, there's no need
for you to use dwc3. Just use xhci-plat directly.

>>> Is this OK?
>>
>> I don't know, I need a bit more details about your integration :-)
>
>
> I can send a patch.
>
> My concern is the following commit.
> I do not know which parts are using this lookups.

Samsung SoCs, probably ;-)

Anyway, if your IP really is host-only, then you don't need dwc3 for
anything. Just go for xHCI directly. If xHCI needs to be extended when
it comes to PHY, then you can discuss with Mathias Nyman :-)

-- 
balbi
