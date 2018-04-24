Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2115912-1524532716-2-16697016968889226816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524532715; b=wI0VwTR6FSsagEBEFXeANx0a5s2/tGGk6ya1B+3wqPxGn2si06
    GytUlPsgtXlK1lqS0HSlJ0Ii4guTT4NsizSdwXg4w0oBkvYZL+TG3J2EAlP2Dr56
    eSfKpFdOWByN05CJu39zVuN7M13irksh0U7g+6kV2rm/u7Wf2dKspvyxkkEfywWe
    cAhxzyzDz47AR7lLOu3ijcZgLe+bDTBfO0lewssJ12TQT1tky/Oj6dzVjXdOlMSP
    dbtg6FWNAdHnKsLGVArb3oF8XCeDUM301APQY0qnk0xf0v12q/H1gGB9dfdiFevh
    LOEdrhszuOzAm20OhAvYBeYesmQ6odDSr8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524532715; bh=mAaW6uu0KbkvGKT7hV/ZRhDGiwSeMe/CIUB6TyofBE
    E=; b=hMtMrRWzcRJhlL7mIMq2J0w1Xrtar++hxyTXsdQgdpBNQy6+YbQ9nx103l
    4hnxjTm388bVo7yXdO3eFFfqRZq+kF++D3g2Jrsku/Lnk5uoS7XfRhm045Df64lH
    vuKcv20k62kPrdX7zy8FL0PEynn63ZM5B6PGeWkqmnUpwP48wDM8TLuXGTzYO4BL
    V1asNWyvRle3P1z6aDqwMUDkYl+o0x2rzbS0jrMmtrlOmgFE13XOo8mR1dsHEBBy
    qWI5m/M+9o+bwVc/kGKDUPwBIXdtinyvSGY3vRImZCduGXEza+hmDKGW7+BonGfw
    hCRhkumDv46JjoWG9sylZxNfCr4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=Se6A50RS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=Se6A50RS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI2X4T6jKd+srJcR846WdVy1Jfv+eXv7FpgvrycJeAOTp1HdiukcUQYKhy7b+qbP9ap43Y8gF82i7hzki3eYzn5ii2N76o8uB+Ny/dPp9MYDcIGXmANw
    qmo0EPI6hPJiuwuM3xS/xlteBbqhMY0WVNfXAKAM06N8TVgIqmnuxaPT5EKwqqK9w+/6JFRs6TKIPh5NI47VhFgMpipB3RSn14uaoWz4FsgIeiMHCsM1T2j2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=mK_AVkanAAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=CxsCZCKxLsY8G-SP4nAA:9
    a=Z9lUPhvjD15z3R21:21 a=978Q8b0q1e5vdpPA:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=3gWm3jAn84ENXaBijsEo:22 a=L0NDqeB7ZLmQzAogN4cw:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbeDXBSW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 21:18:22 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:38729 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeDXBSU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 21:18:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3O1HsLE000427
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AIpwx49o3J8FssW4L0f9kU+urmi9GITGA6Tt/BXBCVDyGtLeYxbYO0oChIdp75qzTlTnT4GKOcHOGBZP4bqXufntjqk=
MIME-Version: 1.0
In-Reply-To: <CAFBinCDwbyovMZ-qAKaMiBfz_YKMwxC1c4MjfNyLAvnXEfXtMw@mail.gmail.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com> <CAFBinCDwbyovMZ-qAKaMiBfz_YKMwxC1c4MjfNyLAvnXEfXtMw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 24 Apr 2018 10:17:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATN+Dp3MRQbELzd4G+cy614dGDDTM_=0a-LB8QzWj7k9w@mail.gmail.com>
Message-ID: <CAK7LNATN+Dp3MRQbELzd4G+cy614dGDDTM_=0a-LB8QzWj7k9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-24 2:44 GMT+09:00 Martin Blumenstingl
<martin.blumenstingl@googlemail.com>:
> Hello,
>
> On Thu, Apr 19, 2018 at 1:03 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Historically, the clocks and resets are handled on the glue layer
>> side instead of the DWC3 core.  For simple cases, dwc3-of-simple.c
>> takes care of arbitrary number of clocks and resets.  The DT node
>> structure typically looks like as follows:
>>
>>   dwc3-glue {
>>           compatible = "foo,dwc3";
>>           clocks = ...;
>>           resets = ...;
>>           ...
>>
>>           dwc3 {
>>                   compatible = "snps,dwc3";
>>                   ...
>>           };
>>   }
>>
>> By supporting the clocks and the reset in the dwc3/core.c, it will
>> be turned into a single node:
>>
>>   dwc3 {
>>           compatible = "foo,dwc3", "snps,dwc3";
>>           clocks = ...;
>>           resets = ...;
>>           ...
>>   }
>>
>> This commit adds the binding of clocks and resets specific to this IP.
>> The number of clocks should generally be the same across SoCs, it is
>> just some SoCs either tie clocks together or do not provide software
>> control of some of the clocks.
>>
>> I took the clock names from the Synopsys datasheet: "ref" (ref_clk),
>> "bus_early" (bus_clk_early), and "suspend" (suspend_clk).
> looking at the code: this could mean that dwc3-exynos.c can be removed
> mid-term (assuming the PHY and regulator handling can be
> moved/removed/changed)

