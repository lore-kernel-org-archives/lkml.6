Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC17CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E28320833
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgrAWgDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E28320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIOX5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 19:57:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39826 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeIOX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 19:57:49 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so6429195itj.4;
        Sat, 15 Sep 2018 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYnMJXlNSwUYe56mqxPdla2xXSdrHBZF2U2HM/EdNU8=;
        b=cgrAWgDGwU4pfuNlU7Zx8xPu/bHSyXiBKgsZ1zhJ6hsl5xGIIoY6whh6+Hwjr9iWy+
         nP2sMwxA9+BWimKtuEKmS9sb/wwIc0TlKgpQuyO47oAZdaIUZGEQuqEt7lQpGSJHsIwR
         VnL+o+YQY596o6eV1tqVBiU1HVfX7b23EuZheAi1nrSE1FPEeRKn2en/hH7CUemIUTo5
         ZsVWWcNQsIl6ZjuNzvFeE9df2ToVm3YAtQr5DyYal2LIAzcDUTlddTgUzlrJsUmFD/ty
         5u0Il2XuMNK6rnj8BgGWYab2zU75f29UYFgICMHkIa0J2cubvX+o5gz31YUcBFfTzTK7
         wrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYnMJXlNSwUYe56mqxPdla2xXSdrHBZF2U2HM/EdNU8=;
        b=Z2f9useXFqC2vvfzCsIZ5+b+ZI4+hHswwHr3d94aEDbuOCPxgKANYbYJC3mWWGXQXy
         UHk9xbSM4tyw+AOUvWxR03Uf3IuBK1JEtjJ+bQc0ulxQUgui4fkW2n5Nw9T9W+1FxaSO
         9aaJ2+BGQPefn1tCRaVF3vOxN75QifGA5ybM31x8V++f4d2sr/HlePi518q3FTRHKaRd
         IEhr94f7cH12ePP04WPjAMR9YZCl4E54HSdXkyEBEKbTy/EbHfV3NP8mxbW51C3qL4yD
         /3zh/oMIlSgLfV43zQFHY+rMpuF1IR6Etz5m8A0FxInSXXN9jrOQskhyiPPKXNn7SqoV
         +Amw==
X-Gm-Message-State: APzg51Cu2vDfMpP7R5qkzu+oJE8L4/mtaoHM3VDORwarYzZFCQL+gvT3
        ZTysLWM7fwijEqG+slgCYoGwc8+kMYtVRi4PfwQ=
X-Google-Smtp-Source: ANB0VdYsTAFeXPkY+OdGuC7n8ULqNmxu+9zPbhZqbd98VwJBqs2ipPblF6J5FGD++QUpIs10fL9kmIUnyHQw9H9UWQ4=
X-Received: by 2002:a02:8c1c:: with SMTP id l28-v6mr15892289jak.22.1537036674033;
 Sat, 15 Sep 2018 11:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180915050843.19183-1-deepa.kernel@gmail.com>
 <20180915050843.19183-5-deepa.kernel@gmail.com> <CAK8P3a2Kkm2ubg_MVN_BJL=s7qpUB1-np=9zVpcJ2U-aPAJswg@mail.gmail.com>
In-Reply-To: <CAK8P3a2Kkm2ubg_MVN_BJL=s7qpUB1-np=9zVpcJ2U-aPAJswg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 15 Sep 2018 11:37:38 -0700
Message-ID: <CABeXuvoOEW9+5BPiDN+2S1boyMSg+csvSAd4ue03TB+yEO6dLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pselect6: use __kernel_timespec
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 8:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Sep 15, 2018 at 7:09 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > +#if defined(CONFIG_64BIT_TIME)
> > +
> > +COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
> > +       compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
> > +       struct __kernel_timespec __user *, tsp, void __user *, sig)
>
> I got a link error here since compat_sys_pselect6_time64 and
> compat_sys_ppoll_time64 are only defined when CONFIG_64BIT_TIME
> is set.
>
> I did not think we would select this symbol on arm64, is that a mistake
> on my side, or should the #ifdef check be removed?

But, this is a compat syscall.
When we introduced this CONFIG_64BIT_TIME we planned to use it for
compat syscalls also is my understanding.

config 64BIT_TIME
         def_bool ARCH_HAS_64BIT_TIME
         help
          This should be selected by all architectures that need to support
           new system calls with a 64-bit time_t. This is relevant on all 32-bit
           architectures, and 64-bit architectures as part of compat syscall
           handling.

This means it should be set on 64 bit architechtures also right?

If we don't have the #ifdef here then we have an entry point from
userspace defined and Thomas had pointed out that it was a security
hole.

-Deepa
