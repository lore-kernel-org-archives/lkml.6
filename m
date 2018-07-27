Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E761C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0567208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0567208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbeG0Q4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbeG0Q4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:56:18 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7883E2088E;
        Fri, 27 Jul 2018 15:33:50 +0000 (UTC)
Date:   Fri, 27 Jul 2018 11:33:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, douly.fnst@cn.fujitsu.com, jgross@suse.com,
        ville.syrjala@linux.intel.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        trivial@kernel.org
Subject: Re: [PATCH] x86/apic: fix two slight indenting
Message-ID: <20180727113348.331a49f7@gandalf.local.home>
In-Reply-To: <1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn>
References: <1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This looks like it should go through the trivial tree. Although I'm not
the maintainer of this code, it looks reasonable to me, and I'll give
my:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Fri, 27 Jul 2018 14:15:03 +0800
Yi Wang <wang.yi59@zte.com.cn> wrote:

> There are two inconsistent indenting in calibrate_APIC_clock()
> and activate_managed(). Remove the surplus TAB.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  arch/x86/kernel/apic/apic.c   | 2 +-
>  arch/x86/kernel/apic/vector.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 5071cc7..f222ebc 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -937,7 +937,7 @@ static int __init calibrate_APIC_clock(void)
>  
>  	if (levt->features & CLOCK_EVT_FEAT_DUMMY) {
>  		pr_warning("APIC timer disabled due to verification failure\n");
> -			return -1;
> +		return -1;
>  	}
>  
>  	return 0;
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index b708f59..19e0b2f 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -433,7 +433,7 @@ static int activate_managed(struct irq_data *irqd)
>  		pr_err("Managed startup irq %u, no vector available\n",
>  		       irqd->irq);
>  	}
> -       return ret;
> +	return ret;
>  }
>  
>  static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,

