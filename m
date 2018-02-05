Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568875-1517838478-2-9672370982703893853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517838478; b=kika73R0Y6Z6nG7Zq9A2X5IIW6Ff2ZCVVeMTHMxl/zfZxkz
    VtuggUgxEthK4hBvtq0myMmwX6llNgyPwt30GvjrWiSMo88qeThkEr1OpFpChvpV
    bIicGDOwNac80Oc/iZh7PMhRip6QzfmN84BFLomZqe8Df8P1XdmC2SCChvUhcL/M
    Gk9H+/QtnMH/1QmfYzcHoH+RGq8DrCmElYr2lAn+dEzcQXVQ8ZUncHsXvnfOpyjg
    Ur6lHQgArVXR5BwgT1O6eWIcm81L/U5mWr203ueWaqCbqTWXMIl3+1LK0V3G653M
    ywBB0TkiIH0ec8AfY+BVrAaEJsUri080l2V7Kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517838478; bh=WS2+PqPYEjvvY74zOpZE21rIsLWnjbrfygerf8r+Q9M=; b=t
    ZBeybpQnbObKvEH/kLwNU6RagWV2HyuHq57V4EvcO4dxZxSgTHFCq/vPvr/9aIEM
    jh8kRRWARKYR15WkwX5W9mIUln1NFXom1kvpaej5awTHWyNRA1NvvDiZ0yZLSZjz
    g25QDNxKF3nBLUMn4EykpdLpVMHirh9RN4ts3ithB0MkA4jgKRG55UJkp7q3CLxp
    7phomT1IlcPlTI2eksyoeJoYyA9ONY/e1V279bjDEg6hHQsRSJ1KxGOPmOxZT+1S
    HunZV7YfbiBsfBJgXuV61FF6rYQYcdmt/4xmTYv9EoC/kLuumnh4f8qnDxWLfH/x
    1rdtsdjiZcR1aa2iUWWnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeBENrz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 08:47:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753015AbeBENry (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Feb 2018 08:47:54 -0500
Message-ID: <1517838456.13097.163.camel@redhat.com>
Subject: Re: RFC(V3): Audit Kernel Container IDs
From: Simo Sorce <simo@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        David Howells <dhowells@redhat.com>, cgroups@vger.kernel.org,
        jlayton@redhat.com, trondmy@primarydata.com,
        "Serge E. Hallyn" <serge@hallyn.com>, mszeredi@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Network Development <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date: Mon, 05 Feb 2018 08:47:36 -0500
In-Reply-To: <CAHC9VhTg0ocArSek03A-XrbjgR4iGeysxXWaA8HknKBD_5ZRkA@mail.gmail.com>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
         <1515514736.3239.10.camel@redhat.com>
         <20180110070011.l4rcdcwb27witfem@madcap2.tricolour.ca>
         <CAHC9VhQ=hX55e7ftkVQCogTZTcdSm3rm-+YNOgWomabbXV_sKg@mail.gmail.com>
         <1517609946.13097.161.camel@redhat.com>
         <CAHC9VhTg0ocArSek03A-XrbjgR4iGeysxXWaA8HknKBD_5ZRkA@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 18:24 -0500, Paul Moore wrote:
> On Fri, Feb 2, 2018 at 5:19 PM, Simo Sorce <simo@redhat.com> wrote:
> > On Fri, 2018-02-02 at 16:24 -0500, Paul Moore wrote:
> > > On Wed, Jan 10, 2018 at 2:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On 2018-01-09 11:18, Simo Sorce wrote:
> > > > > On Tue, 2018-01-09 at 07:16 -0500, Richard Guy Briggs wrote:
> 
> ...
> 
> > > > Paul, can you justify this somewhat larger inconvenience for some
> > > > relatively minor convenience on our part?
> > > 
> > > Done in direct response to Simo.
> > 
> > Sorry but your response sounds more like waving away then addressing
> > them, the excuse being: we can't please everyone, so we are going to
> > please no one.
> 
> I obviously disagree with the take on my comments but you're free to
> your opinion.

The I misunderstood your comments, I am not interested in putting words
in your mouth.

> I believe saying we are pleasing no one isn't really fair now is it?

Well, of course you are going to please the audit subsystem, I
understand that. I think there is a problem of expectations. Some
people, me included, hoped to have a way to identify a container with
the help of the kernel.

> Is there any type of audit container ID now?  How would you go about
> associating audit events with containers now?

We do not have a good way, there are some dirty tricks like inferring
the container identity via cgroup names, but that is ... eww.
This is why, given audit has the same need of user space, there was
some hope we could agree on an identifier that could be used by both.
It would make correlating audit logs and other cluster-wide events
simpler. That is all.

>  (spoiler alert: it ain't
> pretty, and there are gaps I don't believe you can cover)  This
> proposal provides a mechanism to do this in a way that isn't tied to
> any one particular concept of a container and is manageable inside the
> kernel.

I like the proposal for the most part, we are just discussing on the
nature of the identifier, which is a minor detail in the end.

> If you have a need to track audit events for containers, I find it
> extremely hard to believe that you are not at least partially pleased
> by the solutions presented here.  It may not be everything on your
> wishlist, but when did you ever get *everything* on your wishlist?

It is true, and I am sorry if I came out demanding or abrasive. It was
not my intention. Of course a u64 that has to be mapped is still better
than nothing. It does cause a lot more work in user space, but it is
not impossible to deal with.

> > > But to be clear Richard, we've talked about this a few times, it's not
> > > a "minor convenience" on our part, it's a pretty big convenience once
> > > we starting having to route audit events and make decisions based on
> > > the audit container ID information.  Audit performance is less than
> > > awesome now, I'm working hard to not make it worse.
> > 
> > Sounds like a security vs performance trade off to me.
> 
> Welcome to software development.  It's generally a pretty terrible
> hobby and/or occupation, but we make up for it with long hours and
> endless frustration.

Tell me more about that, not! ;-)

> > > > u64 vs u128 is easy for us to
> > > > accomodate in terms of scalar comparisons.  It doubles the information
> > > > in every container id field we print in audit records.
> > > 
> > > ... and slows down audit container ID checks.
> > 
> > Are you saying a cmp on a u128 is slower than a comparison on a u64 and
> > this is something that will be noticeable ?
> 
> Do you have a 128 bit system?

no, but all 64bit systems have an instruction that allow you to do
atomic 128 compare and swap (IIRC ?).

>   I don't.  I've got a bunch of 64 bit
> systems, and a couple of 32 bit systems too.  People that use audit
> have a tendency to really hammer on it, to the point that we get
> performance complaints on a not infrequent basis.  I don't know the
> exact number of times we are going to need to check the audit
> container ID, but it's reasonable to think that we'll expose it as a
> filter-able field which adds a few checks, we'll use it for record
> routing so that's a few more, and if we're running multiple audit
> daemons we will probably want to include LSM checks which could result
> in a few more audit container ID checks.  If it was one comparison I
> wouldn't be too worried about it, but the point I'm trying to make is
> that we don't know what the implementation is going to look like yet
> and I suspect this ID is going to be leveraged in several places in
> the audit subsystem and I would much rather start small to save
> headaches later.
> 
> We can always expand the ID to a larger integer at a later date, but
> we can't make it smaller.

Well looking through the history of in kernel identifiers I know it is
hard also to increase size, because userspace will end up depending on
a specific size ... and this is the only reason I am really debating
this. If it were really easy to change I wouldn't bother to do it now.

> > > > A c36 is a bigger step.
> > > 
> > > Yeah, we're not doing that, no way.
> > 
> > Ok, I can see your point though I do not agree with it.
> > 
> > I can see why you do not want to have arbitrary length strings, but a
> > u128 sounded like a reasonable compromise to me as it has enough room
> > to be able to have unique cluster-wide IDs which a u64 definitely makes
> > a lot harder to provide w/o tight coordination.
> 
> I originally wanted it to be a 32-bit integer, but Richard managed to
> talk me into 64-bits, that was my compromise :)
> 
> As I said earlier, if you are doing container auditing you're going to
> need coordination with the orchestrator, regardless of the audit
> container ID size.

Ok, I guess that's as good as I can get it for now, thank you for your
patient explanations.

Simo.

-- 
Simo Sorce
Sr. Principal Software Engineer
Red Hat, Inc

