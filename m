Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2002674-1524925296-2-11868959229638893586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524925295; b=WhbDmT1xjKCshfKTnmSjhMAUQPiGOCtFIqn/7gAPiwz6A4wvBS
    bKI5919F262t5IBRn9n2UOzUHlcVq16o5SUUSyGTJ/DGsrQn0TTIhbmWX+K2OBSV
    LKq5ZmzKoJBZlL0YyKe61OcTbEk9RMyBewWGKFAJSqBwm1rWhr4dCj9yI4JxIDDB
    lcsMb5ev8sIkqAt4Y7xZsJyKizzUwdSHPw/Cr/vBu1SQhD8W4dSObQh5qar+STac
    W6yo3y2nj2EBvky+U61SLPK1TLT9qSc1PreWjJXCbiYJ4aDRHpOI9WoYTeir2kCO
    Lir22g+MEjtAzK5FCV1Fg7t458Cmr8d89AKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524925295; bh=vXfYnw+6bWVa3GBmRbQL3cD25x0EIN89DVdY6Biu6y
    w=; b=lHcwaQrRjMupIbpwhnhbOAHj1JNrGV2Md9BYr25art+Gsh5EpAp/b0HVkP
    5ypwkd/WpgNKZvwDtwbwz3QGvR8Ehk+GacZymcQ1YbIiJTTrxFMAsvEfSpA1yCpP
    D+jJVNIjcCpB3R+L1ZaGOA+99MqsUN5zdt5WcC3JEz9DCNYdCv77e0Vz+k/lG/pv
    gvbDDDDrfWUZNgEIG3D6Dd3uhxMwrT8KvJCoqpoB94MAmM9XG9Jw9h0Vqti9rNZl
    YcZU6DpoKoVvnZIpbu1Vlr6+I52cVYThHHcdrcMUOo/KilfOb07TtgsN0HnMcZCw
    7KFASGH5thwHZb1Wczd5ADC8RDLw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=WpCSLQE0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=su/J06ht;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=WpCSLQE0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=su/J06ht;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAhwm0Y8ARVJ8HM4uHirYDruDjoiUsNU6sCbl6oq4iRL4vC7SGhOoUjNq2l8IPbtImuv2BKwP1mYiIb6tyYKnQH2m6hXgyAIFZkMy3EdsDtqn8foCAGq
    wmKRDZRi+s+G7tz4jFBbYuHgHweChoDkO9NTB78DDe/4YpCM3Ud2iUv9aM7a1IotnqjsH00DaKdbKrsqEm1DiMoY13JQgOmVvqVSCGY2fU+P6N4uzuXdJ2l7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=25T5d9ZgbPEA:10 a=Kd1tUaAdevIA:10 a=c-n4J4-pAAAA:8 a=mK_AVkanAAAA:8
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=tnaAdXm_djoC8tF6tXMA:9
    a=7MOIemsyGdxoM9Wv:21 a=dfeVCa6pC2CH1Wj1:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=3gWm3jAn84ENXaBijsEo:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeD1OVT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 10:21:19 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42352 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeD1OVR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 28 Apr 2018 10:21:17 -0400
X-Google-Smtp-Source: AB8JxZr+aVFsedVW1TBhGaTjxazIDgGDmeFDjGryiKTyX2Npf4wxa6HcSkPzLZTR32ZCAo4YpSrGHHNhdCktCGmhtmY=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASCLJWWwsDy7zj1uQNcb8pp8ivcAA=Y_oOUOsFMN+YpSA@mail.gmail.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com>
 <CAFBinCDwbyovMZ-qAKaMiBfz_YKMwxC1c4MjfNyLAvnXEfXtMw@mail.gmail.com> <CAK7LNASCLJWWwsDy7zj1uQNcb8pp8ivcAA=Y_oOUOsFMN+YpSA@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 28 Apr 2018 16:20:56 +0200
Message-ID: <CAFBinCCWeTUCK=tN4PfKqNuX2yWQuSVkXuzcKfV476uO88032Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        yixun.lan@amlogic.com
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

(adding Yixun from Amlogic to this mail)

