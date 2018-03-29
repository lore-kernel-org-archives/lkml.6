Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3973300-1522298017-2-11058367938635895354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522298016; b=SPdvDKSYsF2GkWfzYGIygAHoB7oaymMRdifrhPF4f5PDh9U
    pyhJPs9Fy4Od7wRXYAil24+ZmKptwKC60+19G181+XgooGSvzWLK56Ynlm4olmBV
    KtdKq/tFc71ZrBYS8Lbh5GAwTKcofKls6BLymQvMZXOQS8BbkGCXldXtFzHR2EZ+
    XvIP8UFhlgUKiMwCTGkwx8GVz3EfN5cFKYr2L6li6bju5JDibhzh0He38j3MQt79
    1oYe05WLfUahT6fSu784KZtDmDJVY5UAacqgEUzTQ4j98/hAWi6n9D122CE3r5jw
    cTl7emVL5v1IFgLISCLMJ+Nu+nHDafWxIciBo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1522298016; bh=iMrLkd6ixxqtSypEbu9WOMLoGnSsDI2dpEHQxT
    01m00=; b=q4Nc5cGPPJ/TFf4Bw3PECfzJvBk/bD4jfmlA6/VNY5E/ZVJ1fDWCQg
    xY7U6P+5LSMHK0825AEaW6AHXnY/Y4Rs8vpBt28EMnYNXLS3Q6kow59fpF7GuUMw
    fFKbLUZudwxP90D8XBC91NToU+vIdcmRYzmSmJYOwcf37lE9QLiaxsGEz5XX8thp
    6F33/2oezuU5x7vcvbqCXy1vURKHXc4JK3h7LE07CK/S+1jbKbsoGPCCuPUhMfWy
    rIkJPa0RmCjaTpMMzEWo6hrDmoBw9YTG4iDzTBVaSBhkwkQYksFHBcDm/cPhgIRJ
    oD42mTTtm9/vrLxwRojemZKHt/+H6Iwg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=W2xeEWhd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
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
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=W2xeEWhd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtp2sMpE0cvs/X1YLduQ9Fc6qro/OkF7dU1mVXzOhbHvexrnjokH9qK7ECduvrC2tjhvyFHnJxyiQnB1J1Yq8LePN+SfjIIHcq4iZQWx37H/3za5q56
    9Ns3XkGl+M63PwqqfRt3AOHuIwIUreUUsiK3CLRD6ZXvLjMRAtUDx6womHpQpCN2IVIvF++FhBkkmhZndoBrKTRhqks2AcN8Y/CavEq97xrYgHhiUYHkt+fO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=vNf8uVRErFToEVxguwQA:9
    a=TSZEVQPXzDa_SFRT:21 a=X2lTE4POtgJNLLHU:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeC2EdX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 00:33:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:22352 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeC2EdV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 29 Mar 2018 00:33:21 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2T4XFsA027667
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AIpwx4/sfL9SKFCnhbh0+kkSc85Gj91TaBGdchCMbNbKgTcCGLhfL5pxyDgYW3Vs7/4ftyLJ6fZuJg4NLy2Ew+Gq7YQ=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQT8wfAk55c40zrZ15wPh3fnsh=B1ciNfVx4uA-oGi34g@mail.gmail.com>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
 <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
 <20180318125209.juoa3gkgdv2djciw@rob-hp-laptop> <CAK7LNAQT8wfAk55c40zrZ15wPh3fnsh=B1ciNfVx4uA-oGi34g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 29 Mar 2018 13:32:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQixwNS1djgn3SUp=GUsZ58c+5z-B6ou-4NQykrO6AxMw@mail.gmail.com>
