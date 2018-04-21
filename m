Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeDUVyl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 17:54:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33317 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeDUVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 17:54:39 -0400
X-Google-Smtp-Source: AB8JxZqiBl9Ivm/zIOMJMXlHtWVhVJQtFmWA13DHdB1q3MImUgM6dLuyw0OnSTPgQHNr/2FCCiirw6CNVLOm/BSHIGI=
MIME-Version: 1.0
In-Reply-To: <20180421213401.GF14610@bombadil.infradead.org>
References: <20180421210529.GA27238@jordon-HP-15-Notebook-PC> <20180421213401.GF14610@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 22 Apr 2018 03:24:37 +0530
Message-ID: <CAFqt6zZoU0O_w6stq+47ndBUY+yqk950nsyP_1ShTArQfxsSeQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs: dax: Adding new return type vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, mawilcox@microsoft.com,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, jack@suse.cz,
        kirill.shutemov@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 3:04 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Apr 22, 2018 at 02:35:29AM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> There was an existing bug inside dax_load_hole()
>> if vm_insert_mixed had failed to allocate a page table,
>> we'd return VM_FAULT_NOPAGE instead of VM_FAULT_OOM.
>> With new vmf_insert_mixed() this issue is addressed.
>>
>> vm_insert_mixed_mkwrite has inefficiency when it returns
>> an error value, driver has to convert it to vm_fault_t
>> type. With new vmf_insert_mixed_mkwrite() this limitation
>> will be addressed.
>>
>> As new function vmf_insert_mixed_mkwrite() only called
>> from fs/dax.c, so keeping both the changes in a single
>> patch.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> There's a couple of minor things which could be tidied up, but not worth
> doing them as a revision to this patch.

Which tree this patch will go through ? mm or fsdevel ?
