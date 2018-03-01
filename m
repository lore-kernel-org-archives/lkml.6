Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965747AbeCAD25 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:28:57 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55280 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965657AbeCAD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:28:55 -0500
Date: Wed, 28 Feb 2018 22:28:53 -0500 (EST)
Message-Id: <20180228.222853.1570972177848923005.davem@davemloft.net>
To: helgaas@kernel.org
Cc: dwmw2@infradead.org, sparclinux@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] sparc: Use generic pci_mmap_resource_range()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228230828.GR127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519053858.7876.84.camel@infradead.org>
        <20180219.103025.1676484157305869188.davem@davemloft.net>
        <20180228230828.GR127842@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 28 Feb 2018 17:08:29 -0600

> On Mon, Feb 19, 2018 at 10:30:25AM -0500, David Miller wrote:
>> From: David Woodhouse <dwmw2@infradead.org>
>> Date: Mon, 19 Feb 2018 15:24:18 +0000
>> 
>> >> For one, the sparc specific code allows mmap'ing any address range
>> >> within a PCI bus device.  The generic code does not allow that.
>> > 
>> > 
>> > You mean any address range in a given PCI bus even if there is no
>> > actual device with a BAR at the corresponding address?
>> > 
>> > Would I be right to assume this was only available through the legacy
>> > procfs API? I think it should be possible to accommodate it, and it
>> > does look like I'd missed this requirement the first time round; thanks
>> > for pointing it out.
>> 
>> It was probably the case that only procfs could do it.
>> 
>> It is the mechanism by which we were able to let the X server poke
>> around in VGA ISA space.  It does a bus I/O space map for the bus
>> device above the VGA card.
> 
> What's the bottom line?  Do we want this for sparc?  If so, do you
> want to take it, Dave M, or would you like me to?

The bottom line is that David W.'s patch would break sparc so
we don't want this.
