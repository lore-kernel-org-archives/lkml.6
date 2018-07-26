Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E110A20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fC/kNVB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E110A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeGZIUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:20:34 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35012 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeGZIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:20:34 -0400
Received: by mail-yb0-f193.google.com with SMTP id x15-v6so262031ybm.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUh+ihv71o/dpEu+DXw5hSCvc7iyF7vIyltmHnOb30Q=;
        b=fC/kNVB8KC7MnOoEMWHQ0cFxmujabehkgxX1yP4QrVB+Z7NcmMCCbyRdZlXwVGuVZz
         59EQrfbQudk34j11gj10CiTH1HEg+TOdmx06b7qMa270mRQF/1sCnXnXMnZiCFn211lP
         FIysHzFtAiLpHp7YEB1wCNIUuvhOVxSNVWJnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUh+ihv71o/dpEu+DXw5hSCvc7iyF7vIyltmHnOb30Q=;
        b=iovWkJmlpMfWYJ8QkPKZri3Pgkznk5Y7f3iqtXqS9NxtmVWIuqIaNyHzJKZE9bZu9h
         KVZOmE0K673VlJsBkk5vdIzBGqU52VncFNDnOQCMMDfHEkVH51DvwuwIpoYT23cPCHVl
         oENdMVJgoUTkfn142GCfQkKkqsoMBcJWpR0ZIZ/gyEiifWXkgOzsYarS75wIwp2pibC7
         6Ttd0ZX6Ccy83XaxHnnI1RE1EdqlZ75SBx28QsX1/QydrvJjuz7I5Lk0DXmOKJ+64Mbc
         DSNhQK38G7SR5r9DnBtoJ2jFs7i+ihCoZl5kwVhRF33TvtmZ5DpQwp2XHM41P5KQwyHE
         +lHg==
X-Gm-Message-State: AOUpUlGEonqJJsYKNwjDMYRTNIUKDLiPlvhXUjNUnW8j9mc4HKxhuZzn
        BICKY7q6Jya3YGHbJwR+WAr1u/e/OipMLt5sLdo5iUaDMrM=
X-Google-Smtp-Source: AAOMgpe50BBD3q5N/ITliJWOTpDDfLo2Hu+bh0nHHffcaw4Lg3WpIfZ1n2ftC4KlxiUorU1NRWnoKnB9hwZpENoVJHI=
X-Received: by 2002:a25:bfc8:: with SMTP id q8-v6mr330420ybm.361.1532588708959;
 Thu, 26 Jul 2018 00:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180626153035.361-1-anders.roxell@linaro.org>
In-Reply-To: <20180626153035.361-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Jul 2018 09:04:57 +0200
Message-ID: <CADYN=9+HHA+uFJT+QX9hvM1nunTg6zqwVwBeSuAVFAYjBanhSg@mail.gmail.com>
Subject: Re: [PATCH] mips: configs: remove no longer needed config option
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 at 17:30, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Since commit eedf265aa003 ("devpts: Make each mount of devpts an
> independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
> in the defconfig anymore.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/mips/configs/ip27_defconfig    | 1 -
>  arch/mips/configs/nlm_xlp_defconfig | 1 -
>  arch/mips/configs/nlm_xlr_defconfig | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
> index 91a9c13e2c82..fbcbfc365c64 100644
> --- a/arch/mips/configs/ip27_defconfig
> +++ b/arch/mips/configs/ip27_defconfig
> @@ -262,7 +262,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_MANY_PORTS=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_HW_RANDOM_TIMERIOMEM=m
>  CONFIG_I2C_CHARDEV=m
>  CONFIG_I2C_ALI1535=m
> diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
> index e8e1dd8e0e99..aec323ed6968 100644
> --- a/arch/mips/configs/nlm_xlp_defconfig
> +++ b/arch/mips/configs/nlm_xlp_defconfig
> @@ -403,7 +403,6 @@ CONFIG_SERIO_SERPORT=m
>  CONFIG_SERIO_LIBPS2=y
>  CONFIG_SERIO_RAW=m
>  CONFIG_VT_HW_CONSOLE_BINDING=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_LEGACY_PTY_COUNT=0
>  CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_N_HDLC=m
> diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
> index c4477a4d40c1..88c185da23ce 100644
> --- a/arch/mips/configs/nlm_xlr_defconfig
> +++ b/arch/mips/configs/nlm_xlr_defconfig
> @@ -336,7 +336,6 @@ CONFIG_SERIO_SERPORT=m
>  CONFIG_SERIO_LIBPS2=y
>  CONFIG_SERIO_RAW=m
>  CONFIG_VT_HW_CONSOLE_BINDING=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
>  CONFIG_LEGACY_PTY_COUNT=0
>  CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_N_HDLC=m
> --
> 2.18.0
>

Ping.
