Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924DC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E1E21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6PleOdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfACLRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:17:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47023 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfACLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:17:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so27380453oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQcPxfSwbKHal4eWi9/k1XS4dY35WSsLnXPxD3MpobU=;
        b=T6PleOdAW7jaKUX3gNidSFglPIPfLu+3K/DlD5Q2mS4mRTBLBU136P687GkVMoWY2z
         J7kFxwviMe0uGMtVow3IgpPv4vPOsdX4KZWZbtdLn2uaxTC5Ogo/mvMaOAjmNa+fMweb
         y7HuBE0LIhNtsRMLl8ENZtQlaupCvWzo+mV2IKdmThKFuzVdXOIuaVdMrnYMRQvzah3M
         aBTvMaMn5nGRrmqlrHEvv5OSlf+CrjzDX+xXfsnreX4SH2qGEOkIezkEvL50q9H5Po6z
         a4PbOSODE/LkIr7JBhW5B+86ZGPsOeyOuyhy22rFj2MTR6w3z20QjWyn7OOjcQLmMBg8
         REkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQcPxfSwbKHal4eWi9/k1XS4dY35WSsLnXPxD3MpobU=;
        b=Z5gN9Zr2if+GScMMzYy0xzQfKXLl95CtICshvLiiwcRqmDhZZ84u+WJZ9+OFuMWEXM
         UlSxYRiJS/oyxqdCJAMKqmEgyvky5UTyqN1tADn2bsXjcYqEYQ0z1BPyzyiO5zOULS7I
         ZAvvY1YW9Aqvsy5/9IXMTeE6glnx1H1WSlcm9I4T+GAIZcRfAglmX0UF8DcrHM6mwzbE
         wp9f6f0uTULDJPVETaK2D9gmd7mIixEhRW+4SVoEgy9pFJcwYiOP3HQGzlr/7ki04zsG
         W1OWL2WeCOTNOr0W0TwC3zGzAGtESAo7K254EB2GEybfF18iTWAqDdhIgPf0igXuK4GM
         TKGw==
X-Gm-Message-State: AA+aEWZxhItN75bRfENnDd9LBWOvh2B4BOFrKmL2e3NpPnhudCPVQNm8
        Lm452A47g5ZPUrap0dXV6jLGNJeF9uZGfhA7YRs9ds/9DzH2kA==
X-Google-Smtp-Source: AFSGD/XiwJGaiKByr8OTBdwiBgw1TNuFRBMqiz3NETNZjlIQQcbdQvO6wAH9FZ/4kat3ZhktbLlHDDgtyooDQHiPL/c=
X-Received: by 2002:aca:ad14:: with SMTP id w20mr30453747oie.3.1546514265488;
 Thu, 03 Jan 2019 03:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20181212081712.32347-1-mic@digikod.net> <20181212081712.32347-4-mic@digikod.net>
 <CAG48ez3SAW8EyaJ9T1U3qPoRhYwe4CCyL9bAxuc3GxjrXipi-A@mail.gmail.com> <f13bf750-f418-343c-baa6-9eee6e0f5e19@ssi.gouv.fr>
In-Reply-To: <f13bf750-f418-343c-baa6-9eee6e0f5e19@ssi.gouv.fr>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 3 Jan 2019 12:17:18 +0100
Message-ID: <CAG48ez00CpXOOJPLgpQd_e0gG2KgYb1p8bwssA8FDOugHTxRAA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        zohar@linux.ibm.com, philippe.trebuchet@ssi.gouv.fr,
        shuah@kernel.org, thibaut.sautereau@ssi.gouv.fr,
        vincent.strubel@ssi.gouv.fr, yves-alexis.perez@ssi.gouv.fr,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 3:49 PM Micka=C3=ABl Sala=C3=BCn
<mickael.salaun@ssi.gouv.fr> wrote:
> On 12/12/2018 18:09, Jann Horn wrote:
> > On Wed, Dec 12, 2018 at 9:18 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> Enable to either propagate the mount options from the underlying VFS
> >> mount to prevent execution, or to propagate the file execute permissio=
n.
> >> This may allow a script interpreter to check execution permissions
> >> before reading commands from a file.
> >>
> >> The main goal is to be able to protect the kernel by restricting
> >> arbitrary syscalls that an attacker could perform with a crafted binar=
y
> >> or certain script languages.  It also improves multilevel isolation
> >> by reducing the ability of an attacker to use side channels with
> >> specific code.  These restrictions can natively be enforced for ELF
> >> binaries (with the noexec mount option) but require this kernel
> >> extension to properly handle scripts (e.g., Python, Perl).
> >>
> >> Add a new sysctl kernel.yama.open_mayexec_enforce to control this
> >> behavior.  A following patch adds documentation.
[...]
> >> +{
> >> +       if (!(mask & MAY_OPENEXEC))
> >> +               return 0;
> >> +       /*
> >> +        * Match regular files and directories to make it easier to
> >> +        * modify script interpreters.
> >> +        */
> >> +       if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> >> +               return 0;
> >
> > So files are subject to checks, but loading code from things like
> > sockets is always fine?
>
> As I said in a previous email, these checks do not handle fifo either.
> This is relevant in a threat model targeting persistent attacks (and
> with additional protections/restrictions). We may want to only whitelist
> fifo, but I don't get how a socket is relevant here. Can you please clari=
fy?

I don't think that there's a security problem here. I just think it's
weird to have the extra check when it seems to me like it isn't really
necessary - nobody is going to want to execute a socket or fifo
anyway, right?

> >
> >> +       if ((open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_MOUNT) &&
> >> +                       !(mask & MAY_EXECMOUNT))
> >> +               return -EACCES;
> >> +
> >> +       /*
> >> +        * May prefer acl_permission_check() instead of generic_permis=
sion(),
> >> +        * to not be bypassable with CAP_DAC_READ_SEARCH.
> >> +        */
> >> +       if (open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_FILE)
> >> +               return generic_permission(inode, MAY_EXEC);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D=
 {
> >> +       LSM_HOOK_INIT(inode_permission, yama_inode_permission),
> >>         LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
> >>         LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
> >>         LSM_HOOK_INIT(task_prctl, yama_task_prctl),
> >> @@ -447,6 +489,37 @@ static int yama_dointvec_minmax(struct ctl_table =
*table, int write,
> >>         return proc_dointvec_minmax(&table_copy, write, buffer, lenp, =
ppos);
> >>  }
> >>
> >> +static int yama_dointvec_bitmask_macadmin(struct ctl_table *table, in=
t write,
> >> +                                         void __user *buffer, size_t =
*lenp,
> >> +                                         loff_t *ppos)
> >> +{
> >> +       int error;
> >> +
> >> +       if (write) {
> >> +               struct ctl_table table_copy;
> >> +               int tmp_mayexec_enforce;
> >> +
> >> +               if (!capable(CAP_MAC_ADMIN))
> >> +                       return -EPERM;
> >
> > Don't put capable() checks in sysctls, it doesn't work.
> >
>
> I tested it and the root user can indeed open the file even if the
> process doesn't have CAP_MAC_ADMIN, however writing in the sysctl file
> is denied. Btw there is a similar check in the previous function
> (yama_dointvec_minmax).

It's still wrong. If an attacker without CAP_MAC_ADMIN opens the
sysctl file, then passes the file descriptor to a setcap binary that
has CAP_MAC_ADMIN as stdout/stderr, and the setcap binary writes to
it, then the capable() check is bypassed. (But of course, to open the
sysctl file in the first place, you'd need to be root (uid 0), so the
check doesn't really matter.)
