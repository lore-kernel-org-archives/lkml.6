Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412727-2-8102238792061727426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412726; b=I8oU9nYZLFBFAS58WAHQ2O8d8A5JDmNuAgFnHUmT2QnfnLE
    qUv5WuozmE6vT8AiBqIPuWdLFRN3pZWeQRTYMqMjE7Acgjxb8IlQq48S4mml1gaj
    T8vmtcwgKZ2nk8Bb0UoMXdsh7Fak8EPZO2YgBgs/QeFx5dW4/Az8ZBc/EXNhSDzE
    UHADS0jjCKhDHhXwYYnFBcgZsRj1sD3NcnX4FalZwMjKU4np0d9dYXuAtDsNFCgR
    za2eifdoJXN5SxTm5GehKlxmmEL/cA/FpDmuk0M8w00nzN4F4ari8wb1Kee7Uhw9
    D3MLtdHsxGF4+96Oj+Azv3Ftk+ishKP8C5dyT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521412726; bh=owXKlIHCt0iqYKvuSv7nQw5HjymDF7h0noRuG1
    myLKs=; b=tOekJUjTHnxjZnisvdVK/sFw9auDOC+/aRKziR9AdRJxAMdlqIEfJm
    7lIQOVTJzGzjQAo5G/GCbSV7P4KlKo5vxUiMmkeyMvLHl6ZB+zkd3UfNNNXM+vyV
    IcaUk+SFQvvuutvsz7n5rM+np60zzTbrPK1gEH7CYwgWuhmgqcxFKiS1RBIX+LLc
    5hNb/JjftCraWhjXaZv6Zw4HEynpDJFwAGVTc9AJ+GueB/NSoQGQs5OLz3NRe4vK
    KSFFIPrGgEA4tuDu6bDukxoxn7bOb2eEpBecEn48GxBmC4Jt2QdZKsedJ8Mhjq1e
    i1yM49d/pl7GaKPimzsV3cTkUyoLnNcA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=BLudYdOK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=BLudYdOK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbeCRWij (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 18:38:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45804 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbeCRWih (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 18 Mar 2018 18:38:37 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2IMcSHU010250
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AG47ELubVeBBN0skIx7Wj5o2Ik5hBIoEMwJ8lcoI7uBueFpcvhBIZgNXjHS64J4tVXNh9qo9Z6wfGTYfpYFwimSU/7c=
MIME-Version: 1.0
In-Reply-To: <20180318125209.juoa3gkgdv2djciw@rob-hp-laptop>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
 <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com> <20180318125209.juoa3gkgdv2djciw@rob-hp-laptop>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 19 Mar 2018 07:37:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQT8wfAk55c40zrZ15wPh3fnsh=B1ciNfVx4uA-oGi34g@mail.gmail.com>
Message-ID: <CAK7LNAQT8wfAk55c40zrZ15wPh3fnsh=B1ciNfVx4uA-oGi34g@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc3: add clock and resets
To: Rob Herring <robh@kernel.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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

Hi Rob,

2018-03-18 21:52 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Thu, Mar 15, 2018 at 08:39:58PM +0900, Masahiro Yamada wrote:
>> dwc3-of-simple.c only handles arbitrary number of clocks and resets.
>> They are both generic enough to be put into the dwc3 core.  For simple
>> cases, a nested node structure like follows:
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
>
> I'm not a fan of how this was done.
>
>
>>   }
>>
>> would be turned into a single node:
>>
>>   dwc3 {
>>           compatible = "foo,dwc3", "snps,dwc3";
>>           clocks = ...;
>>           resets = ...;
>>           ...
>>   }
>
> And yes, this is what I'd prefer.



Not only dwc3-of-simple.c, but all dwc3 nodes are
written like this.


omap_dwc3_1: omap_dwc3_1@48880000 {
        compatible = "ti,dwc3";
        reg = <0x48880000 0x10000>;
        #address-cells = <1>;
        #size-cells = <1>;
        ranges;
        ...

        usb1: usb@48890000 {
                compatible = "snps,dwc3";
                reg = <0x48890000 0x17000>;
                ...
        };
};


The glue layer initializes SoC-specific things,
then populates the child "snps,dwc3".


I think the following structure should work
by handling EPROBE_DEFER properly.

omap_dwc3_1: omap_dwc3_1@48880000 {
        compatible = "ti,dwc3"; (should be "ti,dwc3-glue" or something)
        reg = <0x48880000 0x10000>;
        ...
};

usb1: usb@48890000 {
        compatible = "snps,dwc3";
        reg = <0x48890000 0x17000>;
        ...
};



>>
>> I inserted reset_control_deassert() and clk_enable() before the first
>> register access, i.e. dwc3_cache_hwparams().
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  Documentation/devicetree/bindings/usb/dwc3.txt |   2 +
>>  drivers/usb/dwc3/core.c                        | 127 ++++++++++++++++++++++++-
>>  drivers/usb/dwc3/core.h                        |   5 +
>>  3 files changed, 132 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>> index 44e8bab..67e9cfb 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>> @@ -9,12 +9,14 @@ Required properties:
>>   - interrupts: Interrupts used by the dwc3 controller.
>>
>>  Optional properties:
>> + - clocks: list of phandle and clock specifier pairs
>
> However, this should be specific as to how many clocks and their
> function. This should be readily available to someone with access to
> Synopsys datasheet. The number of clocks should generally be the same
> across SoCs, it is just some SoCs either tie clocks together or don't
> provide s/w control of some of the clocks.


Make sense.
You also implies this property is mandatory.
The number of clocks should be available in the datasheet
and no hardware can work with zero clock.

However, making it mandatory breaks the binding
since the existing DT files do not specify clocks at all
in the "snps,dwc3" node.



Anyway, our current situation:

- We have the dwc3-core under the glue layer node
  despite they are independent in the CPU address view
- We add all sorts of clocks and resets in the glue layer node,
  and nothing in the dwc3-core node.

If these are design mistake, what should we do?

Continue development based on it?
If we fix it, how to change the course?





>>   - usb-phy : array of phandle for the PHY device.  The first element
>>     in the array is expected to be a handle to the USB2/HS PHY and
>>     the second element is expected to be a handle to the USB3/SS PHY
>>   - phys: from the *Generic PHY* bindings
>>   - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
>>       or "usb3-phy".
>> + - resets: list of phandle and reset specifier pairs
>
> ditto
>

Same issue as the clocks.



-- 
Best Regards
Masahiro Yamada
