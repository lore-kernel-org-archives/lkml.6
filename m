Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488ABC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E677820861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E677820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIERFD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeIERFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:05:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F6A20857;
        Wed,  5 Sep 2018 12:34:56 +0000 (UTC)
Date:   Wed, 5 Sep 2018 08:34:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        Bernhard Landauer <oberon@manjaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Re: [PATCH RT 21/22] Drivers: hv: vmbus: include header for
 get_irq_regs()
Message-ID: <20180905083455.78cd72d3@gandalf.local.home>
In-Reply-To: <20180905122837.830614967@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
        <20180905122837.830614967@goodmis.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ It appears that quilt doesn't use the right mime for the strange
  characters in the change log. I'm replying here as it was bounced
  by the mailing lists ]

On Wed, 05 Sep 2018 08:28:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 4.14.63-rt41-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [ Upstream commit b9fcc1867cc7921bb8441be327ed58461ed12255 ]
> 
> On !RT the header file get_irq_regs() gets pulled in via other header files. On
> RT it does not and the build fails:
> 
>     drivers/hv/vmbus_drv.c:975 implicit declaration of function âget_irq_regsâ [-Werror=implicit-function-declaration]
>     drivers/hv/hv.c:115 implicit declaration of function âget_irq_regsâ [-Werror=implicit-function-declaration]
> 
> Add the header file for get_irq_regs() in a common header so it used by
> vmbus_drv.c by hv.c for their get_irq_regs() usage.
> 
> Reported-by: Bernhard Landauer <oberon@manjaro.org>
> Reported-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  drivers/hv/hyperv_vmbus.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 49569f8fe038..a3608cd52805 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -30,6 +30,7 @@
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  
>  /*
>   * Timeout for services such as KVP and fcopy.

