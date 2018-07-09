Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207FC20883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207FC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeGID2T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:28:19 -0400
Received: from ozlabs.org ([203.11.71.1]:54589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932656AbeGID2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:28:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41P9lJ2Hq9z9rxs;
        Mon,  9 Jul 2018 13:28:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        linux-mm@kvack.org, linuxram@us.ibm.com, shakeelb@google.com,
        shuah@kernel.org, Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 234/279] x86/pkeys/selftests: Adjust the self-test to fresh distros that export the pkeys ABI
In-Reply-To: <20180708132519.GA29528@kroah.com>
References: <20180618080608.851973560@linuxfoundation.org> <20180618080618.495174114@linuxfoundation.org> <fa4b973b-6037-eaef-3a63-09e8ca638527@suse.cz> <20180703114241.GA19730@kroah.com> <877emakynf.fsf@concordia.ellerman.id.au> <20180705071937.GA2636@gmail.com> <87va9qj9tq.fsf@concordia.ellerman.id.au> <20180708132519.GA29528@kroah.com>
Date:   Mon, 09 Jul 2018 13:28:09 +1000
Message-ID: <87a7r19jg6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Sun, Jul 08, 2018 at 08:33:37PM +1000, Michael Ellerman wrote:
...
>> 
>> My comment was less about this actual patch and more about the new
>> reality of patches being backported to stable based on Sasha's tooling,
>> which seems to be much more liberal than anything we've done previously.
>> 
>> I don't generally have any objection to that process, though it possibly
>> could have been more widely announced. But, it would be good if
>> stable-kernel-rules.txt was updated to mention it.
>> 
>> I've had several people ask me "hey my patch got backported to stable
>> but I didn't ask for it - is that OK, what's going on?" etc.
>
> Why didn't those people just ask us?  To not do so is very strange, it's
> not like we are hard to find :)

It's not very strange, it's completely normal behaviour. People are
afraid of asking dumb questions in public, so they ask someone
privately.

And the general sentiment has been "I didn't think that patch met the
stable rules, but I'm happy for it to be backported".

>> I guess I should just send a patch to update it, but I don't really know
>> what it should say.
>
> I don't think it really needs any changes, as the selftests is just a
> corner case that is easily explained if anyone cares enough to actually
> ask :)

Yeah again I'm not really concerned about selftests, I should have
replied to a different patch to start this discussion. My bad.

cheers
