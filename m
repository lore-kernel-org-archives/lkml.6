Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3581170-1524156109-2-11068958863329957127
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524156108; b=jxWGMhrJ7vNGUIMl9CO/L8qLI97JPSpzoiM7HZLzHObyPFMf8D
    KUvOrVm0vy/hyW2U3sKOD9ITCA1bsrMitOUjwH+PS01xv3Qqc+/hEubasad396ni
    FsfzHu2/kghOnA8RDN/wMK568NpcXimWEdsQJ3jEUlLrbg4CxnK0ygNpR5zFy+5k
    M4s7M6ou8HPsvVyq3JbGZJFk2QaU+6w+9cb3SmBmP4L8j7rQ3wOpr/alDzUOSFF0
    KeR+/3q//uguyccEtq2SQdgcpghELa8rfjVyu6omlx+w3z0NzqAKHxm2Rej6Jg+S
    77YXSw0MErhJMnAZj+LyditDRjLmY9H3LVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524156108; bh=VX94VrQnXGKlq5heKm9V9SLX03UBVG
    vAZd06/pofTJw=; b=Hz8XsvZ5KGeyrFsC1RuV20GLXYlc6LddVXtM9lKLXQbhog
    8e+BYkXEvfSKf9Di2qIb3tBViH1SyJNdI8T2GKVYk2eK3Ju7P8n8Uy/vO/8s+TsI
    yeAQuun3O88jSJKpdA5SqBVgz8GjqHbPrq3n/gc/WfHbArzR5KDJCYKV929BVtbN
    GOfQI3W9UJgo/U0XVtiNLNs7IGjN8gMIG+S5/2POyrx0B4mwsJ+UjWrXZCEvPTxj
    3GUMVY7gK3zSJx42zUcWjAUdVnm3LSGtuUxVqW27Fgi0Wu0mRxZ6YksscBggNgwf
    EmsQisg+YKigxsGzGv5z/4KkztuX6IwQj6O5t/og==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA0kVjurbh3uRsWxXPSojjy1eQ9NOyN1MKmDcWuBJIHFDS6hY07dQbr6owz5yMXXIHPpRbkddfHaJcgkHyeo+/lOPLgU0fsZ/loC60ibLID4gjphVXTg
    0gspx3YkUjy2HaXVA98DBV55jSgSD0w2RLPHCWVx3fOYxOHp8JyiDkEEfXHgclqjt+dqWJD1ItxZHbUeTdoLt3u+vc3nvwHUZLpLNtRsAZD67LqoFPZlkO2s
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=x54u9fyVrajkLWY98SEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeDSQlb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 12:41:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeDSQl3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 12:41:29 -0400
Date: Thu, 19 Apr 2018 18:41:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Thomas Backlund <tmb@mageia.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180419164122.GA5494@kroah.com>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
 <20180419135943.GC16862@kroah.com>
 <20180419140545.7hzpnyhiscgapkx4@quack2.suse.cz>
 <20180419142222.GA29648@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419142222.GA29648@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 04:22:22PM +0200, Greg KH wrote:
> On Thu, Apr 19, 2018 at 04:05:45PM +0200, Jan Kara wrote:
> > On Thu 19-04-18 15:59:43, Greg KH wrote:
> > > On Thu, Apr 19, 2018 at 02:41:33PM +0300, Thomas Backlund wrote:
> > > > Den 16-04-2018 kl. 19:19, skrev Sasha Levin:
> > > > > On Mon, Apr 16, 2018 at 12:12:24PM -0400, Steven Rostedt wrote:
> > > > > > On Mon, 16 Apr 2018 16:02:03 +0000
> > > > > > Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> > > > > > 
> > > > > > > One of the things Greg is pushing strongly for is "bug compatibility":
> > > > > > > we want the kernel to behave the same way between mainline and stable.
> > > > > > > If the code is broken, it should be broken in the same way.
> > > > > > 
> > > > > > Wait! What does that mean? What's the purpose of stable if it is as
> > > > > > broken as mainline?
> > > > > 
> > > > > This just means that if there is a fix that went in mainline, and the
> > > > > fix is broken somehow, we'd rather take the broken fix than not.
> > > > > 
> > > > > In this scenario, *something* will be broken, it's just a matter of
> > > > > what. We'd rather have the same thing broken between mainline and
> > > > > stable.
> > > > > 
> > > > 
> > > > Yeah, but _intentionally_ breaking existing setups to stay "bug compatible"
> > > > _is_ a _regression_ you _really_ _dont_ want in a stable
> > > > supported distro. Because end-users dont care about upstream breaking
> > > > stuff... its the distro that takes the heat for that...
> > > > 
> > > > Something "already broken" is not a regression...
> > > > 
> > > > As distro maintainer that means one now have to review _every_ patch that
> > > > carries "AUTOSEL", follow all the mail threads that comes up about it, then
> > > > track if it landed in -stable queue, and read every response and possible
> > > > objection to all patches in the -stable queue a second time around... then
> > > > check if it still got included in final stable point relase and then either
> > > > revert them in distro kernel or go track down all the follow-up fixes
> > > > needed...
> > > > 
> > > > Just to avoid being "bug compatible with master"
> > > 
> > > I've done this "bug compatible" "breakage" more than the AUTOSEL stuff
> > > has in the past, so you had better also be reviewing all of my normal
> > > commits as well :)
> > > 
> > > Anyway, we are trying not to do this, but it does, and will,
> > > occasionally happen.
> > 
> > Sure, that's understood. So this was just misunderstanding. Sasha's
> > original comment really sounded like "bug compatibility" with current
> > master is desirable and that made me go "Are you serious?" as well...
> 
> As I said before in this thread, yes, sometimes I do this on purpose.
> 
> As an specific example, see a recent bluetooth patch that caused a
> regression on some chromebook devices.  The chromeos developers
> rightfully complainied, and I left the commit in there to provide the
> needed "leverage" on the upstream developers to fix this properly.
> Otherwise if I had reverted the stable patch, when people move to a
> newer kernel version, things break, and no one remembers why.
> 
> I also wrote a long response as to _why_ I do this, and even though it
> does happen, why it still is worth taking the stable updates.  Please
> see the archives for the full details.  I don't want to duplicate this
> again here.

And to be more specific, let's always take this as a case-by-case basis.
The last time this happened was the bluetooth bug and it was a fix for a
reported problem, but then the fix caused a regression so upstream
reverted it and I reverted it in the stable trees.  No matter what I
chose to do, someone would be upset so I followed what upstream did.

thanks,

greg k-h
