Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522660672; cv=none;
        d=google.com; s=arc-20160816;
        b=Pr1aGBOV5hn8zIGDxlu6nA+8eEhSVvTY46Os0PL1L7tkQimIk1kzWs16y+J0e+oRDe
         lQffNTO3+ICRsBX2YImCY66WOeqcAxqP53/s7LIGbJqtr6ov2Psubrgrtw62Yf1ArmTZ
         3/uYVcchO0pZaAYEAL4D9Ohbnji0Z7cyaWXpKTeTsG347DigD5GzaprC0+joBfPS7bzZ
         hqYJcyi+6aIW/c7AySeKEtEXYg6PSpLzPmxugHcoNBdvx5jg9R7sm4DmAZ0EwVP+K8dV
         DCQlKsVD+W6UdsAowHXEbBRzrUqji5l9P6bKxXzXI1hr3xgjN3Ow2t5AdN3SrrlGfbA5
         0UAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=pXuZyDWpjOyaCb4wQNQnGNqRROkpqBXlyuNPPQtOv5U=;
        b=KQUt1i1II5A/tPysIZsH0oX7M6RTYaaFo9k6clHdqUE4I5JRpbQrqy/RT1MJAUDerj
         DXIKy595vvU84krQtK8aKZkXYUq64UT/J1+/BLqwkO6ma2gj54n3IAikVmGGWncEM5/S
         8yhVqLn50zuRp8Qg/fIQHHKec+pf3vvL9YzB5epuakGix/dj8aMF69ZdoTsAzFKzFac9
         SWtgp0m6eojCags3yQfPYJvJMC1tPMlX56To85g3R9uK7/aFO5lxI0sdz9Qs1i5Mkw3M
         PMdzU/bxIExbVSzFaCP4evqNidHAwciAU4mpAA8cQd+0IeE7cWD2rN+GThuWXIkqlFZA
         aW3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XgodPHSc;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XgodPHSc;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx497q+gquu/8uiPVjrzQKN7qwKXFr4w/sEJ2tx24IHalJWWlFuGbiuv7mm0ejKjI6UfhBSMhbA==
Subject: Re: [PATCH v3 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 when CONFIG_HAVE_ARCH_PFN_VALID is enable
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko
 <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Mel Gorman <mgorman@suse.de>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Gioh Kim <gi-oh.kim@profitbricks.com>,
 Steven Sistare <steven.sistare@oracle.com>, Daniel Vacek <neelx@redhat.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Steve Capper <steve.capper@arm.com>,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
 Petr Tesarik <ptesarik@suse.com>, YASUAKI ISHIMATSU
 <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Nikolay Borisov <nborisov@suse.com>, Jia He <jia.he@hxt-semitech.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
 <1522033340-6575-2-git-send-email-hejianet@gmail.com>
 <20180328091800.GB97260@WeideMacBook-Pro.local>
 <f8e7eaca-e9f1-0ed1-a9f9-1dff81b13814@gmail.com>
 <20180402081233.GA38180@WeideMacBook-Pro.local>
From: Jia He <hejianet@gmail.com>
Message-ID: <7288ce7c-7535-a5a1-7c7c-18456e431648@gmail.com>
Date: Mon, 2 Apr 2018 17:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402081233.GA38180@WeideMacBook-Pro.local>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967673442117233?=
X-GMAIL-MSGID: =?utf-8?q?1596625437514229719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/2/2018 4:12 PM, Wei Yang Wrote:
> On Wed, Mar 28, 2018 at 05:49:23PM +0800, Jia He wrote:
>>
>> On 3/28/2018 5:18 PM, Wei Yang Wrote:
>>> Oops, I should reply this thread. Forget about the reply on another thread.
>>>
>>> On Sun, Mar 25, 2018 at 08:02:15PM -0700, Jia He wrote:
>>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>>> where possible") optimized the loop in memmap_init_zone(). But it causes
>>>> possible panic bug. So Daniel Vacek reverted it later.
>>>>
>>> Why this has a bug? Do you have some link about it?
>>>
>>> If the audience could know the potential risk, it would be helpful to review
>>> the code and decide whether to take it back.
>> Hi Wei
>> Paul firstly submit a commit b92df1de5 to improve the loop in
>> memmap_init_zone.
>> And Daniel tried to fix a bug_on panic issue on X86 in commit 864b75f9d6b
>> because
>> there is evidence that this bug_on was caused by b92df1de5 [1].
>>
>> But things didn't get better, 864b75f9d6b caused booting hang issue on
>> arm{64} [2]
>> So maintainer decided to reverted both b92df1de5 and 864b75f9d6b
>>
>> [1] https://patchwork.kernel.org/patch/10251145/
>> [2] https://lkml.org/lkml/2018/3/14/469
> I took some time to look into the discussion, while the root cause seems not
> clear now?
>
Frankly speaking, to me the root cause of that bug_on is not completedly
clear :-) Daniel ever gave me some hints as followed, but currently I have
no x86 platform to understand the details.

"On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn()
does not always return the next valid one but skips more resulting in
some valid frames to be skipped (as if they were invalid). And that's
why kernel was eventually crashing on some !arm machines."

-- 
Cheers,
Jia
