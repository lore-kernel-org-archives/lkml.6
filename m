Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943BC2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnWJRCM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeLNPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:18:04 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42667 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbeLNPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:18:03 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so4678798ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgR7/zvoTitAcWtzspwpFbA2pChllrGr1cdcJ907dAE=;
        b=MnWJRCM33UxKWjgGBiFsns1d5BvTi7SYsCn0IqH8uwMe0Cn+75+E3UxGPDGMocDXFv
         mrT1YSV8hlaTyFIl7mOtqkQM9RPhzOepRzzyZUTO37EYgGnzq0aEZvcKkwvVFZpgXeiH
         BdmKCob79YpuDItcmlt1nGI0SJrV8RiEUesXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgR7/zvoTitAcWtzspwpFbA2pChllrGr1cdcJ907dAE=;
        b=OYhqcb4haYnPGag5WVungSkDQ9vaUlh/VG6lmZUB/cRIDVxEefBk9d5gfCiPU8bKtH
         UPPS9xWRz9NmJQe73t6OcjayjRtwgdn+1rLmqRy0nOb9ZO8giZEpgqEaYhDDzda9tQ07
         SlKBhCK9ogNgHSTqp3x7jOgWToAKtBYii4d689LmEQtPu0nvqMpKtA8e7QizyLiDhbDT
         nDOocIGUpfT6oYeOu/TTL4JsHvs9AlCRFrKeeq2o4yUsAwLWb532r27UMhTwt1+51JGY
         1yAOtaIcYyNOyXyBTRCtxlB1OosZsU3cLUb66htUqWzXUMAXJWkj/2wGMaHqhR+E8wBB
         Ns8A==
X-Gm-Message-State: AA+aEWbJ2U0IFA2dxtPaTfOnAkU3W0Jp3V/41hAswcMFoiwoPzZCes58
        OXkz18N7mFqjpWaPHi4FLn1ZWiCFKhRbVKc53topcQ==
X-Google-Smtp-Source: AFSGD/UYB3cWP8A4ZYEZ2iB+GlZvbUS8ucudzax9zn/rBltk6gWoeGoBrX2SzRYN+OKg6YYIAsjcx5vX6bxqEIg88TU=
X-Received: by 2002:a6b:4106:: with SMTP id n6mr2794140ioa.171.1544800682682;
 Fri, 14 Dec 2018 07:18:02 -0800 (PST)
MIME-Version: 1.0
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 14 Dec 2018 20:47:51 +0530
Message-ID: <CALxhOngxbsYFSbK1Y0okuiTmjWEQ8Zcd4vQ0OezhXBgXH82DtA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] alpha: system call table generation support
To:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

On Tue, 13 Nov 2018 at 15:02, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>
> I have done the same support for work for ia64, m68k,
> microblaze, mips, parisc, powerpc, sh, sparc and xtensa.
> Below mentioned git repository contains more details
> about the workflow.
>
> https://github.com/frzkhn/system_call_table_generator/
>
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>
> changes since v2:
>  - changed from generic-y to generated-y in Kbuild.
>  - made changes in syscall.tbl for removing entry -
>    alpha_ni_syscall.
>
> changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall.tbl.
>  - enclosed __NR_sycalls macro with __KERNEL__.
>  - added missing new line.
>
> Firoz Khan (5):
>   alpha: move __IGNORE* entries to non uapi header
>   alpha: remove CONFIG_OSF4_COMPAT flag from syscall table
>   alpha: add __NR_syscalls along with NR_SYSCALLS
>   alpha: add system call table generation support
>   alpha: generate uapi header and syscall table header files

Could someone review this patch series and queue it for 4.21
through alpha tree would be great.

Thanks
Firoz
