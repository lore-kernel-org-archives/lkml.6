Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeCPPCF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:02:05 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35487 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeCPPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:02:02 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Thread-Topic: Do we need to disable preemption in flush_tlb_range()?
Thread-Index: AQHTsW/Ph/wHPbUur0SfkKmu1J1Lq6PQL76AgADLfoCAABQpAIABmz4AgABRA4A=
Date: Fri, 16 Mar 2018 15:01:22 +0000
Message-ID: <1521212481.4805.2.camel@synopsys.com>
References: <1519917189.13866.6.camel@synopsys.com>
         <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
         <20180315082720.GT4064@hirez.programming.kicks-ass.net>
         <1521106770.11552.70.camel@synopsys.com>
         <20180316101124.GB4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180316101124.GB4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <44DB983CB1008B4F89AD99B8A38C0138@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2GF2ff1011716

Hi Peter,

On Fri, 2018-03-16 at 11:11 +0100, Peter Zijlstra wrote:
> On Thu, Mar 15, 2018 at 09:39:31AM +0000, Alexey Brodkin wrote:
> > Hi Peter,
> > 
> > On Thu, 2018-03-15 at 09:27 +0100, Peter Zijlstra wrote:
> > > On Wed, Mar 14, 2018 at 01:19:01PM -0700, Vineet Gupta wrote:
> > > > +CC Peter since we have his attention ;-)
> > > 
> > > Yeah, timezone collision there, I typically sleep at 1am ;-)
> > > 
> > > > On 03/01/2018 07:13 AM, Alexey Brodkin wrote:
> > > > > Hi Vineet,
> > > > > 
> > > > > Just noticed that in comments for smp_call_function_many() it is said that
> > > > > preemption must be disabled during its execution. And that function gets executed
> > > > > among other ways like that:
> > > > > -------------------------->8-----------------------
> > > > >    flush_tlb_range()
> > > > >      -> on_each_cpu_mask()
> > > > >           -> smp_call_function_many()
> > > > > -------------------------->8-----------------------
> > > > 
> > > > In general I prefer not to - Peter what say you ?
> > > 
> > > The comment with smp_call_function_many() is correct, it relies on
> > > preemption being disabled in a number of ways. I would expect
> > > this_cpu_ptr() for example to complain when used with preemption
> > > enabled (CONFIG_DEBUG_PREEMPT).
> 
> So on_each_cpu_mask() already disables preemption around calling
> smp_call_function_many().

Right that happens in get_cpu() so then we're golden here.
Thanks for pointing out - was not clear immediately from the code :)

-Alexey
