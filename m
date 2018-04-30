Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZpw3kJkulv0eixwEilWQBwbCUEn7tFSGV7NXiB1CWzPekY5DHTg8+7iDb4QaeAbsjdJFRKw
ARC-Seal: i=1; a=rsa-sha256; t=1525069868; cv=none;
        d=google.com; s=arc-20160816;
        b=Lv9pX6Nit4uXGS7/z3foey0ZDYgOwbszipiY4t6uRL5F18B1o7cHb+cOA/1B2fFRdN
         3zOIPZO5BS/Xcd1BE7GjBKvijMc/iaaM1Mqx4BxyebcDH0srRJJ1TTDM8I4cuBDnxHJa
         spLXLwJlrLLBUs4LvBQEnIZAHOt/XtNAbGq/uhn2vyZ5ZwDkmQKTO3eKxcbkq3ShwHwg
         SYO4fD1qiYZGZiakWk6bZk5HIm8qkJvt/lcStuG8EjAS5T0SvqwO6/lOHPpx2y2WhRPo
         jtyEmi6H1Lovc2IgNUy7FaaQp9sa7QREsqh1Et3gEnjXLWx2V48TYaqvOtx2bFzI8Wzk
         4kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=c5X2uzGFrhtohzRkbWPemfOzHNNZ5ITMcCyWUZAtUZ4=;
        b=0w7GAB5CNn8tSIErkvf79N1jagmwTH8rX4ftogO2tWUdN9/lmIMMFVkAn0L8xjVlsJ
         UrigKhplsaXRTPvB/lVkCejaKvc9hp73fQKTAPYLDNDQZ31hfrEBjeNB35eXK7oe7+gm
         /7hDv59Q4QYKZ6U0X2EeUX6BVjJY7+Jfqy3OuLGBuC4u634gVvqJXa2U0+c3yz4l7L63
         63JLeMKqBI5jj2l3FxlssZDQURtrrGAUpb7fD8751KqBM5Ft0Z6NYCnb//Q1X9j0Ar72
         P25D15SEsCsx6jgoUXO+UhG2u3UOEi1cbLftqNST5aowCzPpfArsYmVPYi86WznwUXWX
         19vA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RFC 2/8] mm: introduce PG_offline
To: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Miles Chen <miles.chen@mediatek.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rik van Riel <riel@redhat.com>,
 James Hogan <jhogan@kernel.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413131632.1413-3-david@redhat.com>
 <20180413171120.GA1245@bombadil.infradead.org>
 <89329958-2ff8-9447-408e-fd478b914ec4@suse.cz>
 <20180422030130.GG14610@bombadil.infradead.org>
 <7db70df4-c714-574c-5b14-898c1cf49af6@redhat.com>
 <20180422140246.GA30714@bombadil.infradead.org>
 <903ab7f7-88ce-9bc3-036b-261cce1bb26c@redhat.com>
 <20180429210850.GB26305@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a0748efe-60e1-bc85-dbf3-a2352ab2c5b1@redhat.com>
Date: Mon, 30 Apr 2018 08:31:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429210850.GB26305@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597637040722220932?=
X-GMAIL-MSGID: =?utf-8?q?1599151662997133766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29.04.2018 23:08, Michal Hocko wrote:
> On Sun 22-04-18 17:13:52, David Hildenbrand wrote:
>> On 22.04.2018 16:02, Matthew Wilcox wrote:
>>> On Sun, Apr 22, 2018 at 10:17:31AM +0200, David Hildenbrand wrote:
>>>> On 22.04.2018 05:01, Matthew Wilcox wrote:
>>>>> On Sat, Apr 21, 2018 at 06:52:18PM +0200, Vlastimil Babka wrote:
>>>>>> Sounds like your newly introduced "page types" could be useful here? I
>>>>>> don't suppose those offline pages would be using mapcount which is
>>>>>> aliased there?
>>>>>
>>>>> Oh, that's a good point!  Yes, this is a perfect use for page_type.
>>>>> We have something like twenty bits available there.
>>>>>
>>>>> Now you've got me thinking that we can move PG_hwpoison and PG_reserved
>>>>> to be page_type flags too.  That'll take us from 23 to 21 bits (on 32-bit,
>>>>> with PG_UNCACHED)
>>>>
>>>> Some things to clarify here. I modified the current RFC to also allow
>>>> PG_offline on allocated (ballooned) pages (e.g. virtio-balloon).
>>>>
>>>> kdump based dump tools can then easily identify which pages are not to
>>>> be dumped (either because the content is invalid or not accessible).
>>>>
>>>> I previously stated that ballooned pages would be marked as PG_reserved,
>>>> which is not true (at least not for virtio-balloon). However this allows
>>>> me to detect if all pages in a section are offline by looking at
>>>> (PG_reserved && PG_offline). So I can actually tell if a page is marked
>>>> as offline and allocated or really offline.
>>>>
>>>>
>>>> 1. The location (not the number!) of PG_hwpoison is basically ABI and
>>>> cannot be changed. Moving it around will most probably break dump tools.
>>>> (see kernel/crash_core.c)
>>>
>>> It's not ABI.  It already changed after 4.9 when PG_waiters was introduced
>>> by commit 62906027091f.
>>
>> It is, please have a look at the file I pointed you to.
>>
>> We export the *value* of PG_hwpoison in the ELF file, therefore the
>> *value* can change, but the *location* (page_flags, mapcount, whatever)
>> must not change. Or am I missing something here? I don't think we can
>> move PG_hwpoison that easily.
>>
>> Also, I can read "For pages that are never mapped to userspace,
>> page->mapcount may be used for storing extra information about page
>> type" - is that true for PG_hwpoison/PG_reserved? I am skeptical.
>>
>> And we need something similar for PG_offline, because it will become
>> ABI. (I can see that PAGE_BUDDY_MAPCOUNT_VALUE is also exported in an
>> ELF file, so maybe a new page type might work for marking a page offline
>> - but I have to look at the details first tomorrow)
> 
> Wait wait wait. Who is relying on this? Kdump? Page flags have always
> been an internal implementation detail and _nobody_ outside of the
> kernel should ever rely on the specific value. Well, kdump has been
> cheating but that is because kdump is inherently tight to a specific
> kernel implementation but that doesn't make it a stable ABI IMHO.
> Restricting the kernel internals because of a debugging tool would be
> quite insane.
> 

kdump tools (makedumptool) don't rely on any specific value or assume
anything.

Using the example of musing PG_hwpoison to mapcount:

If it sees PG_hwpoison:
- it knows the right bit number to use
- it knows the kernel uses it

If it doesn't see PG_hwpoison (in the ELF info) anymore:
- it cannot exclude poisoned pages anymore, potentially crashing the
system during a dump


If you have a better fitting name for "requires a interlocked update
with tools to keep it working" than ABI, please let me know :)

Anyhow, I have a new prototype based on PAGE_OFFLINE_MAPCOUNT_VALUE that
I will share briefly.

-- 

Thanks,

David / dhildenb
