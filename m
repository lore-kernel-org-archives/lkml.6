Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934893AbeE2OMT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:12:19 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:39316 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934329AbeE2OMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:12:16 -0400
X-Google-Smtp-Source: ADUXVKLLBK+3bAqjW9EH0h/W8c9wMTA9V6jVhxbqLcm6U5PHRpUgsZxapmINkyG6tiYmpEs/vojFP4kJ0daKHsPR4Z0=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180529135938.GA5631@infradead.org>
References: <20180529132148.GC23785@veci.piliscsaba.redhat.com> <20180529135938.GA5631@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 29 May 2018 16:12:15 +0200
Message-ID: <CAJfpeguJ+h5A4ALS3=actNH5UMSWF8Fgoo-RLbmfGuDf0tJicA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 4.18
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 3:59 PM, Christoph Hellwig <hch@infradead.org> wrote:
>>       vfs: add f_op->pre_mmap()
>
> We've been through these pre-mmap games a few times, and always rejected
> them, why is this any different?

Don't know what the other cases were.

Overlayfs case is completely state free.  It just does a copy-up in
the case of a shared mapping so that subsequent modifications of that
file get reflected in the shared mapping.  Can't do the copy-up with
mmap_sem held due to locking depencencies.

>
>>       vfs: export vfs_dedupe_file_range_one() to modules
>
> Please use EXPORT_SYMBOL_GPL for all these crazy low-level exports.
>
> To be homest I'd really like to see the whole thing as a patch series
> instead of a pull request.  Very little seems to have gotten any
> reviewed-by tags which makes me very suspicious.

Did a couple of iterations and got some good feedback.  But can post
the current version, if you think that's useful.

Thanks,
Miklos
