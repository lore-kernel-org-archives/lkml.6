Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeB0JA2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:00:28 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:42444 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeB0JA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:00:26 -0500
X-Google-Smtp-Source: AG47ELvb4Kcx2XMzCFgDlOpZegmzdkNJpFnHt9V2qTjr4N1moQFe+F6JJazwDddpGKaWHGKnJh5fRvOFMzm1WlK46SM=
MIME-Version: 1.0
In-Reply-To: <20180226235302.12708-5-ebiederm@xmission.com>
References: <87po4rz4ui.fsf_-_@xmission.com> <20180226235302.12708-5-ebiederm@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 27 Feb 2018 10:00:25 +0100
Message-ID: <CAOssrKeWvYpgj4_cgsRBL_kTOHyRS-9_mfO9JHP-JahgqFnfHQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] fuse: Simplfiy the posix acl handling logic.
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

On Tue, Feb 27, 2018 at 12:53 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Rename the fuse connection flag posix_acl to cached_posix_acl as that
> is what it actually means.  That fuse will cache and operate on the
> cached value of the posix acl.
>
> When fc->cached_posix_acl is not set, set ACL_DONT_CACHE on the inode
> so that get_acl and friends won't cache the acl values even if they
> are called.
>
> Replace forget_all_cached_acls with fuse_forget_cached_acls.  This
> wrapper only takes effect when cached_posix_acl is true to prevent
> losing the nocache or noxattr status in when posix acls are not
> cached.

Shouldn't forget_cached_acl() be taught about ACL_DONT_CACHE?  I think
it makes sense to generally not clear ACL_DONT_CACHE, since it's not
an actual acl value that needs forgetting.

Thanks,
Miklos
