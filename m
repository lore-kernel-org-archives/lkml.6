Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967676AbeBNM2Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:28:16 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:41373 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967454AbeBNM2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:28:13 -0500
X-Google-Smtp-Source: AH8x225AGXNz4avDq08W0x32zoTH1Pjv2EPpfWSwYaGhTG44zO/FqMi7rvcNfstiBF3y8TADGx7RpontLShPFB8p7UE=
MIME-Version: 1.0
In-Reply-To: <61a37f0b159dd56825696d8d3beb8eaffdf1f72f.1512041070.git.dongsu@kinvolk.io>
References: <cover.1512741134.git.dongsu@kinvolk.io> <61a37f0b159dd56825696d8d3beb8eaffdf1f72f.1512041070.git.dongsu@kinvolk.io>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 14 Feb 2018 13:28:12 +0100
Message-ID: <CAOssrKeSTY1pAhpmegFWdGh7irNbT4veG5JaYFj8Q1JjMynadw@mail.gmail.com>
Subject: Re: [PATCH 07/11] fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and
 thaw filesystems
To: Dongsu Park <dongsu@kinvolk.io>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> From: Seth Forshee <seth.forshee@canonical.com>
>
> The user in control of a super block should be allowed to freeze
> and thaw it. Relax the restrictions on the FIFREEZE and FITHAW
> ioctls to require CAP_SYS_ADMIN in s_user_ns.

Why is this required for unprivileged fuse?

Fuse doesn't support freeze, so this seems to make no sense in the
context of this patchset.

Thanks,
Miklos
