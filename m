Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FB6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22A02084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22A02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLEOAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:00:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55004 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEOAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:00:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C7080D;
        Wed,  5 Dec 2018 06:00:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3303F59C;
        Wed,  5 Dec 2018 06:00:36 -0800 (PST)
Subject: Re: [PATCH RFC 6/7] arm64: kexec: no need to ClearPageReserved()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-7-david@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ce6a4c28-3c3b-329e-df01-325294bd9b2e@arm.com>
Date:   Wed, 5 Dec 2018 14:00:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205122851.5891-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

(CC: +Akashi)

On 05/12/2018 12:28, David Hildenbrand wrote:
> This will already be done by free_reserved_page().

(will already be -> will be ?)

So it does!


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 922add8adb74..0ef4ea73aa54 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -353,7 +353,6 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>  
>  	for (addr = begin; addr < end; addr += PAGE_SIZE) {
>  		page = phys_to_page(addr);
> -		ClearPageReserved(page);
>  		free_reserved_page(page);
>  	}
>  }
> 

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
