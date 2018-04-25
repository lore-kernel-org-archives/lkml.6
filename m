Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDYEUH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:20:07 -0400
Received: from relay02.infra.be.a11.eu ([185.83.138.18]:60938 "EHLO
        relay02.infra.be.a11.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeDYEUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:20:06 -0400
Subject: Re: Fwd: [Bug 199473] New: pcieport does not scan devices behind PEX
 switch, while resources are allocated
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bug-199473-41252@https.bugzilla.kernel.org/>
 <CAErSpo4BOD3V7pgR75Gm7dYqvXYq1QfChjj16Jn1QgSK1W=Drw@mail.gmail.com>
From: Janpieter Sollie <janpieter.sollie@dommel.be>
Message-ID: <633ec24b-4212-581f-05f0-7a86eaf09fee@dommel.be>
Date: Wed, 25 Apr 2018 04:13:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAErSpo4BOD3V7pgR75Gm7dYqvXYq1QfChjj16Jn1QgSK1W=Drw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dear Bjorn,

I understand the confusion.  I quite messed up the bug report. Sorry.
The problem is that lspci with kernel 4.17-rc1 shows exactly the same behaviour when no 
workaround is applied.
the lspci is from 4.17-rc1 with the workaround applied, but by default, it shows the same output 
as 4.14.27

kind regards,

Janpieter Sollie

On 24-04-18 19:31, Bjorn Helgaas wrote:
> Thanks for the report!
>
> I don't understand exactly what the issue is yet.  You attached lspci
> output from v4.14.27 and v4.17-rc1.  The v4.17-rc1 output shows several
> devices (4b:00, 4c:00, 4f:00) below the PEX switch, while the v4.14.27
> output shows only the 4f:00 devices.
>
> Is the problem that v4.14.27 doesn't find the 4b:00 and 4c:00 devices?
> Does v4.17-rc1 work correctly?
>
> If v4.17-rc1 works but v4.14.27 does not, it's probably a question of
> working with your distro to see if they can (1) identify some change that
> fixed things, and (2) backport that change to the distro kernel.
>
> The Broadcom driver you attached at comment #4 shouldn't be related to this
> problem.  Device enumeration is performed by the PCI core and doesn't
> require any additional drivers.  I didn't look at the Broadcom driver, so I
> don't know what it does.  The PEX switch does include an endpoint
> (42:00.1); it's possible the driver is for some functionality provided by
> that endpoint.
>
> ---------- Forwarded message ---------
> From: <bugzilla-daemon@bugzilla.kernel.org>
> Date: Mon, Apr 23, 2018 at 12:20 AM
> Subject: [Bug 199473] New: pcieport does not scan devices behind PEX
> switch, while resources are allocated
> To: <bhelgaas@google.com>
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=199473
>
>               Bug ID: 199473
>              Summary: pcieport does not scan devices behind PEX switch,
>                       while resources are allocated
>              Product: Drivers
>              Version: 2.5
>       Kernel Version: 4.17-rc1
>             Hardware: x86-64
>                   OS: Linux
>                 Tree: Mainline
>               Status: NEW
>             Severity: normal
>             Priority: P1
>            Component: PCI
>             Assignee: drivers_pci@kernel-bugs.osdl.org
>             Reporter: janpieter.sollie@dommel.be
>           Regression: No
>
> Created attachment 275511
>     --> https://bugzilla.kernel.org/attachment.cgi?id=275511&action=edit
> dmesg stable kernel
>
> pcieport assigns the PEX 8619 pcie expander switch ports, but does not scan
> them for additional objects behind the ports. only 1 device is added @ pci
> region 4f.  Workaround for getting all devices online: while pc is on,
> remove
> the card, reinsert it at a slot before the working device, and make a cold
> start.
> It would be nice if the pcie switches are scanned properly.
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
>
