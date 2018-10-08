Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA5AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF062084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF062084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJHQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:22:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35163 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJHQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:22:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id v68-v6so4578385qka.2;
        Mon, 08 Oct 2018 02:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmNGKcKh1FjNeMuSMDd30+6+g6ppmJ8fMJVBFxYD+44=;
        b=K7WhP0itHiQtAO2YbuVwvulMGjSH3TIOYhCUoYlr661w0HbvPsehz+PUHcPZZHUBBJ
         169SV1APlGn+aWXIn//lllxYpRcRdXoqaXocure7Er1QadYUZDFYeb1JnEWpA+WdZGsD
         tDivMRvvoXfHOWDk/Tm8cxJqOHGeRt313FZE1BeSI3KD2VU+4XryWbGeGTVVSTsI8nYG
         YC5KfGPC4jIhkrxL74eI3HqbM+KRPLcY7kXiX0W0clCDzzmKOAKu5ZfaGoBw37aGI94H
         cfmbdrPkBNSe8CwNaqKJ2aa5/XQnR1PO76BfBe4q5XExn+bLeQcIhT8MqiDLSASWyyza
         DDRg==
X-Gm-Message-State: ABuFfoh8ECi9l1PY3nIpmshdo/shoitcMnY12mx2ge/Vu+QuCAQQsRG8
        0GnbOGrw7NlWz0qHOEalTZRkrO5uyVpGJw4ZNDI=
X-Google-Smtp-Source: ACcGV60LQaQRV03hHVVBeThEO585EbT9BnYuXNnmPXpZWi6WH1fjNeqwH387TkW2XR7IYrKDcbTO5w5DdV19EFFysdc=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr18080478qkc.291.1538989921707;
 Mon, 08 Oct 2018 02:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
 <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
 <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com> <CAMuHMdWPx_ZRt-60K9_4oaX0pGESb8WUE6t73Y5DAUF-t=Z5EQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWPx_ZRt-60K9_4oaX0pGESb8WUE6t73Y5DAUF-t=Z5EQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Oct 2018 11:11:44 +0200
Message-ID: <CAK8P3a2GpVjg+re19V5wkJe9MCfox7Dgr6Q54KcP+WQMC5Y2Qw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Firoz Khan <firoz.khan@linaro.org>, Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
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

On Mon, Oct 8, 2018 at 10:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Oct 8, 2018 at 10:55 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Mon, 8 Oct 2018 at 13:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > If the warning is due to a not-yet-implemented feature, IMHO it should not be
> > > silenced, as that would give the false impression that the feature is
> > > present and
> > > implemented.
> >
> > Helge had done some implementation for rseq but not tested. So we
> > either add an IGNORE
> > entry or leave the warning as it is.
>
> Personally, I prefer keeping the warning, for the above reason.

Agreed, there is no need to patch this now if Helge is already working
on the correct fix. Same for the other architectures. If there are architectures
that have multiple missing syscalls, we could add a line with a comment
for rseq but not actually define it, like

 348     common  pwritev2                     sys_pwritev2
       compat_sys_pwritev2
 349     common  statx                           sys_statx
+350    common  io_pgetevents            sys_io_pgetevents
  compat_sys_io_pgetevents
+# rseq requires an arch specific implementation
+# 351    common  rseq                          sys_rseq
         compat_sys_rseq */
+352     common  open_tree                 sys_open_tree
+353     common  move_mount             sys_move_mount
+354     common  fsopen                       sys_fsopen

      Arnd
