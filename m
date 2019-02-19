Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1614CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AD121848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550542730;
	bh=NSp3Oaux3Z1t7jKHeFE4mdFS+JVFVS9Qtu/OyQGaeso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQnoeaKcV4nP/YOt3Bc5IAWJwu+rdgHeAFamG32CFV1iRUmbbitLT+E0NqgG4Gqlu
	 Pce1rnJxo76zS+tcZZKkLkHztebmvYViTtalR2NmAA6nfX+DqzbAjIHmPh/TLpTcF9
	 N9bLGgjAAlXxd5FPEkWXql6IrwbGEwxFb+fa/W4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfBSCSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfBSCSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:18:49 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1460A2173C;
        Tue, 19 Feb 2019 02:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550542728;
        bh=NSp3Oaux3Z1t7jKHeFE4mdFS+JVFVS9Qtu/OyQGaeso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byrxfkxRfTqEgl3PxNNOp00BPSlNGIzaj9yzlSWUIkNeG1YRcpEd5MfmLN9s3Czze
         PN3FBT82RdBzrVocjsEpREY1CE/kWqstuFo23cWeCu/q/wssT7HFHmfGgj7QEBMNLm
         4wuniyGMOGrgqxY72h2yntfchLUFR9L8EzMScPak=
Date:   Tue, 19 Feb 2019 10:18:34 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Mao Han <han_mao@c-sky.com>
Cc:     y2038@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Subject: Re: [PATCH 7/8] csky: Use latest system call ABI
Message-ID: <20190219021834.GA4495@guoren-Inspiron-7460>
References: <20190218210712.3503891-1-arnd@arndb.de>
 <20190218210712.3503891-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218210712.3503891-8-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mao Han has merged csky port into glibc 2.29, so we should keep the
__ARCH_WANT_TIME32_SYSCALLS.

F.Y.I:
han_mao@c-sky.com

On Mon, Feb 18, 2019 at 10:07:11PM +0100, Arnd Bergmann wrote:
> We don't yet have an upstream glibc port for csky, so there is no user
> space for the existing ABI, and we can remove the definitions for 32-bit
> time_t, off_t and struct resource.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/Kconfig                   | 1 -
>  arch/csky/include/uapi/asm/unistd.h | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 6959e0b1e956..398113c845f5 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -1,6 +1,5 @@
>  config CSKY
>  	def_bool y
> -	select ARCH_32BIT_OFF_T
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
> index ec60e49cea66..224c9a9ab45b 100644
> --- a/arch/csky/include/uapi/asm/unistd.h
> +++ b/arch/csky/include/uapi/asm/unistd.h
> @@ -2,8 +2,6 @@
>  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
>  
>  #define __ARCH_WANT_SYS_CLONE
> -#define __ARCH_WANT_SET_GET_RLIMIT
Seems it's not related to y2038 issue. Is __ARCH_WANT_SET_GET_RLIMIT no
use ?

> -#define __ARCH_WANT_TIME32_SYSCALLS

Best Regards
 Guo Ren
