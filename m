Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91FECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08162082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="u6XujMBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08162082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJYFZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:25:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44332 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJYFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:25:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so6093342ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mhT58Z9DF7vdT8qdRKAIaDFlfdlZuKDmfDR6LKKEz4M=;
        b=u6XujMBEI0FG97PZBQ/dTWD45/m8psIFsVE5KrrqVxNOY9SQTmP6SDOgfKtXM3XsJR
         oYy47EM1GVtSPbh4Dy8kK53NARVGHW+/+Xoo622/APDmsvsL4yFIhDUVQq4isNuXZEL4
         UGdUCp/8s0faIV4vPNvAsvAdXLhsPX+WjNQdZcmTDIxoTOLfwlyyTkwRcmf5EDsMmg5a
         0ZOC8ZfGxLDinGG6F1ZYxm0ews4MH8nkJKfmBBgVw6WLmVb1ZcZ+C4vbYAQALDumN7JW
         pjxrPeBQiWq3kfVqv1xC4xHoMKpEidbJCIQGd3miaiQuyoHQslibexQBHc+Rt0UDOeFx
         f/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mhT58Z9DF7vdT8qdRKAIaDFlfdlZuKDmfDR6LKKEz4M=;
        b=aulEHFNRHkgiaNGN+07Ogszydj7QPSUxbPfo3P2qw4jwVVUJIDxrtc/HkJhZBOEdOj
         ZrkCosXftk/IIaK3KxX/xPDcpDgO2ybsHVnaCSQgBDjbjnv27xKIpir6qKSN1c+1u0Q6
         SgYasLkhjmFLPWWJzMy0xdBiqzd7hhGV14X+AQC0tfFMgbhSxL58mvlsQrmwbmAQ1DZx
         iR97m11xbAZOk9TYEAXuXXgzbyqOjrRO4XkbSMhaJYwf9iLLG0Sy2ODgx6d+fGCwH0Ru
         QGXuGkMsJtz/puKUjksitX8tvggoBn9eKB2BvvicS3hVq6CnkRN+Qbc9lC3bzpqGEB4d
         Emiw==
X-Gm-Message-State: AGRZ1gJSi4Tkf7FzRwqcZpVtEbClX47RItwy7vM4iNRXoYHUdiYb6txq
        PSqrqEgF97AHBLp56Jzl8oJvYEOTK+QexU37dJma
X-Google-Smtp-Source: AJdET5dVD8iRmUl/WGSSLcloM+rsRpzC0Y/o4ruERDqIkho4sdOf4l0i8mWjzYe1HHyNnoTPu2BRWGjWxBbSAa0cadg=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr2440311lja.77.1540414549952;
 Wed, 24 Oct 2018 13:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
 <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com> <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca>
In-Reply-To: <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Oct 2018 16:55:38 -0400
Message-ID: <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info of syscalls
To:     rgb@redhat.com
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:15 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-10-19 19:16, Paul Moore wrote:
> > On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs <rgb@redhat.com> wrot=
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
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > Acked-by: Steve Grubb <sgrubb@redhat.com>
> > > ---
> > >  include/linux/audit.h      |  7 +++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.c             | 24 ++++++++++++++++++++++++
> > >  kernel/auditsc.c           |  3 +++
> > >  4 files changed, 35 insertions(+)
> >
> > ...
> >
> > > @@ -2045,6 +2045,30 @@ void audit_log_session_info(struct audit_buffe=
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
> > > +       audit_log_end(ab);
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL(audit_log_contid);
> >
> > As discussed in the previous iteration of the patch, I prefer
> > AUDIT_CONTAINER_ID here over AUDIT_CONTAINER.  If you feel strongly
> > about keeping it as-is with AUDIT_CONTAINER I suppose I could live
> > with that, but it is isn't my first choice.
>
> I don't have a strong opinion on this one, mildly preferring the shorter
> one only because it is shorter.

We already have multiple AUDIT_CONTAINER* record types, so it seems as
though we should use "AUDIT_CONTAINER" as a prefix of sorts, rather
than a type itself.

> > However, I do care about the "op" field in this record.  It just
> > doesn't make any sense; the way you are using it it is more of a
> > context field than an operations field, and even then why is the
> > context important from a logging and/or security perspective?  Drop it
> > please.
>
> I'll rename it to whatever you like.  I'd suggest "ref=3D".  The reason I
> think it is important is there are multiple sources that aren't always
> obvious from the other records to which it is associated.  In the case
> of ptrace and signals, there can be many target tasks listed (OBJ_PID)
> with no other way to distinguish the matching audit container identifier
> records all for one event.  This is in addition to the default syscall
> container identifier record.  I'm not currently happy with the text
> content to link the two, but that should be solvable (most obvious is
> taret PID).  Throwing away this information seems shortsighted.

It would be helpful if you could generate real audit events
demonstrating the problems you are describing, as well as a more
standard syscall event, so we can discuss some possible solutions.

--=20
paul moore
www.paul-moore.com
