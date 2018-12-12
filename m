Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59837C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AF32087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqiNAn3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AF32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeLLRKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:10:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40836 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeLLRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:10:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so18304533oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VMCm0kqjIp/CdDjFajGYlbP/Rx8IRlay7yUUK5VXwrg=;
        b=fqiNAn3JqiJZVWwZxVO9YNkjhOypy8hU4aB7tWKM6uJVjTEdzxx6l3WhOn2rT24hNn
         Rt39V54EufpFlqEGmpbDm7vUkIh9aZcWOWw7jJTv/UvIL20Y1UfyiD4eqyJ+fWxGmdCg
         8P3/Zvyxgcz2GfnI5f+d1rPcCKzhAR3/Q/Tog5sq0mJyx1qLINC3g05WRjKA32hIe2Mh
         e+/uIECyHH0SNLG4uMET88UFQKsf6kbrlkG9f3AUdgOUOhTuiXr5EI5EL7aSoTdEdaHH
         ZirL9F65QVR9vCR6LRDI5iywrh+5pddsyFbeux4tzDrm4xaXYksW4d2jgPBIrUU0ivC7
         Y7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VMCm0kqjIp/CdDjFajGYlbP/Rx8IRlay7yUUK5VXwrg=;
        b=Z76qDi1GeUxFMNcGiTlUr6VKoQ3mhgDqFQ10jLjyFu62vgF2cHuaqEhjzOyWOiMGl1
         7lE872AzH9JW8IlPkp1awVhUkDohZJ+nEw4zG4xjYMU5PAEEtU4V/CvgdyM6JfqJ2o1X
         W1nAZ4gM5N3QN/gnjFV9NjNA2kHnpZlOaxdp9WRHMqqxkDjnvwXR+Et1MBWcal+J08OJ
         xomskV0Afc28UXhE4W5vvPp4xWepl3b6iaFhCyWB7FYJIIm3cecBwsqKi2QIq1LUMMiP
         06EGCuPgAJP+unK+GVxvKun2KJ5uLK8fhIwquB6oUvjw2mGTQ7yKFrtVhd81c7l90LwI
         AsYA==
X-Gm-Message-State: AA+aEWac2FPVI6QGQsHs5WqEdWHutQ2zIDK82pRedXH4i1HgLMZ4hFYK
        ekcGAzHz4BkB9IMbK7xxHYI4jACMzJ+ZztLJ6gkysA==
X-Google-Smtp-Source: AFSGD/UHI/u1T4lraEKfm817NGZLDmde8aZXSyM2lIfkiqE2VOLe6WGkHns8ow0GPNYpJ2HMBFo9iM+v0IHhBrOWT4A=
X-Received: by 2002:a9d:460e:: with SMTP id y14mr15481648ote.198.1544634602121;
 Wed, 12 Dec 2018 09:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20181212081712.32347-1-mic@digikod.net> <20181212081712.32347-4-mic@digikod.net>
In-Reply-To: <20181212081712.32347-4-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 12 Dec 2018 18:09:35 +0100
Message-ID: <CAG48ez3SAW8EyaJ9T1U3qPoRhYwe4CCyL9bAxuc3GxjrXipi-A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        mickael.salaun@ssi.gouv.fr, zohar@linux.ibm.com,
        philippe.trebuchet@ssi.gouv.fr, shuah@kernel.org,
        thibaut.sautereau@ssi.gouv.fr, vincent.strubel@ssi.gouv.fr,
        yves-alexis.perez@ssi.gouv.fr,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 9:18 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> Enable to either propagate the mount options from the underlying VFS
> mount to prevent execution, or to propagate the file execute permission.
> This may allow a script interpreter to check execution permissions
> before reading commands from a file.
>
> The main goal is to be able to protect the kernel by restricting
> arbitrary syscalls that an attacker could perform with a crafted binary
> or certain script languages.  It also improves multilevel isolation
> by reducing the ability of an attacker to use side channels with
> specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g., Python, Perl).
>
> Add a new sysctl kernel.yama.open_mayexec_enforce to control this
> behavior.  A following patch adds documentation.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Reviewed-by: Philippe Tr=C3=A9buchet <philippe.trebuchet@ssi.gouv.fr>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Micka=C3=ABl Sala=C3=BCn <mickael.salaun@ssi.gouv.fr>
> ---
[...]
> +/**
> + * yama_inode_permission - check O_MAYEXEC permission before accessing a=
n inode
> + * @inode: inode structure to check
> + * @mask: permission mask
> + *
> + * Return 0 if access is permitted, -EACCES otherwise.
> + */
> +int yama_inode_permission(struct inode *inode, int mask)

This should be static, no?

> +{
> +       if (!(mask & MAY_OPENEXEC))
> +               return 0;
> +       /*
> +        * Match regular files and directories to make it easier to
> +        * modify script interpreters.
> +        */
> +       if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +               return 0;

So files are subject to checks, but loading code from things like
sockets is always fine?

> +       if ((open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_MOUNT) &&
> +                       !(mask & MAY_EXECMOUNT))
> +               return -EACCES;
> +
> +       /*
> +        * May prefer acl_permission_check() instead of generic_permissio=
n(),
> +        * to not be bypassable with CAP_DAC_READ_SEARCH.
> +        */
> +       if (open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_FILE)
> +               return generic_permission(inode, MAY_EXEC);
> +
> +       return 0;
> +}
> +
>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D {
> +       LSM_HOOK_INIT(inode_permission, yama_inode_permission),
>         LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>         LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>         LSM_HOOK_INIT(task_prctl, yama_task_prctl),
> @@ -447,6 +489,37 @@ static int yama_dointvec_minmax(struct ctl_table *ta=
ble, int write,
>         return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppo=
s);
>  }
>
> +static int yama_dointvec_bitmask_macadmin(struct ctl_table *table, int w=
rite,
> +                                         void __user *buffer, size_t *le=
np,
> +                                         loff_t *ppos)
> +{
> +       int error;
> +
> +       if (write) {
> +               struct ctl_table table_copy;
> +               int tmp_mayexec_enforce;
> +
> +               if (!capable(CAP_MAC_ADMIN))
> +                       return -EPERM;

Don't put capable() checks in sysctls, it doesn't work.
