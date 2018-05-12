Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeELGZm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 02:25:42 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:45418 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeELGZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 02:25:40 -0400
X-Google-Smtp-Source: AB8JxZpgFcAsHXoEWkbTTHjTW+bdn+D6E7vsyA3Li64GzqlaFI82CmMeesennwnLZD5P95hgYPhStJc/7PJtvLTmiaM=
MIME-Version: 1.0
In-Reply-To: <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
References: <20180512061712.GA26660@jordon-HP-15-Notebook-PC> <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 12 May 2018 11:55:38 +0530
Message-ID: <CAFqt6zbauQJb29BSP5bdRNXxhfS9Y9FH+=yqODKWF6cnksG20w@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Change return type to vm_fault_t
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 11:50 AM, Joe Perches <joe@perches.com> wrote:
> On Sat, 2018-05-12 at 11:47 +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler
>> in struct vm_operations_struct. For now, this is
>> just documenting that the function returns a
>> VM_FAULT value rather than an errno.  Once all
>> instances are converted, vm_fault_t will become
>> a distinct type.
>
> trivia:
>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> []
>> @@ -627,7 +627,7 @@ struct vm_special_mapping {
>>        * If non-NULL, then this is called to resolve page faults
>>        * on the special mapping.  If used, .pages is not checked.
>>        */
>> -     int (*fault)(const struct vm_special_mapping *sm,
>> +     vm_fault_t (*fault)(const struct vm_special_mapping *sm,
>>                    struct vm_area_struct *vma,
>>                    struct vm_fault *vmf);
>
>
> It'd be nicer to realign the 2nd and 3rd arguments
> on the subsequent lines.
>
>         vm_fault_t (*fault)(const struct vm_special_mapping *sm,
>                             struct vm_area_struct *vma,
>                             struct vm_fault *vmf);
>

Just now posted v3. Do you want me to send v4 again with
realignment ?
