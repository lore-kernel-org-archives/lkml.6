Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522201820; cv=none;
        d=google.com; s=arc-20160816;
        b=SVvvuFlzVKnnBHqJtg3r+adz+sEDfop5X0FwNFBu51DwM6e/k8kjOfHlyPgbeO2wKW
         KjqL/3P3NrxzkT6+Uc9PSvHoICu4Cj2ham+YkEozB4jtJRFZEAjD8nhXZPFUB8vWsPA+
         V5dZ9SsAjWVVUWH9aZAccDY2l9c0l/2MsfQzlrdG1V1UpHibAqsVzWuMYeR7cjWzvTcf
         nTEaYKgNhdbREni+0Nr0uguyVKdujoeu6UUpJeoIvILCoCoArnC2Hvb7d+FfqMyKTZ8c
         l3dteQzD7ZQum/UITnC+1/3rAl7MJ9eufet9vHx8Q3uX3Q8S8TsiQhC1MXy/Fsh8A8sq
         KaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=RYKw4QU1UBPiC0ZzqdQSmvZgwaA6Id1MKdm50S6r/rw=;
        b=AXPhaJ/hF39eQvP562BqQqVasCA1sVgp3BLhKuEv0UKDqHA3QyZCo+87eJ/8/TEzm6
         SWf3A1nune05XRik7oamfoz30ZW7xjTlr5HOXpofD96NGXmL53OLn1UmerEb18aGacOg
         b/OiJeOKNRsc4867PYqqvaLpU3OXwFIgLLmh3oYNWPRdV79lB1+Q1x2hF8Gd0VyUhr6A
         WSW2IJ4l5Vdy87pa7h1EvH+w7YQu8a81eBOYbKm3piwJ0kVoxJxC4GuqlwiGTi8d48i5
         oD0DuT+v1jTxpQohPvVEeAg4+/aWbvmnygR65gtlnQsD7lYAOR/2cQXzsM1TeamWa5MB
         BHLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jf0H2XNo;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jf0H2XNo;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/NrKnqhfHdmrIlhGlKKBfpIemMpGlUj0owU15lpUmJMXNm8D0ac0d70T3KFqHwbnrtN6K0aQ==
Subject: Re: [PATCH v2 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 when CONFIG_HAVE_ARCH_PFN_VALID is enable
To: Daniel Vacek <neelx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko
 <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Mel Gorman <mgorman@suse.de>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Gioh Kim <gi-oh.kim@profitbricks.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>, Vlastimil Babka <vbabka@suse.cz>,
 open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Steve Capper <steve.capper@arm.com>,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
 Petr Tesarik <ptesarik@suse.com>, YASUAKI ISHIMATSU
 <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Nikolay Borisov <nborisov@suse.com>, Jia He <jia.he@hxt-semitech.com>
References: <1521894282-6454-1-git-send-email-hejianet@gmail.com>
 <1521894282-6454-2-git-send-email-hejianet@gmail.com>
 <CACjP9X-zvGa5OQpuJ1bUp+V=_eTOUDLfKkT1sbT84k5zJz=epA@mail.gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <0a8ba07b-b046-c1b4-9c4e-74d7b5dc370e@gmail.com>
Date: Wed, 28 Mar 2018 09:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X-zvGa5OQpuJ1bUp+V=_eTOUDLfKkT1sbT84k5zJz=epA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595821857199891353?=
X-GMAIL-MSGID: =?utf-8?q?1596144296719361160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/28/2018 12:52 AM, Daniel Vacek Wrote:
> On Sat, Mar 24, 2018 at 1:24 PM, Jia He <hejianet@gmail.com> wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But it causes
>> possible panic bug. So Daniel Vacek reverted it later.
>>
>> But memblock_next_valid_pfn is valid when CONFIG_HAVE_ARCH_PFN_VALID is
>> enabled. And as verified by Eugeniu Rosca, arm can benifit from this
>> commit. So remain the memblock_next_valid_pfn.
> It is not dependent on CONFIG_HAVE_ARCH_PFN_VALID option but on
> arm(64) implementation of pfn_valid() function, IIUC. So it should
> really be moved from generic source file to arm specific location. I'd
> say somewhere close to the pfn_valid() implementation. Such as to
> arch/arm{,64}/mm/ init.c-ish?
>
> --nX
Ok, thanks for your suggestions.
I will try to move the  related codes to arm arch directory.

Cheer,
Jia
