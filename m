Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-546355-1525879746-2-4270043645993306367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525879746; b=fHNqfsI1iecpyQW6pxPIpC/WufvKaCf1Ngwd9+Vamlsgbhap0f
    TsMkJfC4mZSQ4zdbbT3xfRloqrtPicgj01SmqXYkf5XrKkI3AvQrawVeungS5qPs
    g/PQxYHOfHc5S0mlnyZZ8iKOfSRPmnCXbgseFkO0YStE+QP+rX0gZ8fx+Ej4ZH62
    sT6R7Yw7WsuP8ZV9aTM1R3hA4keMvvMPigtJTojs/KzzLnLPFBDSj2IOJfdya55f
    PVRS5YSXSOxf83vljgzfusM45dx4Sxf2Y+b3w7qHuFLPuprGfTM1n4e1Bjyv+irM
    iybzvGHwUWJSuXJQCr/tTz0XdT5OmeQYhh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525879746; bh=A+7WYRO64bn900zJ8h0Rmn38+oDXuLwjqVGza7mlFs
    w=; b=AVccSGOwrL7RIqSXH9rt0l/icm2V4LMwer4ZZjeLU0Q9NKvC9f0XlpMxol
    YNG/0lPuP5DsjbwV5P4VS8rHLlHV2JgnQRvLcNG+Yo9tv4WaXFp8rt3BFQvlpXbm
    q+gU26UCc93wKGwMUcZIPTO4EdeqVIOJxpYXzI0XmpZy+JGqAzGIwmEs9+/7kDfc
    V0a0m9wH2nubF+fJeOM8cogWKp3SKURfERhtr98i2TiBTAzs/dpS/x7K9+OFWouw
    3wlUGbOYX/y/062cAHzofFCeTtkiuZzt2E1VQPVnHlwEPEX/BsDUD3j7Dk5rIRvk
    zYgINfihsLVCx15tyFyjC5ULXk8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=iM8w9+mK
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gdCcRATL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=iM8w9+mK
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gdCcRATL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKHVMaWQO6ApcF9owQFb/Vsj8F0PhQxsC0+IhzsXh4Dxa9mMDTu4U0dnHnPqPaZ/hx/aAmRhotRsCZ608Lj2V7FT4hPQps5d2iqTGFYz0SqO+CgWi3Rp
    EiXLDsmrOxW+OKAouM0tgOsJunT1ngcW/EhPBuQkIW8SIVmR0ifbK6mKM2jHX/xUB8ZQTk+lZ4xjmdWqzf0mWcU1RYHHopCRsuCfZHKB/np0GmOazLyutIiF
    LmY0n/bjGsmMje7Y5Wsxzg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=lEFUVsbgnicA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=Tpkp56UUEifMGCgD9HUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935403AbeEIP3C (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 11:29:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46774 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935399AbeEIP3B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 11:29:01 -0400
X-Google-Smtp-Source: AB8JxZoFmVlwT9eT0qC3U24ptYhoNL7GEx1uQ5kGohhk5gpqKejx0Y16cbtvKsphjbKWD8elLaiQjFVzOEaU7ARLV9E=
MIME-Version: 1.0
X-Originating-IP: [68.177.129.184]
In-Reply-To: <0e43c5135c197209b3189032d538244571e7443d.1525466167.git.rgb@redhat.com>
References: <cover.1525466167.git.rgb@redhat.com> <0e43c5135c197209b3189032d538244571e7443d.1525466167.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 May 2018 11:28:58 -0400
Message-ID: <CAHC9VhSbMaJ72jJnEivDd-M2UXDomexva8B-xsWXapTyeF0JVQ@mail.gmail.com>
Subject: Re: [PATCH ghak81 RFC V1 3/5] audit: use inline function to get audit context
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
> Recognizing that the audit context is an internal audit value, use an
> access function to retrieve the audit context pointer for the task
> rather than reaching directly into the task struct to get it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h                | 16 ++++++++---
>  include/net/xfrm.h                   |  2 +-
>  kernel/audit.c                       |  4 +--
>  kernel/audit_watch.c                 |  2 +-
>  kernel/auditsc.c                     | 52 ++++++++++++++++++------------------
>  net/bridge/netfilter/ebtables.c      |  2 +-
>  net/core/dev.c                       |  2 +-
>  net/netfilter/x_tables.c             |  2 +-
>  net/netlabel/netlabel_user.c         |  2 +-
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/integrity_audit.c |  2 +-
>  security/lsm_audit.c                 |  2 +-
>  security/selinux/hooks.c             |  4 +--
>  security/selinux/selinuxfs.c         |  6 ++---
>  security/selinux/ss/services.c       | 12 ++++-----
>  15 files changed, 60 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 5f86f7c..93e4c61 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -235,26 +235,30 @@ extern void __audit_inode_child(struct inode *parent,
>  extern void __audit_seccomp(unsigned long syscall, long signr, int code);
>  extern void __audit_ptrace(struct task_struct *t);
>
> +static inline struct audit_context *audit_context(struct task_struct *task)
> +{
> +       return task->audit_context;
> +}

Another case where I think I agree with everything here on principle,
especially when one considers it in the larger context of the audit
container ID work.  However, I think we might be able to somply this a
bit by eliminating the parameter to the new audit_context() helper and
making it always reference the current task_struct.  Based on this
patch it would appear that this change would work for all callers
except for audit_take_context() and __audit_syscall_entry(), both of
which are contained within the core audit code and are enough of a
special case that I think it is acceptable for them to access the
context directly.  I'm trying to think of reasons why a non-audit
kernel subsystem would ever need to access the audit context of a
process other than current and I can't think of any ... removing the
task_struct pointer might help prevent mistakes/abuse in the future.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6e3ceb9..a4bbdcc 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -836,7 +836,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
>                                                       int return_valid,
>                                                       long return_code)
>  {
> -       struct audit_context *context = tsk->audit_context;
> +       struct audit_context *context = audit_context(tsk);
>
>         if (!context)
>                 return NULL;
> @@ -1510,7 +1510,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>                            unsigned long a3, unsigned long a4)
>  {
>         struct task_struct *tsk = current;
> -       struct audit_context *context = tsk->audit_context;
> +       struct audit_context *context = audit_context(tsk);
>         enum audit_state     state;
>
>         if (!audit_enabled || !context)

-- 
paul moore
www.paul-moore.com
