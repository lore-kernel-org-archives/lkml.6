Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBZHrZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:47:25 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36883 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeBZHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:47:22 -0500
X-Google-Smtp-Source: AG47ELvidInK4kS+lBnTwzIAqaq+A7nV5SVc1SoTdF6lgYd4dsGj1NB3IVzLJVw7P55HnlOXgJTiJf+jdus9eeBeDNA=
MIME-Version: 1.0
In-Reply-To: <87mv004p0t.fsf@xmission.com>
References: <878tbmf5vl.fsf@xmission.com> <20180221202908.17258-4-ebiederm@xmission.com>
 <CAOssrKeNLBeMkMrrCeRBO9Z80zFxCCEygKL3DErnQ9xBoLkH0g@mail.gmail.com>
 <87inao6dfa.fsf@xmission.com> <87mv004p0t.fsf@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 26 Feb 2018 08:47:21 +0100
Message-ID: <CAOssrKd+c0Mx+=S-+zr1QS8a37Pm=VGki=FVR+LXQZBsk3byqA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] fuse: Ensure posix acls are translated outside of init_user_ns
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:50 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:

> So if we could figure out how to use the generic acl support for the old
> brand of fuse filesystems that don't set FUSE_POSIX_ACL it would be much
> easier to support them long term.

Simplest and most robust way seems to be to do everything the same (as
with FUSE_POSIX_ACL) but tell the vfs not to cache the acl.

Thanks,
Miklos
