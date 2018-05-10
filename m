Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZofuhWfNZHO5bM0QK7d6pBjGhySTWD8/iazSqJWFYUaHjbW65mT5KNBBxDMIuSjB0X8B1yh
ARC-Seal: i=1; a=rsa-sha256; t=1525944318; cv=none;
        d=google.com; s=arc-20160816;
        b=hF362yI1y078qg1czt/1Y+qbYNbj9dvI5C1x3++wYaGAXP7s+2HTkGuIzinZ4a0T32
         8/ApRja8/liR5gOBw4rBRvpNADSd3apsw8SEFPZdE6dzULmwl0bdDUlV18AUjJtwKROY
         HLSQz0PS8exLPjoYDWrpWaeXF8AOvGd1hZ/9uYC5xYuwVUBxdp1Te1RF6/qyLYlQ6voJ
         md+nvBdQ8nbH1eKLSbtXH1fbZ8NzfyFMe75zIuz7nKuIw+df4ZJ2q/DwoXyIP2fDhCvS
         PFnIJOApXgpnPIq6/WDuTsXgKGY0+bHuUTRIk034Pd9tpRPfIX7SPKyxXNYfzsgdcLEi
         Rzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=SWKFAOncQdzL4iVSULVXRVYU7Klnp7u67t9/Cxn3tK8=;
        b=1Ksuibo0Ti45DsFieCQFqxxGcqdouKWboDpwnClwb0ofLGi4hnvc6SkRGI62NRSgiR
         wEKpLh/CUhEZ0gCXeL3Cl6t6m34XMKGSTWyplM/AG/g+NsNzTd70bl3vT/rBSo9aHBgB
         Kt4DqUxqtUeD7caSkOTHrmACrZp39RG4SdRb8BTS41+n4EqBy1bzqaDZ2u9ARnzkTx/w
         HjeK5pEhgbyaBkgqvtFxr6q7ZiRA1PR4mAUeQUgsvZjqC94LpE+u/+eTiubMBqSAECit
         YiHHJByBfNTovX2OWXGJY8bbNyVcqh9oLvBEEq7W1qEfp/u0TNmkwwLlaWiTe26/OYz1
         Tg6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RZDlzi4x;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RZDlzi4x;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w4A9P223024704
X-Nifty-SrcIP: [209.85.217.169]
MIME-Version: 1.0
In-Reply-To: <CAFBinCCWeTUCK=tN4PfKqNuX2yWQuSVkXuzcKfV476uO88032Q@mail.gmail.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com>
 <CAFBinCDwbyovMZ-qAKaMiBfz_YKMwxC1c4MjfNyLAvnXEfXtMw@mail.gmail.com>
 <CAK7LNASCLJWWwsDy7zj1uQNcb8pp8ivcAA=Y_oOUOsFMN+YpSA@mail.gmail.com> <CAFBinCCWeTUCK=tN4PfKqNuX2yWQuSVkXuzcKfV476uO88032Q@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 10 May 2018 18:24:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoTLAPTdAjkW42LS7ndVP=ywrLwadmB0=cxwX9ETdP4Q@mail.gmail.com>
Message-ID: <CAK7LNARoTLAPTdAjkW42LS7ndVP=ywrLwadmB0=cxwX9ETdP4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: yixun.lan@amlogic.com, linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        DTML <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598172301797892822?=
X-GMAIL-MSGID: =?utf-8?q?1600068589703196927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Martin,


