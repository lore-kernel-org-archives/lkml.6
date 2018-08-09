Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C416215A3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C416215A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHIO6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:58:23 -0400
Received: from ozlabs.org ([203.11.71.1]:60975 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbeHIO6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:58:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41mSNM5TPgz9s4c;
        Thu,  9 Aug 2018 22:33:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rashmica <rashmicy@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_hexdump: fix failure on big endian cpu
In-Reply-To: <17a90b003bcc2f1dda2b92b65f16c212ffddc571.camel@linux.intel.com>
References: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr> <87mutxb9qy.fsf@concordia.ellerman.id.au> <7857c69a-a209-541b-b2e1-9fe2e288ca65@gmail.com> <87ftzo9i77.fsf@concordia.ellerman.id.au> <17a90b003bcc2f1dda2b92b65f16c212ffddc571.camel@linux.intel.com>
Date:   Thu, 09 Aug 2018 22:33:38 +1000
Message-ID: <8736vnafdp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> On Thu, 2018-08-09 at 16:18 +1000, Michael Ellerman wrote:
>> rashmica <rashmicy@gmail.com> writes:
>> > On 08/08/18 17:25, Michael Ellerman wrote:
>> > > Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> > > > 
>> > mpe I sent a patch doing that awhile ago and you obviously didn't
>> > like
>> > it because you never merged it :P
>
> Hmm... I (as an author of the test case) never saw that patch.

I probably told Rashmica to send it to the linuxppc list and then I was
meant to follow up who should merge it. So my fault.

>> Sorry, I wasn't sure who should merge it, and never followed up.
>
> lib/* most of the time under Andrew's responsibility, though since it's
> orphaned in MAINTAINERS, anyone can push, though, I think, it's good to
> notify Andrew.

Yeah. I was going to apply it with your Ack because it seems pretty
uncontroversial, and there's nothing else in linux-next touching that
file so it should be conflict-free.

I guess I'll wait and see if Andrew would prefer to take it.

cheers
