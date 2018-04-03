Return-Path: <richard.weiyang@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522714449; cv=none;
        d=google.com; s=arc-20160816;
        b=smjbGBhtudUWgEvKgtleGVJeT18zCxY1yszXi1b//DGOgMtS+9JvwU14ODcptpkbOY
         5dGfB62juwMlyT3/790v8bZ/a/aCHTiT/1+zcGO+cGb7yco7pEBTXlKBMFgdvzcoHwDf
         qo5aAnyd92a7Qq+CUojMJyx4X8dDVhMFC/+T/GmzoCGLB6yVaNyslhUcJf2i2oTiniLi
         55hlAmqABUvWaIRH2X8Qahw95WagoYiDGn+CJ4fJOBk7glRPw5pe5affSgdAu+3oKv7U
         FSCjqXn8x/cMTMF0JG0MRb7/QzG/Cq5ifMcHkTYcJYZ0YQ3FdKYzLOEYC4pxO5I4Cp8v
         HQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7+eVO1s8MLK3CLv9HCrIIDCfEOK3ucaxv0tgklxlF0A=;
        b=L2HObL6yqWvLMWHTfR9GgnpWPNbY6Cy05cQ0+wwqeUAcZIptmN/wIJygJLd/FOfCuq
         c+bgOZhHk1DtT1hrjLZwd+ML9gCeMTXi/wZA6gq7+rcvqWFV+iWqi2cvgtXA648koR5A
         4ShIwnCU8ULsCcvb+XspD9tykYBGCectg+3Y9YH5XIlq58pCnYXAiaRKaQkPpRhJI3p0
         3NGaygP8ItdJkJi+M6/Ti2Lo+kvmV1Hvvdkp5uMH39aQDNclAkG2ks4BMmXMW/FeBzkb
         3Vyl0kXVWjE2QPPJhqA0SMJl82nB/HSGhhiMoNj9mReP54hf14GJq2mp+pkdLUkuWgXp
         wHMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iWlnOuf/;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iWlnOuf/;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49b5UKnIKj5cI8EW/i/zHDVaeXuUo0p6rMVV5/nD8SKXKk9Qb2NyUIFUp0bLV6Ok1ION3flWA==
Date: Tue, 3 Apr 2018 08:14:01 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Jia He <hejianet@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Gioh Kim <gi-oh.kim@profitbricks.com>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Vacek <neelx@redhat.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, James Morse <james.morse@arm.com>,
	Steve Capper <steve.capper@arm.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>, Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>,
	Jia He <jia.he@hxt-semitech.com>
Subject: Re: [PATCH v3 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 when CONFIG_HAVE_ARCH_PFN_VALID is enable
Message-ID: <20180403001401.GA45531@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
 <1522033340-6575-2-git-send-email-hejianet@gmail.com>
 <20180328091800.GB97260@WeideMacBook-Pro.local>
 <f8e7eaca-e9f1-0ed1-a9f9-1dff81b13814@gmail.com>
 <20180402081233.GA38180@WeideMacBook-Pro.local>
 <7288ce7c-7535-a5a1-7c7c-18456e431648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7288ce7c-7535-a5a1-7c7c-18456e431648@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967673442117233?=
X-GMAIL-MSGID: =?utf-8?q?1596681826680169246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 05:17:35PM +0800, Jia He wrote:
>
>
>On 4/2/2018 4:12 PM, Wei Yang Wrote:
>> On Wed, Mar 28, 2018 at 05:49:23PM +0800, Jia He wrote:
>> > 
>> > On 3/28/2018 5:18 PM, Wei Yang Wrote:
>> > > Oops, I should reply this thread. Forget about the reply on another thread.
>> > > 
>> > > On Sun, Mar 25, 2018 at 08:02:15PM -0700, Jia He wrote:
>> > > > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> > > > where possible") optimized the loop in memmap_init_zone(). But it causes
>> > > > possible panic bug. So Daniel Vacek reverted it later.
>> > > > 
>> > > Why this has a bug? Do you have some link about it?
>> > > 
>> > > If the audience could know the potential risk, it would be helpful to review
>> > > the code and decide whether to take it back.
>> > Hi Wei
>> > Paul firstly submit a commit b92df1de5 to improve the loop in
>> > memmap_init_zone.
>> > And Daniel tried to fix a bug_on panic issue on X86 in commit 864b75f9d6b
>> > because
>> > there is evidence that this bug_on was caused by b92df1de5 [1].
>> > 
>> > But things didn't get better, 864b75f9d6b caused booting hang issue on
>> > arm{64} [2]
>> > So maintainer decided to reverted both b92df1de5 and 864b75f9d6b
>> > 
>> > [1] https://patchwork.kernel.org/patch/10251145/
>> > [2] https://lkml.org/lkml/2018/3/14/469
>> I took some time to look into the discussion, while the root cause seems not
>> clear now?
>> 
>Frankly speaking, to me the root cause of that bug_on is not completedly
>clear :-) Daniel ever gave me some hints as followed, but currently I have
>no x86 platform to understand the details.
>
>"On arm and arm64, memblock is used by default. But generic version of
>pfn_valid() is based on mem sections and memblock_next_valid_pfn()
>does not always return the next valid one but skips more resulting in
>some valid frames to be skipped (as if they were invalid). And that's
>why kernel was eventually crashing on some !arm machines."
>

This means a system with memblock is safe to use this function?

As I know, mem_section is based on memblock, so in which case
memblock_next_valid_pfn() skips a valid pfn? A little confused.

>-- 
>Cheers,
>Jia

-- 
Wei Yang
Help you, Help me
