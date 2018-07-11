Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=BUG6152_INVALID_DATE_TZ_ABSURD,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,L_SPAM_TOOL_13,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25FDC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA6320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA6320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mageia.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbeGKUCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:02:11 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:7726 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeGKUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:02:11 -0400
Subject: Re: [PATCH 00/39 v7] PTI support for x86-32
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>
CC:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <CA+55aFzrG+GV5ySVUiiod8Va5P0_vmUuh25Pner1r7c_aQgH9g@mail.gmail.com>
 <nycvar.YFH.7.76.1807111923420.997@cbobk.fhfr.pm>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <1225b274-534b-cc32-54eb-aba89efba494@mageia.org>
Date:   Wed, 11 Jul 2018 22:56:18 +0259
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1807111923420.997@cbobk.fhfr.pm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0201.5B4660E1.0057,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 2018-07-11 kl. 20:28, skrev Jiri Kosina:
> On Wed, 11 Jul 2018, Linus Torvalds wrote:
> 
>> It's the testing that worries me most. Pretty much no developers run
>> 32-bit any more, and I'd be most worried about the odd interactions that
>> might be hw-specific. Some crazy EFI mapping setup or the similar odd
>> case that simply requires a particular configuration or setup.
>>
>> But I guess those issues will never be found until we just spring this
>> all on the unsuspecting public.
> 
> FWIW we shipped Joerg's 32bit KAISER kernel out to our 32bit users (on old
> product where we still support it) on Apr 25th already (and some issues
> have been identified since then because of that). So it (or its port to
> 3.0, to be more precise :p) already did receive some crowd-testing.
> 

And Mageia has had v2 since February 13th patched into 4.14 -longterm, 
then updated to v3 at March 5th, and updated to v4 at March 19th and 
been running that since then (since v5 is rebased on v4.17 we stayed 
with v4)


So, here is another "lets merge it upstream" vote :)


--
Thomas
