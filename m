Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF22C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F512064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F512064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeIFSOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:14:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:14:40 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxuUv-0008H9-Qn; Thu, 06 Sep 2018 15:39:01 +0200
Date:   Thu, 6 Sep 2018 15:39:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Guo Ren <ren_guo@c-sky.com>
cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V3 10/26] csky: IRQ handling
In-Reply-To: <a881fc9d1009f7b3ca1cfa50dd7f1ead7844d521.1536138304.git.ren_guo@c-sky.com>
Message-ID: <alpine.DEB.2.21.1809061535040.1570@nanos.tec.linutronix.de>
References: <cover.1536138304.git.ren_guo@c-sky.com> <a881fc9d1009f7b3ca1cfa50dd7f1ead7844d521.1536138304.git.ren_guo@c-sky.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Guo Ren wrote:

> +static void (*handle_arch_irq)(struct pt_regs *regs) = NULL;
> +
> +void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> +{
> +	if (handle_arch_irq)
> +		return;
> +
> +	handle_arch_irq = handle_irq;
> +}

Please don't introduce yet another variant of that. Please use
CONFIG_GENERIC_IRQ_MULTI_HANDLER which provides that in the generic code.

Btw, some of your patches have tab vs. space inconsistencies, e.g.

+        siginfo_t info;
+       int fault;
+       unsigned long address = mmu_meh & PAGE_MASK;

Thanks,

	tglx
