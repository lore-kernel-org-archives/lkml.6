Return-Path: <erosca@de.adit-jv.com>
X-Google-Smtp-Source: AG47ELtto+tVLhncKEaXvKVcKbmv6Zm5ncVyunWGQGETfscyUi/TKgAUgJr8L4PntCFk/ODZ3AdZ
ARC-Seal: i=1; a=rsa-sha256; t=1521723136; cv=none;
        d=google.com; s=arc-20160816;
        b=1CEUX0NNhUevp4slDCrfkNNdmrrZSM2uD6/2zJEiuzHgN1sxxzT05R6F+lj627cQyV
         TwmSl3k3P9n816d8mosXfgI8pj14EKtB+7ODG207JnYqTQuQYECQape+m7KoUwZE69EE
         ABnqYd5EsmspV39N1YFeHJFsOZfVyOPeWgvgAZELXC/mH0zBLV52QrAnNiJcEq7bycXX
         8WPEaDgqGY7i6W6RfrWrpXwSzitYe0zKPLqI5cFfJ0cbPPLcEztJTcpWwF+wjr5APBTO
         U/2MaRzPreM+0XPCMEaByrN41Ew7PQf3qe6ZVmWPqEQ7Wwxfgzsw2VsWHegDQPvmsVvW
         NTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=AST8vpBL2oAs0lIfNkXVu0r94l94pdVTom+JwLLAqBA=;
        b=vvTWa0ge+ujcVKulg8BiLSG8dJppIhlXk1QhzyElQJLvHHHFrsJ0DDoc7bd+1CxGIL
         0aeCSJ3z0DO0qV11anec6W+NW6Le5hLKeEoTohljH+4PvGHlm+NkfvCfsbNYMZg3klBe
         YJOdJqZ4BgzxpG8hRv50ZdOc0LRy2eGvny0LdrkCi4jHItrUAQJvuBOcm8IwFksHLJOs
         e5PNlvgZbHg+bkIlVns715YP9IhUuyWvpbz5imcyHMp7NXvbCo0rVbIhfWOts98rbebz
         gikuDnvTqvWOwmAFRE9C5sU9DaQRZpg3zKvfIWouUYpRDH0sAHsv+GTs+oWA49W2paZ6
         w45Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of erosca@de.adit-jv.com designates 62.225.105.245 as permitted sender) smtp.mailfrom=erosca@de.adit-jv.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of erosca@de.adit-jv.com designates 62.225.105.245 as permitted sender) smtp.mailfrom=erosca@de.adit-jv.com
Date: Thu, 22 Mar 2018 13:52:04 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Jia He <hejianet@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
	<will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Daniel Jordan
	<daniel.m.jordan@oracle.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Gioh Kim <gi-oh.kim@profitbricks.com>, Steven Sistare
	<steven.sistare@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, open list
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, James Morse
	<james.morse@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Steve
 Capper <steve.capper@arm.com>, <x86@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>, Petr Tesarik
	<ptesarik@suse.com>, YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Andrey
 Ryabinin <aryabinin@virtuozzo.com>, Nikolay Borisov <nborisov@suse.com>, Jia
 He <jia.he@hxt-semitech.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 1/4] mm: page_alloc: reduce unnecessary binary search in
 memblock_next_valid_pfn()
Message-ID: <20180322125204.GA8892@vmlxhi-102.adit-jv.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
 <1521619796-3846-2-git-send-email-hejianet@gmail.com>
 <CACjP9X92M3izDD-1s1vY6n6Hx3mxqNqeM4f+T3RNnBo8kjP4Qg@mail.gmail.com>
 <3f208ebe-572f-f2f6-003e-5a9cf49bb92f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f208ebe-572f-f2f6-003e-5a9cf49bb92f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534036182363270?=
X-GMAIL-MSGID: =?utf-8?q?1595642358736744482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:28:18PM +0800, Jia He wrote:
> 
> 
> On 3/21/2018 6:14 PM, Daniel Vacek Wrote:
> >On Wed, Mar 21, 2018 at 9:09 AM, Jia He <hejianet@gmail.com> wrote:
> >>Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> >>where possible") optimized the loop in memmap_init_zone(). But there is
> >>still some room for improvement. E.g. if pfn and pfn+1 are in the same
> >>memblock region, we can simply pfn++ instead of doing the binary search
> >>in memblock_next_valid_pfn.
> >There is a revert-mm-page_alloc-skip-over-regions-of-invalid-pfns-where-possible.patch
> >in -mm reverting b92df1de5d289c0b as it is fundamentally wrong by
> >design causing system panics on some machines with rare but still
> >valid mappings. Basically it skips valid pfns which are outside of
> >usable memory ranges (outside of memblock memory regions).
> Thanks for the infomation.
> quote from you patch description:
> >But given some specific memory mapping on x86_64 (or more generally
> theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID) > the
> implementation also skips valid pfns which is plain wrong and causes >
> 'kernel BUG at mm/page_alloc.c:1389!'
> 
> Do you think memblock_next_valid_pfn can remain to be not reverted on arm64
> with CONFIG_HAVE_ARCH_PFN_VALID? Arm64 can benifit from this optimization.

I confirm that the boot time of Rcar-H3 arm64 platform greatly
benefits from v4.11-rc1 commit b92df1de5d28 ("mm: page_alloc: skip over
regions of invalid pfns where possible"). The startup improvement is
roughly ~140ms, which will be lost if the mentioned commit is reverted.

For more details on my measurements, please see linux-next commit
283f1645e236 ("mm: page_alloc: skip over regions of invalid pfns on
UMA").

Whichever way you decide to go forward (reimplement/fix b92df1de5d28
or create an <arch>_next_valid_pfn), I am willing to participate in
testing your proposals on RCAR SoCs. TIA.

Thanks,
Eugeniu.
