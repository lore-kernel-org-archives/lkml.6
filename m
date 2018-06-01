Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeFAQAh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:00:37 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:8870 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeFAQAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:00:36 -0400
Date: Fri, 1 Jun 2018 18:00:29 +0200
From: Christian Brauner <christian@brauner.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 03/17] signal: make may_ptrace_stop() return bool
Message-ID: <20180601160029.GA13955@mailbox.org>
References: <20180601132239.4421-1-christian@brauner.io>
 <20180601132239.4421-4-christian@brauner.io>
 <20180601155612.GB1058@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601155612.GB1058@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:56:12PM +0200, Oleg Nesterov wrote:
> On 06/01, Christian Brauner wrote:
> >
> > may_ptrace_stop() already behaves like a boolean function. Let's actually
> > declare it as such too.
> 
> OK. Then probably this patch should only make it return bool and do nothing else?
> 
> > -	if (unlikely(current->mm->core_state) &&
> > -	    unlikely(current->mm == current->parent->mm))
> > -		return 0;
> > +	if (likely(!current->mm->core_state ||
> > +		   current->mm != current->parent->mm))
> > +		return false;
> 
> this is wrong.

This was a suggestion by Al. I just took it over and may have messed it
up while doing so. I'll remove this.

Christian
