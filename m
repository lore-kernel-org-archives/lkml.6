Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeB0DlY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:41:24 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:54394 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeB0DlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:41:22 -0500
X-Google-Smtp-Source: AG47ELu/MXt0yDOxqSLFDuzdjrh5Qgn9XsFmrC3adSLVrgz2XCBbe+gg0bOHHH3kmvuooNPOJOLXolu5v5jYQx2RMoE=
MIME-Version: 1.0
In-Reply-To: <87tvu3qg2b.fsf@xmission.com>
References: <87po4rz4ui.fsf_-_@xmission.com> <20180226235302.12708-3-ebiederm@xmission.com>
 <CA+55aFySgJyR6JLcS9HLC9wEpWU1isdyTkchHxZHbJWsh7HFpg@mail.gmail.com>
 <87r2p7rvn5.fsf@xmission.com> <87tvu3qg2b.fsf@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2018 19:41:21 -0800
X-Google-Sender-Auth: 6VIjTj4Aaa-ITXFFYG9bnEBQUQw
Message-ID: <CA+55aFwPo7Pbq+3Oup-oo8MUFHeEpFXp7qr6z2PrzKp7S0ON+A@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] fs/posix_acl: Document that get_acl respects ACL_DONT_CACHE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Feb 26, 2018 at 7:14 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> As such I believe that usage of forget_cached_acl should be subsumed by
> using ACL_NOT_CACHED.  If not we should really come up with a different
> helper function name to call from ->get_acl.  Preferably one that does
> "cmpxchng(p, sentinel, ACL_NOT_CACHED)" so that we remove the races.

You make your bias very clear, by simply trying to hide the other case.

But for chrissake, that's not the state right now. That other case
exists. You can't - and shouldn't - try to just hide it.

Besides, that "forget_cached_acl()" approach actually has a valid use
case. Maybe you _do_ want to cache ACL's, but with a timeout or
revalidation.

ACL_DONT_CACHE really is a big hammer that makes caching not work at
all. It's not necessarily the right thing to do at all.

                Linus