On Sat, Apr 28, 2018 at 4:41 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Martin,
>
>
> 2018-04-24 2:44 GMT+09:00 Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>:
>> Hello,
>>
>> On Thu, Apr 19, 2018 at 1:03 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> Historically, the clocks and resets are handled on the glue layer
>>> side instead of the DWC3 core.  For simple cases, dwc3-of-simple.c
>>> takes care of arbitrary number of clocks and resets.  The DT node
>>> structure typically looks like as follows:
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
>>>   }
>>>
>>> By supporting the clocks and the reset in the dwc3/core.c, it will
>>> be turned into a single node:
>>>
>>>   dwc3 {
>>>           compatible = "foo,dwc3", "snps,dwc3";
>>>           clocks = ...;
>>>           resets = ...;
>>>           ...
>>>   }
>>>
>>> This commit adds the binding of clocks and resets specific to this IP.
>>> The number of clocks should generally be the same across SoCs, it is
>>> just some SoCs either tie clocks together or do not provide software
>>> control of some of the clocks.
>>>
>>> I took the clock names from the Synopsys datasheet: "ref" (ref_clk),
>>> "bus_early" (bus_clk_early), and "suspend" (suspend_clk).
>> looking at the code: this could mean that dwc3-exynos.c can be removed
>> mid-term (assuming the PHY and regulator handling can be
>> moved/removed/changed)
>>
>> does the datasheet state anything about the clock speeds? from
>> Documentation/devicetree/bindings/usb/dwc3-xilinx.txt:
>> "bus_clk" Master/Core clock, have to be >= 125 MHz for SS operation
>> and >= 60MHz for HS operation
>>
>>> I found only one reset line in the datasheet, hence the reset-names
>>> property is omitted.
>> does the datasheet state whether this is a level or a pulsed reset line?
>> on Amlogic Meson GXL, GXM and AXG SoCs we use a pulsed (and shared)
>> reset line (see ff0a632f08759e "usb: dwc3: of-simple: add support for
>> shared and pulsed reset lines") because the reset line is shared
>> between various components (USB2 PHY, USB3 PHY, dwc3 controller, ...)
>> your current approach (having a vendor-specific "foo,dwc3" binding
>> along with the generic "snps,dwc3") would allow having
>> per-"of_device_id" settings which could indicate whether the reset
>> lines are level or pulsed reset if these are "implementation specific"
>
> Let me ask a question about your reset controller.
> (drivers/reset/reset-meson.c)
>
> All reset ID supports .reset, .assert, .deassert
> Is this correct?
as far as I know: yes (though I have only ever verified this with the
Ethernet controller's reset line)

>
> I believe you and I use the same DWC3 core IP.
this is possible - but I am not sure since I don't have access to
Amlogic's internal resources where this should be documented (my
knowledge mostly comes from reading Amlogic's out-of-tree kernel code
and porting that to mainline)

>
> I suspect the difference is in the reset controller side.
>
> In my case, the reset line is asserted by default.
> (that is, all FFs in the RTL are put into the initial state
> on power-on)
> That's why only reset_deassert() will work for me, I think.
>
> What about your case?  Is the reset line in deassert state on power-on?
> Then, the reset must be explicitly pulsed to put FFs into
> the initial state.  Is this correct?
let me give you a bit of context first:
the Amlogic Meson AXG, GXL and GXM SoCs have one reset line for "USB
components". this is shared among:
- the dwc3 controller
- (depending on the SoC) 2 or 3 USB2 PHYs
- a USB3 PHY
- some OTG detection logic within the registers of the USB3 PHY

(there is also a gate clock which is assigned to the same components)

based on my tests I believe that the reset line is "de-asserted" (=
USB components are working) by default.
asserting that reset line should stop the state machine of all USB
components. de-asserting it again should bring all USB components into
a defined state.
(I'm not sure though if these are HW defaults or if there's some logic
in the bootrom / early stage [pre u-boot] bootloaders)

that said, the "reset" framework currently cannot handle level resets
with shared reset lines which are de-asserted by default.
to bring the USB components into a defined state I would have to use
reset_control_assert() first, then reset_control_deassert(). the reset
framework reports an error in this case: [0]
using a reset pulse however works in any case, the reset framework
ensures that it's only executed once for all shared reset lines (our
reset controller hardware probably asserts and de-asserts the reset
line internally - this is just speculation though)


Regards
Martin


[0] https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/reset/core.c#L317
