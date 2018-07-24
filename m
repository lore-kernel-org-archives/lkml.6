Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD47C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824BB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hgqXkaeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824BB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbeGXXCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:02:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44607 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbeGXXCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:02:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so4010335lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V3daoH7M3DEI/0B0n4Tg6yHU7g58X2Y9N61ZlLxshmA=;
        b=hgqXkaeEVuv4lkgv44qa39/acUowGt0GLtgkje8xEY9HsnOS9vgPcmiIXVuRuKcirD
         sATmYYVCID1OlvQIAFDsu7WCrfjHN2gGUekUmxHuFsFAIKcR0oGZEkBKjwf463MKbETn
         RSIFojBioVnVavHCXGwhG53F6BkwXAoR6b/effkCkdPKfbANr52sb7mUKsusxxhDgCMQ
         v75m7Pa5/zMABU95KJ2YmiabqtX7xk1E1b3KCgYoanhPbYHEneqVIBSYYohMizY/oNyz
         nwQWbiuwiv6xlBd1Zct8MOfpROYMyFuExidXPlU6lFns5WObIXYK1k+xDs0bZvtvXYE4
         SaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V3daoH7M3DEI/0B0n4Tg6yHU7g58X2Y9N61ZlLxshmA=;
        b=VQM0J25bBdQcepHk70FQS6Ph1HviLjY9qC2pohVms+yiZbI+Z4J0j92YprFJlSOlsT
         xN2K0GygxEw/Nyl+NEAvznSqkFVeDqKfoeB3CNXdhV60Xch8JlctRzLFjpbOO6OUwKV2
         5Gst4ppj9wAqCRgWV2zE9vhfWBids1JRYsWIn3d/hHp5gua562vzvyF7e2PLr8eYmW1U
         20rAVlpDKo3PnIiku+W5Iq9gGzO2FzqSQb51bDf7wjWmxRpMqPJTSUTcfpQ9REIqaU/c
         3AcB7tpziyFCJpmLrb3Kan4WXLpb9DXVulLSNCOOuL5EKf53l21L8j1zP673DUinF7E3
         S7Dg==
X-Gm-Message-State: AOUpUlHJegssgoLAXxnJ6cP/Ca6jPhZHoPt18gYHOuc/+MBDkZnmJsrg
        s5PfKdPnOi5oe9I00lX7xnnl6Mk3bjxQdpE7bDl4
X-Google-Smtp-Source: AAOMgpckIFKek5U28fwAEukTIR2klpBBolfHuSo2+3baypRgf7Wj3DihYSaxhDQBdJ4toJMDjo00qaTTGYCR6ImULt0=
X-Received: by 2002:a19:dd5c:: with SMTP id u89-v6mr10798023lfg.83.1532469255762;
 Tue, 24 Jul 2018 14:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <0377c3ced6bdbc44fe17f9a5679cb6eda4304024.1528304203.git.rgb@redhat.com>
 <CAHC9VhRk+qLAyizM9i8D+cjKxyhruuj_Z9N0QRmjM-fjm4hgRw@mail.gmail.com> <20180724190613.ww6yhsqpa7n4s62k@madcap2.tricolour.ca>
In-Reply-To: <20180724190613.ww6yhsqpa7n4s62k@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 17:54:04 -0400
Message-ID: <CAHC9VhQ3KwG-YmpJsOa9k=YqQmaQTaJXeB=eM9Fm80hujbngBg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 01/10] audit: add container id
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 3:09 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-20 18:13, Paul Moore wrote:
> > On Wed, Jun 6, 2018 at 1:00 PM Richard Guy Briggs <rgb@redhat.com> wrot=
e:
> > > Implement the proc fs write to set the audit container identifier of =
a
> > > process, emitting an AUDIT_CONTAINER_ID record to document the event.
> > >
> > > This is a write from the container orchestrator task to a proc entry =
of
> > > the form /proc/PID/audit_containerid where PID is the process ID of t=
he
> > > newly created task that is to become the first task in a container, o=
r
> > > an additional task added to a container.
> > >
> > > The write expects up to a u64 value (unset: 18446744073709551615).
> > >
> > > The writer must have capability CAP_AUDIT_CONTROL.
> > >
> > > This will produce a record such as this:
> > >   type=3DCONTAINER_ID msg=3Daudit(2018-06-06 12:39:29.636:26949) : op=
=3Dset opid=3D2209 old-contid=3D18446744073709551615 contid=3D123456 pid=3D=
628 auid=3Droot uid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfin=
ed_r:unconfined_t:s0-s0:c0.c1023 comm=3Dbash exe=3D/usr/bin/bash res=3Dyes
> > >
> > > The "op" field indicates an initial set.  The "pid" to "ses" fields a=
re
> > > the orchestrator while the "opid" field is the object's PID, the proc=
ess
> > > being "contained".  Old and new audit container identifier values are
> > > given in the "contid" fields, while res indicates its success.
> > >
> > > It is not permitted to unset or re-set the audit container identifier=
.
> > > A child inherits its parent's audit container identifier, but then ca=
n
> > > be set only once after.
> > >
> > > See: https://github.com/linux-audit/audit-kernel/issues/90
> > > See: https://github.com/linux-audit/audit-userspace/issues/51
> > > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > > See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Conta=
iner-ID
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  fs/proc/base.c             | 37 ++++++++++++++++++++++++
> > >  include/linux/audit.h      | 25 ++++++++++++++++
> > >  include/uapi/linux/audit.h |  2 ++
> > >  kernel/auditsc.c           | 71 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 135 insertions(+)

