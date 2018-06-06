Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6my/TdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FC66601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933707AbeFFRHo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:07:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35492 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753762AbeFFRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:07:41 -0400
X-Google-Smtp-Source: ADUXVKK/jdnTZBQP7Yi2Yw9wPUFvJiuMGcO+ECyJO6qg5ugfjBEz/Mo2V8XCkW++8Oq4AxXuG77/Nb4bSvUwSgsvlP0=
MIME-Version: 1.0
In-Reply-To: <CAHp75VepGkCyQ6gM7s2-EO3=6quiCNVGDSZooRr1uoUVeE7hmQ@mail.gmail.com>
References: <20180526193523.3896-1-mattst88@gmail.com> <CAEdQ38GR7XzjfjARuYxnr0dYGnCr_Sxn9bwwZJGZu7CJf6syvw@mail.gmail.com>
 <CAHp75VepGkCyQ6gM7s2-EO3=6quiCNVGDSZooRr1uoUVeE7hmQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 20:07:40 +0300
Message-ID: <CAHp75VdWNsShoD6LzOAi=3y2XYzsd+zns4CCLe0+DD7J+XTinw@mail.gmail.com>
Subject: Re: [PATCH] parport: Add support for the WCH384 4S multi-IO card
To: Matt Turner <mattst88@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergej Pupykin <ml@sergej.pp.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 8:04 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 6, 2018 at 9:07 AM, Matt Turner <mattst88@gmail.com> wrote:
>> On Sat, May 26, 2018 at 12:35 PM, Matt Turner <mattst88@gmail.com> wrote:
>>> This Multi-IO card has one serial 16550-like serial connectors. Here's
>>> the lspci output, after this commit is applied:
>>>
>>> 01:00.0 Serial controller [0700]: Device [1c00:3470] (rev 10) (prog-if 05 [16850])
>>>         Subsystem: Device [1c00:3470]
>>>         Flags: fast devsel, IRQ 16
>>>         I/O ports at e000 [size=256]
>>>         Memory at f0100000 (32-bit, prefetchable) [size=32K]
>>>         I/O ports at e100 [size=4]
>>>         Expansion ROM at f7d00000 [disabled] [size=32K]
>>>         Capabilities: [60] Power Management version 3
>>>         Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
>>>         Capabilities: [80] Express Legacy Endpoint, MSI 00
>>>         Capabilities: [100] Advanced Error Reporting
>>>         Kernel driver in use: parport_serial
>>>
>>> This card was already added to the blacklist of 8250_pci.c in commit
>>> 72a3c0e4e662 ("tty: Add support for the WCH384 4S multi-IO card").
>
> First of all, this patch is in conflict with tty-next AFAICS.
>
> Second, what card w/o parport should do in parport_serial?
>
> Third, this patch brings more mess: either you should remove the code
> from 8250_pci, or do not add it here. See below.
>
> it looks like the mentioned patch mistakenly added it to blacklist by
> unknown reason.
>
> Feels to me like NAK to this one.
>
> And btw, you missed s letter in the model name across the code and I
> don't see any of cards there listed with numports == 0.

Ah, it seems that you have two identical VID:DID devices with either
numports == 0 or 1.

First one should be served by 8250_pci. The second one indeed is good
to have here.

Though, how to distinguish them? By PCI class? by sVID:sDID?


-- 
With Best Regards,
Andy Shevchenko
