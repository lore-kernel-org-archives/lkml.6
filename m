Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA00C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB57D20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpIYtGmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB57D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbeG0X5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:57:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34791 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbeG0X5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:57:19 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so11739276ois.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mn/STYWo5cyHfiNV7ZgAvo/Pn8J0sWwTzWclIs1kjdo=;
        b=VpIYtGmZ0OIQDOYNOgiECMHtrzb54FZYE5+D5ugs2cC5Lkmh6p6Eud/b+2qXQHnVVT
         JGc9Pws7Q548IWKhI8ivvB2Wdzlh4tz11lg03pstuOh3ED8/YXw06kcv4JCv3RtBfUSO
         v17c7Zt9RvzoUoPgjDdJ66Fq1g9R2k+s1Ygzu9ilfOpwyD/D25YaczYzM1mbPPCYRT19
         7iq5fRDoiRt1JruV23Zjz/WXosvI5kJ5m3s4zlbLOB6Qj1kfarJoU6wpbh7dL/Bx+QxD
         NvdaQmvdTQd5IpwDzZ/vBzAo40AX9DonLQV0AuWKgw3U2qIB1cDsFZhiZ1aIvx3nBUPG
         bmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mn/STYWo5cyHfiNV7ZgAvo/Pn8J0sWwTzWclIs1kjdo=;
        b=qAVA5uFQVTIk7uTD7IkTH8Hr1KsvyUZIGUtpbJjwN+XpUpKmezRfdWOrN5ZPL3GrxQ
         EDUcPsEb3g6YdJlhzKTDN2hcJ2q9r84b6BvpidWFQegppNRZ43nPVNYFEupuO00zt5hV
         0m6kBVuorcdrdvm4RE5+FcnBf59yA1hjxe8y/h8VTRiBO+JuAiC7FG1LNh26QudxloqL
         GDPXiH3QFoKSTA70pK7sVA57D6xiY2NbIY/zeK66+26C/wmGZ1e5X4MekTZGWbKvFNVq
         QzRDnWreNvH0tVQ03kOlN44gDgWnSVy5uaGSe+hikz0cYxPz3vtyABJpvYaaCqNwoEqX
         uMxA==
X-Gm-Message-State: AOUpUlF0ToTSS40RvXg15iK1daVOVVxuprybMd0wzzQav6GXIbdtVauY
        dTivOFviGCSVO2pnoN1E+nFWoh8x6FltfiG1TJEcYQ==
X-Google-Smtp-Source: AAOMgpe5wdAYlFgFy7wz4MU34rRIcbRKM1NCrGkPfUc7CARKYKqSByizL8nhMR6fmfE0wFQqyJKqz59/rfAetNzwtRg=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr7912904oig.221.1532730800385;
 Fri, 27 Jul 2018 15:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 28 Jul 2018 00:32:53 +0200
Message-ID: <CAG48ez2f+J+UeFN0u1Hpfq3tFXJbi7ckts8sua3eY4jDwnh6-Q@mail.gmail.com>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and
 managing a context [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 7:34 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a syscall for configuring a filesystem creation context and triggering
> actions upon it, to be used in conjunction with fsopen, fspick and fsmount.
>
>     long fsconfig(int fs_fd, unsigned int cmd, const char *key,
>                   const void *value, int aux);
>
> Where fs_fd indicates the context, cmd indicates the action to take, key
> indicates the parameter name for parameter-setting actions and, if needed,
> value points to a buffer containing the value and aux can give more
> information for the value.
[...]
> +SYSCALL_DEFINE5(fsconfig,
> +               int, fd,
> +               unsigned int, cmd,
> +               const char __user *, _key,
> +               const void __user *, _value,
> +               int, aux)
> +{
[...]
> +       switch (cmd) {
[...]
> +       case fsconfig_set_binary:
> +               if (!_key || !_value || aux <= 0 || aux > 1024 * 1024)
> +                       return -EINVAL;
> +               break;
[...]
> +       }
> +
> +       f = fdget(fd);
> +       if (!f.file)
> +               return -EBADF;
> +       ret = -EINVAL;
> +       if (f.file->f_op != &fscontext_fops)
> +               goto out_f;

We should probably add an fdget_typed(fd, fops) helper, or something
like that, to file.h at some point... there are probably dozens of
such invocations across the kernel at this point, each one with a
couple lines of boilerplate to deal with the two separate error paths.

[...]
> +       case fsconfig_set_binary:
> +               param.type = fs_value_is_blob;
> +               param.size = aux;
> +               param.blob = memdup_user_nul(_value, aux);
> +               if (IS_ERR(param.blob)) {
> +                       ret = PTR_ERR(param.blob);
> +                       goto out_key;
> +               }
> +               break;

This means that a namespace admin (iow, an unprivileged user) can
allocate 1MB of unswappable kmalloc memory per userspace task, right?
Using userfaultfd or FUSE, you can then stall the task as long as you
want while it has that allocation. Is that problematic, or is that
normal?
