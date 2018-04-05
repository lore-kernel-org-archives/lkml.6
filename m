Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDENvj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:51:39 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:56684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751165AbeDENvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:51:37 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:334:355:368:369:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4362:5007:7903:8603:10004:10400:10481:10848:11026:11232:11658:11914:12048:12740:12760:12895:13069:13146:13161:13229:13230:13311:13357:13439:14096:14097:14659:14721:19900:21080:21433:21451:21627:30003:30012:30054:30089:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: team03_2ad5b3cf49351
X-Filterd-Recvd-Size: 2273
Message-ID: <1522936292.11185.15.camel@perches.com>
Subject: Re: [PATCH 00/12] Ethernet: Add and use ether_<type>_addr globals
From: Joe Perches <joe@perches.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Cc: linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com
Date: Thu, 05 Apr 2018 06:51:32 -0700
In-Reply-To: <e0ab9616-64fa-cdbc-7a77-7e25d70c1a52@nbd.name>
References: <cover.1522479607.git.joe@perches.com>
         <e0ab9616-64fa-cdbc-7a77-7e25d70c1a52@nbd.name>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 15:27 +0200, Felix Fietkau wrote:
> On 2018-03-31 09:05, Joe Perches wrote:
> > There are many local static and non-static arrays that are used for
> > Ethernet broadcast address output or comparison.
> > 
> > Centralize the array into a single separate file and remove the local
> > arrays.
> 
> I suspect that for many targets and configurations, the local arrays
> might actually be smaller than exporting a global.

I tried x86-64 allnoconfig and defconfig.
Those both did not increase vmlinux size.

The defconfig actually got smaller, but that might have been
some object alignment oddity.

>  You have to factor in
> not just the .text size, but the fact that referencing an exported
> symbol needs a .reloc entry as well, which also eats up some space (at
> least when the code is being built as module).

Thanks, the modules I built got smaller.

> In my opinion, your series probably causes more bloat in common
> configurations instead of reducing it.
> 
> You're also touching several places that could easily use
> eth_broadcast_addr and eth_zero_addr. I think making those changes would
> be more productive than what you did in this series.

Doubtful. AFAIK: possible unaligned addresses.
