Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-555205-1525878836-2-12398082283979098510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525878836; b=RN0/ribI1RcWhfmQL9VlcZ+Fd47A/t6YXdJCa0tpix352V2ebJ
    sjebghXedkeEpzvyq0QLcgUW9qh9GBj2k7kiv/pZJp74uqHcyXnmH+sd8IPPP0hw
    DOZSXxRQyMgjopj+wMGxJUP3DK7P6T9g4AfnB4jEXy7MGFWqrWbamIqR+UvQs3I4
    TGV5SZu8CYv+0PM41HRor8gHoMj1dj/DvDBki1mwUy95CawyqKo1tPx6c1D83tBZ
    Zk463FvXvUxFMrmLFPYqcNSGa5A6gLQNdwfjqd1emMDiCvL3+NQXy5hgqXfVjW6Q
    SvwHLgr3ZWoWdRg8eYK1DO2vTgpEILoJOqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525878836; bh=aTIO+mv+mKDeNn1GpaYBzZ03sr3VkGV2nUsz5eXdcg
    U=; b=LrZ7qSsxfLpqvM6KAEk+Vjk/B/55uv4/8rSw3gXySXuoMN6IgNWAPcUM88
    AhhCiRE8r7IVrYYHsDCQf32UQEGBtGBJLXUAt8yi9+OVl8dLwG8dvpZzUsOA6NEU
    D2kCBraOw2Y44dFXzCPVANRzwiGmNZvrm3OCVelxo1gjLVQ5/mXN3VO51KGCKTH+
    E8AomAnvavOdW06J/XqVkQ3gADGgAA2wH4YZPBLfRodz+qhKgLDRBBcMk6GvcQA7
    bvQRPMHYYAzIfpUV1icE3GKweHDooPTsaJVLGDe5m4r43nyV1ireq3nNhQJkriWd
    /LG6lcEFnLqaxXWZoSxjjUsuTELg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=izj3dOmM
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pgv+RNRP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=izj3dOmM
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pgv+RNRP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFfGaDS2/+PAPVeItCjdjmINt/wvpYnk5/3p4ivbyaDG/BwWjJ6Tqh1Mvv1Khh/Xk4+X+ZPsQSXB/b6a25hGrVkdHROUQXxfREQjpcXP2IUDSYwRRAxG
    5oZlJExyiRTyKP4FRoHKF3F43wZCeKDJKFKxtf9dNnohbfKQqgTk8J8pXfVxop11TGs+VGMsb2bX/gXcG9t5Qp4BOeKK+oTp2JKg993lJrSKdOGzk7FfOzgA
    9L17pYVtK/uRNcCvYWwncA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=lEFUVsbgnicA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=9vufOQ2zYSIYgMGVJNAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964955AbeEIPNw (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 11:13:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37327 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964843AbeEIPNt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 11:13:49 -0400
X-Google-Smtp-Source: AB8JxZqtjCePk4RSGhXk8/O9Bg+FsPH2Srt1oEOcXpV5Wpt3Yrr8Rf0ua3aT2NOjNvU1ceVy5bgFf5TCcTAWAfmbIM0=
MIME-Version: 1.0
X-Originating-IP: [68.177.129.184]
In-Reply-To: <611e9c85fca8bcdb24e6fb6da412773663c007b3.1525466167.git.rgb@redhat.com>
References: <cover.1525466167.git.rgb@redhat.com> <611e9c85fca8bcdb24e6fb6da412773663c007b3.1525466167.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 May 2018 11:13:47 -0400
Message-ID: <CAHC9VhQKYt0PC0L65pwFRte1D98R=2tUDGxMVpc8bbJsMncGpw@mail.gmail.com>
Subject: Re: [PATCH ghak81 RFC V1 1/5] audit: normalize loginuid read access
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 4, 2018 at 4:54 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the loginuid is an internal audit value, use an access
> function to retrieve the audit loginuid value for the task rather than
> reaching directly into the task struct to get it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 479c031..f3817d0 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -374,7 +374,7 @@ static int audit_field_compare(struct task_struct *tsk,
>         case AUDIT_COMPARE_EGID_TO_OBJ_GID:
>                 return audit_compare_gid(cred->egid, name, f, ctx);
>         case AUDIT_COMPARE_AUID_TO_OBJ_UID:
> -               return audit_compare_uid(tsk->loginuid, name, f, ctx);
> +               return audit_compare_uid(audit_get_loginuid(tsk), name, f, ctx);
>         case AUDIT_COMPARE_SUID_TO_OBJ_UID:
>                 return audit_compare_uid(cred->suid, name, f, ctx);
>         case AUDIT_COMPARE_SGID_TO_OBJ_GID:
> @@ -385,7 +385,7 @@ static int audit_field_compare(struct task_struct *tsk,
>                 return audit_compare_gid(cred->fsgid, name, f, ctx);
>         /* uid comparisons */
>         case AUDIT_COMPARE_UID_TO_AUID:
> -               return audit_uid_comparator(cred->uid, f->op, tsk->loginuid);
> +               return audit_uid_comparator(cred->uid, f->op, audit_get_loginuid(tsk));
>         case AUDIT_COMPARE_UID_TO_EUID:
>                 return audit_uid_comparator(cred->uid, f->op, cred->euid);
>         case AUDIT_COMPARE_UID_TO_SUID:
> @@ -394,11 +394,11 @@ static int audit_field_compare(struct task_struct *tsk,
>                 return audit_uid_comparator(cred->uid, f->op, cred->fsuid);
>         /* auid comparisons */
>         case AUDIT_COMPARE_AUID_TO_EUID:
> -               return audit_uid_comparator(tsk->loginuid, f->op, cred->euid);
> +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->euid);
>         case AUDIT_COMPARE_AUID_TO_SUID:
> -               return audit_uid_comparator(tsk->loginuid, f->op, cred->suid);
> +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->suid);
>         case AUDIT_COMPARE_AUID_TO_FSUID:
> -               return audit_uid_comparator(tsk->loginuid, f->op, cred->fsuid);
> +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->fsuid);
>         /* euid comparisons */
>         case AUDIT_COMPARE_EUID_TO_SUID:
>                 return audit_uid_comparator(cred->euid, f->op, cred->suid);
> @@ -611,7 +611,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>                                 result = match_tree_refs(ctx, rule->tree);
>                         break;
>                 case AUDIT_LOGINUID:
> -                       result = audit_uid_comparator(tsk->loginuid, f->op, f->uid);
> +                       result = audit_uid_comparator(audit_get_loginuid(tsk), f->op, f->uid);
>                         break;
>                 case AUDIT_LOGINUID_SET:
>                         result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
> @@ -2287,8 +2287,8 @@ int audit_signal_info(int sig, struct task_struct *t)
>             (sig == SIGTERM || sig == SIGHUP ||
>              sig == SIGUSR1 || sig == SIGUSR2)) {
>                 audit_sig_pid = task_tgid_nr(tsk);
> -               if (uid_valid(tsk->loginuid))
> -                       audit_sig_uid = tsk->loginuid;
> +               if (uid_valid(audit_get_loginuid(tsk)))
> +                       audit_sig_uid = audit_get_loginuid(tsk);

I realize this comment is a little silly given the nature of loginuid,
but if we are going to abstract away loginuid accesses (which I think
is good), we should probably access it once, store it in a local
variable, perform the validity check on the local variable, then
commit the local variable to audit_sig_uid.  I realize a TOCTOU
problem is unlikely here, but with this new layer of abstraction it
seems that some additional safety might be a good thing.

>                 else
>                         audit_sig_uid = uid;
>                 security_task_getsecid(tsk, &audit_sig_sid);
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
