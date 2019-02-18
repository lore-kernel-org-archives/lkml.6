Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260E521738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfBRQcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:32:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfBRQcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:32:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2A580D;
        Mon, 18 Feb 2019 08:32:18 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2F03F675;
        Mon, 18 Feb 2019 08:32:15 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     linux-arm-kernel@lists.infradead.org
Cc:     bigeasy@linutronix.de, Dave.Martin@arm.com,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <10464811-e050-5ea1-6763-4362cb1c7c7c@arm.com>
Date:   Mon, 18 Feb 2019 16:32:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208165513.8435-1-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 08/02/2019 16:55, Julien Grall wrote:
> @@ -1094,9 +1113,7 @@ void kernel_neon_begin(void)
>   	/* Invalidate any task state remaining in the fpsimd regs: */
>   	fpsimd_flush_cpu_state();
>   
> -	preempt_disable();
> -
> -	local_bh_enable();
> +	kernel_neon_enable();

I found one error in the patch. We should not re-enable NEON from 
kernel_neon_begin(). I will resend a patch once the thread settle down.

Cheers,

-- 
Julien Grall
