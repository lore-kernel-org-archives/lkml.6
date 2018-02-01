Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeBASke (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:40:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeBASk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:40:29 -0500
Message-ID: <1517510422.2755.5.camel@redhat.com>
Subject: Re: [PATCH] x86/microcode/intel: print previous microcode revision
 during early update
From: Petr Oros <poros@redhat.com>
Reply-To: poros@redhat.com
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2018 19:40:22 +0100
In-Reply-To: <20180126144918.7jiaezmdhjsiman5@pd.tnic>
References: <20180126103451.16863-1-poros@redhat.com>
         <20180126104109.slxxoq4vkqytqjxd@pd.tnic>
         <1516967135.2801.1.camel@redhat.com>
         <20180126115800.bvqrzik2f3hmmiah@pd.tnic>
         <1516974600.2801.10.camel@redhat.com>
         <20180126144918.7jiaezmdhjsiman5@pd.tnic>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov píše v Pá 26. 01. 2018 v 15:49 +0100:
> On Fri, Jan 26, 2018 at 02:50:00PM +0100, Petr Oros wrote:
> > But what in production? Edit boot params, restart server, grep /proc/cpuinfo and
> > restart again? Why i can not read it just from dmesg?
> 
> Because you don't need the previous revision.
> 
> You only *happen* to need it now but that is being addressed too with
> the blacklisting. And when you have broken microcode, it will say:
> 
> +               pr_warn("Intel Spectre v2 broken microcode detected; disabling SPEC_CTRL\n");
> 
> and if you have microcode which doesn't have IBRS, there won't be
> "spec_ctrl" in /proc/cpuinfo.
> 
> I don't want people to start paying attention to microcode
> revision numbers with the gazillion different revisions and
> family/model/steppings out there and the crazy confusion that will ensue
> from this.
> 

We talk about dmesg log, it is place for diagnostic messages.
I think, people expected gazillion numbers here.

I adding only one number (microcode version) into log and only if patch is
applied. This is good also for future bugs, and for example for tools like
sosreport.

It is really better to have microcode version ready and not try find it and try
to collect after problem...

Btw: with hot microcode patch is possible to get previous version from dmesg
[    0.680519] microcode: sig=0x306c3, pf=0x10, revision=0x23
Only with early it is not possible.

Thanks,
-Petr
