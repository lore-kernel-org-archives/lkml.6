Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964880AbeBMNSY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:18:24 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43101 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935196AbeBMNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:18:22 -0500
X-Google-Smtp-Source: AH8x227N/JU6nZYk7/48kpPbGI3DYfJIVXWXbJvj9Q1UBrWfH9Qq2JsBLb42IcGFocDiKCwkp5q2gZVXt2lhK/VFFZI=
MIME-Version: 1.0
In-Reply-To: <ac3d34002d7690f6ca5928b57b7fc4d707104b04.1512041070.git.dongsu@kinvolk.io>
References: <cover.1512741134.git.dongsu@kinvolk.io> <ac3d34002d7690f6ca5928b57b7fc4d707104b04.1512041070.git.dongsu@kinvolk.io>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 13 Feb 2018 14:18:21 +0100
Message-ID: <CAOssrKcZeAHsRz7P_dxh==QAKnp7HeSTh4vWY2tgbWa1ZD918g@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: Allow superblock owner to change ownership of inodes
To: Dongsu Park <dongsu@kinvolk.io>
Cc: lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org, Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
>
> Allow users with CAP_SYS_CHOWN over the superblock of a filesystem to
> chown files.  Ordinarily the capable_wrt_inode_uidgid check is
> sufficient to allow access to files but when the underlying filesystem
> has uids or gids that don't map to the current user namespace it is
> not enough, so the chown permission checks need to be extended to
> allow this case.
>
> Calling chown on filesystem nodes whose uid or gid don't map is
> necessary if those nodes are going to be modified as writing back
> inodes which contain uids or gids that don't map is likely to cause
> filesystem corruption of the uid or gid fields.

How can the filesystem be corrupted if chown is denied?

It is not clear to me what the purpose of this patch is or what the
exact usecase this is fixing.

Thanks,
Miklos