2018-04-28 23:20 GMT+09:00 Martin Blumenstingl
<martin.blumenstingl@googlemail.com>:
> (adding Yixun from Amlogic to this mail)
>
> On Sat, Apr 28, 2018 at 4:41 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi Martin,
>>
>>
>> 2018-04-24 2:44 GMT+09:00 Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com>:
>>> Hello,
>>>
>>> On Thu, Apr 19, 2018 at 1:03 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> Historically, the clocks and resets are handled on the glue layer
>>>> side instead of the DWC3 core.  For simple cases, dwc3-of-simple.c
>>>> takes care of arbitrary number of clocks and resets.  The DT node
>>>> structure typically looks like as follows:
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
>>>>   }
>>>>
>>>> By supporting the clocks and the reset in the dwc3/core.c, it will
>>>> be turned into a single node:
>>>>
>>>>   dwc3 {
>>>>           compatible = "foo,dwc3", "snps,dwc3";
>>>>           clocks = ...;
>>>>           resets = ...;
>>>>           ...
>>>>   }
>>>>
>>>> This commit adds the binding of clocks and resets specific to this IP.
>>>> The number of clocks should generally be the same across SoCs, it is
>>>> just some SoCs either tie clocks together or do not provide software
>>>> control of some of the clocks.
>>>>
>>>> I took the clock names from the Synopsys datasheet: "ref" (ref_clk),
>>>> "bus_early" (bus_clk_early), and "suspend" (suspend_clk).
>>> looking at the code: this could mean that dwc3-exynos.c can be removed
>>> mid-term (assuming the PHY and regulator handling can be
>>> moved/removed/changed)
>>>
>>> does the datasheet state anything about the clock speeds? from
>>> Documentation/devicetree/bindings/usb/dwc3-xilinx.txt:
>>> "bus_clk" Master/Core clock, have to be >= 125 MHz for SS operation
>>> and >= 60MHz for HS operation
>>>
>>>> I found only one reset line in the datasheet, hence the reset-names
>>>> property is omitted.
>>> does the datasheet state whether this is a level or a pulsed reset line?
>>> on Amlogic Meson GXL, GXM and AXG SoCs we use a pulsed (and shared)
>>> reset line (see ff0a632f08759e "usb: dwc3: of-simple: add support for
>>> shared and pulsed reset lines") because the reset line is shared
>>> between various components (USB2 PHY, USB3 PHY, dwc3 controller, ...)
>>> your current approach (having a vendor-specific "foo,dwc3" binding
>>> along with the generic "snps,dwc3") would allow having
>>> per-"of_device_id" settings which could indicate whether the reset
>>> lines are level or pulsed reset if these are "implementation specific"
>>
>> Let me ask a question about your reset controller.
>> (drivers/reset/reset-meson.c)
>>
>> All reset ID supports .reset, .assert, .deassert
>> Is this correct?
> as far as I know: yes (though I have only ever verified this with the
> Ethernet controller's reset line)
>
>>
>> I believe you and I use the same DWC3 core IP.
> this is possible - but I am not sure since I don't have access to
> Amlogic's internal resources where this should be documented (my
> knowledge mostly comes from reading Amlogic's out-of-tree kernel code
> and porting that to mainline)
>
>>
>> I suspect the difference is in the reset controller side.
>>
>> In my case, the reset line is asserted by default.
>> (that is, all FFs in the RTL are put into the initial state
>> on power-on)
>> That's why only reset_deassert() will work for me, I think.
>>
>> What about your case?  Is the reset line in deassert state on power-on?
>> Then, the reset must be explicitly pulsed to put FFs into
>> the initial state.  Is this correct?
> let me give you a bit of context first:
> the Amlogic Meson AXG, GXL and GXM SoCs have one reset line for "USB
> components". this is shared among:
> - the dwc3 controller
> - (depending on the SoC) 2 or 3 USB2 PHYs
> - a USB3 PHY
> - some OTG detection logic within the registers of the USB3 PHY
>
> (there is also a gate clock which is assigned to the same components)
>
> based on my tests I believe that the reset line is "de-asserted" (=
> USB components are working) by default.
> asserting that reset line should stop the state machine of all USB
> components. de-asserting it again should bring all USB components into
> a defined state.
> (I'm not sure though if these are HW defaults or if there's some logic
> in the bootrom / early stage [pre u-boot] bootloaders)
>
> that said, the "reset" framework currently cannot handle level resets
> with shared reset lines which are de-asserted by default.
> to bring the USB components into a defined state I would have to use
> reset_control_assert() first, then reset_control_deassert(). the reset
> framework reports an error in this case: [0]
> using a reset pulse however works in any case, the reset framework
> ensures that it's only executed once for all shared reset lines (our
> reset controller hardware probably asserts and de-asserts the reset
> line internally - this is just speculation though)
>
>
> Regards
> Martin
>
>
> [0] https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/reset/core.c#L317


Sorry for the late reply.


Personally, I'd like to see a generic solution
instead of tweaking the reset consumer (dwc3-of-simple.c)


I am not sure what the right thing to do,
but just threw this post:

https://lkml.org/lkml/2018/5/10/116




-- 
Best Regards
Masahiro Yamada
