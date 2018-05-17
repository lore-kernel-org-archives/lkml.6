Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeEQP7j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:59:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33007 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:59:38 -0400
X-Google-Smtp-Source: AB8JxZqPF2xFpfw2ZoN3w8TdBWQtDtiTEblA0NW421W2jaKn/BdDQcnrBNwBAwvdegH5T8lcbfs7Eg==
Date: Thu, 17 May 2018 09:59:32 -0600
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
Subject: Re: [PATCH v2 3/4] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180517155932.GC3831@cisco>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-4-tycho@tycho.ws>
 <20180517154139.GB8586@redhat.com>
 <20180517155733.GB3831@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517155733.GB3831@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 09:57:33AM -0600, Tycho Andersen wrote:
> On Thu, May 17, 2018 at 05:41:39PM +0200, Oleg Nesterov wrote:
> > and since init_listener() does __get_seccomp_filter() on sucess, it is needed
> > uncondtitionally?
> 
> I think there does need to be a __get_seccomp_filter() on success in
> init_listener(), because it's paired with the __put_seccomp_filter in
> seccomp_notify_release. The listener fd has a reference to the filter,
> and that shouldn't go away until after the fd is freed.

Oh, sorry. I see what you meant here. Yes, it should be unconditional.

Tycho
