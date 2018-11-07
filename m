Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D9E20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tf63N5w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D9E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeKHEBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:01:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33358 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbeKHEBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:01:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id q1so15724352otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qir1mi0hHMJAP7Lw3MalCFm49tn0u4t4BKJWHobqbRU=;
        b=tf63N5w6VuBPxQ5zlL67xSUas37DgpssM1ymwWH8FHvyqVEyDKUi07Bl/GuhLFwUgg
         GVUpy8VcxftGvoxCFgW79pwkbwNDdeAiVqnaaXrwjHCOksE2K86wrnJX5D3Ho3ltSDmC
         4/HMLfwUBlYzWBbdYcWV4yxcYny40OA9FQjJHK5SBFoWI9EjM8Li/Hjt+2tY1uqaLtZE
         29SGGSWyk1INmti7hgzlczMdLs7oOFsLUWKr48fFSIsE8eb5k8H14CEQAmjXJLPc9rJC
         gPzGZ+sD1ZwLz9o/3kzIHZSyXXuwID0jCt0pGLprucdiJKuQz+2g7cHulGjKtYSflwOt
         Tqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qir1mi0hHMJAP7Lw3MalCFm49tn0u4t4BKJWHobqbRU=;
        b=cS59w1r8qMOAULSfPPoV3WFbpQ33dP2K5XCkqprM+zVxy2cgFu1CRj7GtbpCEyrAv6
         qC6i52rqGDzm86OuwiCsP5GHqqlWsMIKVYPmGYY2sYZWHcUcGz95yoiZRwz+MWP/YYV5
         St2FnnmYb2btG0GADCDZ5xMlOPVpGrHeeslTjqO4moyL506L4X/Z6ZT0v7tVp01k3GNT
         HVWWD8yt84wZOf+3nlsmYESAkobWncrxim3A1rlMPN5ZqIx72SUDorCuN6LMH6Hr24OQ
         vmMuH1RhmgxOUsRG+ya5EBBScd9yZSpNmAaCgIW4L2K7A3Ylh6krzuAt4X8JVtkksVaj
         xZ0A==
X-Gm-Message-State: AGRZ1gKCHvocn67nwssLgydgwYQ+erma9LZWBPfUfXRn6EjZ2EoU67gs
        +CErYmnvxk9oQEC8uEcNdELNX+08prrSDZUNajw=
X-Google-Smtp-Source: AJdET5eyLcDef4rT5eB0yX0yy1wcNuyPIlm5Dz/87B7r7PWdjK9fjnAsG61hBTBHGfmuU3wpInEFiLAOJI/sDeDB0OU=
X-Received: by 2002:a9d:2ea9:: with SMTP id w38mr756772ota.99.1541615415219;
 Wed, 07 Nov 2018 10:30:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a3JcztCSYBuu5ZJXaV83VNLv_1v3v-EKMR+tC1oOsQesw@mail.gmail.com>
 <mhng-3c26b2fb-0c11-42f2-9026-1113b200a7b2@palmer-si-x1c4>
In-Reply-To: <mhng-3c26b2fb-0c11-42f2-9026-1113b200a7b2@palmer-si-x1c4>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Wed, 7 Nov 2018 19:30:03 +0100
Message-ID: <CAEn-LTpQ5uTte2bBrEs3uLKtsckkKPUOP+jHw5k-DFAwGCS3WA@mail.gmail.com>
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:08 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
> > On 11/5/18, David Abdurachmanov <david.abdurachmanov@gmail.com> wrote:
> >> Marcin Juszkiewicz reported issues while generating syscall table for riscv
> >> using 4.20-rc1. The patch refactors our unistd.h files to match some other
> >> architectures.
> >>
> >> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT
> >> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
> >> - Adjust kernel asm/unistd.h
> >>
> >> So now asm/unistd.h UAPI header should show all syscalls for riscv.
> >>
> >> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
> >> generated asm/unistd.h UAPI header thus user didn't see:
> >>
> >> - __NR_riscv_flush_icache
> >> - __NR_newfstatat
> >> - __NR_fstat
> >>
> >> which are supported by riscv kernel.
> >>
> >> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >
> > Thanks for addressing this, your patch correctly fixes riscv64, and
> > I should have noticed the mistake when I originally merged the
> > broken patch.
> >
> > However, looking closer I found another problem with the original
> > patch that your fix does not address:
> >
> > __ARCH_WANT_NEW_STAT should only be set on 64-bit
> > architectures.
> >
> > For a 32-bit architecture, we only want __ARCH_WANT_STAT64 if
> > any. For 64-bit architectures with compat mode, we still need to
> > set __ARCH_WANT_STAT64 from the non-uapi file so we get
> > the syscall implementation.
> >
> > If we don't care about the riscv32 ABI changing yet, we can
> > decide to leave out __ARCH_WANT_STAT64 here, and require
> > glibc to implement it using statx() like any new architecture.
> > stat64 is not y2038 safe, and statx replaces it because of that.
>
> Thanks for pointing this out.   A while ago we decided the rv32 ABI was
> "slushy": it can change if it has a good reason to.  Right now the only planned
> changes are the y2038 changes, which I consider this a part of.  For some
> reason I thought we'd already done this, but since we haven't then I think it
> should go in sooner rather than later -- that will help the glibc guys get
> everything lined up.
>
> The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.
> That's progressing well, with one last blocking issue related to some of our
> floating-point emulation routines before we can submit the port.  This should
> give us ample time to line up the ABIs correctly so everything works.
>
> So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.
>

Then if you agree I could do and send v2:

+#ifdef __LP64__
+#define __ARCH_WANT_NEW_STAT
+#endif /* __LP64__ */

Cannot use CONFIG_64BIT as in user space nothing defines it.
Alternatively I could
check for __riscv_xlen == 64.

I found _LP64 and __LP64__ being used in kernel, incl. include/uapi/linux/rseq.h

david
