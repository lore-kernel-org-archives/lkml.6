Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0578601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeFFKSN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:18:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeFFKSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:18:10 -0400
Date: Wed, 6 Jun 2018 12:17:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>
cc: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Alexander Grest <Alexander.Grest@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HV: Fix definition of struct hv_vp_assist_page.
In-Reply-To: <20180521092506.90121-1-Tianyu.Lan@microsoft.com>
Message-ID: <alpine.DEB.2.21.1806061217220.1579@nanos.tec.linutronix.de>
References: <20180521092506.90121-1-Tianyu.Lan@microsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018, Tianyu Lan wrote:

KY ????

> The struct hv_vp_assist_page was defined incorrectly.
> The "vtl_control" should be u64[3], "nested_enlightenments_control"
> should be a u64 and there is 7 reserved bytes following "enlighten_vmentry".
> This patch is to fix it.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index f7be6d03a310..fae0a5431cdd 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -496,10 +496,11 @@ struct hv_timer_message_payload {
>  /* Define virtual processor assist page structure. */
>  struct hv_vp_assist_page {
>  	__u32 apic_assist;
> -	__u32 reserved;
> -	__u64 vtl_control[2];
> -	__u64 nested_enlightenments_control[2];
> -	__u32 enlighten_vmentry;
> +	__u32 reserved1;
> +	__u64 vtl_control[3];
> +	__u64 nested_enlightenments_control;
> +	__u8 enlighten_vmentry;
> +	__u8 reserved2[7];
>  	__u64 current_nested_vmcs;
>  };
>  
> -- 
> 2.14.3
> 
