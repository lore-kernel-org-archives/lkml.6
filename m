Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25662ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC7A2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dg1KqmTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC7A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeJTDqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:46:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44773 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeJTDqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:46:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so31788068ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LfbCSyroO8opLylaJt4warH9w8yP/UMKHeDhKle/I7I=;
        b=dg1KqmTVpCN31G+VnQGP2okyIZNGrbDQzItUIjpRG+9sshTJHeKBSh8VNLi/28Ldym
         0E7wpn3Qe4VcXVXOyELO2r3AJcmLXnWxZrniQmh9YJy479rNOAwXlLLd3L3pqLj/ipeC
         +hpdhJB9GcRYS0zFzOkNLLdyVWcPPw9Kf9YLDzOhegkNYPwTR89m5g8YeaVwx/PpPgLd
         E4eTReOOMZMS1D974CnmZiDlIUx4EIbSE3uIf93sa9TA63byoKzrFrI3W7CVsjabaN6Q
         /eo4MLRFIWDeRlflkShM7qIAsYCQV3PQRHMBBTn+Yb+sYm1rJ2JtdFaSxL4wUtzNM1bt
         2LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LfbCSyroO8opLylaJt4warH9w8yP/UMKHeDhKle/I7I=;
        b=iNQjUz0GkYfzSkVP6WI9Ii4TP2RPjRq2+5KCTLWQN/Azmv3ZTKViKZkKEK7cwFBzMv
         hk/bwJVrJWO48UjX2IOj5aC6bZWdIS7hJFmWoOWGwUPLB15/e4HVZwwTEmUK8hxEjiYS
         undYQsIIWEBiZai/yx3ClC7EMI2AWM7LrySa9hxOZVZzUGVtINEeUkK6mlf8xXd6UeQn
         SGJV5E8O5UtviQdClhydN2Xu+FOu19+vW1Sx08z1XElTCxRXsWgWNQfK2UhnDLNiMVA6
         vSljLzHdaUVO9S0CzRvQ0eCsP4urvcP8MYrzcL2gUQLzwLp16txvU1plfpNHWpOHHWH/
         6UEw==
X-Gm-Message-State: ABuFfogpjOPgrqsKsr/nZWboIxlHSSgZwqywmHsUvMMGBTXuS19wYwaW
        xzZQFZy0HwxuwugHVl4i3vK0OCGgR4UYJ3FnOLuI
X-Google-Smtp-Source: ACcGV626mHUxEWyw/a+i4SjmmXI+mCCDKqgA6ZKQ2A1ulmZGA100Uz+LS2XV0+Szj2Zbqf8/m48WamBNhruTGHShRdA=
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr25537322ljn.18.1539977924682;
 Fri, 19 Oct 2018 12:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <12396e378a78ee8dd38c75f7730d67d8fbb08e02.1533065887.git.rgb@redhat.com>
In-Reply-To: <12396e378a78ee8dd38c75f7730d67d8fbb08e02.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 15:38:33 -0400
Message-ID: <CAHC9VhTT7n4wDoaDGFXAK+wtcsMDDMRkQVCQ2jNYLKSFqFc+bA@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 02/10] audit: add container id
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

On Tue, Jul 31, 2018 at 4:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Implement the proc fs write to set the audit container identifier of a
> process, emitting an AUDIT_CONTAINER_OP record to document the event.
>
> This is a write from the container orchestrator task to a proc entry of
> the form /proc/PID/audit_containerid where PID is the process ID of the
> newly created task that is to become the first task in a container, or
> an additional task added to a container.
>
> The write expects up to a u64 value (unset: 18446744073709551615).
>
> The writer must have capability CAP_AUDIT_CONTROL.
>
> This will produce a record such as this:
>   type=3DCONTAINER_ID msg=3Daudit(2018-06-06 12:39:29.636:26949) : op=3Ds=
et opid=3D2209 old-contid=3D18446744073709551615 contid=3D123456 pid=3D628 =
auid=3Droot uid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfined_r=
:unconfined_t:s0-s0:c0.c1023 comm=3Dbash exe=3D/usr/bin/bash res=3Dyes

