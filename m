Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932901AbeCEX3y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932393AbeCEX3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:29:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B4321777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELv70TOaHcEfNRa0rRz14HhcKXMm3/GIV0W9s1wsos80Bq279Dnsp5+3CBT9dDrIr04W8J4xocIjLLkOPs425Y8=
MIME-Version: 1.0
In-Reply-To: <20180305231936.GA14751@roeck-us.net>
References: <1519687145-9430-1-git-send-email-linux@roeck-us.net>
 <20180305215737.oxelfzdgsro6poee@rob-hp-laptop> <20180305231936.GA14751@roeck-us.net>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Mar 2018 17:29:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpVLoi+N1WwbLwKvp9c=fESKM_UD=cJMJnPjGOx8ARsA@mail.gmail.com>
Message-ID: <CAL_JsqJpVLoi+N1WwbLwKvp9c=fESKM_UD=cJMJnPjGOx8ARsA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Move declaration of of_irq_parse_and_map_pci under OF_IRQ
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 5:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Mar 05, 2018 at 03:57:37PM -0600, Rob Herring wrote:
>> On Mon, Feb 26, 2018 at 03:19:05PM -0800, Guenter Roeck wrote:
>> > Since commit 4670d610d5923 ("PCI: Move OF-related PCI functions into
>> > PCI core"), sparc:allmodconfig fails to build with the following error.
>> >
>> > pcie-cadence-host.c:(.text+0x4c4):
>> >     undefined reference to `of_irq_parse_and_map_pci'
>> > pcie-cadence-host.c:(.text+0x4c8):
>> >     undefined reference to `of_irq_parse_and_map_pci'
>> >
>> > of_irq_parse_and_map_pci is now only available if OF_IRQ is enabled.
>> > Make its declaration and its dummy function dependent on OF_IRQ
>> > to solve the problem.
>> >
>> > Fixes: 4670d610d5923 ("PCI: Move OF-related PCI functions into PCI core")
>> > Cc: Rob Herring <robh@kernel.org>
>> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> > ---
>> >  include/linux/of_pci.h | 17 ++++++++++-------
>> >  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> Bjorn should take this. Can you resend to linux-pci so it is in his
>> queue.
>>
> MAINTAINERS lists you as maintainer and devicetree@vger.kernel.org as
> mailing list. But, sure, no problem.

The commit it fixes went in thru his tree was my reasoning. I'll look
at fixing MAINTAINERS.

Ideally, the header would move to drivers/pci/, but since all the PPC
PCI host code is still in arch/powerpc, it cannot.

Rob
