Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7C21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MIqso/Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJTHZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:25:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33057 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeJTHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:24:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so32209745ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eU3hN7Qd160SIyvxMA6HkaqwduRsf+Lu1KiuA7LcWA=;
        b=MIqso/MrwQgKc+/nuUIP5phhZH8xDJwSIHvPgQC8KEmanjeZ4dVj9u6WvGJ2ePQTOR
         oVtKIFF3gkcnG6zIEo6kW/XZ75XOrKrTTNTEzRhW4bMl62I8lGE4FpFCaqX+1SalmH0L
         UWCULrWW8arY9gT3jPf3kX4vo5qs20CpHu4cm4vmwKDOuYIK2QKKsRxJIE66yekaICCo
         2TXHyMmC6LEr1vXrR9n3zUx8pSz7AYdTA8lBEH5RKC6NgobUhhMEA8XAlOZ33RNuXnQx
         zRoBfUGWfblKBp9V3Q50HKw6STMDrp+qMGBe8Z0I2rSCwIvCnYL7mzjI945MIuMjIvfB
         VBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eU3hN7Qd160SIyvxMA6HkaqwduRsf+Lu1KiuA7LcWA=;
        b=FCDOuUy2Z0nDQo2OP1WICGz72OG8umgcVQBcvA/C4QYowQGWmOmpPidPFYUIWdi34h
         tP+NnA2T0tjKPvlJAqnnsof37Pnsz2V3LRPZtLpcVhRC6jDCQl0nhp98Ng3cxZWPxthi
         u7OcczgTv27+UA9So1giRzjwa9Il36yezCZSdOO2wCcK/3nGTVQrvRTXVR8TLioh9QS5
         u5oXAuUs12YC1p9qQvgMD0elU4sH51KcM41IIXvdBALuFI2/mSEPD1cMVlOupwlLeHgi
         meqPz7Va8+mLemjXabzX+Mep6SisSLks3STyLlwvN8wy+B4UTVa5/+rSTdi7tGtgYUjW
         mMVg==
X-Gm-Message-State: ABuFfoiP5VQA3puy0a5O6otzddqdqgo3KGdCH0/xPOW1zSYNK48AthvM
        auItfh91oD14h1eTKoi4dPyblzgXhSnd3sHTcFn0
X-Google-Smtp-Source: ACcGV6329Fm65ImRLKHHUN/WnEuz49itsfa7Sgh6GRqJ85v3e2c61cRw6dFyOtN+nfMzRUiGkjk0cda0AZR32MZGtKI=
X-Received: by 2002:a2e:2c15:: with SMTP id s21-v6mr23931461ljs.162.1539991009923;
 Fri, 19 Oct 2018 16:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
In-Reply-To: <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 19:16:38 -0400
Message-ID: <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
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

On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> Create a new audit record AUDIT_CONTAINER to document the audit
> container identifier of a process if it is present.
>
> Called from audit_log_exit(), syscalls are covered.
>
> A sample raw event:
> type=3DSYSCALL msg=3Daudit(1519924845.499:257): arch=3Dc000003e syscall=
=3D257 success=3Dyes exit=3D3 a0=3Dffffff9c a1=3D56374e1cef30 a2=3D241 a3=
=3D1b6 items=3D2 ppid=3D606 pid=3D635 auid=3D0 uid=3D0 gid=3D0 euid=3D0 sui=
d=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D3 comm=3D"bash=
" exe=3D"/usr/bin/bash" subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0=
:c0.c1023 key=3D"tmpcontainerid"
> type=3DCWD msg=3Daudit(1519924845.499:257): cwd=3D"/root"
> type=3DPATH msg=3Daudit(1519924845.499:257): item=3D0 name=3D"/tmp/" inod=
e=3D13863 dev=3D00:27 mode=3D041777 ouid=3D0 ogid=3D0 rdev=3D00:00 obj=3Dsy=
stem_u:object_r:tmp_t:s0 nametype=3D PARENT cap_fp=3D0000000000000000 cap_f=
i=3D0000000000000000 cap_fe=3D0 cap_fver=3D0
> type=3DPATH msg=3Daudit(1519924845.499:257): item=3D1 name=3D"/tmp/tmpcon=
tainerid" inode=3D17729 dev=3D00:27 mode=3D0100644 ouid=3D0 ogid=3D0 rdev=
=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DCREATE cap_fp=
=3D0000000000000000 cap_fi=3D0000000000000000 cap_fe=3D0 cap_fver=3D0
> type=3DPROCTITLE msg=3Daudit(1519924845.499:257): proctitle=3D62617368002=
D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E746169=
6E65726964
> type=3DCONTAINER msg=3Daudit(1519924845.499:257): op=3Dtask contid=3D1234=
58
>
> See: https://github.com/linux-audit/audit-kernel/issues/90
> See: https://github.com/linux-audit/audit-userspace/issues/51
> See: https://github.com/linux-audit/audit-testsuite/issues/64
> See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container=
-ID
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  include/linux/audit.h      |  7 +++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 24 ++++++++++++++++++++++++
>  kernel/auditsc.c           |  3 +++
>  4 files changed, 35 insertions(+)

...

> @@ -2045,6 +2045,30 @@ void audit_log_session_info(struct audit_buffer *a=
b)
>         audit_log_format(ab, " auid=3D%u ses=3D%u", auid, sessionid);
>  }
>
> +/*
> + * audit_log_contid - report container info
> + * @tsk: task to be recorded
> + * @context: task or local context for record
> + * @op: contid string description
> + */
> +int audit_log_contid(struct task_struct *tsk,
> +                            struct audit_context *context, char *op)
> +{
> +       struct audit_buffer *ab;
> +
> +       if (!audit_contid_set(tsk))
> +               return 0;
> +       /* Generate AUDIT_CONTAINER record with container ID */
> +       ab =3D audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
> +       if (!ab)
> +               return -ENOMEM;
> +       audit_log_format(ab, "op=3D%s contid=3D%llu",
> +                        op, audit_get_contid(tsk));
> +       audit_log_end(ab);
> +       return 0;
> +}
> +EXPORT_SYMBOL(audit_log_contid);

As discussed in the previous iteration of the patch, I prefer
AUDIT_CONTAINER_ID here over AUDIT_CONTAINER.  If you feel strongly
about keeping it as-is with AUDIT_CONTAINER I suppose I could live
with that, but it is isn't my first choice.

However, I do care about the "op" field in this record.  It just
doesn't make any sense; the way you are using it it is more of a
context field than an operations field, and even then why is the
context important from a logging and/or security perspective?  Drop it
please.

--
paul moore
www.paul-moore.com
