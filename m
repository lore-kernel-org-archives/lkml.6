Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEQPd3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:33:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751396AbeEQPd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:33:28 -0400
Date: Thu, 17 May 2018 17:33:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.ws>
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
Message-ID: <20180517153323.GA8586@redhat.com>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517151218.12850-2-tycho@tycho.ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't read this series yet, and I don't even understand what are you
trying to do, just one question...

On 05/17, Tycho Andersen wrote:
>
> +static struct file *init_listener(struct task_struct *task,
> +				  struct seccomp_filter *filter)
> +{
> +	struct file *ret = ERR_PTR(-EBUSY);
> +	struct seccomp_filter *cur;
> +	bool have_listener = false;
> +
> +	for (cur = task->seccomp.filter; cur; cur = cur->prev) {
> +		mutex_lock(&cur->notify_lock);

Did you test this patch with CONFIG_LOCKDEP ?

>From lockdep pov this loop tries to take the same lock twice or more, it shoul
complain.

Oleg.
