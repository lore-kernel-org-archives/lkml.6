Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756381AbeDYToj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:44:39 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:45697 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeDYToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:44:37 -0400
X-Google-Smtp-Source: AB8JxZrYdOOb1JPhBji6izuXRaUNUJxgwI91CJHW7Fp6E2stvzlwVhdrAaeNYSgbt6IZwCleLv6MMVwKdoN+JvsirEU=
MIME-Version: 1.0
In-Reply-To: <5342.1524667789@jrobl>
References: <20180412150826.20988-1-mszeredi@redhat.com> <5342.1524667789@jrobl>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 25 Apr 2018 21:44:36 +0200
Message-ID: <CAOssrKfeopc43SbHKOL9TL82U57_9Z2TaLwH5kqh7-3PuE3MBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] overlayfs: stack file operations
To: "J. R. Okajima" <hooanon05g@gmail.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 4:49 PM, J. R. Okajima <hooanon05g@gmail.com> wrote:
> Miklos Szeredi:
>> This patch series reverts the VFS hacks (with the exception of d_path) and
>
> I totally agree with removing d_real things.
> It must be good to the world.
>
> If I understand correctly, this series affects file_inode() too.
> So there may exist more commits to revert such as
>         fea6d2a6 2017-02-14 vfs: Use upper filesystem inode in bprm_fill_uid()


Yep.

>
> Here is another question.
> Does overlayfs support atomic_open?

No.  Overlayfs doesn't support network filesystems as modifiable
(upper) layer, and that's where atomic_open makes sense.  I think
actually no filesystem that defines atomic_open() can be used as upper
layer.   So that's currently not a worry.  If it turns out to be a
requirement to use such filesystem as upper, then I'll worry about
atomic_open().

Thanks,
Miklos
