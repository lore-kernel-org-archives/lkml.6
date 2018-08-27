Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B25C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47E8208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UEcAcvOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47E8208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH0Xig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:38:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35590 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0Xif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:38:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id z4-v6so72571pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz3nBvz0aQuuIxcvXuFcetm+L+FBUOslkCbbDGEw66A=;
        b=UEcAcvOOWS9TZ7MdKExlVFYl7bQJi+5/PenFBJz1wJwrN80RGNSzMRQHkuLmLZf6sJ
         MyqGxgLXgFajzzIvRH/eqqToY9P1dJLSLgUCjEULTX+lkgQekrQCjr8McWEVtRphMDh6
         Q1YJXd9EOxdrwzQ+LOTGXPViS+t0ELieC1fkmKrJRp8/pJVBumNQ/yPcxD4RRTGX9HUj
         FPZxthRgqEWA7VlS9dDX7QYzQKQLFknjI6IyqnMsixuhf5axKGmI0JZ8nzZEpRBkR46x
         Gr1aG+zHgpuXTJ7/Nw36xPNvYuY3FhafbJ5hwSqBQphmLDUBDg+KlIuBg86cEw2RTOhv
         hOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Hz3nBvz0aQuuIxcvXuFcetm+L+FBUOslkCbbDGEw66A=;
        b=J6yh29MyiOyz9815SZguvfUzmbNM2y5Xo0V71w3Cg2ON36tUW11G2D/io9Scqzc/gs
         wcmPmdAXx0Sm21sDY8b6dMJ401dcEgl5lt5hdqlL7XGGU1CjBml7r3sguh4DYKylMg61
         wMuo7Q1SpUUQ+fhiRBUkUpQ54nmsAZOizka/jgIQpuTi49ZcQNVX8AvzQYaD/LgmcbuF
         +P4I4VWspoxo9jxV8ZpyLNPs2L6DTWJxmPbg4tQpR81UigX42Bw4epEIvPh5IMDQW2Sf
         dq4SYpfZbcF7sp4D/TvL1EDDabaKjzvW5dgB8Tu9lUx7dSLY6dtiwcH+TY0xyLDCYhWd
         A/bQ==
X-Gm-Message-State: APzg51AxeaVN7CJdnL+szv8g/7VXzaNgFLjwsk6ePqWQXlp85N8lroFg
        Ipr0UcpAWNA8pebtSOB+sJ+8hw==
X-Google-Smtp-Source: ANB0VdZzSteE2413JNsOn7UzYHIE1ByGnRZHVWQmlZFJ/1syUQPxWp83zf7t+9M2ox8N1hohXErKTQ==
X-Received: by 2002:a63:ce43:: with SMTP id r3-v6mr13718709pgi.439.1535399433404;
        Mon, 27 Aug 2018 12:50:33 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m15-v6sm71567pfj.171.2018.08.27.12.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:50:32 -0700 (PDT)
Date:   Mon, 27 Aug 2018 12:50:32 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 12:11:00 PDT (-0700)
Subject:     Re: [PATCH] riscv: tlb: Provide definition of tlb_flush() before including tlb.h
In-Reply-To: <1535134975-18594-1-git-send-email-linux@roeck-us.net>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-17c848f8-6342-44c6-95b3-f4eee460b91c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 11:22:55 PDT (-0700), linux@roeck-us.net wrote:
> From: Will Deacon <will.deacon@arm.com>
>
> As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
> asm-generic/tlb.h now calls tlb_flush() from a static inline function,
> so we need to make sure that it's declared before #including the
> asm-generic header in the arch header.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma")
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> [groeck: Use forward declaration instead of moving inline function]
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/riscv/include/asm/tlb.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index c229509288ea..439dc7072e05 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -14,6 +14,10 @@
>  #ifndef _ASM_RISCV_TLB_H
>  #define _ASM_RISCV_TLB_H
>
> +struct mmu_gather;
> +
> +static void tlb_flush(struct mmu_gather *tlb);
> +
>  #include <asm-generic/tlb.h>
>
>  static inline void tlb_flush(struct mmu_gather *tlb)

Thanks!  I'm going to take this into my for-linus branch which I'm still hoping 
to tag today, pending my email queue.
