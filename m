Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25534C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E442070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfBTJ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:28:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45161 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBTJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:28:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so16361436qtg.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEECWmoaxLKcflnT7o8isAvCgchnA7bQDZHOVtYr+LA=;
        b=DGkkqYKQ+X1b5asFL0++DySVAu5c7a35tZJ4BTCbEA0XrcuWdcPvUYGom78NJI4wLj
         L/dqDen+UVCgLZ+Sgnxj5gYkrK1E4qyg2PAF0MwCmCcIUhQgzFQN+QCbMquffQrZ4P79
         +efVa8REn1ckLk7SEA7380wE3tl3B4tNhdSwMFJdJmhwuXhXcIHpcG22SbZmy+ccWpCO
         mWP2/m8ddsHQ3TklkOaHFn7rLtdIDL7oJzBynOUgRHPOgTBQRMYeJnjlRNeQCl8n6uzz
         qdx8xAVQ7/l2vJtn7Nvv4o8ZEIoZHmwOfN7uBYJRfbFY81DgoY0kr+fcotjefsbUEhVl
         IOHg==
X-Gm-Message-State: AHQUAuZ81JoFbiPs+ioTK0FlrIN96LAV0pjgV9ByxAB1GgGnPs43PxTd
        K1fywa5MswpcfkxnQ8aEtzH8PqyAYcUeg9z248w=
X-Google-Smtp-Source: AHgI3IbCQZWZ+c/E7yLc81SyNeQLOF7qVFLtnoL6YpCkRNA39syiVHMEvaM4yGBe7kmZwJMviefGSO65l/xmftxb0rA=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr25804180qtb.319.1550654934224;
 Wed, 20 Feb 2019 01:28:54 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 10:28:38 +0100
Message-ID: <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        soc@kernel.org, Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> new file mode 100644
> index 0000000..a263211
> --- /dev/null
> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> @@ -0,0 +1,175 @@

I no longer see anything here that should be turned off, but you
might want to run 'make savedefconfig' and use the output of that,
to make it easier to keep it up to date.

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 5bee34a..6753805 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
>  CONFIG_ARCH_KEYSTONE=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_MESON=y
> +CONFIG_ARCH_MILBEAUT=y
> +CONFIG_ARCH_MILBEAUT_M10V=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_ARMADA_370=y
>  CONFIG_MACH_ARMADA_375=y

I'm surprised that you don't need to enable any drivers. Does this actually
boot on your hardware?

      Arnd
