Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164579-1523280775-2-17892336673073403885
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523280775; b=wf5YqpsrEAAvkBi2eSfZW8o60WFUjltXvj0D9PSC8uvdDFf1ML
    XyBMEY8ka2y1bnFOnWUGl4hT7fL+7EgL/zciNIi/Fn6HJjeC6SApz34qNclru8ab
    dAPYENQltZQEuy3Pm2ltWavI8OKgUhHCOX5YXU8/9MeY+DxXSY1zLW8lUBEULsOp
    Bb5kuOJFAGYUb+sEodyTjeW7U3tXt/v4Ld0uxACo2bbABjzlijZLtkBtaN6TaYcB
    xuLecM5xL2wqium1yMTHg848lE7fAMEBzTGAimWb+fA27rj1sciw6rbYucO7MWsk
    LHcpTYjOyZTynL+h8K25LKhsIDJ0WVRa8gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523280775; bh=PXm/kZZplnFN825kx3wNpiW7yANgZCAbh7sYfEqL7h
    E=; b=wfWgEgOfK0VP+n/PpvJaFj+dAgBxWBFuD2gpqmG5UYcV2Jtqs3nCyMWjAG
    IHY/tYg4N6JdBCJXu2RDj4F9c7CMAfN59wzXiFKny9xalQ+aZrarsw+23IL/l5v5
    kRB4RAm4uqHKK0OjyUc3zObaRyI086KRAOCcbpXzcROf2/t66q3NqV+1htVe5K3N
    NEtO8zfJGFFR+2Xh+hidfoEv39A7RdMXkPn2uApklaGCDA4RtLrlrMTLeGgS+bRg
    qc49VBuFTJCpb1WNRcv+aSVJo7DIW0iBYOocnz3KbwGk6wRyH7e4xTQs3IlyrBR0
    fOu2H8IEyAwRenbIA7mMNGuQJd6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAlyV9TmUlrDnRrNMjuEk+DoGjffxZNBxcCVEp3XrsBhmUnt8gxhnLd2Boi7VDAgrWMougUMvEF7pjj57/esgZ/BjI4JI2TWCnpbZBoLxaJ6NnwXXc8q
    /CbbqUfrVlXrngEezn1q42btYMkzRtg1Pf+fpaWlM+34mLH4Fg1YGh975Ql1uI83cn9kesjSz+aP6OUiFq5ebUIi+kKVOVGXzBEC/vE9g10IDrInT1UQWc9J
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=yA3rI6-E96diDjWMYaYA:9
    a=UHAfCyYiKH0xDiRG:21 a=B80H-sZvkSca27oI:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDINci (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 09:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752688AbeDINcd (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 9 Apr 2018 09:32:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E94F217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx4/zqRACXAbF2wTUyu7I+rrz4Ng7ShjclvIEgLep+iCVJAKnSNLj6w9MEHysuPhy7zen+TtrSzSJ20YeWTBfbdY=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQixwNS1djgn3SUp=GUsZ58c+5z-B6ou-4NQykrO6AxMw@mail.gmail.com>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
 <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
 <20180318125209.juoa3gkgdv2djciw@rob-hp-laptop> <CAK7LNAQT8wfAk55c40zrZ15wPh3fnsh=B1ciNfVx4uA-oGi34g@mail.gmail.com>
 <CAK7LNAQixwNS1djgn3SUp=GUsZ58c+5z-B6ou-4NQykrO6AxMw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Apr 2018 08:32:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJkcNZf1gLXVu11u4S4hiCxPcs7p_eS=ArxFG3AeQ21+Q@mail.gmail.com>
Message-ID: <CAL_JsqJkcNZf1gLXVu11u4S4hiCxPcs7p_eS=ArxFG3AeQ21+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc3: add clock and resets
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

On Wed, Mar 28, 2018 at 11:32 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-19 7:37 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Hi Rob,
>>
>> 2018-03-18 21:52 GMT+09:00 Rob Herring <robh@kernel.org>:
>>> On Thu, Mar 15, 2018 at 08:39:58PM +0900, Masahiro Yamada wrote:
>>>> dwc3-of-simple.c only handles arbitrary number of clocks and resets.
>>>> They are both generic enough to be put into the dwc3 core.  For simple
>>>> cases, a nested node structure like follows:
>>>>
>>>>   dwc3-glue {
>>>>           compatible = "foo,dwc3";
>>>>           clocks = ...;
>>>>           resets = ...;
>>>>           ...
>>>>
>>>>           dwc3 {
>>>>                   compatible = "snps,dwc3";
>>>>                   ...
>>>>           };
>>>
>>> I'm not a fan of how this was done.
>>>
>>>
>>>>   }
>>>>
>>>> would be turned into a single node:
>>>>
>>>>   dwc3 {
>>>>           compatible = "foo,dwc3", "snps,dwc3";
>>>>           clocks = ...;
>>>>           resets = ...;
>>>>           ...
>>>>   }
>>>
>>> And yes, this is what I'd prefer.
>>
>>
>>
>> Not only dwc3-of-simple.c, but all dwc3 nodes are
>> written like this.
>>
>>
>> omap_dwc3_1: omap_dwc3_1@48880000 {
>>         compatible = "ti,dwc3";
>>         reg = <0x48880000 0x10000>;
>>         #address-cells = <1>;
>>         #size-cells = <1>;
>>         ranges;
>>         ...
>>
>>         usb1: usb@48890000 {
>>                 compatible = "snps,dwc3";
>>                 reg = <0x48890000 0x17000>;
>>                 ...
>>         };
>> };
>>
>>
>> The glue layer initializes SoC-specific things,
>> then populates the child "snps,dwc3".
>>
>>
>> I think the following structure should work
>> by handling EPROBE_DEFER properly.
>>
>> omap_dwc3_1: omap_dwc3_1@48880000 {
>>         compatible = "ti,dwc3"; (should be "ti,dwc3-glue" or something)
>>         reg = <0x48880000 0x10000>;
>>         ...
>> };
>>
>> usb1: usb@48890000 {
>>         compatible = "snps,dwc3";
>>         reg = <0x48890000 0x17000>;
>>         ...
>> };
>>
>>
>>
>>>>
>>>> I inserted reset_control_deassert() and clk_enable() before the first
>>>> register access, i.e. dwc3_cache_hwparams().
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>>  Documentation/devicetree/bindings/usb/dwc3.txt |   2 +
>>>>  drivers/usb/dwc3/core.c                        | 127 ++++++++++++++++++++++++-
>>>>  drivers/usb/dwc3/core.h                        |   5 +
>>>>  3 files changed, 132 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> index 44e8bab..67e9cfb 100644
>>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>> @@ -9,12 +9,14 @@ Required properties:
>>>>   - interrupts: Interrupts used by the dwc3 controller.
>>>>
>>>>  Optional properties:
>>>> + - clocks: list of phandle and clock specifier pairs
>>>
>>> However, this should be specific as to how many clocks and their
>>> function. This should be readily available to someone with access to
>>> Synopsys datasheet. The number of clocks should generally be the same
>>> across SoCs, it is just some SoCs either tie clocks together or don't
>>> provide s/w control of some of the clocks.
>>
>>
>> Make sense.
>> You also implies this property is mandatory.
>> The number of clocks should be available in the datasheet
>> and no hardware can work with zero clock.
>>
>> However, making it mandatory breaks the binding
>> since the existing DT files do not specify clocks at all
>> in the "snps,dwc3" node.

Because of this it has to be optional. We could list what compatibles
it is optional for and that it is mandatory for new users.

>>
>> Anyway, our current situation:
>>
>> - We have the dwc3-core under the glue layer node
>>   despite they are independent in the CPU address view
>> - We add all sorts of clocks and resets in the glue layer node,
>>   and nothing in the dwc3-core node.
>>
>> If these are design mistake, what should we do?
>>
>> Continue development based on it?
>> If we fix it, how to change the course?
>>
>
> Any insight about this?

We just need to reject new bindings that do things the old way. The
driver will have to support both cases for some time period.


> I think this is rather a general question.
>
> If somebody upstreams a driver without clocks,
> then later it turns out clocks are necessary,
> adding required clocks would break existing platforms
> since clk_get() fails.

We should try to prevent that, but of course that is not always
possible. Unless that platform is deemed unstable and we break
compatibility, we'd have to handle both cases in the driver.

Rob
