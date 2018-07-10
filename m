Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08619C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C098620852
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C098620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbeGJS2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:42 -0400
Received: from foss.arm.com ([217.140.101.70]:51734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732889AbeGJS2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:28:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B71EB1AED;
        Tue, 10 Jul 2018 10:52:56 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88AEE3F589;
        Tue, 10 Jul 2018 10:52:56 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5EC3C1AE53F3; Tue, 10 Jul 2018 18:53:38 +0100 (BST)
Date:   Tue, 10 Jul 2018 18:53:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        mathieu.desnoyers@efficios.com, arnd@arndb.de
Cc:     arnd@arndb.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, peter.maydell@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] asm-generic: unistd.h: Wire up sys_rseq
Message-ID: <20180710175337.GD10177@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1531145985-3747-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531145985-3747-3-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jul 09, 2018 at 03:19:44PM +0100, Will Deacon wrote:
> The new rseq call arrived in 4.18-rc1, so provide it in the asm-generic
> unistd.h for architectures such as arm64.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/uapi/asm-generic/unistd.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Please can you Ack this, so I can take it the arm64 tree?

Thanks,

Will

> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 42990676a55e..df4bedb9b01c 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
>  __SYSCALL(__NR_statx,     sys_statx)
>  #define __NR_io_pgetevents 292
>  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> +#define __NR_rseq 293
> +__SYSCALL(__NR_rseq, sys_rseq)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 293
> +#define __NR_syscalls 294
>  
>  /*
>   * 32 bit systems traditionally used different
> -- 
> 2.1.4
> 
