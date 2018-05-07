Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeEGK1Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:27:24 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:36164 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEGK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:27:20 -0400
X-Google-Smtp-Source: AB8JxZr4BxHclBFhs+wnjoEwn1rmJz025r3vtkaTrgmGz1wV2blBG49n6KZldrqNJiKMqEY46J+ykB0cVqrsT+C7Mfo=
MIME-Version: 1.0
In-Reply-To: <20180507083807.28792-23-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com> <20180507083807.28792-23-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 May 2018 13:27:19 +0300
Message-ID: <CAOQ4uxi-_0xkSgHnzBhJLnWTyz_m0VXTx9206k2vZA6dgtQYmQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/35] vfs: don't open real
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 11:37 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> Let overlayfs do its thing when opening a file.
>
> This enables stacking and fixes the corner case when a file is opened for
> read, modified through a writable open, and data is read from the read-only
> file.  After this patch the read-only open will not return stale data even
> in this case.
>

So now you can get rid of ovl_do_check_copy_up() and the check_copy_up
module param ;-)

Thanks,
Amir.
