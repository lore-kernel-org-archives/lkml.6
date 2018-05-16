Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEPEoG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:44:06 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41868 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeEPEoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:44:04 -0400
X-Google-Smtp-Source: AB8JxZp4/SmdW2ggXmeh9RSETWWlgBALDjqSOckIXeukSiWD4iMzUThM5i3490Y8t4Rrzf9CG79z5QBK1UzNpSYUHZ8=
MIME-Version: 1.0
In-Reply-To: <CAFqt6zai16qZ--L9aAh0dtD9XTfu-vpUpO4CWgOHKavxH5AU1Q@mail.gmail.com>
References: <20180425043413.GA21467@jordon-HP-15-Notebook-PC> <CAFqt6zai16qZ--L9aAh0dtD9XTfu-vpUpO4CWgOHKavxH5AU1Q@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 16 May 2018 10:14:02 +0530
Message-ID: <CAFqt6zYLDsQ+LRPMJF+H-9hKt03HwGPaj1eaxPGMuu039a8j2g@mail.gmail.com>
Subject: Re: [PATCH v2] ipc: Adding new return type vm_fault_t
To: Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, manfred@colorfullife.com,
        dave@stgolabs.net, ebiederm@xmission.com, linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 7:34 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Wed, Apr 25, 2018 at 10:04 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>> v2: Updated the change log
>>
>>  ipc/shm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ipc/shm.c b/ipc/shm.c
>> index 4643865..2ba0cfc 100644
>> --- a/ipc/shm.c
>> +++ b/ipc/shm.c
>> @@ -378,7 +378,7 @@ void exit_shm(struct task_struct *task)
>>         up_write(&shm_ids(ns).rwsem);
>>  }
>>
>> -static int shm_fault(struct vm_fault *vmf)
>> +static vm_fault_t shm_fault(struct vm_fault *vmf)
>>  {
>>         struct file *file = vmf->vma->vm_file;
>>         struct shm_file_data *sfd = shm_file_data(file);
>> --
>> 1.9.1
>>
>
> Any comment for this patch ?

If no further comment, we would like to get this
patch in queue for 4.18.
