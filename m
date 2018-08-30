Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D450D20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D450D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeH3Xye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:54:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeH3Xye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:54:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F4D17A9;
        Thu, 30 Aug 2018 12:50:46 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC5B53F5BC;
        Thu, 30 Aug 2018 12:50:45 -0700 (PDT)
Subject: Re: [PATCH 2/8] RISC-V: Don't set
 cacheinfo.{physical_line_partition,attributes}
To:     Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        atish.patra@wdc.com, dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-3-palmer@sifive.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <fe5ba627-ab8a-79b1-a46a-1d7213707684@arm.com>
Date:   Thu, 30 Aug 2018 14:50:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180827184243.25344-3-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/27/2018 01:42 PM, Palmer Dabbelt wrote:
> These are just hard coded in the RISC-V port, which doesn't make any
> sense.  We should probably be setting these from device tree entries
> when they exist, but for now I think it's saner to just leave them all
> as their default values.

Default value here means unset and not visible in /sys.

Which looks fine to me.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks,


> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>   arch/riscv/kernel/cacheinfo.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 0bc86e5f8f3f..cb35ffd8ec6b 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -22,13 +22,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>   {
>   	this_leaf->level = level;
>   	this_leaf->type = type;
> -	/* not a sector cache */
> -	this_leaf->physical_line_partition = 1;
> -	/* TODO: Add to DTS */
> -	this_leaf->attributes =
> -		CACHE_WRITE_BACK
> -		| CACHE_READ_ALLOCATE
> -		| CACHE_WRITE_ALLOCATE;
>   }
>   
>   static int __init_cache_level(unsigned int cpu)
> 


