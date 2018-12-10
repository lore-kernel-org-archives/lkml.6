Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BFA20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvAbAhOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BFA20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLJFDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:03:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34292 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeLJFDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:03:03 -0500
Received: by mail-yw1-f68.google.com with SMTP id g75so3471761ywb.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gokXEaayarhxMI6caXM2jwP/JGu2CK/TKpDjM3H/tco=;
        b=LvAbAhOV8bCeoBpUUXP2l+i9cpKf1QSjoxoK3HIz6KAqGW1ybLTd74gICJLXFM+RTY
         QpDpHhe0A+n6nWoKKITa16a52L0/KDMxqWQ6VIigIXLwNYc0SsCTquFq22HKTQ1whoyF
         Itr+7BZxj3Ap9BRkfCsJJYaiDcMs9e5u4dTITn2En+mh/YSLLQuoYevtGtNiYKyvKFBk
         VbBwSRSppu1wdOvl8u5CcFxJpoc5hOwHgqGSKmGhseqZ4oF2fcyFl7d/OWOfVjEBEnRi
         PbdxeQ09WJ4OWe0y9faBkaw2fma/e2qAe40zJNRrI5RZFW64jn5fQZ3uDlBG7YWZ61Z/
         /8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gokXEaayarhxMI6caXM2jwP/JGu2CK/TKpDjM3H/tco=;
        b=bD2AEKp+QsRuBwxSLJHodhaJ8PWxyGFl610K2C0/Uh6pB+Ad4k57A9QvMruYPmG+ev
         ehbvsZikUp+4l64tfwK9PfujDBoT8jAFZKaipaTzXTYhrr6sgiIyUsoP/SoVIbnUawGI
         KxEROBUvLxdPZcXJmdBAtZWI87wefYc8G3TK1KkKRGrKZowEV8AgAItP89+tGCZ4nsTO
         QnXvNPn7rvQV8l+mVZEIkxF9ik0N6gMPnDI/VLESIaXGo3Q7dGe/xny9iU/6augGF0XO
         aCUJhnugLY1Sunn8r+f/ZgQ+dQfzxIhd0IliMHBRmxFgTH18/0MIcpW7RO6ZuF9bEs/Z
         a36A==
X-Gm-Message-State: AA+aEWY/D9DJwFltbj25oUMU889gT9zofIdahFafoV+8pNHcoTDHYXF8
        xbJ2G6hX2mrxTdGoXqUyJQZODavn7fp1l7YDtDY=
X-Google-Smtp-Source: AFSGD/Xstu+AHR7yrBBa552/via6F2gqjfhzHne5087UJllhERAI1ph4XorVNnl8EKAYoPjcV5JRTcOo4lxcCy8o+hw=
X-Received: by 2002:a81:3217:: with SMTP id y23mr10894223ywy.275.1544418182075;
 Sun, 09 Dec 2018 21:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043041.GS6131@altlinux.org>
In-Reply-To: <20181210043041.GS6131@altlinux.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 9 Dec 2018 21:02:50 -0800
Message-ID: <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com>
Subject: Re: [PATCH v5 19/25] xtensa: define syscall_get_* functions
To:     ldv@altlinux.org
Cc:     oleg@redhat.com, Andrew Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, esyr@redhat.com,
        Chris Zankel <chris@zankel.net>,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Dec 9, 2018 at 8:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> syscall_get_* functions are required to be implemented on all
> architectures in order to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request.
>
> This adds all 5 syscall_get_* functions on xtensa as documented
> in asm-generic/syscall.h: syscall_get_nr, syscall_get_arguments,
> syscall_get_error, syscall_get_return_value, and syscall_get_arch.

I have this set of functions plus syscall_set_arguments implemented
for syscall tracing here:
  https://github.com/jcmvbkbc/linux-xtensa/commit/0023f56298cc92ce47e61b1b5dd1038f7be4f826

How should we synchronize our changes?

> diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
> index 3673ff1f1bc5..d529c855a144 100644
> --- a/arch/xtensa/include/asm/syscall.h
> +++ b/arch/xtensa/include/asm/syscall.h

[...]

> +static inline void
> +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> +                     unsigned int i, unsigned int n, unsigned long *args)
> +{
> +       switch (i) {
> +       case 0:
> +               if (!n--)
> +                       break;
> +               *args++ = regs->areg[6];
> +               /* fall through */
> +       case 1:
> +               if (!n--)
> +                       break;
> +               *args++ = regs->areg[3];
> +               /* fall through */
> +       case 2:
> +               if (!n--)
> +                       break;
> +               *args++ = regs->areg[4];
> +               /* fall through */
> +       case 3:
> +               if (!n--)
> +                       break;
> +               *args++ = regs->areg[5];
> +               /* fall through */
> +       case 4:
> +               if (!n--)
> +                       break;
> +               *args++ = regs->areg[8];
> +               /* fall through */
> +       case 5:
> +               if (!n--)
> +                       break;
> +               *args++ = regs->areg[9];
> +               /* fall through */
> +       case 6:
> +               if (!n--)
> +                       break;
> +               /* fall through */
> +       default:
> +               BUG();

A WARN should be enough.

-- 
Thanks.
-- Max
