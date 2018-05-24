Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966680AbeEXP2f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:28:35 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43253 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966171AbeEXP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:28:32 -0400
X-Google-Smtp-Source: AB8JxZo/jRW1ZVrClOj/V6BJu/mld5di4qJ9mvc7I4ZZZXr+ZLbRYQHXyeYdAoSnziz94fXCkvYgYQ==
Date: Thu, 24 May 2018 09:28:27 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v2 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180524152827.GD21405@cisco>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-2-tycho@tycho.ws>
 <20180517153323.GA8586@redhat.com>
 <20180517153957.GA3831@cisco>
 <20180517154637.GC8586@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517154637.GC8586@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Thu, May 17, 2018 at 05:46:37PM +0200, Oleg Nesterov wrote:
> On 05/17, Tycho Andersen wrote:
> >
> > > From lockdep pov this loop tries to take the same lock twice or more, it shoul
> > > complain.
> >
> > I didn't, but I guess that's because it's not trying to take the same lock
> > twice -- the pointer cur is changing in the loop.
> 
> Yes, I see. But this is the same lock for lockdep, it has the same class.

I finally figured this out, I needed CONFIG_PROVE_LOCKING=y too,
anyway, I've added the nesting annotations for v3. Thanks!

Tycho
