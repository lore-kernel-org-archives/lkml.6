Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeDTBbN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:31:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbeDTBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:31:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Apr 2018 09:31:08 +0800
From: yuankuiz@codeaurora.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
In-Reply-To: <a74acb94090555b96702de7a15f7dedf@codeaurora.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <20180410123305.GF4082@hirez.programming.kicks-ass.net>
 <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
 <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
 <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
 <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
 <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
 <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>
 <alpine.DEB.2.20.1804120816130.3559@hadrien>
 <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
 <alpine.DEB.2.20.1804142315300.2750@hadrien>
 <e7cbe275136b86083ff70d9af26f41bf@codeaurora.org>
 <5341b3b1945c4c1dbf7b356b1a7a4bd6ce304287.camel@perches.com>
 <alpine.DEB.2.20.1804190639410.2830@hadrien>
 <b17a1d0de54ca0db12bd38a0b7fb20a5befb6778.camel@perches.com>
 <alpine.DEB.2.20.1804190705580.2830@hadrien>
 <473cf88b25731a3729a3566abbebd0b6@codeaurora.org>
 <a74acb94090555b96702de7a15f7dedf@codeaurora.org>
Message-ID: <5a0f2c2e5fe8626c9aead3c035c12dd8@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 06:42 PM, yuankuiz@codeaurora.org wrote:
> On 2018-04-19 02:48 PM, yuankuiz@codeaurora.org wrote:
>> On 2018-04-19 01:16 PM, Julia Lawall wrote:
>>> On Wed, 18 Apr 2018, Joe Perches wrote:
>>> 
>>>> On Thu, 2018-04-19 at 06:40 +0200, Julia Lawall wrote:
>>>> >
>>>> > On Wed, 18 Apr 2018, Joe Perches wrote:
>>>> >
>>>> > > On Tue, 2018-04-17 at 17:07 +0800, yuankuiz@codeaurora.org wrote:
>>>> > > > Hi julia,
>>>> > > >
>>>> > > > On 2018-04-15 05:19 AM, Julia Lawall wrote:
>>>> > > > > On Wed, 11 Apr 2018, Joe Perches wrote:
>>>> > > > >
>>>> > > > > > On Thu, 2018-04-12 at 08:22 +0200, Julia Lawall wrote:
>>>> > > > > > > On Wed, 11 Apr 2018, Joe Perches wrote:
>>>> > > > > > > > On Wed, 2018-04-11 at 09:29 -0700, Andrew Morton wrote:
>>>> > > > > > > > > We already have some 500 bools-in-structs
>>>> > > > > > > >
>>>> > > > > > > > I got at least triple that only in include/
>>>> > > > > > > > so I expect there are at probably an order
>>>> > > > > > > > of magnitude more than 500 in the kernel.
>>>> > > > > > > >
>>>> > > > > > > > I suppose some cocci script could count the
>>>> > > > > > > > actual number of instances.  A regex can not.
>>>> > > > > > >
>>>> > > > > > > I got 12667.
>>>> > > > > >
>>>> > > > > > Could you please post the cocci script?
>>>> > > > > >
>>>> > > > > > > I'm not sure to understand the issue.  Will using a bitfield help if there
>>>> > > > > > > are no other bitfields in the structure?
>>>> > > > > >
>>>> > > > > > IMO, not really.
>>>> > > > > >
>>>> > > > > > The primary issue is described by Linus here:
>>>> > > > > > https://lkml.org/lkml/2017/11/21/384
>>>> > > > > >
>>>> > > > > > I personally do not find a significant issue with
>>>> > > > > > uncontrolled sizes of bool in kernel structs as
>>>> > > > > > all of the kernel structs are transitory and not
>>>> > > > > > written out to storage.
>>>> > > > > >
>>>> > > > > > I suppose bool bitfields are also OK, but for the
>>>> > > > > > RMW required.
>>>> > > > > >
>>>> > > > > > Using unsigned int :1 bitfield instead of bool :1
>>>> > > > > > has the negative of truncation so that the uint
>>>> > > > > > has to be set with !! instead of a simple assign.
>>>> > > > >
>>>> > > > > At least with gcc 5.4.0, a number of structures become larger with
>>>> > > > > unsigned int :1. bool:1 seems to mostly solve this problem.  The
>>>> > > > > structure
>>>> > > > > ichx_desc, defined in drivers/gpio/gpio-ich.c seems to become larger
>>>> > > > > with
>>>> > > > > both approaches.
>>>> > > >
>>>> > > > [ZJ] Hopefully, this could make it better in your environment.
>>>> > > >       IMHO, this is just for double check.
>>>> > >
>>>> > > I doubt this is actually better or smaller code.
>>>> > >
>>>> > > Check the actual object code using objdump and the
>>>> > > struct alignment using pahole.
>>>> >
>>>> > I didn't have a chance to try it, but it looks quite likely to result in a
>>>> > smaller data structure based on the other examples that I looked at.
>>>> 
>>>> I _really_ doubt there is any difference in size between the
>>>> below in any architecture
>>>> 
>>>> struct foo {
>>>> 	int bar;
>>>> 	bool baz:1;
>>>> 	int qux;
>>>> };
>>>> 
>>>> and
>>>> 
>>>> struct foo {
>>>> 	int bar;
>>>> 	bool baz;
>>>> 	int qux;
>>>> };
>>>> 
>>>> Where there would be a difference in size is
>>>> 
>>>> struct foo {
>>>> 	int bar;
>>>> 	bool baz1:1;
>>>> 	bool baz2:1;
>>>> 	int qux;
>>>> };
>>>> 
>>>> and
>>>> 
>>>> struct foo {
>>>> 	int bar;
>>>> 	bool baz1;
>>>> 	bool baz2;
>>>> 
>>>> int qux;
>>>> };
> [ZJ] Even though, two bool:1 are grouped in the #3, finally 4 bytes are 
> padded
>      due for int is the most significant in the type size.
>      At least, they are all the same per x86 and arm based on gcc.(12 
> bytes).
[ZJ] However, #3 could be difference to #4 if compiling it if the size 
of (_Bool)
      is a bigger value(4 bytes maybe available in Alpha EV45 for ex.).
>>> 
>>> In the situation of the example there are two bools together in the 
>>> middle
>>> of the structure and one at the end.  Somehow, even converting to 
>>> bool:1
>>> increases the size.  But it seems plausible that putting all three 
>>> bools
>>> together and converting them all to :1 would reduce the size.  I 
>>> don't
>>> know.  The size increase (more than 8 bytes) seems out of proportion 
>>> for 3
>>> bools.
>> [ZJ] Typically, addition saving is due for difference padding.
>>> 
>>> I was able to check around 3000 structures that were not declared 
>>> with any
>>> attributes, that don't declare named types internally, and that are
>>> compiled for x86.  Around 10% become smaller whn using bool:1, 
>>> typically
>>> by at most 8 bytes.
> [ZJ] As my example, int (*)() requested 8 bytes in x86 arch, then 8
> bytes is similiar to that.
>      While it request 4 bytes in arm arch. Typically, my previous
> example struct can
>      reach to 32 bytes in x86 arch(compared to 40 bytes for original 
> version).
>      Similarly, 20 bytes in arm arch(compared to 24 bytes per original 
> version).
>>> 
>>> julia
>>> 
>>>> 
>>>> 
