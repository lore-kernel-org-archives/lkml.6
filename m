Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3551165-1517609964-2-3209715902771320264
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
    t=1517609962; b=BHqYK4UwDh24FHgfYZaMM5wtOjIcHYgguOKk8AsWuriei9h
    SoSt4yCysro5X+fLhqMB9hRNI3UbX1DnRGtjALOs4rObZW7liaODY+AJMmq/BBkz
    xMv9l2KsDutGrWGNu2q+R+leFB770xJ9Ju/qaG5rLhWRGB7Z70/m5vA0YTL3OFtR
    vC6qMhLrPsLyGvVZMeKjhuvHCli8RyCw6LYcpxkrKV9apiyJasQ8Cj5Kg7iAbTRo
    KNGYlQNTGJA+z/m4NgwSjhu2QzpGZiMowqvjlk2fRcOOT442MSGVK8DfTUQSx6Mk
    cpw0jLIrSnxXOGokcWgJg6kq+JoNM6DpxX3G5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517609962; bh=MbPeo+lNlisUHUrGlPMF3waSNm4f8SEy8r5+tjSJKJo=; b=T
    HsXkZ59EGWRJ3Qau4bPOd6pNHE8URG5Vz7j9D0a4p+sIq0MUZ5HakbuKnQ6EAZEp
    awxzLfXhpTQnYnloQ18/RGHYfi7IReDGp1PWCadd6WyAQLFt4W96IlGMPwIWH63p
    IQKe8Fg66SFqe/mJJiLYzh6h7avbiLo/6Kx3ocuuR1dE8q1H6sU2F3GMqH2m02+E
    rUh2ssb1D2iRu9ELlPljHgqa2g3TFhdzR4nfqNq2eIsZOxVIbLAWzmuHl57e8bbJ
    Nlypl/yoxLd6HgiofT6R4pW5ImVs/DzrVQHFbBVdL4+WUNJ3wQPSX0IMCiUDmz3a
    Bg1oNBLT5dxvsFVKwAqZg==
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
        id S1752853AbeBBWTU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 17:19:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeBBWTT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 2 Feb 2018 17:19:19 -0500
Message-ID: <1517609946.13097.161.camel@redhat.com>
Subject: Re: RFC(V3): Audit Kernel Container IDs
From: Simo Sorce <simo@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: David Howells <dhowells@redhat.com>, cgroups@vger.kernel.org,
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
Date: Fri, 02 Feb 2018 17:19:06 -0500
In-Reply-To: <CAHC9VhQ=hX55e7ftkVQCogTZTcdSm3rm-+YNOgWomabbXV_sKg@mail.gmail.com>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
         <1515514736.3239.10.camel@redhat.com>
         <20180110070011.l4rcdcwb27witfem@madcap2.tricolour.ca>
         <CAHC9VhQ=hX55e7ftkVQCogTZTcdSm3rm-+YNOgWomabbXV_sKg@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 16:24 -0500, Paul Moore wrote:
