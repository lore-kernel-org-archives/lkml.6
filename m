Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AABC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB720857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bDD0nPd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBB720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeIFOTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:19:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53895 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeIFOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:19:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so10753360wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Kz//PqfDvl07qRLlrVVRifWkrkDSnN6HI1ix02GjM/s=;
        b=bDD0nPd5jP5P55+2no4uyCS9a8ONlSBOoeQqcsLapooYLw3mRxIqJxOHaAmMusX51y
         HZmunw8iPH94t9RmWnnagVm1/b7zCs4FxjUUlNX0Praag/j8oTLqCYB36L8UmTvTelmL
         TOuYgVZPnzEbw31YeaiocKhZY0ZWARmcRRYropmA7ACXCUXAY/CAiuSJbxAg9nVekXjv
         s0YRAeuCWS9NhS3dh6g7Zrr24EPYPO0ilaeu7E++vnwqFnjHDgYQjjZoQ69WabPLHRCa
         K1lHwDo05LMMOkp4/Cz5bd8sbtOpFZdJpWcnN0xXfTEG8LoNC0NGgxjvOfVvxadt7Mo5
         51rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Kz//PqfDvl07qRLlrVVRifWkrkDSnN6HI1ix02GjM/s=;
        b=nQEwRvUr2NfKziMiv2cPnrjkLwulZ0pIFCL6cnf389gQqTSaqU8vPgktaHZUiCQFC2
         QQYPGu5xjlbq0P+Vn+TDMAm/aGzSMtrrszIdhQV4tDiHiVYu4zAWtTLqN+8bSoBKXI3d
         JoF7OnH/eKepKtDavZrzR+XTP5FeJhSjeiGUaIaE7WF0N+MZDCwOJyW+bK6DinLjJIrv
         8Wo82QkQrPcwtove+9lkxi0PsPNRc54vC1FHLjqtUQF7s5NJBeGADpWPZ0dVvlrRnPh7
         ThOiEjL9wxK7Tach3r2AzZkZcYFFOZmaz0Ckjz9JA9avC5NXTpew6Zd/oLVtcsbMks7L
         K8pQ==
X-Gm-Message-State: APzg51CalWZqsuKBiIv0/rJl+BNKYnjIVQhKx8d+MKqrulrollYz6R+J
        per1qI6E10/+h+BV7rRSPmF/T4cA+wEYdw==
X-Google-Smtp-Source: ANB0VdYswfUKppbuLnKk+auy/4KorFg+7pexWpusT3YtTVw3dX8EMlml6hTPxwOjYnTjg+uS74hW/A==
X-Received: by 2002:a1c:9141:: with SMTP id t62-v6mr1706019wmd.69.1536227104431;
        Thu, 06 Sep 2018 02:45:04 -0700 (PDT)
Received: from localhost (smb-adpcdg1-01.hotspot.hub-one.net. [213.174.99.129])
        by smtp.gmail.com with ESMTPSA id d22-v6sm8874763wra.80.2018.09.06.02.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:45:03 -0700 (PDT)
Date:   Thu, 06 Sep 2018 02:45:03 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 18:10:44 PDT (-0700)
Subject:     Re: [PATCH] riscv: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
In-Reply-To: <1535099634-29439-1-git-send-email-yamada.masahiro@socionext.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yamada.masahiro@socionext.com
Message-ID: <mhng-89887f62-7423-4fcf-9df5-f5777e6644db@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 01:33:53 PDT (-0700), yamada.masahiro@socionext.com wrote:
> This becomes much neater in Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/riscv/Kconfig  | 1 +
>  arch/riscv/Makefile | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980..ed81df4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -112,6 +112,7 @@ config ARCH_RV32I
>  config ARCH_RV64I
>  	bool "RV64I"
>  	select 64BIT
> +	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FTRACE_MCOUNT_RECORD
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 61ec424..33700e4 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -25,8 +25,6 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>
>  	KBUILD_CFLAGS += -mabi=lp64
>  	KBUILD_AFLAGS += -mabi=lp64
> -
> -	KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
>
>  	KBUILD_MARCH = rv64im
>  	KBUILD_LDFLAGS += -melf64lriscv

FWIW, while there isn't an official RISC-V GCC port that old (IIRC 6 was our 
first version, but it may have been 7) there are out-of-tree ports so I think 
this is OK to leave as it stands.
