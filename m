Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F42133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIMQPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:15:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:15:15 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0PRt-0007hP-Tw; Thu, 13 Sep 2018 13:06:14 +0200
Date:   Thu, 13 Sep 2018 13:06:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yi Sun <yi.y.sun@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
In-Reply-To: <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809131304560.1473@nanos.tec.linutronix.de>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com> <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Yi Sun wrote:
> +#include <asm/mshyperv.h>
>  
>  /* representing HT siblings of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
> @@ -1335,6 +1336,7 @@ void __init native_smp_prepare_boot_cpu(void)
>  	/* already set me in cpu_online_mask in boot_cpu_init() */
>  	cpumask_set_cpu(me, cpu_callout_mask);
>  	cpu_set_state_online(me);
> +	hv_init_spinlocks();

No. We have smp_ops.smp_prepare_boot_cpu for that.

Thanks,

	tglx
