Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521633884; cv=none;
        d=google.com; s=arc-20160816;
        b=PkBoisd/7bVUDS6jxshRf+30CV7+9SJNlSvZQu7d5Svol88EuF/OZETw5LS3C7Dk+p
         VN9OXGp9s3gWM33F6GqlatmJ2alm0so730OwbhQWQ/H7s1rNJDaFM76y46QZR88D9PEg
         i+fbXnKOkBhRgPdBAxeBzlwbS/EUUsi3D/cBq7rYIEU1C0HVWBmEKRckuy7JAOBmsS7E
         +jnh4TetOm1H9gMC4Y2CC1CZDMKxSvYQmCOQQN0cI0V7ncbLsZ+cOD96btaiXDcm4Qh1
         wxJyZ/ACNCKhSJP2dcFaKI/KgkynYJdHJxEOBpD/gqYGjFpgyMj76adv4MyWok4i63p8
         KmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=bGMkFVp7VTZrlZVxjrCotgn4ZeeVAj3utT63571G0Ng=;
        b=R6nZWKGrvUYKIn16YPC2aMOasEOyU5bl+Ho1xVO95gYvQd9cZei8siuRhSkm5ZAT6e
         WA/+W1Crt2w0ppmqADajwW4E8tHM1U3nrHu2yh6dKyo47wh9IKXHB6R4vNE5ewZZ6PFx
         BohR8qubKknK0RjqxZdK91J/8Jph7jGdmmsVW0F/rdwChsskzsHDjriuyPHulwWSuFgU
         Jtvg42c/54FsSpapEup1E0+Z92orrTbtPUzRml0z13Yo9NAgXj6T7jtgVGBZtT6OoqD7
         ECopaoeox6dt2UffMPgW/F78YNQOXQIrupzLhidLSkJbXXvJ7TLzKzX1HpLLnN7PY+mX
         MqAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z+7KPWPt;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z+7KPWPt;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49JsYvxo5qtcRht45v6u3K3pbfIeDJCVWcDvUPKuhrEuv5tBp3E+9ugK0QrId0kujLPL8zxmw==
Subject: Re: [PATCH 2/4] mm/memblock: introduce memblock_search_pfn_regions()
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
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
 <1521619796-3846-3-git-send-email-hejianet@gmail.com>
 <CACjP9X94yUxYWimmq1re7oTxhQUfbduVoJ0=iqPiWqV0cjUKng@mail.gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <e7e399f0-93d9-eef5-da7b-42df2d4417d8@gmail.com>
Date: Wed, 21 Mar 2018 20:04:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X94yUxYWimmq1re7oTxhQUfbduVoJ0=iqPiWqV0cjUKng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534048954240176?=
X-GMAIL-MSGID: =?utf-8?q?1595548771955698938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel

Thanks for the review


On 3/21/2018 6:14 PM, Daniel Vacek Wrote:
> On Wed, Mar 21, 2018 at 9:09 AM, Jia He <hejianet@gmail.com> wrote:
>> This api is the preparation for further optimizing early_pfn_valid
>>
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>   include/linux/memblock.h |  2 ++
>>   mm/memblock.c            | 12 ++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 9471db4..5f46956 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -203,6 +203,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>>               i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
>>   #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>
>> +int memblock_search_pfn_regions(unsigned long pfn);
>> +
>>   unsigned long memblock_next_valid_pfn(unsigned long pfn, int *last_idx);
>>   /**
>>    * for_each_free_mem_range - iterate through free memblock areas
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index a9e8da4..f50fe5b 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1659,6 +1659,18 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
>>          return -1;
>>   }
>>
>> +/* search memblock with the input pfn, return the region idx */
>> +int __init_memblock memblock_search_pfn_regions(unsigned long pfn)
>> +{
>> +       struct memblock_type *type = &memblock.memory;
>> +       int mid = memblock_search(type, PFN_PHYS(pfn));
>> +
>> +       if (mid == -1)
>> +               return -1;
> Why this?
Yes, it is redudant and can be removed.
Thanks

Cheers,
Jia
