Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x224csg4bLwl8pzGpur51Mkw82NSKJxQUVsIGi3ST+TXqAaXtjr0gSuy6mRBnmNzS9Lmr8zip
ARC-Seal: i=1; a=rsa-sha256; t=1518618260; cv=none;
        d=google.com; s=arc-20160816;
        b=BRauAiGld4yDt/PAVtXjGWt06+HC1VUjp+cEoPQJydTQHFteHm4k2/WlQVEXfka8D7
         yFxE3qteJSa0CDZSgLoH2Lhg0Nyduz+AVFmu2xk29geaon7J+tKDcJTbHMv2z9i+6M8f
         HDgIVZ42WFinqSdsr2Cr5JgJCg8N4Mf1O5ZDinlUHLpacE63NOgBQ0SQaku446KD72Gy
         qXU2W65f7DjV/QYifBsl4xXylDQrpT4ZqOxfar52Ek/vVdaT1P4P/5NetwOIPGg5YwFm
         DV7WN2QoCwBu/OJ4t7NNmFtJ8iYxhlp+kL6yx/T6MruuDtMpIXZ6QgFcgKiww56ls4fq
         t1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=V7zg0fb8Fl9hiHp8Azd4cwgvtgE070xOfrFrIcDSaHI=;
        b=uchPnH2L3HfES6W/8HtIp/d4tDsu6UmqOznSkPovapvwQnWDGG46i6/B1X2eMXNSfX
         p4P4GbBd4kMymgbnlkDT4K2iGQ2ZnY2sfIXDCcp8P09y2HP306+nTEAfA5ygDtGYJ4Mp
         DfcUtrIWwrD/snIvvxixj8SerT+WpTzvgpM9ypigebcPJU1xGCzFR5Y00l9tZVy7JKXW
         GQYv8iAnEVBMX9SX9SEYD76jn9RmlmrK3kTtgJMZbFqYA4Y0CuY2Y8gsLbKA+35aqDAG
         Uo0trWb8gxSMNjhu0es+9Shp/lBdEDzGcwzKkHQx7RTA4qyoPsbmKgnZeX8FSUkzsUb0
         tPWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ucthKJHE;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ucthKJHE;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180214080930.n44x3arzqanja5zq@gmail.com>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213135359.705680d373a482b650f38b50@linux-foundation.org> <20180214080930.n44x3arzqanja5zq@gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 14 Feb 2018 09:14:17 -0500
X-Gmail-Original-Message-ID: <CAOAebxsAXC8CgoRdeD4=1ePwoB6TeqprZgnkenU-aCeKGv_p+w@mail.gmail.com>
Message-ID: <CAOAebxsAXC8CgoRdeD4=1ePwoB6TeqprZgnkenU-aCeKGv_p+w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] optimize memory hotplug
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446760578462?=
X-GMAIL-MSGID: =?utf-8?q?1592386661556756294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ingo,

Thank you very much for your review. I will address spelling issues,
and will also try to split the patch #4.  Regarding runtime concern
for patch #3: the extra checking is only performed when the both of
the following CONFIGs are enabled:

CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_PGFLAGS=y

I do not expect either of these to be ever enabled on a production systems.

Thank you,
Pavel

On Wed, Feb 14, 2018 at 3:09 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Tue, 13 Feb 2018 14:31:55 -0500 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>>
>> > This patchset:
>> > - Improves hotplug performance by eliminating a number of
>> > struct page traverses during memory hotplug.
>> >
>> > - Fixes some issues with hotplugging, where boundaries
>> > were not properly checked. And on x86 block size was not properly aligned
>> > with end of memory
>> >
>> > - Also, potentially improves boot performance by eliminating condition from
>> >   __init_single_page().
>> >
>> > - Adds robustness by verifying that that struct pages are correctly
>> >   poisoned when flags are accessed.
>>
>> I'm now attempting to get a 100% review rate on MM patches, which is
>> why I started adding my Reviewed-by: when I do that thing.
>>
>> I'm not familiar enough with this code to add my own Reviewed-by:, and
>> we'll need to figure out what to do in such cases.  I shall be sending
>> out periodic review-status summaries.
>>
>> If you're able to identify a suitable reviewer for this work and to
>> offer them beer, that would help.  Let's see what happens as the weeks
>> unfold.
>
> The largest patch, fix patch #2, looks good to me and fixes a real bug.
> Patch #1 and #3 also look good to me (assuming the runtime overhead
> added by patch #3 is OK to you):
>
>   Reviewed-by: Ingo Molnar <mingo@kernel.org>
>
> (I suspect patch #1 and patch #2 should also get a Cc: stable.)
>
> Patch #4 is too large to review IMO: it should be split up into as many patches as
> practically possible. That will also help bisectability, should anything break.
>
> Before applying these patches please fix changelog and code comment spelling.
>
> But it's all good stuff AFAICS!
>
> Thanks,
>
>         Ingo
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
