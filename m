Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90336C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629DB218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfA3KTZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:19:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:45219 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfA3KTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:19:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 02:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="112264877"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2019 02:19:21 -0800
Received: from irsmsx112.ger.corp.intel.com (10.108.20.5) by
 IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 10:19:21 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 irsmsx112.ger.corp.intel.com ([169.254.1.84]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 10:19:20 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Thread-Topic: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Thread-Index: AQHUtwJjl6FToBsL5EumdKDVAgvWOaXGR+kAgAA6+MCAAKhAgIAAbTig
Date:   Wed, 30 Jan 2019 10:19:20 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B9A2B5@IRSMSX102.ger.corp.intel.com>
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+aw1L7u+WJb8Ug8ED2bESfZccVK3o_7OBbjyQbQrLskbg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B99139@IRSMSX102.ger.corp.intel.com>
 <20190130032701.GA3739@andrea>
In-Reply-To: <20190130032701.GA3739@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzIyNDEyNzctNDg0Yi00OThiLWFlYWYtNmNhZWVjM2Y2ZGFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicDdxaG9iU1QxNzZwNnZHcXVRVHBIYjRCdXlob2JtYnd2SjZmSnQ5UlhRQ0UwUkVsbEhcL0ppQjVOS1ZKY2ZcL2ZQIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > So, you are saying that ACQUIRE does not guarantee that "po-later stores
> > on the same CPU and all propagated stores from other CPUs
> > must propagate to all other CPUs after the acquire operation "?
> > I was reading about acquire before posting this and trying to understand,
> > and this was my conclusion that it should provide this, but I can easily be wrong
> > on this.
> >
> > Andrea, Peter, could you please comment?
> 
> Short version:  I am not convinced by the above sentence, and I suggest
> to remove it (as done in
> 
>   http://lkml.kernel.org/r/20190128142910.GA7232@andrea ).

Sorry, I misunderstood your previous email on this. I somehow misread it
that " A-cumulative property" as a notion that is not used in LKMM for ACQUIRE,
so I should not mention the notion, but the guarantees stay, but it is guarantees
that are also wrong, which is much worse. 

> 
> ---
> To elaborate:  I think that we should first discuss the meaning of that
> "[...] after the acquire operation (does)",  because there is no notion
> of "ACQUIRE (or more generally, load) propagation" in the LKMM:
> 
> Stores propagate (after being executed) to other CPUs.  Loads _execute_
> (possibly multiple times /speculatively, but this is irrelevant for the
> discussion below).
> 
> A detailed, but still informal, description of these concepts is in:
> 
>   tools/memory-model/Documentation/explanation.txt
> 
> (c.f., in particular, section "AN OPERATIONAL MODEL"); I can illustrate
> them with an example:
> 
> 	{ initially: x=0, y=0; }
> 
> 	CPU0			CPU1
> 	--------------------------------------
> 	LOAD-ACQUIRE x=0	LOAD y=1
> 	STORE y=1
> 
> In this scenario,
> 
>   a) CPU0's "LOAD-ACQUIRE x=0" executes before CPU0's "STORE y=1"
>      executes (this is guaranteed by the ACQUIRE),
> 
>   b) CPU0's "STORE y=1" executes before "STORE y=1" propagates to
>      CPU1 (a store cannot be propagated before being executed),
> 
>   c) CPU0's "STORE y=1" propagates to CPU1 before CPU1's "LOAD y=1"
>      executes (since CPU1 "sees the store").
> 
> The example also illustrates the following property:
> 
>   ACQUIRE guarantees that po-later stores on the same CPU must
>   propagate to all other CPUs after the acquire _executes_.
> 
> (combine (a) and (b) ).
> 
> OTOH, please notice that:
> 
>   ACQUIRE does _NOT_ guarantee that all propagated stores from
>   other CPUs (to the CPU executing the ACQUIRE) must propagate
>   to all other CPUs after the acquire operation _executes_.

Thank you very much Andrea, this example and explanation clarifies it nicely!
So Acquire only really affects the current CPU "view of the world" and operation
propagation from it, and not anything else, which is actually very logical.

My initial confusion was because I was thinking of ACQUIRE as a pair
for RELEASE, i.e. it should provide a complementary guarantees to 
 RELEASE ones, just on po-later operations. 

> 
> In fact, we've already seen how full barriers can be used to break such
> "guarantee"; for example, in
> 
> 	{ initially: x=0, y=0; }
> 
> 	CPU0			CPU1
> 		...
> 	---------------------------------------------------
> 	STORE x=1		LOAD x=1
> 				FULL-BARRIER
> 				LOAD-ACQUIRE y=0
> 
> the full barrier forces CPU0's "STORE x=1" (seen by/propagated to CPU1)
> to be propagated to all CPUs _before_ "LOAD-ACQUIRE y=0" is executed.
> 
> Does this make sense?

Yes, thank you again! I think it would take me still a long while to be familiar
with all these notions and not to be confused even in simple things. 

> 
> 
> > > Is ACQUIRE strictly stronger than control dependency?
> >
> > In my understanding yes.
> 
> +1 (or we have a problem)
> 
> 
> >
> > > It generally looks so unless there is something very subtle that I am
> > > missing. If so, should we replace it with just "RELEASE ordering +
> > > ACQUIRE ordering on success"? Looks simpler with less magic trickery.
> >
> > I was just trying to mention all the applicable orderings/guarantees.
> > I can remove "control dependency" part if it is easier for people to understand
> > (the main goal of documentation).
> 
> This sounds like a good idea; thank you, Dmitry, for pointing this out.

I will remove it. So, the rule that we always mention the strongest type of barrier
When we mention some ordering guarantees, right? 

Best Regards,
Elena.
