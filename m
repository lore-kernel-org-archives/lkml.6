Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0761724728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761724728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbeGCQd0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:33:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:33:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B088C7A9;
        Tue,  3 Jul 2018 09:33:24 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453953F5BA;
        Tue,  3 Jul 2018 09:33:22 -0700 (PDT)
Subject: Re: [PATCH v10 07/14] arm64: enable KEXEC_FILE config
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-8-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <9545cb7f-9648-660a-f034-a94f186a8224@arm.com>
Date:   Tue, 3 Jul 2018 17:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-8-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> Modify arm64/Kconfig to enable kexec_file_load support.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090cf0292..f68318f61c85 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -835,6 +835,16 @@ config KEXEC
>  	  but it is independent of the system firmware.   And like a reboot
>  	  you can start any kernel with it, not just Linux.
>  
> +config KEXEC_FILE
> +	bool "kexec file based system call"
> +	select KEXEC_CORE
> +	select BUILD_BIN2C

Wasn't BIN2C only needed for purgatory?

x86/powerpc/s390 all select CRYPTO_SHA256 here, presumably for arch-specific
verification mechanisms. I assume we're using SIGNED_PE_FILE_VERIFICATION instead.


> +	help
> +	  This is new version of kexec system call. This system call is
> +	  file based and takes file descriptors as system call argument
> +	  for kernel and initramfs as opposed to list of segments as
> +	  accepted by previous system call.
> +
>  config CRASH_DUMP
>  	bool "Build kdump crash kernel"
>  	help


Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
