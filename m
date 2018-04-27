Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422737-1524846079-2-3502968801291705959
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
    1524846078; b=KR19OR0NDowrCsLHaG3VWDSrp32S+euu1eIbPpaK8ko9Wuk4mD
    ClY0leuKqXpkKimd8dkzYYAOXw08F+TX9FHQinIGLGC6B87lcSTpjcQCUGPTVpOm
    dyn5qeadbvkgc8FXXAXWiPl+I/j4QknFlDt4RYy9PmmLhHzka+ElNesrzP4HX0rk
    TAhqkft6cUtEoXmzUPj4upJ9hTnz8VwlHs3LMjSvPkv8CP07Nrg2mWs2wgFZnuUI
    owkb73BTLD+KhAqG3T6aRl8xy/uYaojqGhWq7VEn/RX4+7otLt3rOMh0IkYY+Ek+
    jAJgpQy5+oCNG78wOjahaE/AlWowkdhFWJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524846078; bh=4ld4OO4owwLjPhJeq8ODtdOeKaMy71drqaGp1EEj00
    g=; b=OXrWOBiByppTru7jbZPSXn9AY1gMGRkRjn3uRCXv1TS2+pd13Qny7itAPC
    kxxog9YUWswoPeVmFmAyFrGC4iBH0DqRu2hlAHNetdxI9v6f5O6PYCPvxRRfC4P2
    fUejLHm9FlxyVHShdKB1f1gvX72J/He7BbRfjZnq70zeuYyWUvqUwYFyx2TXdB2J
    pQowOGGDFMdFNbfIYb604Q4DhrVEBkuECcfQxcdWDhPvEhpP0RGnig72z7kuZYGl
    sLut559W1roQGRBjT00Fs32p95g0++fDiHD3FXLa4TS1thzFfnZIR5+XeY5FKZEX
    bjWdMVYyjFqi2tDFZ71FONpBCiQw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=quiff4Ln x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=quiff4Ln x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDnNidBqeOKgkqCZgzT4ak9N8s9xvtoxEYtB1Crvu7V5v828zs6zVZgenOBdJh1f5Fcp1hwdvgd43yKaNit1B+jXF3WwOP4TWCtvXF511Wd5uAggMdt7
    HSeDk5PoHfw1rlwcHmbwLk5cVdAPFb4zzfbiQCWh0U51NzjoPt+rZeB86AwPMCSaGoQwkFPUOvKX01bUdHyDzAMNj57tUHxtksZbSOIhwuPAc2TOKJ0Q68gd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=XBv5Wb9mfa7rX1cFcNwA:9 a=82xB01K8pL-hV8jj:21
    a=1DLqBwdC2KHm-huO:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeD0QVD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 12:21:03 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32099 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeD0QVC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 27 Apr 2018 12:21:02 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w3RGKrQJ024142
X-Nifty-SrcIP: [209.85.213.45]
X-Google-Smtp-Source: AB8JxZoT6GoVuOfxM8GWw6RGwDuPrqS/J30spWU1UZ1fuenOyt9R5WQ+suHPCfaAZAMMb4UBqobdiUEQ3OjqYCeWoek=
MIME-Version: 1.0
In-Reply-To: <20180425152114.pzklc5uqva3nil5v@rob-hp-laptop>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com> <20180425152114.pzklc5uqva3nil5v@rob-hp-laptop>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 28 Apr 2018 01:20:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtOxUjfoqmgAu-X_OYihKkMMRVLaYimEY0bRogOoHRZQ@mail.gmail.com>
Message-ID: <CAK7LNATtOxUjfoqmgAu-X_OYihKkMMRVLaYimEY0bRogOoHRZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
To: Rob Herring <robh@kernel.org>
Cc: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,


2018-04-26 0:21 GMT+09:00 Rob Herring <robh@kernel.org>:

>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>> index 0dbd308..feb1cc33 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>> @@ -7,6 +7,27 @@ Required properties:
>>   - compatible: must be "snps,dwc3"
>>   - reg : Address and length of the register set for the device
>>   - interrupts: Interrupts used by the dwc3 controller.
>> + - clock-names: should contain "ref", "bus_early", "suspend"
>> + - clocks: list of phandle and clock specifier pairs corresponding to
>> +           entries in the clock-names property.
>> + - resets: a single pair of phandle and reset specifier
>
> This should be optional as some SoCs don't have separate, s/w controlled
> resets of modules.

OK.  I will move resets to optional property.


Please let ask a question.


The number of clocks should be the same across SoCs.
(Even if there is no s/w control for clocks,
we should input something such as clk-fixed-rate.)

On the other hand, the number of resets can be different
across SoCs.  If there is no s/w control for resets,
we can make it optional.   (optional = 1 or 0 reset)

Is this what you mean?

If we had something like reset-nop (or reset-dummy)
in case no s/w control, we would be able to input something.
I am not sure if this is the right thing, though.




> Otherise, for the DT binding:
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>


-- 
Best Regards
Masahiro Yamada
