Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3239998-1524146773-2-9321805661880432606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524146769; b=iQ2BFNo8enWl+12A0wRwxMOendqCQfI/sSFn5a+7opTgfJdUJ9
    EgLqD3aCLH5ia9VfGs8UTGyUEkO0hIVJwpzUFTnP6QQCTh7wNJQtKgfc0UyCPKkI
    KYq3NEsAvSLCCC5E66eLGJsLhhPFHuFDjxty5/v58rphkK/0g7cH5plIC8mLa7yJ
    m0TYBwypS/vRwH6bIrTNbFd/YumfoVoDzR5XUPQxXDJmRXqhbBjjvtzM2buA206J
    bH+qu3xbp/X5JAo1vQk8CZWf1n5AseUw0Czpmp96Y71yVvgQuyTrfVJdVvpEwxdm
    WN/mffjou6x7PF2Y3Q7jrW79NFI0wWdJWA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524146769; bh=o36K1M8a4+9r7raZSloXHhK8xIQP0E
    Ue2lAEMd08m98=; b=BuiO3bPy13e3lj9Zmyjrpt9GKLaZfqphsdKIvB3PV5DPAG
    5esfr2z05dNSq786y53llfmYAjt3F0ieUiB10xb+Tf9+yIwpD7A+zuMkMi4RuAzB
    zfH3+H4lQ57pyF/ptGbKof1cxzY1VNtqnLNoegTFWk65PuetA6ErCurc/57RYY8E
    pYPnmdivoJSEaxVGBZAbuO0K50xHF7AGK7lUvBi1KYboN+YAtBYcJtbi3f6K+qiJ
    ZSjEL37+VQVrsVDMDevNU2Bf5ArrAN2Yi3fCU4rRD3UojmLnOoVkYR97WQcbvuVj
    kiOkVmkqaIchs7WvsCh2Q8wfaoHxT2bvCIVRNzgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGAlkCz9RxeDSFXB7/pKR2VOLg3/egEHbr3rVFVpbd1qlJFIQnP1ojhU7DmQ/bps/B1bZHPXfh8edudSQ5MhYgS1W1IHrRn+HHS6JQuii7PLocHcCyoh
    3YLeBAiKwFVWIZQ2o3u9i4rpfigrDoRleAtH7tyBXoB8sciACLjm52UBJjxgLU6Mg84L7UEyKiPo1xBl52o2n9y65AB2S42qZm0T+dInvrpuClk+JIVKsAfS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=iox4zFpeAAAA:8 a=j92hxSc1Wd_PTkg83TYA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDSOFu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:05:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeDSOFt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 19 Apr 2018 10:05:49 -0400
Date: Thu, 19 Apr 2018 16:05:45 +0200
From: Jan Kara <jack@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
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
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180419140545.7hzpnyhiscgapkx4@quack2.suse.cz>
References: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
 <20180419135943.GC16862@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419135943.GC16862@kroah.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 19-04-18 15:59:43, Greg KH wrote:
> On Thu, Apr 19, 2018 at 02:41:33PM +0300, Thomas Backlund wrote:
> > Den 16-04-2018 kl. 19:19, skrev Sasha Levin:
> > > On Mon, Apr 16, 2018 at 12:12:24PM -0400, Steven Rostedt wrote:
> > > > On Mon, 16 Apr 2018 16:02:03 +0000
> > > > Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> > > > 
> > > > > One of the things Greg is pushing strongly for is "bug compatibility":
> > > > > we want the kernel to behave the same way between mainline and stable.
> > > > > If the code is broken, it should be broken in the same way.
> > > > 
> > > > Wait! What does that mean? What's the purpose of stable if it is as
> > > > broken as mainline?
> > > 
> > > This just means that if there is a fix that went in mainline, and the
> > > fix is broken somehow, we'd rather take the broken fix than not.
> > > 
> > > In this scenario, *something* will be broken, it's just a matter of
> > > what. We'd rather have the same thing broken between mainline and
> > > stable.
> > > 
> > 
> > Yeah, but _intentionally_ breaking existing setups to stay "bug compatible"
> > _is_ a _regression_ you _really_ _dont_ want in a stable
> > supported distro. Because end-users dont care about upstream breaking
> > stuff... its the distro that takes the heat for that...
> > 
> > Something "already broken" is not a regression...
> > 
> > As distro maintainer that means one now have to review _every_ patch that
> > carries "AUTOSEL", follow all the mail threads that comes up about it, then
> > track if it landed in -stable queue, and read every response and possible
> > objection to all patches in the -stable queue a second time around... then
> > check if it still got included in final stable point relase and then either
> > revert them in distro kernel or go track down all the follow-up fixes
> > needed...
> > 
> > Just to avoid being "bug compatible with master"
> 
> I've done this "bug compatible" "breakage" more than the AUTOSEL stuff
> has in the past, so you had better also be reviewing all of my normal
> commits as well :)
> 
> Anyway, we are trying not to do this, but it does, and will,
> occasionally happen.

Sure, that's understood. So this was just misunderstanding. Sasha's
original comment really sounded like "bug compatibility" with current
master is desirable and that made me go "Are you serious?" as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
