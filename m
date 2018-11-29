Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E96C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E502145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E502145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeK3Elj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:41:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:45924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730407AbeK3Elj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:41:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D166BABCE;
        Thu, 29 Nov 2018 17:35:29 +0000 (UTC)
Date:   Thu, 29 Nov 2018 18:35:26 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, David.Laight@aculab.com, bp@alien8.de,
        julia@ni.com, jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation
 for x86-64
In-Reply-To: <6C359EF7-B2B6-4FED-96EB-CB7C91918763@amacapital.net>
Message-ID: <nycvar.YFH.7.76.1811291831560.21108@cbobk.fhfr.pm>
References: <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129170742.GC9027@hirez.programming.kicks-ass.net> <6C359EF7-B2B6-4FED-96EB-CB7C91918763@amacapital.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Andy Lutomirski wrote:

> Does anyone know what the actual hardware semantics are?  The SDM is not 
> particularly informative unless I looked at the wrong section.

I don't think SDM answers all the questions there, unfortunately.

I vaguely remember that back then when I was preparing the original 
text_poke_bp() implementation, hpa had to provide some answers directly 
from inner depths of Intel ... see fd4363fff3 ("x86: Introduce int3 
(breakpoint)-based instruction patching") for reference.

-- 
Jiri Kosina
SUSE Labs

