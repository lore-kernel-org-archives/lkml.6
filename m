Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6803C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925AE217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHmfth3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbeLQJnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:43:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44311 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:43:42 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so9469494iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/Kd8y/P0hk6ES3J3FR7RngN1V+s6c2Jn0+hOSRipyw=;
        b=GHmfth3yJzP79N51mTgBjb8upAGBi4v4XpsuzYbaS16cKQ1XhcPTRWgXchvhLX3i/w
         B/uNoUPj/dmKJxQ3A9zm4rF90Xc258Z+CjaJQUENhy7GX2pUXHINwweVvCSFDek/Pgy2
         doZc2T4vyh+7CwxC8F6j3+gbNpbL6oErcQM8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/Kd8y/P0hk6ES3J3FR7RngN1V+s6c2Jn0+hOSRipyw=;
        b=jqelmD+3XxJ4I0mYS2PGH2X+CIwMb8iIMiarYgMF5t3i9uBPXQ/p8tnH9Y0i3KCj1m
         8ph2dAyu+ht5/azkRbRs0n5EN+TNideQppwUBoRYmzdSrvi4u2X3opst3IjwR7JKp03H
         pe6KkS+LYZCQTuBwErpHDOh89gXp0tWeQh5kDVDUTTnME+22Z4tPiX2QbApk0sE17vre
         nNT8WWbwLPYjTgGegZFQ3PrAPbihboJ6ljSxqZVat2/v3Qe4KUQplpeGMejOOqXicFxi
         eY6QXbusCvgQvu5dRAZqp8nddLQn8oCU60aQRFORP5irFVgvUqJNmgNnR5sxbNHh1+yG
         rROA==
X-Gm-Message-State: AA+aEWZ8GL8LW5+YTkxc4a7OHHDB1m1PCmDYZZEUED+Ge3MbfOztJYEP
        uINjxxGJYhtNmNmIeSqvnd6WzusZnierM6MK+X6l8w==
X-Google-Smtp-Source: AFSGD/V9FQF+4pFGe7RsjlDHf0Q4kByV2n59iXUUZ+3t+8va8u5qOA56qf9fQgD09x0uaRBGHZDe3RnvoQ1kqRo7L9Q=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr10157073ioc.119.1545039821297;
 Mon, 17 Dec 2018 01:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org> <20181217080846.GA28424@sathnaga86.in.ibm.com>
In-Reply-To: <20181217080846.GA28424@sathnaga86.in.ibm.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 17 Dec 2018 15:13:30 +0530
Message-ID: <CALxhOni8Gynxp-NgcuZk41Qx1GT_pAEQ0tjX2z2q2pJPd49o6A@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satheesh,

On Mon, 17 Dec 2018 at 13:39, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> Hi Firoz,
>
> On Thu, Dec 13, 2018 at 02:32:45PM +0530, Firoz Khan wrote:
> Tried to apply on linus "master" and linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "merge" branch,
> both failed to apply series.
>
> # git am mbox
> Applying: powerpc: add __NR_syscalls along with NR_syscalls
> Applying: powerpc: move macro definition from asm/systbl.h
> Applying: powerpc: add system call table generation support
> Applying: powerpc: split compat syscall table out from native table
> Applying: powerpc: generate uapi header and system call table files
> error: patch failed: arch/powerpc/include/uapi/asm/Kbuild:1
> error: arch/powerpc/include/uapi/asm/Kbuild: patch does not apply
> Patch failed at 0005 powerpc: generate uapi header and system call table files
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Then, tried with linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "next" branch,
> patch got applied, compiled with ppc64le_defconfig and booted on IBM Power8 box.
>
> # uname -r
> 4.20.0-rc2-gdd2690d2c
>
> Looks like patch series needs a rebase against the latest kernel versions.

Thanks for the update.
Sure, I'll update the patch series and post asap.

Firoz
