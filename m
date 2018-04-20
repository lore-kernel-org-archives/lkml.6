Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeDTTYm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:24:42 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:39490 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751375AbeDTTYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:24:41 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3868:3871:4321:4605:5007:6119:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21222:21451:21627:30054:30060:30070:30090:30091,0,RBL:172.58.14.137:@perches.com:.lbl8.mailshell.net-62.14.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: ant22_2827b2adc430d
X-Filterd-Recvd-Size: 2331
Message-ID: <9447358d3f7cda9032b24d62dd79dacfca73fc30.camel@perches.com>
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
From: Joe Perches <joe@perches.com>
To: yuankuiz@codeaurora.org, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org, akpm@linux-foundation.org
Date: Fri, 20 Apr 2018 12:24:32 -0700
In-Reply-To: <41aec3337f05316de118357fcbd9d175@codeaurora.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
         <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
         <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
         <alpine.DEB.2.21.1804101242110.2058@nanos.tec.linutronix.de>
         <2f7755fae34bb65ef0a4b5a11c67f431@codeaurora.org>
         <c3e05a4aad4895046401519dc83fa623@codeaurora.org>
         <a98928c4a1ee719aba5f00932a41a2c3@codeaurora.org>
         <c08f28e5c0461384c8d9a9d2d8b04799@codeaurora.org>
         <aaa5ae49ff33ce9c83c6cf520cc83c0b@codeaurora.org>
         <41aec3337f05316de118357fcbd9d175@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 14:44 +0800, yuankuiz@codeaurora.org wrote:
> On 2018-04-20 09:47 AM, yuankuiz@codeaurora.org wrote:
[]
> > [ZJ] Further prototyping has been given based on gcc for both of
> > x86_64 and armv8-a,
> >      unsigned int and bool share the same 1 bytes without the
> > addtional storage for sure.
> >      Open this and welcome if any other difference behaviour could be 
> > captured.
> 
> [ZJ] Typo.. change 4 bytes above to 1 byte actually.

Not really.

unsigned int is 4 and bool is generally 1.
Alignment padding after a bool may exist.
