Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeFDEhU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:37:20 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42739 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeFDEhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:37:18 -0400
X-Google-Smtp-Source: ADUXVKJtOA/BJDiuB72nowuJvMHiS4KmW3VV0uKlx5EBToSstNOmsTqOrW9ug7F2V4yYVpqhVXy/1lh/ciTYYdD8Qz8=
MIME-Version: 1.0
In-Reply-To: <20180602220136.GA14810@bombadil.infradead.org>
References: <20180602200407.GA15200@jordon-HP-15-Notebook-PC> <20180602220136.GA14810@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 4 Jun 2018 10:07:16 +0530
Message-ID: <CAFqt6zaf1k1SvYXLrCXAvsAPC+jGQoKxR_LtUwNybdJosptQTQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Change return type int to vm_fault_t for fault handlers
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, riel@redhat.com,
        pasha.tatashin@oracle.com, jschoenh@amazon.de,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
        yang.s@alibaba-inc.com, Minchan Kim <minchan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 3:31 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Jun 03, 2018 at 01:34:07AM +0530, Souptick Joarder wrote:
>> @@ -3570,9 +3571,8 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>>                       return 0;
>>               }
>>
>> -             ret = (PTR_ERR(new_page) == -ENOMEM) ?
>> -                     VM_FAULT_OOM : VM_FAULT_SIGBUS;
>> -             goto out_release_old;
>> +             ret = vmf_error(PTR_ERR(new_page));
>> +                     goto out_release_old;
>>       }
>>
>>       /*
>
> Something weird happened to the goto here

Didn't get it ? Do you refer to wrong indent in goto ?