Message-ID: <CAK7LNAQixwNS1djgn3SUp=GUsZ58c+5z-B6ou-4NQykrO6AxMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc3: add clock and resets
To: Rob Herring <robh@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-19 7:37 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Rob,
>
> 2018-03-18 21:52 GMT+09:00 Rob Herring <robh@kernel.org>:
>> On Thu, Mar 15, 2018 at 08:39:58PM +0900, Masahiro Yamada wrote:
>>> dwc3-of-simple.c only handles arbitrary number of clocks and resets.
>>> They are both generic enough to be put into the dwc3 core.  For simple
>>> cases, a nested node structure like follows:
>>>
>>>   dwc3-glue {
>>>           compatible = "foo,dwc3";
>>>           clocks = ...;
>>>           resets = ...;
>>>           ...
>>>
>>>           dwc3 {
>>>                   compatible = "snps,dwc3";
>>>                   ...
>>>           };
>>
>> I'm not a fan of how this was done.
>>
>>
>>>   }
>>>
>>> would be turned into a single node:
>>>
>>>   dwc3 {
>>>           compatible = "foo,dwc3", "snps,dwc3";
>>>           clocks = ...;
>>>           resets = ...;
>>>           ...
>>>   }
>>
>> And yes, this is what I'd prefer.
>
>
>
> Not only dwc3-of-simple.c, but all dwc3 nodes are
> written like this.
>
>
> omap_dwc3_1: omap_dwc3_1@48880000 {
>         compatible = "ti,dwc3";
>         reg = <0x48880000 0x10000>;
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges;
>         ...
>
>         usb1: usb@48890000 {
>                 compatible = "snps,dwc3";
>                 reg = <0x48890000 0x17000>;
>                 ...
>         };
> };
>
>
> The glue layer initializes SoC-specific things,
> then populates the child "snps,dwc3".
>
>
> I think the following structure should work
> by handling EPROBE_DEFER properly.
>
> omap_dwc3_1: omap_dwc3_1@48880000 {
>         compatible = "ti,dwc3"; (should be "ti,dwc3-glue" or something)
>         reg = <0x48880000 0x10000>;
>         ...
> };
>
> usb1: usb@48890000 {
>         compatible = "snps,dwc3";
>         reg = <0x48890000 0x17000>;
>         ...
> };
>
>
>
>>>
>>> I inserted reset_control_deassert() and clk_enable() before the first
>>> register access, i.e. dwc3_cache_hwparams().
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/usb/dwc3.txt |   2 +
>>>  drivers/usb/dwc3/core.c                        | 127 ++++++++++++++++++++++++-
>>>  drivers/usb/dwc3/core.h                        |   5 +
>>>  3 files changed, 132 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> index 44e8bab..67e9cfb 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> @@ -9,12 +9,14 @@ Required properties:
>>>   - interrupts: Interrupts used by the dwc3 controller.
>>>
>>>  Optional properties:
>>> + - clocks: list of phandle and clock specifier pairs
>>
>> However, this should be specific as to how many clocks and their
>> function. This should be readily available to someone with access to
>> Synopsys datasheet. The number of clocks should generally be the same
>> across SoCs, it is just some SoCs either tie clocks together or don't
>> provide s/w control of some of the clocks.
>
>
> Make sense.
> You also implies this property is mandatory.
> The number of clocks should be available in the datasheet
> and no hardware can work with zero clock.
>
> However, making it mandatory breaks the binding
> since the existing DT files do not specify clocks at all
> in the "snps,dwc3" node.
>
>
>
> Anyway, our current situation:
>
> - We have the dwc3-core under the glue layer node
>   despite they are independent in the CPU address view
> - We add all sorts of clocks and resets in the glue layer node,
>   and nothing in the dwc3-core node.
>
> If these are design mistake, what should we do?
>
> Continue development based on it?
> If we fix it, how to change the course?
>

Any insight about this?


I think this is rather a general question.

If somebody upstreams a driver without clocks,
then later it turns out clocks are necessary,
adding required clocks would break existing platforms
since clk_get() fails.


-- 
Best Regards
Masahiro Yamada
