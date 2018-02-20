Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2825185-1519130641-2-6549657004961487784
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
    t=1519130641; b=wh9yy2C52Aw1bXDOvYrrE6qo552R5WPoZVp6qQ+HL3wl/LR
    NnYvuFKmD7n2v2nMO/oj0Jb4z0KEpd+5sTR0GCILyVhODF7mDb637i6sgysCkh8e
    MzvEHvxCzqoEOMRsUCR2OSzyCryi5IIrBVFsWiHVft5gFYM1lptCuSiCG1lpFAse
    mUXRi0uo74yYWahkPHkCYpxyOCmxLwya7ts8JzPYTF140so7PHnQyjqGIQnWg/N2
    0cniL4652EtAgqYqfHVnuox141B0LaGkdJ5xNK+Fd0AIxbN4LV3c07Ql7elhd2TU
    /BBGbxWhWYc5JkxdfygcNnOiQYtRW2PRHhzTnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519130641; bh=kgkfG7B7B0stlcP2qu/BndbmSq
    ruV1HvjKqaM6p2HLw=; b=vewpoHrIOR9EwiTNvTZ3NLW9b7vODA7vN4JYbFxEd0
    zNQyUQMAKfGnQXGMpXJQW3JyngcEaoQEKDMe0KJRG2PSvxdTC/NnZxACDiuAMkPN
    FPcw9UyxVIXNYJ8gyW1VQHETt44/7XSqrV5iriVD1hS79socCIjon0rRFnR40ke2
    MC7UBvoF4N1PzRFAagwUSTHSXo52Ub6f1Juvgd2+AS4WZsHHRNlMRQ9PbBYu31dc
    F4W5j0NtNmSvL7niBvk3eyycBImH6cr37Orgi662qsEXzxxQe9X9q2rE6NJI0A82
    PRQpN9rt6AO0NF02KLAAId0ZapmLVUDsm1LMqhnpkh7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeBTMn6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:43:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbeBTMn5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Feb 2018 07:43:57 -0500
Date: Tue, 20 Feb 2018 13:43:54 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
Message-ID: <20180220124354.6awua447q55lfduf@quack2.suse.cz>
References: <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com>
 <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
 <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
 <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com>
 <20180219135027.fd6doess7satenxk@quack2.suse.cz>
 <CAOQ4uxjkfTTJ7nxrtj8ZsKcsWfBz=J0RPv3N=u3JaskRgG9aWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkfTTJ7nxrtj8ZsKcsWfBz=J0RPv3N=u3JaskRgG9aWw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 19-02-18 21:07:28, Amir Goldstein wrote:
> On Mon, Feb 19, 2018 at 3:50 PM, Jan Kara <jack@suse.cz> wrote:
> [...]
> > For fanotify without FAN_UNLIMITED_QUEUE the situation is similar as for
> > inotify - IMO low practical impact, apps should generally handle queue
> > overflow so I don't see a need for any opt in (more accurate memcg charging
> > takes precedense over possibly broken apps).
> >
> > For fanotify with FAN_UNLIMITED_QUEUE the situation is somewhat different -
> > firstly there is a practical impact (memory consumption is not limited by
> > anything else) and secondly there are higher chances of the application
> > breaking (no queue overflow expected) and also that this breakage won't be
> > completely harmless (e.g., the application participates in securing the
> > system). I've been thinking about this "conflict of interests" for some
> > time and currently I think that the best handling of this is that by
> > default events for FAN_UNLIMITED_QUEUE groups will get allocated with
> > GFP_NOFAIL - such groups can be created only by global CAP_SYS_ADMIN anyway
> > so it is reasonably safe against misuse (and since the allocations are
> > small it is in fact equivalent to current status quo, just more explicit).
> > That way application won't see unexpected queue overflow. The process
> > generating event may be looping in the allocator but that is the case
> > currently as well. Also the memcg with the consumer of events will have
> > higher chances of triggering oom-kill if events consume too much memory but
> > I don't see how this is not a good thing by default - and if such reaction
> > is not desirable, there's memcg's oom_control to tune the OOM behavior
> > which has capabilities far beyond of what we could invent for fanotify...
> >
> > What do you think Amir?
> >
> 
> If I followed all your reasoning correctly, you propose to change behavior to
> always account events to group memcg and never fail event allocation,
> without any change of API and without opting-in for new behavior?
> I think it makes sense. I can't point at any expected breakage,
> so overall, this would be a good change.
> 
> I just feel sorry about passing an opportunity to improve functionality.
> The fact that fanotify does not have a way for defining the events queue
> size is a deficiency IMO, one which I had to work around in the past.
> I find that assigning group to memgc and configure memcg to desired
> memory limit and getting Q_OVERFLOW on failure to allocate event
> is going to be a proper way of addressing this deficiency.

So if you don't pass FAN_Q_UNLIMITED, you will get queue with a fixed size
and will get Q_OVERFLOW if that is exceeded. So is your concern that you'd
like some other fixed limit? Larger one or smaller one and for what
reason?

> But if you don't think we should bind these 2 things together,
> I'll let Shakeel decide if he want to pursue the Q_OVERFLOW change
> or not.

So if there is still some uncovered use case for finer tuning of event
queue length than setting or not setting FAN_Q_UNLIMITED (+ possibly
putting the task to memcg to limit memory usage), we can talk about how to
address that but at this point I don't see a strong reason to bind this to
whether / how events are accounted to memcg...

And we still need to make sure we properly do ENOMEM -> Q_OVERFLOW
translation and use GFP_NOFAIL for FAN_Q_UNLIMITED groups before merging
Shakeel's memcg accounting patches. But Shakeel does not have to be the one
implementing that (although if you want to, you are welcome Shakeel :) -
otherwise I hope I'll get to it reasonably soon).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
