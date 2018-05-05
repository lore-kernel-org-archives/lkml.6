Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1754801-1525525874-2-11062432034586936831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525525873; b=Jno/UrYmuTmGaZl756rVLezgCgpZ6c/CJlvXTrQk9Bh4MFoaGI
    p5yFX+tQd/v3BgZC9NaQfpdneFidSY0r+x3p4GDpZs+y6X7UY9UQcJqYQfWUP1JJ
    iTPqSQQkvhtCmStND4euxGcpf3YLCT0btkWe7ofC3s9wQ5YspcYr/VCVI2Mync40
    hFGyQdwzSegCenjMR36Oi8rsTsodzLm1whOoS5MjXEPUPCUf0gmsrL/Aa2AUigMs
    uwN8CgsEOmNHQy9OhpxwimCQyAuUb13ImvY3QumV2CUBIAxqYFUr/UZ29HTO35BD
    tajXoGhPFF8AWh7uEjw+sOo0ghrwLIqjJ0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1525525873; bh=A
    /BdcbYknXJWFqpsiFX4eO+HHK64Es4CDPTYL3LmFEQ=; b=RlAMinPKvIlZBKL9/
    A0w75abQu0+k1Yt2hF3NbfSh+TyRot0Qvv2pWE7ZT9l/6Yq9fk6JbGful5bSwumv
    V7Jv1skmiE96w54Z4QItLie1rhUlR8QBzSzIcQzr2EEVKoS/SGdzVOORtgJKp9zV
    zyL1L325cHj8/OtEL7gR24MSuU08/XSQO7OtxNihrGeWqhXoC1mkZEqkUoIOyh9f
    rQ8/KsePdWQp6CyNMu1/tdPeOkSzn14Qeq2Wu0p03OGXQwayB0K/BkxJmG7y2j2O
    0OOWi6sPXBUym+HXjuuMITiQHK0A1hqe62i0SnKkqE91LBykS8mmQLSGP9avVYBb
    hdwzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vanmierlo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=vanmierlo.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vanmierlo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=vanmierlo.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIDR/TCEsFX6XazoPJ6u89mOSkapokNvJGzQU8V/9ZRgryeSBhm2BVbHWEqN+zgb5deBv3EWKm3ZAD6qMMbVDgeQ3uQ1M1AxcdN3YjxeItkIWobg8tIV
    nvPxuPeyOdeurdsmvA0KE0I3dhG8PyXrLb8dQN6fLWHMFYHAKeDm2iw4b9XCstY9tdDK4QcSt39Yh5wZFJOU2bOPaHfAIs/fwe376baWN11bDb2zCb2T4Qcv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=XnXCVQNIiuOdO5GK9d4A:9 a=0FvTp_OFvXTXV_LQ:21
    a=QqJgP5j_Jc_31mY_:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeEENLL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 5 May 2018 09:11:11 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:43374 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751157AbeEENLL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 May 2018 09:11:11 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 05 May 2018 15:10:35 +0200
From: Maarten Brock <m.brock@vanmierlo.com>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] serial: uartps: Add run time support for more IPs
 than hardcoded 2
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
Message-ID: <1d3bc2082972bb1d4abc2c15db396257@vanmierlo.com>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-26 16:08, Michal Simek wrote:
> Hi,
> 
> this series is trying to address discussion I had with Alan in past
> https://patchwork.kernel.org/patch/9738445/.
> 
> It is moving uart_register_driver() to probe function like it is done 
> in
> pl011 driver.
> And also introducing new function for alias compatibility checking to
> resolve cases where some IPs have alias and some of them not.
> This case is detected in pl011_probe_dt_alias() but not properly 
> solved.
> 
> Also keep status of free ids/minor numbers in bitmap to know what's the
> next unallocated number.
> 
> The same solution can be used in pl011, uart16550 and uartlite to 
> really
> get unified kernel.
> 
> Tested on these use cases:
> Notes:
> ff000000 is the first PS uart listed in dtsi
> ff010000 is the second PS uart listed in dtsi
> 
> Standard zcu102 setting
> 		serial0 = &uart0;
> 		serial1 = &uart1;
> [    0.196628] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.642542] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> Swapped zcu102 setting
> 		serial0 = &uart1;
> 		serial1 = &uart0;
> [    0.196472] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.196824] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uart0 on alias higher then MAX uart ports
> 		serial0 = &uart1;
> 		serial200 = &uart0;
> [    0.176793] ff000000.serial: ttyPS200 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177288] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> Both uarts on higher aliases
> 		serial1 = &uart1;
> 		serial2 = &uart0;
> [    0.196470] ff000000.serial: ttyPS2 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.196823] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uart0 not listed but it is probed first that's why should be ttyPS0 but
> there is uart1 via alias
> 		serial0 = &uart1;
> [    0.176656] xuartps ff000000.serial: No serial alias passed. Using
> the first free id
> [    0.176671] xuartps ff000000.serial: Validate id 0
> [    0.176680] xuartps ff000000.serial: The empty id is 0
> [    0.176692] xuartps ff000000.serial: ID 0 already taken - skipped
> [    0.176701] xuartps ff000000.serial: Validate id 1
> [    0.176710] xuartps ff000000.serial: The empty id is 1
> [    0.176719] xuartps ff000000.serial: Selected ID 1 allocation passed
> [    0.176760] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177104] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uart0 not listed but it is probed first that's why should be ttyPS0
> 		serial1 = &uart1;
> [    0.176661] xuartps ff000000.serial: No serial alias passed. Using
> the first free id
> [    0.176676] xuartps ff000000.serial: Validate id 0
> [    0.176686] xuartps ff000000.serial: The empty id is 0
> [    0.176696] xuartps ff000000.serial: Selected ID 0 allocation passed
> [    0.176737] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177069] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> uarts not listed in aliases list
> [    0.176673] xuartps ff000000.serial: No serial alias passed. Using
> the first free id
> [    0.176687] xuartps ff000000.serial: Validate id 0
> [    0.176697] xuartps ff000000.serial: The empty id is 0
> [    0.176707] xuartps ff000000.serial: Selected ID 0 allocation passed
> [    0.176746] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
> base_baud = 6250000) is a xuartps
> [    0.177057] xuartps ff010000.serial: No serial alias passed. Using
> the first free id
> [    0.177070] xuartps ff010000.serial: Validate id 0
> [    0.177079] xuartps ff010000.serial: The empty id is 0
> [    0.177089] xuartps ff010000.serial: Selected ID 0 allocation failed
> [    0.177098] xuartps ff010000.serial: Validate id 1
> [    0.177107] xuartps ff010000.serial: The empty id is 1
> [    0.177116] xuartps ff010000.serial: Selected ID 1 allocation passed
> [    0.177149] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
> base_baud = 6250000) is a xuartps
> 
> Thanks,
> Michal

Hello Michal,

How will this interact with ns16550 based UARTs?

Can we have both /dev/ttyS0 and /dev/ttyPS0?
Currently we can't unless we create *no* serialN alias for the ns16550.
And there is no other means to lock the /dev/ttySx name to a device 
either.

Or will the xuartps driver eventually use /dev/ttySx as well?

Maarten

