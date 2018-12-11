Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7922084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7922084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeLKMqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:46:52 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48878 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeLKMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:46:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0F812608A38A;
        Tue, 11 Dec 2018 13:46:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q0tmx8Q_ommH; Tue, 11 Dec 2018 13:46:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B4DD2608A38C;
        Tue, 11 Dec 2018 13:46:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cu7OYQQD2KB9; Tue, 11 Dec 2018 13:46:49 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 35987608A38A;
        Tue, 11 Dec 2018 13:46:49 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     ndesaulniers@google.com
Cc:     jdike@addtoit.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/um/vdso: Drop implicit common-page-size linker flag
Date:   Tue, 11 Dec 2018 13:46:48 +0100
Message-ID: <1633144.08IGjMOzBB@blindfold>
In-Reply-To: <20181210222718.19926-1-ndesaulniers@google.com>
References: <20181210222718.19926-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Dezember 2018, 23:27:16 CET schrieb ndesaulniers@google.com:
> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/x86/entry/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
> 
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/um/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index 822ccdba93ad..bf94060fc06f 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -26,7 +26,7 @@ targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
>  CPPFLAGS_vdso.lds += -P -C
>  
>  VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> -       -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> +       -Wl,-z,max-page-size=4096

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


