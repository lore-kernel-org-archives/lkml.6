Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197B42170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgPFqKVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197B42170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeI1CJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:09:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37929 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeI1CJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:09:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id h15-v6so3782389otj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvzR1FHaIiGrJzDjWZDHSHctMY6/8YLrE9EiC/S+3wg=;
        b=KgPFqKVdYkxIJR1UiEEKS2KwtqQHOVsxqHCzh9gBiovdRRQTBUO6sk4WNby1smweAu
         CqEyQ9m57P+Kv7CbPFXIFhAsmvjAFsQSrcXFYfJNbqqAoRGJKmly1h9MQ3ATlxdkAF0M
         e6jDcss0voc1NlXiwd5RS0xLGpx953hR8uyMzAiYJHmlF5sVMWZxKh0vw6/wtu39yV21
         zk/FhSvIsxEymJaheVQHsXyd7ouysivY0sP+wGWASCI8eFs1pdi7lXCuxOYQrAYYyyt+
         dOQ9N9kQI108LLJUsF83/fM9YLw24ftcagNNFaCoH/TbbifsBZvYh0ckYeYhs3L78UQ5
         8OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvzR1FHaIiGrJzDjWZDHSHctMY6/8YLrE9EiC/S+3wg=;
        b=ASqgTDtNT2VinLC0sxulLhplK0E5NAXmubbXaut0v5lt9X/8mNXTT7+gCBgg3M/zWQ
         mWEMGBg5rw+Ecm6cXOxxva3y3TARH6btSkC6w32/MwjIweb5ceoEUtOZ1wbNUoub6cDY
         LMEyS9u2mYafYuEbVxQ8ruUaxfEI4CPnz1bzdT2GsFKOQpKj0YOxksV/75gAlCylIeI7
         2/HpB5s0QJ1Y8xMLLyLpnd2QnY5vBX/SPY739aMaREIDOjeuAux9gI/hsLpPCRk9RHWF
         gzelmIfmNLlmXXEahfFpzggqQwFigXCvlpB2gG5s5J5IhA/muxc4gpa8v0oqctXwKTmA
         22tw==
X-Gm-Message-State: ABuFfogZ4MU2lkXZ+JIuD6nCbQAVGjlzgUu63H1mz0YqmSPdhVvZjoqI
        7M9PO2Zons+lprB8KDb6QhhrmtkI+OTkynIU036UqSmy4Hc=
X-Google-Smtp-Source: ACcGV62ZtewSHy76we1eICNLd4/tqsCsFzNEEFO5Yd1NVN+PKesjFuTZ91A/gIEOHv2fnFhc5f0TfAk1ph9SBd0xZHI=
X-Received: by 2002:a9d:4e94:: with SMTP id v20-v6mr8039959otk.255.1538077777344;
 Thu, 27 Sep 2018 12:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180824224117.3356-1-casey.schaufler@intel.com> <20180927191720.9480-1-casey.schaufler@intel.com>
In-Reply-To: <20180927191720.9480-1-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 21:49:10 +0200
Message-ID: <CAG48ez1qZQqffLfB_JV=UB12QjFWmfHm2=PH2eiF+Z_yn9RhpA@mail.gmail.com>
Subject: Re: [PATCH 6/5] capability: Repair sidechannel test in ptrace
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 9:17 PM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> From: Casey Schaufler <casey@schaufler-ca.com>
>
> The PTRACE_MODE_SCHED check erroniously returns 0 in
> all cases. It should be returning -EPERM. This fixes
> the logic to correct that error.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  security/commoncap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index e77457110d05..70a7e3d19c16 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -152,9 +152,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
>         if (cred->user_ns == child_cred->user_ns &&
>             cap_issubset(child_cred->cap_permitted, *caller_caps))
>                 goto out;
> -       if (mode & PTRACE_MODE_SCHED)
> -               goto out;
> -       if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
> +       if (!(mode & PTRACE_MODE_SCHED) &&
> +           ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
>                 goto out;
>         ret = -EPERM;
>  out:
> --
> 2.17.1
>
