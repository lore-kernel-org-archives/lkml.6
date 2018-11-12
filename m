Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4282C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5B208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsVqv87D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B5B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbeKLMwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:52:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeKLMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:52:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id b13so7614506wrx.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 19:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L3kQxmTjk6MTKkX1IlspIEH2m0wUz6jvpIqfoir3s/M=;
        b=EsVqv87DO1yLpbZKf24AfI6aZwswyBibHj2+7AVj3zSWvH3Ysuz8NxsoxhD/8tuUeW
         PkB9GK5yJWETg8Nww20f9qp0nw4QZGQsdvqMSOK+KRPO/eNYLjxccpbejwoREEah9BAb
         OBfw2QyD8RdxqR8COib/vjl6skeh2uBwLq1SkHWd0LW2Xjy8AaqnkOLaYDBxRV6yXl2A
         hwUfUB0DPGYF4g6ZNATI/07m/kEwPW1dGWcxGFYB38vx7suoO378vL0q2BTMF9kkYKKs
         dELtp0VZWhL2PoYICbGkgBPQkeoKOLvl135UCb6PAS0rvj8gzWQ+OsO9AEg9Lj9mLThc
         FAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3kQxmTjk6MTKkX1IlspIEH2m0wUz6jvpIqfoir3s/M=;
        b=unLDAGIUXmlTm1rQ774vmCwLWWWkElV+1NzwQlpVMQ0K7w+218QxM75N5HLIAe9ejn
         Ikn1LepMU1HFXbOzo8MXJbv7PY5k6o+ty/U6BYwl8ACXmrvgUTN4DxBuuphP/3isB9tE
         BhvfFibme5qL4CP8jCMBwZhGeLDoTgnL+nvfm50KmQlpz55zc07SxmKnKRS9Mazx2M3E
         2I62QUWRRp1K0xNC+9guGF9iTxox+Cs/tZ78LOxqbEF+QNybxjBeuka39zOg6nyGAuMb
         xBuJ3b0n+gzONUnusCIln4G41AzpY7X0a4iju/7mdBbbtWTp4GPtbTwi6QPe/5zYBeP/
         lh9A==
X-Gm-Message-State: AGRZ1gI6uh9gFaWMHKx8N0IAlutcn77mPHlTwoU1xvZf2GJ/niC2XMdq
        9tKEdpXyZmxJyWSRZP66Ohc=
X-Google-Smtp-Source: AJdET5dGTfhXafaxyeMGnVIsWWNWFNko16IRBA/4D/NtegVWG4sjScnVlw9ZyMDj/tBU9vYWwFEe7g==
X-Received: by 2002:adf:c90e:: with SMTP id m14-v6mr15869007wrh.6.1541991697649;
        Sun, 11 Nov 2018 19:01:37 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v10-v6sm24139995wrq.4.2018.11.11.19.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 19:01:36 -0800 (PST)
Date:   Mon, 12 Nov 2018 04:01:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Richard Weinberger <richard@sigma-star.at>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] x86, powerpc: remove -funit-at-a-time compiler
 option entirely
Message-ID: <20181112030134.GA39035@gmail.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> GCC 4.6 manual says:
> 
> -funit-at-a-time
>   This option is left for compatibility reasons. -funit-at-a-time has
>   no effect, while -fno-unit-at-a-time implies -fno-toplevel-reorder
>   and -fno-section-anchors.
>   Enabled by default.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/powerpc/Makefile | 4 ----
>  arch/x86/Makefile     | 4 ----
>  arch/x86/Makefile.um  | 5 -----
>  3 files changed, 13 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 88398fd..3508049 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -130,10 +130,6 @@ else
>  
>          KBUILD_CFLAGS += -mno-red-zone
>          KBUILD_CFLAGS += -mcmodel=kernel
> -
> -        # -funit-at-a-time shrinks the kernel .text considerably
> -        # unfortunately it makes reading oopses harder.
> -        KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
>  endif
>  
>  ifdef CONFIG_X86_X32
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index 577976b..1db7913 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -26,9 +26,6 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
>  # an unresolved reference.
>  cflags-y += -ffreestanding
>  
> -# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> -KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> -
>  KBUILD_CFLAGS += $(cflags-y)
>  
>  else
> @@ -50,6 +47,4 @@ ELF_FORMAT := elf64-x86-64
>  LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
>  LINK-y += -m64
>  
> -# Do unit-at-a-time unconditionally on x86_64, following the host
> -KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
>  endif

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
