Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1184236-1524883328-2-16405345552711935784
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
    1524883327; b=HHPUUkmf3IXRiBFdQnSX874hO3+jQIdIITPqBHSMXYu5QeKAMD
    lesqEG5llEKUEWO+K+2/0ZbUWM2MsvyS/7kDCzJHogSLs11PGKQB1Rqzg6WQdeq9
    DYWyt5stPgFjm7mW+PklarZKYSF/4osaz0TkAluHKtGD3J4vIP5vTXZXXLkcKdK7
    DPkSz0FMVMwRsExol+Zkc63Diva9KA2yPEOPH72ZKkRduYb92MVYpLcfVR99Gw70
    SIKVBPqWGTmz8KPI6/54GujB0WnQ76fwV2MsdW3zOgl/E310cEi4g6XvKsz0+V1q
    fabuL0+kKKYJBDBXq5/O4SAT2grVj4wjaqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524883327; bh=jKaa04K/4OEZxy6W8vaqqFZr9yTX3tVxgffT1LX+MZ
    4=; b=MIvSGK1P/lG9fciR6J+NCXsb9Os6PTNa8JzMAjLaXMfQj7vymAmSihTPWV
    BNh1ThS/U0f6YhVqfluzrPVTGq/hrIzbyFJTI4dz3OmdEC8bh+Zs8K0Uxv8yZCCJ
    g5NPGsspHs0QeUXhg4Vw3s8Tv44b/22PaUm7+7+wjplaZ/KifsZv5Fl8OYq9QkpO
    K6fmJ2BZaPe6C2oIzLO6B8InCw0X3GMlBErpm1EwupeOSglbYrBD1Te2ZdZUUYmT
    pvBNGbID7EN3dgXTIzWp/ouVD4EunZbRcgTriONPN2xDUobz8WGBWKqJu00Ben78
    KkpT9tIWyK+Nv5OBtF+rAHarieZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=cCzYzVtB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=cCzYzVtB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGJHxDWa5H/p16a3ilSPlbhVUirFpmDlWMRDHuFTVFxNkmFnmhZmx0CV6zdGEyjxE06ONDTHMBXrtjA+9GVCBXo/6iD7c4NCwAmIhIVctW/3dAuDjkmq
    AmY7z7ZvIrlGr/MY6zynxSY1e2iplE6JfIHdPxP8hK/HhPus6gB+yG2R+rMthA3pIaIRCBRmppJVA3lraHm37MoC2Hi8e61uM/oGtdgNUni6It259RcBjkIz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=mK_AVkanAAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=pfnyFxkWYSIjjpj8ANEA:9
    a=k-K-5MDfmC-MtvtA:21 a=5JUPb90s6yLsh3Pb:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=3gWm3jAn84ENXaBijsEo:22 a=L0NDqeB7ZLmQzAogN4cw:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759519AbeD1Cly (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 22:41:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:40263 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1Clw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 27 Apr 2018 22:41:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3S2fiWP012317
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AB8JxZpNSSK4VimSCGNWepBJAIjZj7oyCsi0HhKw85dLQK/LrZXJ4Wy8F85xo5pmyyj5/A5uKGIIxUwmAXADpoD9BmE=
MIME-Version: 1.0
In-Reply-To: <CAFBinCDwbyovMZ-qAKaMiBfz_YKMwxC1c4MjfNyLAvnXEfXtMw@mail.gmail.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com> <CAFBinCDwbyovMZ-qAKaMiBfz_YKMwxC1c4MjfNyLAvnXEfXtMw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 28 Apr 2018 11:41:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCLJWWwsDy7zj1uQNcb8pp8ivcAA=Y_oOUOsFMN+YpSA@mail.gmail.com>
Message-ID: <CAK7LNASCLJWWwsDy7zj1uQNcb8pp8ivcAA=Y_oOUOsFMN+YpSA@mail.gmail.com>
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

Hi Martin,


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
>
> does the datasheet state anything about the clock speeds? from
> Documentation/devicetree/bindings/usb/dwc3-xilinx.txt:
> "bus_clk" Master/Core clock, have to be >= 125 MHz for SS operation
> and >= 60MHz for HS operation
>
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

Let me ask a question about your reset controller.
(drivers/reset/reset-meson.c)

All reset ID supports .reset, .assert, .deassert
Is this correct?


I believe you and I use the same DWC3 core IP.


I suspect the difference is in the reset controller side.

In my case, the reset line is asserted by default.
(that is, all FFs in the RTL are put into the initial state
on power-on)
That's why only reset_deassert() will work for me, I think.

What about your case?  Is the reset line in deassert state on power-on?
Then, the reset must be explicitly pulsed to put FFs into
the initial state.  Is this correct?




-- 
Best Regards
Masahiro Yamada
