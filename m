Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeEQSnK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:43:10 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:46163 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750924AbeEQSnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:43:09 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2198:2199:2200:2393:2525:2553:2559:2563:2682:2685:2828:2859:2914:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3167:3353:3590:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:8957:9025:10004:10400:10848:10967:11026:11232:11658:11914:12043:12048:12266:12296:12438:12555:12663:12740:12760:12895:12986:13069:13071:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21365:21433:21451:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: car53_552f246eb3210
X-Filterd-Recvd-Size: 2659
Message-ID: <a341a36ed75712b6c624a14aa694843ee1ef948e.camel@perches.com>
Subject: Re: [tip:x86/cleanups] x86: Remove pr_fmt duplicate logging prefixes
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org
Date: Thu, 17 May 2018 11:43:04 -0700
In-Reply-To: <20180517182659.GB27807@pd.tnic>
References: <e7b709a2b040af7faa81b0aa2c3a125aed628a82.1525964383.git.joe@perches.com>
         <tip-1de392f5d5e803663abbd8ed084233f154152bcd@git.kernel.org>
         <20180517182659.GB27807@pd.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-17 at 20:27 +0200, Borislav Petkov wrote:
> On Sun, May 13, 2018 at 12:27:45PM -0700, tip-bot for Joe Perches wrote:
> > Commit-ID:  1de392f5d5e803663abbd8ed084233f154152bcd
> > Gitweb:     https://git.kernel.org/tip/1de392f5d5e803663abbd8ed084233f154152bcd
> > Author:     Joe Perches <joe@perches.com>
> > AuthorDate: Thu, 10 May 2018 08:45:30 -0700
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Sun, 13 May 2018 21:25:18 +0200
> > 
> > x86: Remove pr_fmt duplicate logging prefixes
> > 
> > Converting pr_fmt from a default simple #define to use KBUILD_MODNAME
> > added some duplicate prefixes.
> > 
> > Remove the duplicate prefixes.
[]
> Maybe I'm missing something but this dropped the prefixes now
> completely:
> 
> -e820: BIOS-provided physical RAM map:
> +BIOS-provided physical RAM map:
> 
> -e820: last_pfn = 0x43f000 max_arch_pfn = 0x400000000
> +last_pfn = 0x43f000 max_arch_pfn = 0x400000000
> 
> -e820: last_pfn = 0x9d000 max_arch_pfn = 0x400000000
> +last_pfn = 0x9d000 max_arch_pfn = 0x400000000
> 
> ...
> 
> I don't think that was the intention.

Hi Borislav

It wasn't and isn't the intention.

This is a patch _series_, and all of the patches
from 4-18 depend on patch 3 which converts the
generic define in include/linux/printk.h

from
	#define pr_fmt(fmt) fmt
to
	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Perhaps a better option, which could be done in
a v2 of the series, is to add a temporary
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
to each file modified in patches 4-18 and then
allow the follow-on script described in the 0/18
cover letter to remove those #defines

cheers, Joe
