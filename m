Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeERJKI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:10:08 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:54777 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753153AbeERJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:10:06 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:966:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2196:2198:2199:2200:2201:2393:2559:2562:2689:2691:2693:2828:2895:2901:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4362:4385:5007:6117:6119:7974:8957:10004:10400:10848:11232:11658:11914:12296:12555:12663:12740:12760:12895:13069:13311:13357:13439:13869:13972:14181:14659:14721:21080:21324:21451:21627:21740:30005:30054:30055:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: dirt67_57fe51cddcd56
X-Filterd-Recvd-Size: 2818
Message-ID: <9332d922caf8e25747aa19e573cc3ab82519f6f7.camel@perches.com>
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Date: Fri, 18 May 2018 02:10:02 -0700
In-Reply-To: <20180518084203.n2etqcigvwxzcanv@pathway.suse.cz>
References: <cover.1525964381.git.joe@perches.com>
         <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
         <20180518084203.n2etqcigvwxzcanv@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 10:42 +0200, Petr Mladek wrote:
> On Thu 2018-05-10 08:45:29, Joe Perches wrote:
> > There are more than 1000 uses of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > Make that the default define so these uses can be removed later via script.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> It removes a lot of duplicates. I just hope that we will not need to
> add the same amount of defines to remove/change the prefix where the
> new default would look ugly.

I expect there will be far far fewer additions,
perhaps a few dozen, than the about 1200 removals.  

> I am not completely convinced that it is worth it. But it makes some
> sense. Feel free to use:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
> 
> 
> BTW: I tried the entire patchset and there are still many locations
> even in the boot log that might need an update:

Thanks.

> [    0.000000] generic: MTRR default type: write-back

generic might be removed.

> [    0.000000] libftrace: ftrace: allocating 40753 entries in 160 pages
> [    0.004008] apic: APIC: Switch to symmetric I/O mode setup

I believe the uppercase APIC: bit should be removed.

> [    0.796479] workingset: workingset: timestamp_bits=36 max_order=20 bucket_order=0

and I will submit patches for these other duplicates.

> [    1.044458] ipmi_si: ipmi_si: Unable to find any System Interface(s)
> [    1.046489] ioatdma: ioatdma: Intel(R) QuickData Technology Driver 4.00
> [    1.076080] ppdev: ppdev: user-space parallel port driver
> [    1.484645] ehci_pci: ehci-pci: EHCI PCI platform driver
> [    1.544643] parport: parport0: cannot grant exclusive access for device pps_parport
> [    1.556821] usbcore: usbcore: registered new interface driver usbhid
> [    1.558001] usbhid: usbhid: USB HID core driver

cheers, Joe
