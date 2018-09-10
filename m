Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4AA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4AA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIJTBT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:01:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39600 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:01:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fzMqA-0001Iq-Hd; Mon, 10 Sep 2018 16:06:58 +0200
Date:   Mon, 10 Sep 2018 16:06:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Bernhard Landauer <oberon@manjaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Re: [PATCH] Drivers: hv: vmbus: include header for get_irq_regs()
Message-ID: <20180910140658.4umofqptuxhevtit@linutronix.de>
References: <20180830075503.vh3qcdcnxcjobj55@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180830075503.vh3qcdcnxcjobj55@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-30 09:55:03 [+0200], To K. Y. Srinivasan wrote:
> On !RT the header file get_irq_regs() gets pulled in via other header files. On
> RT it does not and the build fails:
> 
>     drivers/hv/vmbus_drv.c:975 implicit declaration of function ‘get_irq_regs’ [-Werror=implicit-function-declaration]
>     drivers/hv/hv.c:115 implicit declaration of function ‘get_irq_regs’ [-Werror=implicit-function-declaration]
> 
> Add the header file for get_irq_regs() in a common header so it used by
> vmbus_drv.c by hv.c for their get_irq_regs() usage.
> 
> Reported-by: Bernhard Landauer <oberon@manjaro.org>
> Reported-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ping

> ---
>  drivers/hv/hyperv_vmbus.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 72eaba3d50fc2..797f07918197c 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -31,6 +31,7 @@
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  
>  #include "hv_trace.h"
>  
> -- 
> 2.18.0
> 
