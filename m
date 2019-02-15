Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6621929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfBORch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:32:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36622 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfBORch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:32:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2C5A78;
        Fri, 15 Feb 2019 09:32:36 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A433F589;
        Fri, 15 Feb 2019 09:32:33 -0800 (PST)
Subject: Re: [PATCH 13/13] x86: mm: Convert dump_pagetables to use
 walk_page_range
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-14-steven.price@arm.com>
 <59a6d402-e383-b9d0-499a-7d65b9a2d402@intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9d7d1e1f-93de-c9a8-e6bb-63696e162210@arm.com>
Date:   Fri, 15 Feb 2019 17:32:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <59a6d402-e383-b9d0-499a-7d65b9a2d402@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 17:16, Dave Hansen wrote:
> On 2/15/19 9:02 AM, Steven Price wrote:
>>  arch/x86/mm/dump_pagetables.c | 281 ++++++++++++++++++----------------
>>  1 file changed, 146 insertions(+), 135 deletions(-)
> 
> I'll look through this in more detail in a bit.  But, I'm a bit bummed
> out by the diffstat.  When I see patches add a bunch of infrastructure,
> I *really* hope for code simplification.
> 
> Looking at the diff, I think it gets there.  The code you add is
> simpler than the code you remove.  But, the diffstat is misleading.

I agree, I was disappointed myself by the diffstat. Hopefully the code
is simplier though - there's unfortunately quite a bit of boiler plate
code in the new version, but that code is at least easier to understand.

My hope is that it will be possible to move the boiler plate code into
common code (there's a lot of similarity with arm64 here). However I
wanted to get some agreement on the approach and make a non-functional
change before attempting to unify the different dump_pagetables
implementations (which is likely to cause minor functional changes).

> I'd probably address this disparity for each patch in the changelogs.

Good point, I'll try to remember for next time.

Thanks for taking a look,

Steve
