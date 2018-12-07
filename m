Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED6EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB9920868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OK7/DQPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB9920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLGR65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:58:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35295 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeLGR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:58:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so2296008pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=i0Q9sHwMUr1ekdKWXnqO7o2xE02Jg3yQin/DuOT/sO0=;
        b=OK7/DQPUD/pVtDKYclK0FyeGWFC1aYMhNDPfQJfdXdLkt8jm2piokX5AC3IlMTVxzL
         IICcnOnP3OjFK76Mx/Ze0sBqXfolnlgACpKRrz+FJJUaf14fFekODHgFl8hH+TFxE+AC
         rlySbFnYUP6mqJhrumlXJOUnoJlr8ibryYHVYuybMqvQZ6e4HVwzevMQFA7lW8nGswYz
         bKHvRHhhyAnsD1c6P5vefSWTMW71hXt6XdHMc5lXdQP8PVTWzsDbEOg+QLviN2Wc9LiK
         yfLci+n14Z3LK/6/YX+j54/fN2tk2lnKBHMP1Su4tCvkQPIbtbw1xV8HR9eIQTxorTCj
         2cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=i0Q9sHwMUr1ekdKWXnqO7o2xE02Jg3yQin/DuOT/sO0=;
        b=mQF6XWpzd/gN7y6MEj7GVAayN/Hn/yx/4pEK/GvE3d6oyTeY2IrzBEB/YyotZCB86p
         x4Mlublrnr7B9hzWu2JgYxlViwTNMS82ziAYv5PLgW3PGlbyTIBxVtHErAQ9u35dyRuk
         Xv6JolHMU7iuvHbLIjfG9CTDV5J3FRhE6veACiVMbLKNFUH3yeomjugqCWDvIx0M1/gs
         AhNMYG33AEDDh9aWz6Qxa1UD8XyoXCpETDeV583tyPKUuwHeoUqJ4UOkHUIPRKI2/AIm
         rY7LM0t2gJApeBdfgdzlCc+i2HOZmEKjjNS0rvqWA9Ds/8ltBWHR/7YcT6HNrGRah5R7
         lDBg==
X-Gm-Message-State: AA+aEWbqKz1TkumMiRIKjnGedwnTWclZ8LbiY5ylpQHFsXW7vfMJaFjF
        M5EzhvZRTMN7mGfA0jbcPUUtYw==
X-Google-Smtp-Source: AFSGD/WoZN9ourd0BU90eh+nSpKc44uv0qb/DauBIPmCqOMuUtBJgKLBIw2p05q0mp1UrW0SAEn/VA==
X-Received: by 2002:a62:5444:: with SMTP id i65mr3278084pfb.193.1544205536460;
        Fri, 07 Dec 2018 09:58:56 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id p2sm4796263pfb.28.2018.12.07.09.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:58:55 -0800 (PST)
Date:   Fri, 07 Dec 2018 09:58:55 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 09:58:16 PST (-0800)
Subject:     Re: [PATCH v2 1/2] RISC-V: Select GENERIC_SCHED_CLOCK for clocksource drivers
In-Reply-To: <20181204102952.21297-2-anup@brainfault.org>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-17317b78-68ae-4bf8-8914-e7d5a8348b82@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 02:29:51 PST (-0800), anup@brainfault.org wrote:
> The riscv_timer driver can provide sched_clock using "rdtime"
> instruction but to achieve this we require generic sched_clock
> framework hence this patch selects GENERIC_SCHED_CLOCK for RISCV.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 55da93f4e818..09a0f2582cad 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -24,6 +24,7 @@ config RISCV
>  	select GENERIC_CPU_DEVICES
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
> +	select GENERIC_SCHED_CLOCK
>  	select GENERIC_STRNCPY_FROM_USER
>  	select GENERIC_STRNLEN_USER
>  	select GENERIC_SMP_IDLE_THREAD

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
