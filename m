Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757268AbeD0FY5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:24:57 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:45095 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756973AbeD0FYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:24:55 -0400
X-Google-Smtp-Source: AB8JxZrohN5PwcPjUp7jIkm4QNyMBbRHVo/ei4PCxh6ZCA6sq32Omh2EueqOyW6Un0nnrs7nA3ThdnGZXw+k41c9ftg=
MIME-Version: 1.0
In-Reply-To: <20180426195831.GA27127@linux.intel.com>
References: <20180424164751.GA18923@jordon-HP-15-Notebook-PC> <20180426195831.GA27127@linux.intel.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 27 Apr 2018 10:54:53 +0530
Message-ID: <CAFqt6zZti0oY7C-pU0LhsHtctqeWBkikH6Pb0wfBZSigHNMUwA@mail.gmail.com>
Subject: Re: [PATCH v6] fs: dax: Adding new return type vm_fault_t
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, kirill.shutemov@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that we have the following status translation now in 4 places in 2
> files:
>
>         if (err == -ENOMEM)
>                 return VM_FAULT_OOM;
>         if (err < 0 && err != -EBUSY)
>                 return VM_FAULT_SIGBUS;
>         return VM_FAULT_NOPAGE;
>
>
> This happens in vmf_insert_mixed_mkwrite(), vmf_insert_page(),
> vmf_insert_mixed() and vmf_insert_pfn().
>
> I think it'd be a good idea to consolidate this translation into an inline
> helper, in the spirit of dax_fault_return().  This will ensure that if/when we
> start changing this status translation, we won't accidentally miss some of the
> places which would make them get out of sync.  No need to fold this into this
> patch - it should be a separate change.

Sure, I will send this as a separate patch.
