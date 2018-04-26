Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2603440-1524751727-2-1590754285888957645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524751726; b=SIH6+qhOj59jJQwMdaeXRKi5LYzybzHUptIxoUndlP+1p5QfZp
    z/EjjHJm7I4Mv45AxEP43ADVBGNoF/Rrt2+6espyyeWdcCQ9jD6zOkdkzdoaR1Lg
    bQ6BuyeOJugjhdQn9x6++usWxo/AZ90mGzktIO1phtWpujPp6wTJ8pU4/P86Vo++
    YnUaQcRtcdV023wa4sSGRxgadc/1Ckqqbazk92Em+quwWu8NzTJUlhsJAVc6yZI5
    iv+sQZCPjJiLrXMTcovis+QmYGUdDb7bAWm+g2ig5Vs8X7nM0g1xsvwKkQKkD0TF
    gew3M5RMyNwXeTTKOzuH/+W0M9CagOkQ650w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524751726; bh=wLC5i7ItM0GfduvHGAK7+N6mwsqoNh
    R2zoLE/EBvpeM=; b=sj7UhhqN5S3Z89ZQD3MQ+gOsvsfvOAM7RpyKAZcvZuwEYq
    MXfxyO5S+GJrZ/QsX5+AF06mmykz5O6yoRnIrsKU6fiSoO2iW7ETgCx/nZKTJNqe
    HIbQ6qZhvSv/YzwZsa4uA3GkzuK0uC29nl0YrFZawZU8OXm9Il/IVueVZaaoTqPi
    k+S0PTYJin1xOShZsQgXY3VtPxkBEKcb/5wK3yRaLxAHATrDKqEZk85eH1zDuPS3
    Iz1iCTDf04mJid0xjGR7MXl+kWzWpyYABF3fIHCASFV4u+ORw/8zRYl5zkwBxbsb
    ROjYzO9MWybxgrV1XKRQKaHn0WanFGnfXB2GzyBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=IsQk0qsF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lfvhZjrC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=IsQk0qsF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lfvhZjrC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGepaBimgHK8gK7hO1kbL5RnkTL+BDaY66qI7K0pY6IDJJLdCer8/55FOke2xZwuwKJvspjmzNojRvaLOUVCyFq2Z/U/AwZeyxHTMIAKrl0IEzFNDE5u
    l12OdKw0Eu/DPWjgpxfI7ycL5h4IBliiJeBeWwPm2tK1Bqz2RTcfvhML12Bug1fm3Ng8NIxPKkFAGIRCj2eXY5CKou9blh0LIVYXPG6kAxd7bcm2Ohsisi95
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=ERBoA_1hzK5CDDegt40A:9 a=E0cOJMorxDq_GPi4:21 a=_eb7AxrDv_5DxRSb:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756543AbeDZOIc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 10:08:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51039 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756433AbeDZOI1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Apr 2018 10:08:27 -0400
X-Google-Smtp-Source: AB8JxZruEe7nvh/WMiUxl+qgZ7+s0fEmt1usLGh+cxuuZo2H7fzZbZSue5MkWyrHfRyi8Sx/MRoP1A==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>
Cc: devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/3] serial: uartps: Add run time support for more IPs than hardcoded 2
Date: Thu, 26 Apr 2018 16:08:16 +0200
Message-Id: <cover.1524751696.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

this series is trying to address discussion I had with Alan in past
https://patchwork.kernel.org/patch/9738445/.

It is moving uart_register_driver() to probe function like it is done in
pl011 driver.
And also introducing new function for alias compatibility checking to
resolve cases where some IPs have alias and some of them not.
This case is detected in pl011_probe_dt_alias() but not properly solved.

Also keep status of free ids/minor numbers in bitmap to know what's the
next unallocated number.

The same solution can be used in pl011, uart16550 and uartlite to really
get unified kernel.

Tested on these use cases:
Notes:
ff000000 is the first PS uart listed in dtsi
ff010000 is the second PS uart listed in dtsi

Standard zcu102 setting
		serial0 = &uart0;
		serial1 = &uart1;
[    0.196628] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.642542] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

Swapped zcu102 setting
		serial0 = &uart1;
		serial1 = &uart0;
[    0.196472] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.196824] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

uart0 on alias higher then MAX uart ports
		serial0 = &uart1;
		serial200 = &uart0;
[    0.176793] ff000000.serial: ttyPS200 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.177288] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

Both uarts on higher aliases
		serial1 = &uart1;
		serial2 = &uart0;
[    0.196470] ff000000.serial: ttyPS2 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.196823] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

uart0 not listed but it is probed first that's why should be ttyPS0 but
there is uart1 via alias
		serial0 = &uart1;
[    0.176656] xuartps ff000000.serial: No serial alias passed. Using
the first free id
[    0.176671] xuartps ff000000.serial: Validate id 0
[    0.176680] xuartps ff000000.serial: The empty id is 0
[    0.176692] xuartps ff000000.serial: ID 0 already taken - skipped
[    0.176701] xuartps ff000000.serial: Validate id 1
[    0.176710] xuartps ff000000.serial: The empty id is 1
[    0.176719] xuartps ff000000.serial: Selected ID 1 allocation passed
[    0.176760] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.177104] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

uart0 not listed but it is probed first that's why should be ttyPS0
		serial1 = &uart1;
[    0.176661] xuartps ff000000.serial: No serial alias passed. Using
the first free id
[    0.176676] xuartps ff000000.serial: Validate id 0
[    0.176686] xuartps ff000000.serial: The empty id is 0
[    0.176696] xuartps ff000000.serial: Selected ID 0 allocation passed
[    0.176737] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.177069] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

uarts not listed in aliases list
[    0.176673] xuartps ff000000.serial: No serial alias passed. Using
the first free id
[    0.176687] xuartps ff000000.serial: Validate id 0
[    0.176697] xuartps ff000000.serial: The empty id is 0
[    0.176707] xuartps ff000000.serial: Selected ID 0 allocation passed
[    0.176746] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
base_baud = 6250000) is a xuartps
[    0.177057] xuartps ff010000.serial: No serial alias passed. Using
the first free id
[    0.177070] xuartps ff010000.serial: Validate id 0
[    0.177079] xuartps ff010000.serial: The empty id is 0
[    0.177089] xuartps ff010000.serial: Selected ID 0 allocation failed
[    0.177098] xuartps ff010000.serial: Validate id 1
[    0.177107] xuartps ff010000.serial: The empty id is 1
[    0.177116] xuartps ff010000.serial: Selected ID 1 allocation passed
[    0.177149] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
base_baud = 6250000) is a xuartps

Thanks,
Michal


Michal Simek (3):
  of: base: Introduce of_alias_check_id() to check alias IDs
  serial: uartps: Move register to probe based on run time detection
  serial: uartps: Change uart ports allocation

 drivers/of/base.c                  |  49 +++++++++++
 drivers/tty/serial/xilinx_uartps.c | 128 +++++++++++++++++++++++------
 include/linux/of.h                 |   2 +
 3 files changed, 153 insertions(+), 26 deletions(-)

-- 
2.17.0

