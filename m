Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B15EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2160720846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="bk6dGD0w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sbzrDRru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2160720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeGZCdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:33:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56675 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728411AbeGZCdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:33:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0016021BBC;
        Wed, 25 Jul 2018 21:18:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Jul 2018 21:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=ns9WZq2Pwf6QWlbkI8hRjKL8yUdeD
        T17V6+CCte/utM=; b=bk6dGD0wj/q0r2EhTakN/m8lWx6w6OOF1zRVHvt0Nv31R
        GRJOcfbN9qVMmUqLluG/jGTFdBT8rKBptSn0+CGrb/cuYw3kX2qN//f8P+NFFZpW
        IG/OEr64tCr4u/gXgXykotjNB+kxz6EQ6UhWiEaXjLqck2yKWDEBwuFWELrK2fSO
        GST4r0/QF4D8nFavdBgtIIlK3rUhF8eLHgowLuDJF/exEhnej7Ypzf3CeBEf7PR5
        w3G5tCjApfjbXwzNoRZzFILv7qEKb/gG8zj8FryUPOOnTusy8yh9/VPzNaoiu3KB
        3p9SYkh6T1Or+ZkVH5RMH99RucjJpYm1Jep+TnM7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ns9WZq
        2Pwf6QWlbkI8hRjKL8yUdeDT17V6+CCte/utM=; b=sbzrDRruJp1dtP9V8pRv9M
        ve9bdz8PNR1qzxUGGH073LQs7LSqV3IdLJi59t8auApboq/BaV5gpljhBx9LKWZ6
        LOs6MSAcBg6eBj0u2yS9Kb+Y8DM5z4Avmq0PbYMrjiBN32DxkflTHSgkEfWSx31j
        iiJ9eJ5cu+nErKqNME+9Gm8raN9SqalfYMqLIt7bSMz/w5G3/I/DWDodVhx3g4Nz
        xxp9eiin0EPdoOjbAyglOln3bb5qhQ2aHG9bhK6HsOOK1k/MzsKdEMyek/i1qwNn
        Z3S9B6f0D9khoJK1UfDKWEPvAyB2zVFimDSQyFhHmYAiTEaQcL7yl/jk2Q0ZECTQ
        ==
X-ME-Proxy: <xmx:byFZWx6C14nJkTIDWUWgDSH9ZKgMTk45LAE9svBsJbf-y_p-ASikZg>
    <xmx:byFZW4iSMw0o2cJtxXx5RllUXAyhTLEChI4ExKd98Hbh4eO-emPPfg>
    <xmx:byFZW1Jnv4kwGyA42z_CBN5QBOB4FikjFC7lLvraCni7QRv2KuSUxA>
    <xmx:byFZW7ppGzxGNDJdEyWen--Mq7_rQcFVQePGpoqXzK7RQWXI3WF-3w>
    <xmx:byFZW7ijJ35mAwU9nMyEDO7mPMMUd7XGGupCtuyN50CiGvcN0M_FAg>
    <xmx:byFZW-4qZ5tN9A02VfHYkFF3D3DsnF9LkTqEs_CDfISQTa6f-tkM3w>
X-ME-Sender: <xms:byFZW5AjKsk22Q8hKmHe2FIvDd4qYvVjodXP_VMSjYZNNbIZ1sHXlw>
Received: from localhost (unknown [118.209.42.46])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEE4610261;
        Wed, 25 Jul 2018 21:18:36 -0400 (EDT)
Message-ID: <1532567914.2939.23.camel@themaw.net>
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
From:   Ian Kent <raven@themaw.net>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 26 Jul 2018 09:18:34 +0800
In-Reply-To: <55bb8ed3-59b4-ca6e-5741-a7d5e4489a7c@schaufler-ca.com>
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
         <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
         <23894.1532448035@warthog.procyon.org.uk>
         <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
         <1532497196.2688.65.camel@themaw.net>
         <55bb8ed3-59b4-ca6e-5741-a7d5e4489a7c@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 08:48 -0700, Casey Schaufler wrote:
> On 7/24/2018 10:39 PM, Ian Kent wrote:
> > On Tue, 2018-07-24 at 11:57 -0700, Casey Schaufler wrote:
> > > On 7/24/2018 9:00 AM, David Howells wrote:
> > > > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > 
> > > > > >  (1) Mount topology and reconfiguration change events.
> > > > > 
> > > > > With the possibility of unprivileged mounting you're going to have to
> > > > > address access control on events.  If root in a user namespace mounts
> > > > > a
> > > > > filesystem you may have a case where the "real" user wouldn't want the
> > > > > listener to receive a notification.
> > > > 
> > > > Can you clarify who the listener is in this case?
> > > 
> > > That would be anyone with a watchpoint set.
> > 
> > And that process would have had the privilege to do so ...
> 
> Which isn't the point. The access control isn't on the watchpoint,
> it's on delivering the event to the watchpoint. The access control
> needs to be based on the process that created the event and the
> process receiving the event.
> 
> > 
> > > > Note that mount topology events don't leak outside of the mount
> > > > namespace
> > > > they're generated in.
> > > > 
> > > > That said, if you, a random user, put a watchpoint on "/" you can see
> > > > the
> > > > mount events triggered by another random user in the same mount
> > > > namespace.  I
> > > > don't see a way to control this except by resorting to the LSM since
> > > > UNIX
> > > > doesn't have 'notify' permission bits.
> > > 
> > > I would call that a write operation from the process that triggered
> > > the watchpoint to the one watching it. Like a signal. Signals have a
> > > rudimentary DAC policy (write only to the same UID) that could be
> > > your model.
> > 
> > I'm not sure signals are a good comparison.
> 
> In both cases you have one process sending information
> to another. If you use killpg() instead of kill() you can
> send to a number of processes without knowing them individually.
> A process can chose what to do with (most) signals, including
> ignore them.

