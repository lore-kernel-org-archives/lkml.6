Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7607C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B1208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6B1208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeGHKdq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:33:46 -0400
Received: from ozlabs.org ([203.11.71.1]:40041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932600AbeGHKdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:33:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41NlDf431gz9s01;
        Sun,  8 Jul 2018 20:33:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        linux-mm@kvack.org, linuxram@us.ibm.com, shakeelb@google.com,
        shuah@kernel.org, Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 234/279] x86/pkeys/selftests: Adjust the self-test to fresh distros that export the pkeys ABI
In-Reply-To: <20180705071937.GA2636@gmail.com>
References: <20180618080608.851973560@linuxfoundation.org> <20180618080618.495174114@linuxfoundation.org> <fa4b973b-6037-eaef-3a63-09e8ca638527@suse.cz> <20180703114241.GA19730@kroah.com> <877emakynf.fsf@concordia.ellerman.id.au> <20180705071937.GA2636@gmail.com>
Date:   Sun, 08 Jul 2018 20:33:37 +1000
Message-ID: <87va9qj9tq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
> * Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > On Tue, Jul 03, 2018 at 01:36:43PM +0200, Vlastimil Babka wrote:
>> >> On 06/18/2018 10:13 AM, Greg Kroah-Hartman wrote:
>> >> > 4.16-stable review patch.  If anyone has any objections, please let me know.
>> >> 
>> >> So I was wondering, why backport such a considerable number of
>> >> *selftests* to stable, given the stable policy? Surely selftests don't
>> >> affect the kernel itself breaking for users?
>> >
>> > These came in as part of Sasha's "backport fixes" tool.  It can't hurt
>> > to add selftest fixes/updates to stable kernels, as for some people,
>> > they only run the selftests for the specific kernel they are building.
>> > While others run selftests for the latest kernel on older kernels, both
>> > of which are valid ways of testing.
>> 
>> I don't have a problem with these sort of patches being backported, but
>> it seems like Documentation/process/stable-kernel-rules.txt could use an
>> update?
>> 
>> I honestly don't know what the rules are anymore.
>
> Self-tests are standalone tooling which help the testing of the kernel, and it 
> makes sense to either update all of them, or none of them.

Yes I know what selftests are.

> Here it makes sense to update all of them, because if a self-test on a stable 
> kernel shows a failure then a fix is probably missing from -stable, right?

Usually, though it's not always that simple IME.

But sure, I don't have a problem with updating selftests, I said that before.

> Also note that self-test tooling *cannot possibly break the kernel*, because they 
> are not used in the kernel build process, so the normally conservative backporting 
> rules do not apply.

Right. So stable-kernel-rules.txt could use an update to mention that.


My comment was less about this actual patch and more about the new
reality of patches being backported to stable based on Sasha's tooling,
which seems to be much more liberal than anything we've done previously.

I don't generally have any objection to that process, though it possibly
could have been more widely announced. But, it would be good if
stable-kernel-rules.txt was updated to mention it.

I've had several people ask me "hey my patch got backported to stable
but I didn't ask for it - is that OK, what's going on?" etc.

I guess I should just send a patch to update it, but I don't really know
what it should say.

cheers
