Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeEGLgR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:36:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37599 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeEGLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:36:13 -0400
X-Google-Smtp-Source: AB8JxZpXjIO3bOGcu4ApmzfNloz8He8O4CUMzoWVue7W3J8u9R3xcEEoC166lAvmD7cpkOF9OiByJPFwalNgD3dELWg=
MIME-Version: 1.0
In-Reply-To: <20180507111644.GB18116@bombadil.infradead.org>
References: <20180507082108.28186-1-mszeredi@redhat.com> <20180507082108.28186-3-mszeredi@redhat.com>
 <20180507111644.GB18116@bombadil.infradead.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 7 May 2018 13:36:12 +0200
Message-ID: <CAOssrKf8FLPGWZ9dbT0Tzw4KAkSvUC4ghc_1Wf6-iBob+yQZJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vfs: dedupe: rationalize args
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 1:16 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, May 07, 2018 at 10:21:07AM +0200, Miklos Szeredi wrote:
>> @@ -1738,7 +1738,7 @@ struct file_operations {
>>                       loff_t, size_t, unsigned int);
>>       int (*clone_file_range)(struct file *, loff_t, struct file *, loff_t,
>>                       u64);
>> -     s64 (*dedupe_file_range)(struct file *, u64, u64, struct file *,
>> +     s64 (*dedupe_file_range)(struct file *, loff_t, struct file *, loff_t,
>>                       u64);
>
> Please name the parameters here ...
>
> +       loff_t (*dedupe_file_range)(struct file *src, loff_t src_off,
> +                       struct file *dst, loff_t dst_off, loff_t len);

It's the convention here.  Going against the convention looks odd and
has dubious value.

Fixing the convention is okay by me, but I'd leave that to some
kernelnewbie to worry about.

Thanks,
Miklos