> On Wed, Jan 10, 2018 at 2:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-01-09 11:18, Simo Sorce wrote:
> > > On Tue, 2018-01-09 at 07:16 -0500, Richard Guy Briggs wrote:
> > > > Containers are a userspace concept.  The kernel knows nothing of them.
> > > > 
> > > > The Linux audit system needs a way to be able to track the container
> > > > provenance of events and actions.  Audit needs the kernel's help to do
> > > > this.
> > > > 
> > > > Since the concept of a container is entirely a userspace concept, a
> > > > registration from the userspace container orchestration system initiates
> > > > this.  This will define a point in time and a set of resources
> > > > associated with a particular container with an audit container
> > > > identifier.
> > > > 
> > > > The registration is a u64 representing the audit container identifier
> > > > written to a special file in a pseudo filesystem (proc, since PID tree
> > > > already exists) representing a process that will become a parent process
> > > > in that container.  This write might place restrictions on mount
> > > > namespaces required to define a container, or at least careful checking
> > > > of namespaces in the kernel to verify permissions of the orchestrator so
> > > > it can't change its own container ID.  A bind mount of nsfs may be
> > > > necessary in the container orchestrator's mount namespace.  This write
> > > > can only happen once per process.
> > > > 
> > > > Note: The justification for using a u64 is that it minimizes the
> > > > information printed in every audit record, reducing bandwidth and limits
> > > > comparisons to a single u64 which will be faster and less error-prone.
> > > > 
> > > > Require CAP_AUDIT_CONTROL to be able to carry out the registration.  At
> > > > that time, record the target container's user-supplied audit container
> > > > identifier along with a target container's parent process (which may
> > > > become the target container's "init" process) process ID (referenced
> > > > from the initial PID namespace) in a new record AUDIT_CONTAINER with a
> > > > qualifying op=$action field.
> > > > 
> > > > Issue a new auxilliary record AUDIT_CONTAINER_INFO for each valid
> > > > container ID present on an auditable action or event.
> > > > 
> > > > Forked and cloned processes inherit their parent's audit container
> > > > identifier, referenced in the process' task_struct.  Since the audit
> > > > container identifier is inherited rather than written, it can still be
> > > > written once.  This will prevent tampering while allowing nesting.
> > > > (This can be implemented with an internal settable flag upon
> > > > registration that does not get copied across a fork/clone.)
> > > > 
> > > > Mimic setns(2) and return an error if the process has already initiated
> > > > threading or forked since this registration should happen before the
> > > > process execution is started by the orchestrator and hence should not
> > > > yet have any threads or children.  If this is deemed overly restrictive,
> > > > switch all of the target's threads and children to the new containerID.
> > > > 
> > > > Trust the orchestrator to judiciously use and restrict CAP_AUDIT_CONTROL.
> > > > 
> > > > When a container ceases to exist because the last process in that
> > > > container has exited log the fact to balance the registration action.
> > > > (This is likely needed for certification accountability.)
> > > > 
> > > > At this point it appears unnecessary to add a container session
> > > > identifier since this is all tracked from loginuid and sessionid to
> > > > communicate with the container orchestrator to spawn an additional
> > > > session into an existing container which would be logged.  It can be
> > > > added at a later date without breaking API should it be deemed
> > > > necessary.
> > > > 
> > > > The following namespace logging actions are not needed for certification
> > > > purposes at this point, but are helpful for tracking namespace activity.
> > > > These are auxilliary records that are associated with namespace
> > > > manipulation syscalls unshare(2), clone(2) and setns(2), so the records
> > > > will only show up if explicit syscall rules have been added to document
> > > > this activity.
> > > > 
> > > > Log the creation of every namespace, inheriting/adding its spawning
> > > > process' audit container identifier(s), if applicable.  Include the
> > > > spawning and spawned namespace IDs (device and inode number tuples).
> > > > [AUDIT_NS_CREATE, AUDIT_NS_DESTROY] [clone(2), unshare(2), setns(2)]
> > > > Note: At this point it appears only network namespaces may need to track
> > > > container IDs apart from processes since incoming packets may cause an
> > > > auditable event before being associated with a process.  Since a
> > > > namespace can be shared by processes in different containers, the
> > > > namespace will need to track all containers to which it has been
> > > > assigned.
> > > > 
> > > > Upon registration, the target process' namespace IDs (in the form of a
> > > > nsfs device number and inode number tuple) will be recorded in an
> > > > AUDIT_NS_INFO auxilliary record.
> > > > 
> > > > Log the destruction of every namespace that is no longer used by any
> > > > process, including the namespace IDs (device and inode number tuples).
> > > > [AUDIT_NS_DESTROY] [process exit, unshare(2), setns(2)]
> > > > 
> > > > Issue a new auxilliary record AUDIT_NS_CHANGE listing (opt: op=$action)
> > > > the parent and child namespace IDs for any changes to a process'
> > > > namespaces. [setns(2)]
> > > > Note: It may be possible to combine AUDIT_NS_* record formats and
> > > > distinguish them with an op=$action field depending on the fields
> > > > required for each message type.
> > > > 
> > > > The audit container identifier will need to be reaped from all
> > > > implicated namespaces upon the destruction of a container.
> > > > 
> > > > This namespace information adds supporting information for tracking
> > > > events not attributable to specific processes.
> > > > 
> > > > Changelog:
> > > > 
> > > > (Upstream V3)
> > > > - switch back to u64 (from pmoore, can be expanded to u128 in future if
> > > >   need arises without breaking API.  u32 was originally proposed, up to
> > > >   c36 discussed)
> > > > - write-once, but children inherit audit container identifier and can
> > > >   then still be written once
> > > > - switch to CAP_AUDIT_CONTROL
> > > > - group namespace actions together, auxilliary records to namespace
> > > >   operations.
> > > > 
> > > > (Upstream V2)
> > > > - switch from u64 to u128 UUID
> > > > - switch from "signal" and "trigger" to "register"
> > > > - restrict registration to single process or force all threads and
> > > >   children into same container
> > > 
> > > I am trying to understand the back and forth on the ID size.
> > > 
> > > From an orchestrator POV anything that requires tracking a node
> > > specific ID is not ideal.
> > > 
> > > Orchestrators tend to span many nodes, and containers tend to have IDs
> > > that are either UUID or have a Hash (like SHA256) as identifier.
> > > 
> > > The problem here is two-fold:
> > > 
> > > a) Your auditing requires some mapping to be useful outside of the
> > > system.
> > > If you aggreggate audit logs outside of the system or you want to
> > > correlate the system audit logs with other components dealing with
> > > containers, now you need a place where you provide a mapping from your
> > > audit u64 to the ID a container has in the rest of the system.
> > > 
> > > b) Now you need a mapping of some sort. The simplest way a container
> > > orchestrator can go about this is to just use the UUID or Hash
> > > representing their view of the container, truncate it to a u64 and use
> > > that for Audit. This means there are some chances there will be a
> > > collision and a duplicate u64 ID will be used by the orchestrator as
> > > the container ID. What happen in that case ?
> > 
> > Paul, can you justify this somewhat larger inconvenience for some
> > relatively minor convenience on our part?
> 
> Done in direct response to Simo.

Sorry but your response sounds more like waving away then addressing
them, the excuse being: we can't please everyone, so we are going to
please no one.

> But to be clear Richard, we've talked about this a few times, it's not
> a "minor convenience" on our part, it's a pretty big convenience once
> we starting having to route audit events and make decisions based on
> the audit container ID information.  Audit performance is less than
> awesome now, I'm working hard to not make it worse.

Sounds like a security vs performance trade off to me.

> > u64 vs u128 is easy for us to
> > accomodate in terms of scalar comparisons.  It doubles the information
> > in every container id field we print in audit records.
> 
> ... and slows down audit container ID checks.

Are you saying a cmp on a u128 is slower than a comparison on a u64 and
this is something that will be noticeable ?

> > A c36 is a bigger step.
> 
> Yeah, we're not doing that, no way.

Ok, I can see your point though I do not agree with it.

I can see why you do not want to have arbitrary length strings, but a
u128 sounded like a reasonable compromise to me as it has enough room
to be able to have unique cluster-wide IDs which a u64 definitely makes
a lot harder to provide w/o tight coordination.

Simo.

-- 
Simo Sorce
Sr. Principal Software Engineer
Red Hat, Inc