You need to update the record type in the example above.

> The "op" field indicates an initial set.  The "pid" to "ses" fields are
> the orchestrator while the "opid" field is the object's PID, the process
> being "contained".  Old and new audit container identifier values are
> given in the "contid" fields, while res indicates its success.

I understand Steve's concern around the "op" field, but I think it
might be a bit premature to think we might not need to do some sort of
audit container ID management in the future that would want to make
use of the CONTAINER_OP message type.  I would like to see the "op"
field preserved.

> It is not permitted to unset the audit container identifier.
> A child inherits its parent's audit container identifier.
>
> See: https://github.com/linux-audit/audit-kernel/issues/90
> See: https://github.com/linux-audit/audit-userspace/issues/51
> See: https://github.com/linux-audit/audit-testsuite/issues/64
> See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container=
-ID
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  fs/proc/base.c             | 37 +++++++++++++++++++++++++
>  include/linux/audit.h      | 24 ++++++++++++++++
>  include/uapi/linux/audit.h |  2 ++
>  kernel/auditsc.c           | 68 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 131 insertions(+)

...

> @@ -2112,6 +2114,72 @@ int audit_set_loginuid(kuid_t loginuid)
>  }
>
>  /**
> + * audit_set_contid - set current task's audit_context contid
> + * @contid: contid value
> + *
> + * Returns 0 on success, -EPERM on permission failure.
> + *
> + * Called (set) from fs/proc/base.c::proc_contid_write().
> + */
> +int audit_set_contid(struct task_struct *task, u64 contid)
> +{
> +       u64 oldcontid;
> +       int rc =3D 0;
> +       struct audit_buffer *ab;
> +       uid_t uid;
> +       struct tty_struct *tty;
> +       char comm[sizeof(current->comm)];
> +
> +       task_lock(task);
> +       /* Can't set if audit disabled */
> +       if (!task->audit) {
> +               task_unlock(task);
> +               return -ENOPROTOOPT;
> +       }
> +       oldcontid =3D audit_get_contid(task);
> +       read_lock(&tasklist_lock);

I assume lockdep was happy with nesting the tasklist_lock inside the task l=
ock?

> +       /* Don't allow the audit containerid to be unset */
> +       if (!audit_contid_valid(contid))
> +               rc =3D -EINVAL;
> +       /* if we don't have caps, reject */
> +       else if (!capable(CAP_AUDIT_CONTROL))
> +               rc =3D -EPERM;
> +       /* if task has children or is not single-threaded, deny */
> +       else if (!list_empty(&task->children))
> +               rc =3D -EBUSY;
> +       else if (!(thread_group_leader(task) && thread_group_empty(task))=
)
> +               rc =3D -EALREADY;
> +       read_unlock(&tasklist_lock);
> +       if (!rc)
> +               task->audit->contid =3D contid;
> +       task_unlock(task);
> +
> +       if (!audit_enabled)
> +               return rc;
> +
> +       ab =3D audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONTAIN=
ER_OP);
> +       if (!ab)
> +               return rc;
> +
> +       uid =3D from_kuid(&init_user_ns, task_uid(current));
> +       tty =3D audit_get_tty(current);
> +       audit_log_format(ab, "op=3Dset opid=3D%d old-contid=3D%llu contid=
=3D%llu pid=3D%d uid=3D%u auid=3D%u tty=3D%s ses=3D%u",
> +                        task_tgid_nr(task), oldcontid, contid,
> +                        task_tgid_nr(current), uid,
> +                        from_kuid(&init_user_ns, audit_get_loginuid(curr=
ent)),
> +                        tty ? tty_name(tty) : "(none)",
> +                        audit_get_sessionid(current));
> +       audit_put_tty(tty);
> +       audit_log_task_context(ab);
> +       audit_log_format(ab, " comm=3D");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +       audit_log_d_path_exe(ab, current->mm);
> +       audit_log_format(ab, " res=3D%d", !rc);
> +       audit_log_end(ab);
> +       return rc;
> +}

--=20
paul moore
www.paul-moore.com
