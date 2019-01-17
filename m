Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E55C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4913520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odqiWu2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfAQRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:43:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35191 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfAQRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:43:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so8464454lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPK3vpUMsa41+yGP3TZAcnaVmjICNGsm5A82VYsal8k=;
        b=odqiWu2XPvyQ1HQzXKrPOVYPd4XAJpD4kqAUDSGhyldYzvfX+00KualOUDg1acdJAG
         4A2inNnT9K0Lq+SvozS4Oo1nuoCvMZR2GZv6SgWTFl2hLFujxvvyX9Wkx3RN1cHJpd+v
         JBKTLAYGc0yDD4/0MrJHgPVTSrim01ax2Q+Co8DtSG1pTBAu5D7YYJmY3aGG2/o5bOEp
         roi8obZLsYt3JD3PkFft1gkmeaV1/KdLzzw3W9PKAmY39o+vcbCw9qncep8KzNhJsKLD
         +BSLFGUxADJMIEHIxbPExQEI1by7ypyiiTb0wB4pvfa8AoBxIw0NIQ3KZJ0zIFpCcJ8p
         peBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPK3vpUMsa41+yGP3TZAcnaVmjICNGsm5A82VYsal8k=;
        b=L2Lwc6eLYnVvJzQU68tL2K/9/uDiUaF7WoF2SYO5aJGvHzfzp2B4NZwE1J8aRAiKIJ
         Lu0nL9CWVvmEy+SssZeePiH9RDf5hh1QXMHlxPjI99z1UnBl7dEWhQGFQSF03la1Tbu2
         QVso9vhHvSnWNRl/jSWPsDFGHyQCrUGJ52r8bahb43wr73peCn2Tg7dzVqufItxdBdt0
         9zK7rjLMAViLXIx/4x5b6gW405593lDahO0Tfl7f1zwLbCkrmzzNk6ZdsDQ75wbgmMQg
         HLlryX6e88hJ+XSDAuBtc9VNTo0EQHi1TVHrMX1YTuMino3rpQ10cG7MN6mIELfcXIxH
         549w==
X-Gm-Message-State: AJcUuke8hLyZeeYaKUpmvKPRex56UZvanpouaa7idMtCLHGx8Dv1aWGQ
        NbacL0yQDr6nMyF3Wv7eP6tWrUA9IikY/UMEeGE=
X-Google-Smtp-Source: ALg8bN4O4+46Yqxa1wZM6HnuSfhAGcKP6UY6DguBT/Qu1QdMPVFO7HFZqo1wwGV9WrGGsa1RzSFVsUiUS2P1nIVI9Io=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr10430027lfg.24.1547746993042;
 Thu, 17 Jan 2019 09:43:13 -0800 (PST)
MIME-Version: 1.0
References: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
In-Reply-To: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 17 Jan 2019 23:17:09 +0530
Message-ID: <CAFqt6zZPXcX+Qk_CMNaBhs9=dTJuzv4nQzoj09xWLbMuT6NvDQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/cell: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:49 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/syscalls.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/powerpc/platforms/cell/spu_syscalls.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> index 263413a..b95d6af 100644
> --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> @@ -26,7 +26,6 @@
>  #include <linux/syscalls.h>
>  #include <linux/rcupdate.h>
>  #include <linux/binfmts.h>
> -#include <linux/syscalls.h>
>
>  #include <asm/spu.h>
>
> --
> 2.7.4
>
