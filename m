Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36447ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1B7214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1B7214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIYDKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:10:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41594 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeIYDKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:10:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15-v6so4962815qtp.8;
        Mon, 24 Sep 2018 14:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFsIRsWNjlCfL0bq6/GHOfhJrfdLppGlvx5hOIDhj28=;
        b=V5o6Co2AHC/mM6n371SpNrb3SADYWhl7JBBcjc8CvtGQxAuW7kIuKoiKqRdzH3Osas
         nA4CHLL7bO/J7Bc59CxoPW+8gvmB7k6LxlRAiO4hGqqcrZt97ne4xhlj27sJ+PcffcBT
         yWb4jL4UQpNsJMkZmzfUQ4lodSOroMrbDP+8TpL+aNeDV1NvZga7y1KV73mBWsD8DYyu
         KtmCanI/O9LRgrkqjiWHbZbCpWxnyheAoRUpdNr1j84oBwa/mv79bJSDUyUg/xvfWSIG
         EAMJE/t7X466bM9BnQLzn328wRKfjHbxY7xo3N4VumBw52C9Lhp2XW2xpu+nbHPoslxa
         IJUw==
X-Gm-Message-State: ABuFfoj1+Qmmjudr7vkky7OchVWsjO1DPLYkLZPV+n4XzpA273V3KVpa
        QQ3WM0hU+a5YWD1faBM8aUjTbxIfmKxAWfyaymA=
X-Google-Smtp-Source: ACcGV62y0tbDlIP255cllvvVWP6dXK896AiQZgP9k0U0uV6kJe5sWEps5wZeZMzvQhl/7hE3Q9w9GP/mlw/4O8H3pGc=
X-Received: by 2002:a0c:f642:: with SMTP id s2-v6mr526207qvm.115.1537823201514;
 Mon, 24 Sep 2018 14:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
 <CALxhOngCL4DEcMD7NaxbUiksByzoxaaozzZGPmB0JFziFEWojw@mail.gmail.com>
In-Reply-To: <CALxhOngCL4DEcMD7NaxbUiksByzoxaaozzZGPmB0JFziFEWojw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 23:06:25 +0200
Message-ID: <CAK8P3a0_omFwid2NZzs_T=A_TY9ddfGOsVKV2vtiaVodWswbmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 1:53 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> On 6 September 2018 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> >> +++ b/arch/sparc/include/uapi/asm/unistd.h
> >> @@ -15,12 +15,6 @@
> >>  #ifndef _UAPI_SPARC_UNISTD_H
> >>  #define _UAPI_SPARC_UNISTD_H
> >>
> >> -#ifndef __32bit_syscall_numbers__
> >> -#ifndef __arch64__
> >> -#define __32bit_syscall_numbers__
> >> -#endif
> >> -#endif
> >
> > This is certainly required in the uapi header as of this patch,
> > without it all the numbers are wrong when you include the
> > file from user space.
> >
> > I suppose it can be removed later once the header is replaced
> > with the two generated versions,
>
> The script will generate 2 versions, ie, unistd_32.h and unistd_64.h.
> Please give few more pointer here.

You still need to check at least for __arch64__ in asm/unistd.h in order
to pick which header to include, right? Since the
__32bit_syscall_numbers__ check was already in the public header
file, it may also be possible that there is some user space application
that sets this in order to get the 32-bit definitions. This might e.g.
be needed for strace.

     Arnd
