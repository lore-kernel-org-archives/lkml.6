Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6386C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6386C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbeGZOws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:52:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbeGZOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:52:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E35215A2;
        Thu, 26 Jul 2018 06:35:54 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7200B3F6A8;
        Thu, 26 Jul 2018 06:35:51 -0700 (PDT)
Subject: Re: [PATCH v12 01/16] asm-generic: add kexec_file_load system call to
 unistd.h
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-2-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <f77fe157-f9f6-8dfc-eca0-1ecd687f671f@arm.com>
Date:   Thu, 26 Jul 2018 14:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-2-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> The initial user of this system call number is arm64.

This patch conflicts with commit db7a2d1809a5 ("asm-generic: unistd.h: Wire up
sys_rseq") in the arm64 tree.

Thanks,

James

> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 42990676a55e..c81f4a0df51f 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
>  __SYSCALL(__NR_statx,     sys_statx)
>  #define __NR_io_pgetevents 292
>  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> +#define __NR_kexec_file_load 293
> +__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 293
> +#define __NR_syscalls 294
>  
>  /*
>   * 32 bit systems traditionally used different
> 
