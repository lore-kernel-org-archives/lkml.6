Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDLRYD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:24:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46663 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDLRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:24:01 -0400
X-Google-Smtp-Source: AIpwx4/nxSScdbjl62DKlc8UWuYIWLimjGlh+DcPFcUMpLaPCJ2m32ayyocyzG+DDdbw3UxFVlDqGGTuQYw+6LV1trU=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180412162500.GA24728@bombadil.infradead.org>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-2-mszeredi@redhat.com>
 <20180412162500.GA24728@bombadil.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Apr 2018 19:24:00 +0200
Message-ID: <CAJfpegt18KcursBrY23vz8xKst=rbX-g2pU27-9yvfvqf39_Dg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/35] vfs: clean up dedup
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 6:25 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Apr 12, 2018 at 05:07:52PM +0200, Miklos Szeredi wrote:
>> +ssize_t vfs_dedupe_file_range_one(struct file *src_file, u64 src_pos, u64 len,
>> +                           struct file *dst_file, u64 dst_pos)
>
> Why u64 instead of loff_t?

Peculiarity of f_op->dedupe_file_range().

I think a cleanup of copyfile/clone/dedupe interfaces would be good.
Perhaps merge them into one?  Or just merge copyfile/clone?  Even if
not merging it should make sense to make argument types and argument
order the same.

Thanks,
Miklos
