Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB5C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145D721736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBJUoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:44:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:44:10 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gsvxO-0000xu-QD; Sun, 10 Feb 2019 21:44:07 +0100
Date:   Sun, 10 Feb 2019 21:44:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will.deacon@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, peterz@infradead.org, bigeasy@linutronix.de
Subject: Re: [PATCH 3/5] perf/arm-ccn: Fix CPU hotplug race avoidance
In-Reply-To: <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
Message-ID: <alpine.DEB.2.21.1902102143290.8784@nanos.tec.linutronix.de>
References: <cover.1549299188.git.robin.murphy@arm.com> <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
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

On Mon, 4 Feb 2019, Robin Murphy wrote:
>  	/* Pick one CPU which we will use to collect data from CCN... */
> -	cpumask_set_cpu(get_cpu(), &ccn->dt.cpu);
> +	cpus_read_lock();
> +	ccn->dt.cpu = smp_processor_id();

Again raw_smp_processor_id()

Thanks,

	tglx