I'm just saying that the analogy isn't quite the same.

In the this case notifications can't be just sent by a process,
it's entirely controlled by the VFS so the notion of some process
doing something out-off-band doesn't apply.

> 
> > They can affect a process in significant ways whereas triggering
> > a notification is less invasive so the security requirements
> > should take that into consideration.
> 
> I'm looking at this from a security model viewpoint. If process
> A sends information to process B that's a write operation with
> A as the subject and B as the object. 

Perhaps, but again there's no process A deciding to send something.

It's the VFS saying to itself, I see this thing has changed, someone
that had appropriate privilege asked me to tell it so ...

I may be wrong but there isn't a similar access control mechanism
on the proc file system mount table (pseudo) files, only the usual
access control on opening them and what is seen is based on the
mount name space of the opening process.

This is also not quite as what we have here but it is similar.

> 
> > But there is a problem here I think.
> > 
> > How about the case where a user name space is created or entered
> > without a newly created mount name space and mounts and umounts
> > are done, the user name space necessarily expects the table of
> > mounts it sees to be up to date.
> > 
> > But, if the methods here are used by user space, say libmount
> > was updated to use it, to gain the efficiency of not constantly
> > re-reading the proc mount table then restrictions on notifications
> > would mean the mount table seen in the user name space might not
> > be updated and would no longer be correct.
> 
> Hey, I'm not the one saying that containers don't need/want kernel
> manifestation. Of course you may have troubles with access consistency
> if you go around changing the access control attributes with namespaces.
> One of the problems with signals is that you can't chmod() your process
> to allow signals from other specified users. If you don't design an
> access control scheme into the watchpoint mechanism you aren't going to
> be able to deal with situations like this.

Don't get me wrong, I'm not criticizing your suggestion that
some sort of security model is needed.

I'm saying it's not straight forward to work out what's actually
needed and, in thinking about it, I ended up described an additional
potential problem that's not even (necessarily) security related.

> 
> > The converse is more interesting, where the user name space does
> > create or enter a new mount name space, then libmount would see ???,
> > probably not the updated mount information ... unless it opens a
> > new file handle to get mount update information ... a long running
> > daemon that uses libmount and dispenses or uses mount information
> > would very likely have a problem ...
> > 
> > The current proc file system method or providing the mount table
> > forces a new file handle to be opened whenever getting the mount
> > table so it always sees only the current mount name space mount
> > table.
> > 
> > At the very least I need to think more about this ...
> > 
> > > > But for each event, I can associate an object label, derived from the
> > > > source,
> > > > and use f_cred on the notification queue to provide a subject label.
> > > 
> > > ... or UID or groups.
> > > 
> > > > > >  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
> > > > > 
> > > > > Here, too. If SELinux (for example) policy says you can't see
> > > > > anything on a filesystem you shouldn't get notifications about
> > > > > things that happen to that filesystem.
> > > > 
> > > > Yep.  Sounds like I need to refer that to the LSM as above.
> > > > 
> > > > It's a bit easier for specifically nominated sb sources since you might
> > > > only
> > > > need to do the check once at sb_notify() time.  If there's a general
> > > > queue
> > > > that all sbs contribute to, however, then things become more complicated
> > > > as
> > > > the checks have to be done at do-we-write-into-this-queue? time.
> > > > 
> > > > > >  (3) Key/keyring changes events
> > > > > 
> > > > > And again, I should only get notifications about keys and
> > > > > keyrings I have access to.
> > > > 
> > > > Currently, you can only watch keys that grant you View permission, which
> > > > might
> > > > suffice.
> > > 
> > > That seems appropriate.
> > > 
> > > > > I expect that you intentionally left off
> > > > > 
> > > > >    (4) User injected events
> > > > > 
> > > > > at this point, but it's an obvious extension. That is going
> > > > > to require access controls (remember kdbus) so I think you'd
> > > > > do well to design them in now rather than have some security
> > > > > module hack like me come along later and "fix" it. 
> > > > 
> > > > Yeah - the thought had occurred to me, but there needs to be some way to
> > > > define a 'source' and a way to connect them.  Also, would you want a
> > > > general
> > > > source that anyone can contribute through, specific sources where you
> > > > have
> > > > to
> > > > directly connect or namespace-restricted sources?
> > > 
> > > My guess is that the consensus would be "Yes" to all the above.
> > > 
> > > > David
> > > > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-
> > module" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
