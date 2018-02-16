Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeBPDsD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:48:03 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56606 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeBPDsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:48:00 -0500
Date: Fri, 16 Feb 2018 14:47:58 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: David Miller <davem@davemloft.net>
cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
In-Reply-To: <20180214.171558.1617880686804101923.davem@davemloft.net>
Message-ID: <alpine.LNX.2.21.1802161203480.8@nippy.intranet>
References: <alpine.LNX.2.21.1802131419540.8@nippy.intranet>        <20180213.095820.761578588685460710.davem@davemloft.net>        <alpine.LNX.2.21.1802150857480.8@nippy.intranet> <20180214.171558.1617880686804101923.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, David Miller wrote:

> > Have you considered that implementing the ethtool hooks in the core 
> > driver might allow removal of all 8390 driver 'msg_enable' module 
> > parameters and msglevel ethtool hooks added by c45f812f0280, excepting 
> > those in the core driver? But even if we did that, it seems to me that 
> > we still need this patch.
> 
> No, because the module parameter lets you set the default msg level at 
> the time the driver loads, so you can control messages printed very 
> early on before it is practical to invoke ethtool and set the msg level.
> 
> This is why most drivers have this module parameter, and implement
> such a scheme.

Among the 8390 drivers, so far only ne2k-pci implements that scheme.

This patch implements that scheme for ax88796 and etherh as well, by 
making better use of the msg_enable module parameter in lib8390.c.

The axnet_cs and pcnet_cs modules lack the msglevel ethtool ops and the 
msg_enable module parameters.

The remaining nine modules lack just the ethtool ops. If you like I will 
write additional patches to implement the missing ethtool ops or module 
parameters or both (?)

This small patch already addresses the use-case in which the end-user 
needs to enable (for example) probe messages for some or all 8390 drivers.

Thoughts?

-- 
