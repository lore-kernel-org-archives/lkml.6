Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14762208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N78nMXqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14762208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbeKTRdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:33:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33163 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbeKTRdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:33:31 -0500
Received: by mail-it1-f195.google.com with SMTP id p11-v6so9302070itf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njRB5YrwvPAuwvTzkXx47jt5XkZKXLf9VfbAmPMwazI=;
        b=N78nMXqxaaWx2NWIvnHMx1rZilyaymSwztLimGi4M6MooVrmnLfqJi7piOFUmbwUC8
         dKYM2sxqAUY39u9tG3RqxtN/af+tDiL3vosSCyaV0JMkIR86RqF/e2NkJ6WVJtXDbA0m
         eXbnrCw3wnKJKRdiz8FjSrz36OEH6W4vYKnRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njRB5YrwvPAuwvTzkXx47jt5XkZKXLf9VfbAmPMwazI=;
        b=bMmqxyH02cNahPXYBlhM8KgnQssz4L4EEevPJ+7idmbqQvq7yePSVSg6XRFcdQCROG
         hvKNihxnqmd9YTrlVSJLn6fQ/wNJ7N8PVTnxIzeDb5BcBTx9up5b2nJ1jaHvWJv206kV
         4x3fHgqFp/jrX1toPsjT1j1f2dR+dVasFuf9I7+LxNh2GHuHx5f/0GyOIuYz631J7dAD
         ljzHAITOy1hVri1O2n6UjRScOH1hG2YqqgDxjIxGtgG0OmR0ClmSd+q5qPYuP94FHE5D
         D4xM4lhXsYo/TA4X3mviiavZ7DjgZyvvO0oNXEfNcT5m0MAYm+z8ZuLKPAWM87qDZVpm
         80ng==
X-Gm-Message-State: AGRZ1gLZbCENLpSGz1UZEe0xH/lpbfcU/WFOiOdmT0QIb9Mk8QwZd7Hj
        SfLcJBmmYrEU2cmDm8HsZfRQKeYwdlABUY3CmJKQwA==
X-Google-Smtp-Source: AJdET5dXssYdO+oCy0jYnG/h7GXQXE8y3r57R0HN5Dlzdxure/7Fm2FAqilzCkaU1CXrjh6NVEIbMteiKURol1dk6so=
X-Received: by 2002:a02:788:: with SMTP id f130-v6mr807025jaf.58.1542697556148;
 Mon, 19 Nov 2018 23:05:56 -0800 (PST)
MIME-Version: 1.0
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
 <1542169930-24118-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a3fFznLDZTs0eLa_dJCKdENC96w1MoC1pNM6gYwcb=Cow@mail.gmail.com>
In-Reply-To: <CAK8P3a3fFznLDZTs0eLa_dJCKdENC96w1MoC1pNM6gYwcb=Cow@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 20 Nov 2018 12:35:44 +0530
Message-ID: <CALxhOng+PHszhOWiBr3BXzy+PFrkrMteyk8A7J74ZUdGf24aww@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sh: add __NR_syscalls along with NR_syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 19 Nov 2018 at 22:21, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Nov 14, 2018 at 5:32 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > NR_syscalls macro holds the number of system call exist
> > in sh architecture. We have to change the value of NR-
> > _syscalls, if we add or delete a system call.
> >
> > One of the patch in this patch series has a script which
> > will generate a uapi header based on syscall.tbl file.
> > The syscall.tbl file contains the total number of system
> > calls information. So we have two option to update NR_sy-
> > scalls value.
> >
> > 1. Update NR_syscalls in asm/unistd.h manually by count-
> >    ing the no.of system calls. No need to update NR_sys-
> >    calls until we either add a new system call or delete
> >    existing system call.
> >
> > 2. We can keep this feature it above mentioned script,
> >    that will count the number of syscalls and keep it in
> >    a generated file. In this case we don't need to expli-
> >    citly update NR_syscalls in asm/unistd.h file.
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd_32/64.h
> > along with NR_syscalls which is moved to asm/unistd.h.
> > The macro __NR_syscalls also added for making the name
> > convention same across all architecture. While __NR_sys-
> > calls isn't strictly part of the uapi, having it as part
> > of the generated header to simplifies the implementation.
> > We also need to enclose this macro with #ifdef __KERNEL__
> > to avoid side effects.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Looks correct to me, but since there are only three references to
> 'NR_syscalls' in arch/sh, I wonder if we should just replace it with
> __NR_syscalls in the same patch.

This is the approach I had initially, But someone pointed out that doing
this way - #define NR_syscalls    __NR_syscalls would be better. The
only difference is here the number of occurrence 3 and there 5-7
occurrence of NR_syscalls.

Thanks
Firoz

>
>        Arnd
