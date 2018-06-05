Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2109003-1528161433-2-14468403303167957376
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528161433; b=gjwrQcGk1Xsk0caX9+cKz4TDV0I6Dp/w8LrfLM2IfJ87Izxm7M
    Y/HymE2uSPjM5radYu0oqnzG+ofDPiyW6cJzUvcowRXezjCbYA54xDY5n6w7vgbD
    yNe8XEVL7sSt4OJL10LvcYHJYrUwrJp8TAR24ZnLDYp1TqI2ICtTBYzhPaEo2OoT
    qpolSNEmwfMW0BwXrqcNgjQP4GDHkn3d5eWmZU8tBg+GCmS6ELGUNO1oAELQEoxM
    n6WzKxP2hMuBLa8eGE0yodegNC1XbTC7BAmUvyR6K1LCh+6F6da+46ljZJ/TYcbd
    QRKQ5GOqeoBNYSJv/mtjY6qu1uJaj8tDAKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528161433;
    bh=N0ieEOdom/VZZw5D1CSbOOUO0g+9SMBYKX++FUFkZio=; b=SBJHAShcjdqB
    Li+iVWyEKSmJYOdcdZLytmhuNTVzDetvmOcq3D2ebLbKjxSEU1dKUfDsFDg5nmOp
    sjhEiBKHKcfd4gqL/5r2vHwoFSY9U+dJ0bd7HvbTionxbi+cXOTCP99e4t7HxZUp
    fBh7TFNNJpr9jqm1IR51GW+24FoShzPURFisc2axKL5q1eXg9C6pp3w9LSBFqN1O
    cLDj23AN4M+W1HgY1QaHW4ynN+M3BjdZfG+GCDK40zwh9kwQzFvZlgSUICMFAlQq
    bwPfGrD7U5g3A+Nf729TRTuwn8oNhc2QJ8+ez1pgU8yEVOKnfxd2RLDfER1KofgP
    EKYZ+wWUZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=broadcom.com
    header.i=@broadcom.com header.b=iN+fcxsN header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none)
    header.from=broadcom.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=ha38t8ic;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=broadcom.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=broadcom.com
      header.i=@broadcom.com header.b=iN+fcxsN header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none)
      header.from=broadcom.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=ha38t8ic;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=broadcom.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK7rbj/S4GEKfdzp/E0o4o7woERXfKZm0GrFKx9aOxVPNtnKcT64CnFXGWHj9kKcpUyR9Y+KlK97jUFlWNrgsHt9GJrDDMIqyI40+CQ3XKC7Gv5xKCm3
    yglyLA24IDJQGbcQ/XW2wRORawSl9LJ7X9sUFYJtqEFBFO6sPzhe0CsVKQACUo4XxQTsJ0pu7Sukd+Kt6Ds2bW4oXqdAW6NAUAvG5PMoog7JmO2s1IUH2FvY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=Q-fNiiVtAAAA:8 a=AazsPb391056pfN2G7MA:9 a=by7vTLfK73Ub2rXL:21
    a=AMqT0ALYXGNZ7Gjg:21 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFEBRL (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 21:17:11 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34068 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeFEBRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jun 2018 21:17:10 -0400
X-Google-Smtp-Source: ADUXVKIByjzrBGM/uH1TB+lhgsh21JxGTPYLClNK+zWYYGhoPiNLhR1VY9Ud/lEcj7ISgNELOWBa1A==
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
To: Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
 <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <808cc0bd-3ff2-a601-9c2d-09705fd36e51@broadcom.com>
Date: Mon, 4 Jun 2018 18:17:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob/Arnd,

On 6/4/2018 7:17 AM, Rob Herring wrote:
> +Arnd
> 
> On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>> Update the iProc PCIe binding document for better modeling of the legacy
>> interrupt (INTx) support
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> index b8e48b4..7ea24dc 100644
>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>> @@ -13,9 +13,6 @@ controller, used in Stingray
>>     PAXB-based root complex is used for external endpoint devices. PAXC-based
>>   root complex is connected to emulated endpoint devices internal to the ASIC
>>   - reg: base address and length of the PCIe controller I/O register space
>> -- #interrupt-cells: set to <1>
>> -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
>> -  mapping of the PCIe interface to interrupt numbers
>>   - linux,pci-domain: PCI domain ID. Should be unique for each host controller
>>   - bus-range: PCI bus numbers covered
>>   - #address-cells: set to <3>
>> @@ -41,6 +38,16 @@ Required:
>>   - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>>   address used by the iProc PCIe core (not the PCIe address)
>>
>> +Legacy interrupt (INTx) support (optional):
>> +
>> +Note INTx is for PAXB only.
>> +
>> +- interrupt-controller: claims itself as an interrupt controller for INTx
>> +- #interrupt-cells: set to <1>
>> +- interrupt-map-mask and interrupt-map, standard PCI properties to define
>> +the mapping of the PCIe interface to interrupt numbers
>> +- interrupts: interrupt line wired to the generic GIC for INTx support
>> +
>>   MSI support (optional):
>>
>>   For older platforms without MSI integrated in the GIC, iProc PCIe core provides
>> @@ -77,9 +84,14 @@ Example:
>>                  compatible = "brcm,iproc-pcie";
>>                  reg = <0x18012000 0x1000>;
>>
>> +               interrupt-controller;
>>                  #interrupt-cells = <1>;
>> -               interrupt-map-mask = <0 0 0 0>;
>> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>> +               interrupt-map-mask = <0 0 0 7>;
>> +               interrupt-map = <0 0 0 1 &pcie0 1>,
> 
> Are you sure this works? The irq parsing code will ignore
> interrupt-map if interrupt-controller is found. In other words, you
> should have one or the other, but not both.

Yes, it does work. I tested this by using an Intel E1000E PCIe NIC card 
installed in our system and have it fall back to INTx.

> 
> Maybe it happens to work because "pcie0" is this node and your irq
> numbers are the same.

Perhaps it works because we are claiming "pcie0" as an interrupt 
controller by itself and the INTx is modeled under that.

> 
> Arnd, any thoughts on this?
> 

Please let me know if the above model makes sense or not.

Thanks,

Ray

>> +                               <0 0 0 2 &pcie0 2>,
>> +                               <0 0 0 3 &pcie0 3>,
>> +                               <0 0 0 4 &pcie0 4>;
>> +               interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
>>
>>                  linux,pci-domain = <0>;
>>
>> @@ -115,9 +127,14 @@ Example:
>>                  compatible = "brcm,iproc-pcie";
>>                  reg = <0x18013000 0x1000>;
>>
>> +               interrupt-controller;
>>                  #interrupt-cells = <1>;
>> -               interrupt-map-mask = <0 0 0 0>;
>> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
>> +               interrupt-map-mask = <0 0 0 7>;
>> +               interrupt-map = <0 0 0 1 &pcie1 1>,
>> +                               <0 0 0 2 &pcie1 2>,
>> +                               <0 0 0 3 &pcie1 3>,
>> +                               <0 0 0 4 &pcie1 4>;
>> +               interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>>
>>                  linux,pci-domain = <1>;
>>
>> --
>> 2.1.4
>>
