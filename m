Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD30D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD30D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeLKRno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:43:44 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:53124 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:43:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 93884608A399;
        Tue, 11 Dec 2018 18:43:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id p-LGstvDYGe6; Tue, 11 Dec 2018 18:43:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F2E7B608A39E;
        Tue, 11 Dec 2018 18:43:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YzVsvNyoUZaA; Tue, 11 Dec 2018 18:43:40 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4931A608A399;
        Tue, 11 Dec 2018 18:43:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>, mingo@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, bp@suse.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size linker flag
Date:   Tue, 11 Dec 2018 18:43:39 +0100
Message-ID: <5480353.C3TqP6Wb6x@blindfold>
In-Reply-To: <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
References: <20181206191231.192355-1-ndesaulniers@google.com> <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org> <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Dezember 2018, 18:39:45 CET schrieb Nick Desaulniers:
> On Tue, Dec 11, 2018 at 5:12 AM tip-bot for ndesaulniers@google.com
> <tipbot@zytor.com> wrote:
> >
> > Commit-ID:  f4313ba52f9caccfda6a55f991c84aba6726b88f
> > Gitweb:     https://git.kernel.org/tip/f4313ba52f9caccfda6a55f991c84aba6726b88f
> > Author:     ndesaulniers@google.com <ndesaulniers@google.com>
> > AuthorDate: Mon, 10 Dec 2018 14:27:16 -0800
> > Committer:  Borislav Petkov <bp@suse.de>
> > CommitDate: Tue, 11 Dec 2018 13:58:57 +0100
> >
> > x86/um/vdso: Drop implicit common-page-size linker flag
> >
> > GNU linker's -z common-page-size's default value is based on the target
> > architecture. arch/x86/um/vdso/Makefile sets it to the architecture
> > default, which is implicit and redundant. Drop it so that one more LLVM
> > build issue gets addressed.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Acked-by: Richard Weinberger <richard@nod.at>
> 
> I missed Richard's ACK.  Did it occur off list?  I just want to
> confirm there's nothing wrong with my email client.  Thank you for
> taking the patch either way.

https://lore.kernel.org/lkml/1633144.08IGjMOzBB@blindfold/

Maybe google started to hate my mailserver (again).

Thanks,
//richard


