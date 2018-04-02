Return-Path: <richard.weiyang@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522656762; cv=none;
        d=google.com; s=arc-20160816;
        b=fiISMkgS3Uhfn8+Gb8wH2MuDPea7UvSMH6Ktnd2qVyd7kMxbfMacsf2vA66PuiJa7f
         4gi1xfpfL4YbW4OMg/vmSMqdVmeUtXu4Hfj9JT0YOvr2/geAzWLCgu1lGE6uDp5Dln9X
         HAHHuMBEmyY78w+PRM+/O7bA2hMu8BGnF6zuRR4ZjnXsQ+JByRu/fhe197Rg0UBmnsBI
         UerSHMzmN4KKlVLmnNCSD+F1Pg8BwCiTpdZYPap6yk+lVjpcMx8VxF6YLsoweNBZcjfs
         ICBUC4p4KdIio2uHgu+Jz5a1LQtl0DsTTZlLa+sFek+y6u6l9uzbZi39cD73iKaIctM4
         XqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Tkizeu4ES2/0iv8vbUMdzBAfLkWTrhXB9M0mpsSJKvI=;
        b=cu7svbxew+Vak6MZaVvSNjL1tzD+HRrbWkzLh8ax3Jjeb45dERONNxU7sQWI6qxAI8
         HP+EMno4owvLVPK0S916b8LJtWgqeZFUu4DNkLd8koVeg46Fi1M3f9DJlgmmQtN9ocPV
         36/a+Moe4EUACi+fIaDgyjKt/LhNIQ81Yt5SEDmtdi+ZmtL0zHr9mebDW0gRPnOmDaWj
         QUElvE1du58Ap6pxpzlYaf7a0+HPc14JQloQ9QbN3VZt8qEapDKFX5cRjnCnQfX/lkcX
         BcXzCWOxdZamvo8LxgDDTPsb7EBfmR252+x49Yo96yJxSlpaA09HDvHDNxs2y/H3i8CH
         7AgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WYzTv8QH;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WYzTv8QH;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48UwexeDBQgWIOOv/y4tITt2FXmRWTRV/eeMts290qnAk2QiSd0xogKSma9E3Wkosj5xNmWlw==
Date: Mon, 2 Apr 2018 16:12:33 +0800
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
Message-ID: <20180402081233.GA38180@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
 <1522033340-6575-2-git-send-email-hejianet@gmail.com>
 <20180328091800.GB97260@WeideMacBook-Pro.local>
 <f8e7eaca-e9f1-0ed1-a9f9-1dff81b13814@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e7eaca-e9f1-0ed1-a9f9-1dff81b13814@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967673442117233?=
X-GMAIL-MSGID: =?utf-8?q?1596621337622357107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 05:49:23PM +0800, Jia He wrote:
>
>
>On 3/28/2018 5:18 PM, Wei Yang Wrote:
>> Oops, I should reply this thread. Forget about the reply on another thread.
>> 
>> On Sun, Mar 25, 2018 at 08:02:15PM -0700, Jia He wrote:
>> > Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> > where possible") optimized the loop in memmap_init_zone(). But it causes
>> > possible panic bug. So Daniel Vacek reverted it later.
>> > 
>> Why this has a bug? Do you have some link about it?
>> 
>> If the audience could know the potential risk, it would be helpful to review
>> the code and decide whether to take it back.
>Hi Wei
>Paul firstly submit a commit b92df1de5 to improve the loop in
>memmap_init_zone.
>And Daniel tried to fix a bug_on panic issue on X86 in commit 864b75f9d6b
>because
>there is evidence that this bug_on was caused by b92df1de5 [1].
>
>But things didn't get better, 864b75f9d6b caused booting hang issue on
>arm{64} [2]
>So maintainer decided to reverted both b92df1de5 and 864b75f9d6b
>
>[1] https://patchwork.kernel.org/patch/10251145/
>[2] https://lkml.org/lkml/2018/3/14/469

I took some time to look into the discussion, while the root cause seems not
clear now?

-- 
Wei Yang
Help you, Help me
