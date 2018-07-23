Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44611ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E095220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="g448z9Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E095220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeGWORy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:17:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44802 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbeGWORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:17:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so506066ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o2SsxW88pOHsRsleaQPlTTBgQ2OXBJ2JH6i/3a87KTY=;
        b=g448z9EcT84iag84a5Fq/RVrJeyhDZVti//cS8wLSefHONZuRcbvhs5qA1usc/1OjI
         Hn1Cj8OJtCmQWJR3jz8W19URlUE87ec+efYX7BdrZAyC0kyFkIA5JdiJAiv3IgucpInP
         XNeJq/QejeyuzF5LaE91z1SUZ2LHpmByF6lyhMmSN+/MD6rPw2ETQx/O9PYUCc7zS0vX
         mrVX3aOFgTxAH57UxXXG851wG6KK4v1pmcrgrP/vt8+RxsCzhAmnkaeVx2ksanm6lPXG
         dzIznkVPejch99Py7Rri3n/SczdcUfK3L4iVZvWPBqgHXvQDlaRHQ2Sc+w6S7BqaItAk
         fgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o2SsxW88pOHsRsleaQPlTTBgQ2OXBJ2JH6i/3a87KTY=;
        b=LT7Vd7M4mT0OF7+g92omVyInDlPxnOjOfZ0eSVjli01H6Iq8WH0bx9a7yuDZNDpsCz
         L3L/fDnTRAg7vg8wti2m8NwRc1PRpvqJwJmRhLFtdsh5vdNHc0pepf6BnYqYmakhuQ6k
         Lw5oMCIdZudvdHx1a106y9e/nlcw+wzPrWvLJDOcypZe5I7lnDSSSqaz7/4yVkk3Nn5W
         uAF+xhB5rHOyddjFV+X1z98AuhTKDosxv8kJVeZ9DGDdd8s3ulPwFJk5N4RntW1lokQd
         /IF1Frf655DTRVzT+7He2Qu8lsdxr1bxr1NJkvk11Yq680FXx8tNq7ey3TF1mfgOrbRs
         T1hw==
X-Gm-Message-State: AOUpUlEQLJd2O0nqEgESzpgJ9oRkVyIEI4zfBUgT4SMZQ6LQsUOmyRlf
        Q5aaFHUiUS/TU8X3ontmGgTQeLbgMWunCLY+fnEN
X-Google-Smtp-Source: AAOMgpfE9hCdfacv0ibJlchqzx4/6+Rg3CLYreyrGo6fBRQcGANKN9xh67y7GNh/oKsPQhYm279C0htnNPdFQEQt10E=
X-Received: by 2002:a2e:5f5b:: with SMTP id t88-v6mr9392188ljb.140.1532351797094;
 Mon, 23 Jul 2018 06:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <b839dc7fb29aae226b2a4602e7ef3c2a406ee90a.1528304203.git.rgb@redhat.com>
 <CAHC9VhS0-4XSEFFPLrOvAiSYv-XDLG-yGyB4ULRGz=AnwE6diQ@mail.gmail.com> <20180721202930.a7rypxc5rxi3hyiv@madcap2.tricolour.ca>
In-Reply-To: <20180721202930.a7rypxc5rxi3hyiv@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jul 2018 09:16:25 -0400
Message-ID: <CAHC9VhSUhSDaXzD9fpxm-oK=U4MieekKwY-pypzT=RA1HBw6+Q@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 02/10] audit: log container
 info of syscalls
