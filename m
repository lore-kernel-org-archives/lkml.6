Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A18C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F232D215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6ZZDYsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F232D215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeI0Xyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:54:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37219 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeI0Xyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:54:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id o13-v6so3382177otl.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSpwSWwm4iMk7xqC3ILfh7UMzamZ6WABzvdm9zGzjCI=;
        b=p6ZZDYsNsyOUCirEtU4rYHXzhHQ/2idpj43Su2lS6tTJoyTGw1C43drN/W9dSZCU1i
         sDX3k6ZRxsdMW4koH2TlfC/ahCWQxSYWpg7xVxdfPXo6m3xpOkOJfFSt43aCdwhHViGK
         N/cd0AWnOISpmjPrAJUvYXkGghk8cpgC8zG0jLM63vmhglbDsn28QG92kDDoJYAP3WY0
         xLQZg0Weol586wSVEaWyMABwdK1HnIc9ajbF/1T3ahyIDBnnfTPN39oS9e2Qau4AA9dc
         KyTYrvbiKPgQkz4LTucv4PZB/4vlF1NTZ8xuszqfGPhLpf0YKyDU9ONelM1ZoEcBtF2P
         cWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSpwSWwm4iMk7xqC3ILfh7UMzamZ6WABzvdm9zGzjCI=;
        b=Jk8rjLE21mw/SiCS1GNI6LcSmVWb/6E9u7DEnDyZN1Otz7N6d++vpUrD46B3wJ0Ps8
         N2AcVgvk8M9vL6tXnYcHjJlwQZTgh7SGrxeMxxCLHqe52/5L50q+MZupDPVIj15BZYqD
         QGdy883W8zCMCnOIezhzHLVwV+SPH8NZDh/Tt+g6WgRkMohiOmZxUJZBoCM6MkhCsk5k
         MAx0LZseHCHKWxkOhFFd1l7LZ9ZFNBk5RUQALHnQlGAhxBUhyTWfLnzFk1Ikj8OCoUf5
         r8I0ZRrHuK8CGozXnbHQylMnmcV7Gy4xGVbGlQY4iMgXHBecwId92Hwlxana9tnMxHEU
         Z0UQ==
X-Gm-Message-State: ABuFfogiyxWrh+m8voeuselOrLJyvy6tfgWAuZ55xjZ2BERP9tyRbQpo
        KAgAk0mnvJjDv56AaTT1rBnp2SCY0z+hoBHMJlb6V/+gLxUk8g==
X-Google-Smtp-Source: ACcGV63J+gRfSAOCrYyp2Tm9cUVeeMXk17LrBnDLirZ6WATG34LjzsH1meufkydstkZU+S7g1aEw/O8qpcOo/lrFWmI=
X-Received: by 2002:a9d:2a38:: with SMTP id t53-v6mr7213017ota.35.1538069733166;
 Thu, 27 Sep 2018 10:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
In-Reply-To: <20180927151119.9989-4-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 19:35:06 +0200
Message-ID: <CAG48ez14hkjQr8_ysg13Ax9uc+abKeTtN7pCxuiJ83Ms3Gbo5Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
>
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
[...]
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 21fec73d45d4..289960ac181b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
>                 ret = seccomp_get_metadata(child, addr, datavp);
>                 break;
>
> +       case PTRACE_SECCOMP_NEW_LISTENER:
> +               ret = seccomp_new_listener(child, addr);
> +               break;

Actually, could you amend this to also ensure that `data == 0` and
return -EINVAL otherwise? Then if we want to abuse `data` for passing
flags in the future, we don't have to worry about what happens if
someone passes in garbage as `data`.
