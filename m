Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeCEJxr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:53:47 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:38960 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933071AbeCEJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:53:42 -0500
X-Google-Smtp-Source: AG47ELvZlKWkoLBVwp8EfYHyGfGZXnkbROn/TjtBc1h7yB8EfNPugq61KxoctjcYFRis3YxE7Ei9vs1Ll2E4DcCyays=
MIME-Version: 1.0
In-Reply-To: <20180302215919.27207-1-ebiederm@xmission.com>
References: <87r2p287i8.fsf_-_@xmission.com> <20180302215919.27207-1-ebiederm@xmission.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 5 Mar 2018 10:53:41 +0100
Message-ID: <CAOssrKf0cuxx1YLiwFJHSnzMOOoejjWWibs98Mb5KSXVSSXfOg@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] fs/posix_acl: Update the comments and support
 lightweight cache skipping
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:59 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> The code has been missing a way for a ->get_acl method to not cache
> a return value without risking invalidating a cached value
> that was set while get_acl() was returning.
>
> Add that support by implementing to_uncachable_acl, to_cachable_acl,
> is_uncacheable_acl, and dealing with uncachable acls in get_acl().

I don't like the pointer magic here.  Can't the uncachable bit just be
added to struct posix_acl?

 AFAICS that can be done even without increasing the size of that
struct (e.g. by unioning it with the rcu_head).

Thanks,
Miklos
