Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-177322-1519048234-2-6629628769676856817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519048233; b=C34lwS10xx76x7yIyp0wAPHbJe/T/WSLS2Qn5SvBfoB6QBO
    PbNz1voXaXzhT034/+cNBAVRH0IDoR2AKMl7xON19XnvRdK+tJwXco64DSLIn70D
    qMVNzigVld1BTvC/KPMKlvR4GQUi58xiHFE7mByBUBF22AGsQhUlVLx2KmTQpNq8
    OQ+MwWByW4yTrs4xwm5TgVSRf2m2/QMJY92rCSOU1UqcjM9slrLeFKEc8YMDajcx
    KEyLWi04Iql+pdlBuYcEHG6GK9eVmpzu1leV58zvpfj2CoVtamqdEu7K3TEO+3Wv
    NxacSm9sjfNy8cKxB3xkkqtIPu9PC/1cfIxCsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519048233; bh=SIdcP8T+L/TjxIEA1DFzhZZwoW
    5fry0kU62kSPIms7M=; b=D7bTfQvXNLts95/b3jXoSLVm9CcE1y73I7uG6IDF21
    sDQlRvlOBT3RdWP2tjZSY/xvO/x7/BXWCPmF/F70qIGyYSbN3RgVSDQojdkaKAJJ
    PZxNtTo8Va37RF2pvG63TKhh1/WI8GvCOW22idsDcanRAY1fnavD5FfBRM5ERgJL
    taxxDKPGPk2/XTeJME8cmoN15rSWs3tjoQlY7UQtf4VmQTBUfuTluukzNFZEajId
    20fSWs6RapDtaYDF4r2lK4vZmM+00AeakEgBnorVj0Yy0IaBFxkXIIaEWLzisapz
    Q3cNnzLv+zsRK3wtC6cizXfd8DtAreI11UvvgYAPHRnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeBSNub (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 08:50:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:39163 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbeBSNua (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 19 Feb 2018 08:50:30 -0500
Date: Mon, 19 Feb 2018 14:50:27 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Shakeel Butt <shakeelb@google.com>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
Message-ID: <20180219135027.fd6doess7satenxk@quack2.suse.cz>
References: <CALvZod4PyqfaqgEswegF5uOjNwVwbY1C4ptJB0Ouvgchv2aVFg@mail.gmail.com>
 <CAOQ4uxhyZNghjQU5atNv5xtgdHzA75UayphCyQDzxjM8GDTv3Q@mail.gmail.com>
 <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com>
 <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
 <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
 <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 14-02-18 10:38:09, Amir Goldstein wrote:
> On Wed, Feb 14, 2018 at 3:59 AM, Shakeel Butt <shakeelb@google.com> wrote:
> > On Tue, Feb 13, 2018 at 2:20 PM, Shakeel Butt <shakeelb@google.com> wrote:
> [...]
> >>>>> Something like FAN_GROUP_QUEUE  (better name is welcome)
> >>>>> which is mutually exclusive (?) with FAN_UNLIMITED_QUEUE.
> >>>>>
> >>
> >> How about FAN_CHARGE_MEMCG?
> >>
> 
> I am not crazy about this name.
> Imagine a user that writes a file system listener that is going to run
> inside a container.
> The user doesn't need to know about the container or what is memcg
> and what is memcg charging.
> IMO, we need to hide those implementation details from the user and
> yet encourage user to opt-in for memcg charging... or do we?

Well, there's also a different question: Why should an application writer
*want* to opt for such flag? Even if he wants his application to be well
behaved he most likely just won't think about memcg charging and thus why
should he set the flag? IMHO users of such API would be very limited...

> > Also should there be a similar flag for inotify_init1() as well?
> >
> 
> This question changed my perspective on the fanotify_init() flag.
> Unlike with fanotify, for inotify, is it the sysadmin that determines
> the size of the queue of future listeners by setting
> /proc/sys/fs/inotify/max_queued_events
> 
> IMO, there is little justification for a program to opt-out of memcg
> charging if the sysadmin opts-in for memcg charging.
> Anyone disagrees with that claim?

Frankly, I believe there's little point in memcg charging for inotify.
Everything is limited anyway and the amount of consumed memory is small (a
few megabytes at most). That being said I do think that for consistency
it should be implemented. Just the practical impact is going to be small.

> So how about /proc/sys/fs/inotify/charge_memcg
> which defaults to CONFIG_INOTIFY_CHARGE_MEMCG
> which defaults to N.
> 
> Then sysadmin can opt-in/out of new behavior and distro can
> opt-in for new behavior by default and programs don't need to
> be recompiled.
> 
> I think that should be enough to address the concern of changing
> existing behavior.

For inotify my concerns about broken apps are even lower than for fanotify
- if sysadmin sets up memcgs he very likely prefers broken inotify app to
container consuming too much memory (generally breakage is assumed when a
container runs out of memory since most apps just crash in such case
anyway) and app should generally be prepared to handle queue overflow so
there are reasonable chances things actually work out fine. So I don't see
a good reason for adding inotify tunables for memcg charging. We don't have
tunables for inode memcg charging either and those are more likely to break
apps than similar inotify changes after all.

> The same logic could also apply to fanotify, excpet we may want to
> use sysfs instead of procfs.
> The question is: do we need a separate knob for charging memcg
> for inotify and fanotify or same knob can control both?
> 
> I can't think of a reason why we really need 2 knobs, but maybe
> its just nicer to have the inotify knob next to the existing
> max_queued_events knob.

For fanotify without FAN_UNLIMITED_QUEUE the situation is similar as for
inotify - IMO low practical impact, apps should generally handle queue
overflow so I don't see a need for any opt in (more accurate memcg charging
takes precedense over possibly broken apps).

For fanotify with FAN_UNLIMITED_QUEUE the situation is somewhat different -
firstly there is a practical impact (memory consumption is not limited by
anything else) and secondly there are higher chances of the application
breaking (no queue overflow expected) and also that this breakage won't be
completely harmless (e.g., the application participates in securing the
system). I've been thinking about this "conflict of interests" for some
time and currently I think that the best handling of this is that by
default events for FAN_UNLIMITED_QUEUE groups will get allocated with
GFP_NOFAIL - such groups can be created only by global CAP_SYS_ADMIN anyway
so it is reasonably safe against misuse (and since the allocations are
small it is in fact equivalent to current status quo, just more explicit).
That way application won't see unexpected queue overflow. The process
generating event may be looping in the allocator but that is the case
currently as well. Also the memcg with the consumer of events will have
higher chances of triggering oom-kill if events consume too much memory but
I don't see how this is not a good thing by default - and if such reaction
is not desirable, there's memcg's oom_control to tune the OOM behavior
which has capabilities far beyond of what we could invent for fanotify...

What do you think Amir?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
