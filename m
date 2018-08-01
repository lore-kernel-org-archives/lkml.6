Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1BCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32894208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LB6BudRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32894208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeHATmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:42:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46810 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeHATmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:42:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so9138599ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1yGFDMsUI2gv7DWp5GQJyeQoj4wOz5H0w37F7ELpQmE=;
        b=LB6BudRi71q2u/uOq2WTr3McJsTimaatgZEtIqEd+E8U0u4qRzSVWetZ7L32oxehb+
         wMWkGU9xRsyp6pfR8TlHyBQsJQzXEC9sOvQ7opKF+H3+10H6lk0xxbTpYYrU4rFhi2oG
         LnvUEXWK2sbmG/MsHRJ6h61UxYTYsg5rfPskyENm7VpU8mE5wPS3k6ezEVIaos/e9zrH
         L/o9O7vBlCKeQxGk0Z3omaqVllpMEr0UFhzymPIb43ldhevp9OD4MyocNY6rUe3b4JeY
         TaqUmp64T49uE3IP6LIalAaeJsLnSCajYQ2HEmmd2VY2V4a0ZbaJlKJKqGm6ol/+W23m
         ND0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1yGFDMsUI2gv7DWp5GQJyeQoj4wOz5H0w37F7ELpQmE=;
        b=pxS/xdXgBtTwZPm4JeLujkwVtPG1PaaKuaK9or+KpPic0VGiWTP4fv4BRFFZpcJZds
         SAorp0P1NHpakvyfEsXS5Ju7+svVpmLocio1b37FM6dnH3dxJQIZodyy9Td+girEMfmz
         VD4rAdaEjbQeTE6JotXyW6sM6NDTk/B8cXdybr4giecyySSjQk/Y9oYPmPrwqJMaXiOu
         eBH5aWen9RGM4NXgYYbpknOuq8N+U8IKmnOV4f44HsjUfTfLDMh84UXMKSueY2NFDRtJ
         ccXAB4SosRwVCihpJcykqLUq1oxTnALrhOd8v7RV7eBwl9l2l6Gk4JaThyh4lZ6wWtMv
         49uA==
X-Gm-Message-State: AOUpUlElB2GcfYAg8a9hTkGTjb71ss8dbW0nXYyQCwO+f7ot5jTB44YB
        IzlJhGnWJTcrndtBgwp64CizMw==
X-Google-Smtp-Source: AAOMgpdWOU/9UQkh/7PwVwXCyQrgK1GLiS2LluOh4rfWg/jswLYfqi1d9HPkX1lqspR5ivcf50+BeA==
X-Received: by 2002:a17:902:1682:: with SMTP id h2-v6mr25607984plh.327.1533146129529;
        Wed, 01 Aug 2018 10:55:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c12-v6sm46047267pfl.20.2018.08.01.10.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 10:55:28 -0700 (PDT)
Date:   Wed, 01 Aug 2018 10:55:28 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Aug 2018 10:55:24 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Add support to no-FPU systems
In-Reply-To: <1530073346-5341-1-git-send-email-alankao@andestech.com>
CC:     albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        zong@andestech.com, alankao@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-47d9ea80-a0c6-4cde-be65-75046c5d49d2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 21:22:26 PDT (-0700), alankao@andestech.com wrote:
> This patch adds an option, CONFIG_FPU, to enable/disable floating
> procedures.  Also, some style issues are fixed.
>
> Signed-off-by: Alan Kao <alankao@andestech.com>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/Kconfig                 |  9 ++++
>  arch/riscv/Makefile                | 19 +++----
>  arch/riscv/include/asm/switch_to.h |  6 +++
>  arch/riscv/kernel/entry.S          |  3 +-
>  arch/riscv/kernel/process.c        |  7 ++-
>  arch/riscv/kernel/signal.c         | 82 +++++++++++++++++++++---------
>  6 files changed, 90 insertions(+), 36 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6debcc4afc72..6069597ba73f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -232,6 +232,15 @@ config RISCV_BASE_PMU
>
>  endmenu
>
> +config FPU
> +	bool "FPU support"
> +	default y
> +	help
> +	  Say N here if you want to disable all floating-point related procedure
> +	  in the kernel.
> +
> +	  If you don't know what to do here, say Y.
> +
>  endmenu

Sorry for letting this slide for a bit.  While I'm not opposed to a solution 
that requires a FPU Kconfig option, it'd be a bit better if we could detect 
this at boot time.  I think this should be possible because at one point this 
actually worked and we could boot the same kernel on FPU and no-FPU systems.

If that's not possible then we'll have to take something like this.  There were 
some comments on this v2 but I don't see a v3, did I miss one?
