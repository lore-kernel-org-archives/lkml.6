Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeDJRxh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:53:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751589AbeDJRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:53:35 -0400
Date: Tue, 10 Apr 2018 12:53:34 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] livepatch: Add an extra flag to distinguish
 registered patches
Message-ID: <20180410175334.uksntqslarnl7izn@treble>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-5-pmladek@suse.com>
 <alpine.LSU.2.21.1804091556110.20943@pobox.suse.cz>
 <20180410105625.4o4ozkpmanevytnh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410105625.4o4ozkpmanevytnh@pathway.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 12:56:25PM +0200, Petr Mladek wrote:
> > > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > > index f28af280f9e0..d6e6d8176995 100644
> > > --- a/include/linux/livepatch.h
> > > +++ b/include/linux/livepatch.h
> > > @@ -378,7 +383,7 @@ int klp_disable_patch(struct klp_patch *patch)
> > >  
> > >  	mutex_lock(&klp_mutex);
> > >  
> > > -	if (!klp_is_patch_registered(patch)) {
> > > +	if (!patch->registered) {
> > 
> > I don't see any actual problem, but I'd feel safer if we preserve 
> > klp_is_patch_on_stack() even somewhere in disable path.
> 
> It is strictly needed in klp_enable_patch() which will be better
> visible if I squash it with the next patch.
> 
> The use in klp_disable_patch() is optional. I do not have problems
> to add it there though. If Josh does not see it as too paranoid,
> I'll add it.

That does seem pointless to me, how did you know? :-)

Of course if we make the other changes we've been discussing, maybe it's
no longer an issue.

-- 
Josh
