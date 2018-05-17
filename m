Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeEQTPl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:15:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeEQTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:15:17 -0400
Date: Thu, 17 May 2018 21:14:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Joe Perches <joe@perches.com>
cc: Borislav Petkov <bp@alien8.de>, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/cleanups] x86: Remove pr_fmt duplicate logging
 prefixes
In-Reply-To: <a341a36ed75712b6c624a14aa694843ee1ef948e.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1805172114240.1698@nanos.tec.linutronix.de>
References: <e7b709a2b040af7faa81b0aa2c3a125aed628a82.1525964383.git.joe@perches.com>  <tip-1de392f5d5e803663abbd8ed084233f154152bcd@git.kernel.org>  <20180517182659.GB27807@pd.tnic> <a341a36ed75712b6c624a14aa694843ee1ef948e.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Joe Perches wrote:
> On Thu, 2018-05-17 at 20:27 +0200, Borislav Petkov wrote:
> > On Sun, May 13, 2018 at 12:27:45PM -0700, tip-bot for Joe Perches wrote:
> > > Commit-ID:  1de392f5d5e803663abbd8ed084233f154152bcd
> > > Gitweb:     https://git.kernel.org/tip/1de392f5d5e803663abbd8ed084233f154152bcd
> > > Author:     Joe Perches <joe@perches.com>
> > > AuthorDate: Thu, 10 May 2018 08:45:30 -0700
> > > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > > CommitDate: Sun, 13 May 2018 21:25:18 +0200
> > > 
> > > x86: Remove pr_fmt duplicate logging prefixes
> > > 
> > > Converting pr_fmt from a default simple #define to use KBUILD_MODNAME
> > > added some duplicate prefixes.
> > > 
> > > Remove the duplicate prefixes.
> []
> > Maybe I'm missing something but this dropped the prefixes now
> > completely:
> > 
> > -e820: BIOS-provided physical RAM map:
> > +BIOS-provided physical RAM map:
> > 
> > -e820: last_pfn = 0x43f000 max_arch_pfn = 0x400000000
> > +last_pfn = 0x43f000 max_arch_pfn = 0x400000000
> > 
> > -e820: last_pfn = 0x9d000 max_arch_pfn = 0x400000000
> > +last_pfn = 0x9d000 max_arch_pfn = 0x400000000
> > 
> > ...
> > 
> > I don't think that was the intention.
> 
> Hi Borislav
> 
> It wasn't and isn't the intention.
> 
> This is a patch _series_, and all of the patches
> from 4-18 depend on patch 3 which converts the
> generic define in include/linux/printk.h
> 
> from
> 	#define pr_fmt(fmt) fmt
> to
> 	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> Perhaps a better option, which could be done in
> a v2 of the series, is to add a temporary
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> to each file modified in patches 4-18 and then
> allow the follow-on script described in the 0/18
> cover letter to remove those #defines

Yes, I think thats the right thing todo.

Thanks,

	tglx