That is a good news.



> does the datasheet state anything about the clock speeds? from
> Documentation/devicetree/bindings/usb/dwc3-xilinx.txt:
> "bus_clk" Master/Core clock, have to be >= 125 MHz for SS operation
> and >= 60MHz for HS operation


Not sure.
"xlnx,zynqmp-dwc3" is a member of dwc3-of-simple.c
which just enables/disables clocks.

That information is not important.


>> I found only one reset line in the datasheet, hence the reset-names
>> property is omitted.
> does the datasheet state whether this is a level or a pulsed reset line?
> on Amlogic Meson GXL, GXM and AXG SoCs we use a pulsed (and shared)
> reset line (see ff0a632f08759e "usb: dwc3: of-simple: add support for
> shared and pulsed reset lines") because the reset line is shared
> between various components (USB2 PHY, USB3 PHY, dwc3 controller, ...)
> your current approach (having a vendor-specific "foo,dwc3" binding
> along with the generic "snps,dwc3") would allow having
> per-"of_device_id" settings which could indicate whether the reset
> lines are level or pulsed reset if these are "implementation specific"


I guess your commit
ff0a632f08759e31f45b06fee27bc71c826c6b11
is wrong.


About the clocks, Rob Herring pointed out:

  However, this should be specific as to how many clocks and their
  function. This should be readily available to someone with access to
  Synopsys datasheet. The number of clocks should generally be the same
  across SoCs, it is just some SoCs either tie clocks together or don't
  provide s/w control of some of the clocks.



The same applies to the reset control.
The reset policy should be the same across SoCs
since we are using the same IP (i.e. the same delivered RTL).


You are using a pulse reset for DWC3
just because the reset controller in your SoC
is implemented like that.

This is NOT because your DWC3 in your SoC is
specially customized, right?

You put a reset-provider matter to a reset-consumer.





>> Supporting those clocks and resets is the requirement for new platforms.
> just to confirm:
> with this series your goal is to replace the wrapper node which is
> needed due to dwc3-of-simple.c ?


In my _hope_.

But, I cannot do this by myself
since I do not have such boards.

Depends on how people make efforts to covert existing platforms.


> would other drivers which currently create a wrapper node (like
> dwc3-keystone.c) keep their wrapper node or do you have any plans for
> removing it for the other "wrapper" drivers too?


We need to take a close look per driver.

Looking at the dwc3-keystone.c,
it works like an interrupt controller with irq-domain hierarchy.
If it is moved to the irqchip subsystem,
dwc3-keystone.c could be removed.


>> Enforcing the new binding breaks existing platforms since they specify
>> clocks and resets in their glue layer node, but nothing in the core
>> node.  I listed such exceptional cases in the DT binding.  The driver
>> code is loosened up to accept no clock/reset.  This change is based
>> on the discussion [1].
> (snip)
>
> Regards
> Martin



-- 
Best Regards
Masahiro Yamada
