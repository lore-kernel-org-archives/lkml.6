Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CEAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CD32081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeKBAhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:37:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:37:53 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIEzD-0006MS-97; Thu, 01 Nov 2018 16:34:19 +0100
Date:   Thu, 1 Nov 2018 16:34:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Vacek <neelx@redhat.com>
cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tsc: make calibration refinement more robust
In-Reply-To: <1541085133-32534-1-git-send-email-neelx@redhat.com>
Message-ID: <alpine.DEB.2.21.1811011630310.1642@nanos.tec.linutronix.de>
References: <1541085133-32534-1-git-send-email-neelx@redhat.com>
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

Daniel,

On Thu, 1 Nov 2018, Daniel Vacek wrote:

Please use 'x86/tsc:' as prefix. git log path/to/file usually gives you a
reasonable hint about prefixes.

> -#define MAX_RETRIES     5
> -#define SMI_TRESHOLD    50000
> +#define MAX_RETRIES	5
> +#define TSC_THRESHOLD	(tsc_khz >> 5)

This breaks pit_hpet_ptimer_calibrate_cpu() because at that point tsc_hkz is 0.

Thanks,

	tglx