...

> > > @@ -2112,6 +2116,73 @@ int audit_set_loginuid(kuid_t loginuid)
> > >  }
> > >
> > >  /**
> > > + * audit_set_contid - set current task's audit_context contid
> > > + * @contid: contid value
> > > + *
> > > + * Returns 0 on success, -EPERM on permission failure.
> > > + *
> > > + * Called (set) from fs/proc/base.c::proc_contid_write().
> > > + */
> > > +int audit_set_contid(struct task_struct *task, u64 contid)
> > > +{
> > > +       u64 oldcontid;
> > > +       int rc =3D 0;
> > > +       struct audit_buffer *ab;
> > > +       uid_t uid;
> > > +       struct tty_struct *tty;
> > > +       char comm[sizeof(current->comm)];
> > > +
> > > +       /* Can't set if audit disabled */
> > > +       if (!task->audit)
> > > +               return -ENOPROTOOPT;
> > > +       oldcontid =3D audit_get_contid(task);
> > > +       /* Don't allow the audit containerid to be unset */
> > > +       if (!cid_valid(contid))
> > > +               rc =3D -EINVAL;
> > > +       /* if we don't have caps, reject */
> > > +       else if (!capable(CAP_AUDIT_CONTROL))
> > > +               rc =3D -EPERM;
> > > +       /* if task has children or is not single-threaded, deny */
> > > +       else if (!list_empty(&task->children))
> > > +               rc =3D -EBUSY;
> >
> > Is this safe without holding tasklist_lock?  I worry we might be
> > vulnerable to a race with fork().
> >
> > > +       else if (!(thread_group_leader(task) && thread_group_empty(ta=
sk)))
> > > +               rc =3D -EALREADY;
> >
> > Similar concern here as well, although related to threads.
>
> I think you are correct here and tasklist_lock should cover both.  Do we
> also want rcu_read_lock() immediately preceeding it?

You'll need to take a closer look and determine the locking scheme. I
simply took a quick look while reviewing this patch to see what of the
existing locks, if any, would be most applicable here; tasklist_lock
seemed like a good starting point.

It looks like tasklist_lock is defined as a rwlock_t so I'm not sure
it would make sense to use it with a RCU protected structure
(typically it's RCU+spinlock), but maybe that is the case with a
task_struct, you'll need to check.

> > > +       /* it is already set, and not inherited from the parent, reje=
ct */
> > > +       else if (cid_valid(oldcontid) && !task->audit->inherited)
> > > +               rc =3D -EEXIST;
> >
> > Maybe I'm missing something, but why do we care about preventing
> > reassigning the audit container ID in this case?  The task is single
> > threaded and has no descendants at this point so it should be safe,
> > yes?  So long as the task changing the audit container ID has
> > capable(CAP_AUDIT_CONTOL) it shouldn't matter, right?
>
> Because we hammered out this idea 6 months ago in the design phase and I
> thought we all firmly agreed that the audit container identifier could
> only be set once.  Has any significant discussion happenned since then
> to change that wisdom?  I just wonder why this is coming up now.

Implementation, and time, can change how one looks at an earlier
design.  I believe this is why most well reasoned specifications have
a reference design.

Remind me why the design had the restriction of write once for the
audit container ID?  At this point given the CAP_AUDIT_CONTROL and the
single-thread, no-children restrictions I'm not sure what harm there
is in allowing the value to be written multiple times (so long as the
changes are audited of course).

> > Related, I'm questioning if we would ever care if the audit container
> > ID was inherited or not?
>
> We do since that is the only way we can tell if the value has been set
> once already or inherited unless we check if the parent's audit
> container identifier is identical (which tells us it was inherited).

Tied to the above question.  If we don't care about multiple changes,
given the other constraints, we probably don't need the inherited
flag.

--=20
paul moore
www.paul-moore.com