To:     rgb@redhat.com
Cc:     sgrubb@redhat.com, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 4:32 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-20 18:13, Paul Moore wrote:
> > On Wed, Jun 6, 2018 at 1:00 PM Richard Guy Briggs <rgb@redhat.com> wrot=
e:
> > > Create a new audit record AUDIT_CONTAINER to document the audit
> > > container identifier of a process if it is present.
> > >
> > > Called from audit_log_exit(), syscalls are covered.
> > >
> > > A sample raw event:
> > > type=3DSYSCALL msg=3Daudit(1519924845.499:257): arch=3Dc000003e sysca=
ll=3D257 success=3Dyes exit=3D3 a0=3Dffffff9c a1=3D56374e1cef30 a2=3D241 a3=
=3D1b6 items=3D2 ppid=3D606 pid=3D635 auid=3D0 uid=3D0 gid=3D0 euid=3D0 sui=
d=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D3 comm=3D"bash=
" exe=3D"/usr/bin/bash" subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0=
:c0.c1023 key=3D"tmpcontainerid"
> > > type=3DCWD msg=3Daudit(1519924845.499:257): cwd=3D"/root"
> > > type=3DPATH msg=3Daudit(1519924845.499:257): item=3D0 name=3D"/tmp/" =
inode=3D13863 dev=3D00:27 mode=3D041777 ouid=3D0 ogid=3D0 rdev=3D00:00 obj=
=3Dsystem_u:object_r:tmp_t:s0 nametype=3D PARENT cap_fp=3D0000000000000000 =
cap_fi=3D0000000000000000 cap_fe=3D0 cap_fver=3D0
> > > type=3DPATH msg=3Daudit(1519924845.499:257): item=3D1 name=3D"/tmp/tm=
pcontainerid" inode=3D17729 dev=3D00:27 mode=3D0100644 ouid=3D0 ogid=3D0 rd=
ev=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DCREATE cap_=
fp=3D0000000000000000 cap_fi=3D0000000000000000 cap_fe=3D0 cap_fver=3D0
> > > type=3DPROCTITLE msg=3Daudit(1519924845.499:257): proctitle=3D6261736=
8002D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E74=
61696E65726964
> > > type=3DCONTAINER msg=3Daudit(1519924845.499:257): op=3Dtask contid=3D=
123458
> > >
> > > See: https://github.com/linux-audit/audit-kernel/issues/90
> > > See: https://github.com/linux-audit/audit-userspace/issues/51
> > > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > > See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Conta=
iner-ID
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  include/linux/audit.h      |  7 +++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.c             | 23 +++++++++++++++++++++++
> > >  kernel/auditsc.c           |  3 +++
> > >  4 files changed, 34 insertions(+)
> >
> > ...
> >
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -115,6 +115,7 @@
> > >  #define AUDIT_REPLACE          1329    /* Replace auditd if this pac=
ket unanswerd */
> > >  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
> > >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision *=
/
> > > +#define AUDIT_CONTAINER                1332    /* Container ID */
> >
> > I'm not sure I'm completely sold on the AUDIT_CONTAINER_ID and
> > AUDIT_CONTAINER record type names.  From what I can tell
> > AUDIT_CONTAINER_ID seems to be used for audit container ID management
> > operations, e.g. setting the ID, whereas the AUDIT_CONTAINER is used
> > to tag events with the corresponding audit container ID.  Assuming
> > that is correct, it seems like AUDIT_CONTAINER might be better served
> > if it was named AUDIT_CONTAINER_ID and if we could change
> > AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP/MGMT/etc.  Thoughts?
>
> Please see discussion at:
>         https://www.redhat.com/archives/linux-audit/2018-May/msg00101.htm=
l
>
> I'm fine with changing AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP/MGMT/etc.

Noted, and while I'm generally a big fan of consistency for things
like this, I think these things are different enough (the loginuid is
recorded as a field, the audit container ID is recorded in a dedicated
record) that we don't need to be bound by LOGINUID's naming
convention.

> > >  #define AUDIT_AVC              1400    /* SE Linux avc denial or gra=
nt */
> > >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors *=
/
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index e7478cb..5e150c6 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -2048,6 +2048,29 @@ void audit_log_session_info(struct audit_buffe=
r *ab)
> > >         audit_log_format(ab, " auid=3D%u ses=3D%u", auid, sessionid);
> > >  }
> > >
> > > +/*
> > > + * audit_log_contid - report container info
> > > + * @tsk: task to be recorded
> > > + * @context: task or local context for record
> > > + * @op: contid string description
> > > + */
> > > +int audit_log_contid(struct task_struct *tsk,
> > > +                            struct audit_context *context, char *op)
> > > +{
> > > +       struct audit_buffer *ab;
> > > +
> > > +       if (!audit_contid_set(tsk))
> > > +               return 0;
> > > +       /* Generate AUDIT_CONTAINER record with container ID */
> > > +       ab =3D audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
> > > +       if (!ab)
> > > +               return -ENOMEM;
> > > +       audit_log_format(ab, "op=3D%s contid=3D%llu",
> > > +                        op, audit_get_contid(tsk));
> >
> > Can you explain your reason for including an "op" field in this record
> > type?  I've been looking at the rest of the patches in this patchset
> > and it seems to be used more as an indicator of the record's
> > generating context rather than any sort of audit container ID
> > operation.
>
> "action" might work, but that's netfilter and numeric... "kind"?
> Nothing else really seems to fit from a field name, type or lack of
> searchability perspective.

My concern isn't so much the name of the "op" field, although that
does seem wrong, but rather the existence of the field in the first
place.  This audit container ID record (whatever we end up calling it)
exists to attach an audit container ID to an audit event, that's it;
an audit event should have other records which provide the context
(granted, the exact number of records depends on the event and the
system's configuration).  If we are relying on this record to provide
critical information about the audit event other than the audit
container ID, I believe this is a strong indicator that the existing
audit records are lacking and should be augmented.

--=20
paul moore
www.paul-moore.com
