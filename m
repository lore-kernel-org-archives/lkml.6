Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERPKd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:10:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51388 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:10:32 -0400
X-Google-Smtp-Source: AB8JxZpug3k8vFwC4MrqJOZW0wmok3rIP787LdTLZtLrYJrXJ6RZ9wdnfvZj0CDAF+CglIfF9RzFBg==
Date: Fri, 18 May 2018 09:10:28 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        "Tobin C . Harding" <me@tobin.cc>, Kees Cook <keescook@chromium.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v2 3/4] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180518151028.GA7699@cisco>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-4-tycho@tycho.ws>
 <20180518140556.GC26297@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518140556.GC26297@mailbox.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 04:05:56PM +0200, Christian Brauner wrote:
> On Thu, May 17, 2018 at 09:12:17AM -0600, Tycho Andersen wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> > 
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> 
> I get the problem I guess the question we need to answer is do we care
> enought to bring ptrace into this? Not really objecting, just asking. :)
> If blocking sendmsg() or socket() becomes an issue because people like
> to shoot themselves in the foot we can surely add this option later.

It doesn't seem that unreasonable to me to want to filter socket() or
sendmsg() though, so designing an API that doesn't support that from
the get-go seems like a bad idea. But that's why there are two
alternatives, so we can argue about it :)

Tycho
