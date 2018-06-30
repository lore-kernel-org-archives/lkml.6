Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB8C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B35208B7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B35208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbeF3JYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 05:24:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeF3JYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 05:24:45 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fZC6t-00072T-GF; Sat, 30 Jun 2018 11:24:03 +0200
Date:   Sat, 30 Jun 2018 11:24:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] x86/tsc: Clean up legacy code for Intel MID
In-Reply-To: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1806301120010.1595@nanos.tec.linutronix.de>
References: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
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

On Fri, 29 Jun 2018, Andy Shevchenko wrote:

> As Thomas noticed there is unusual initialization is going on on Intel MID
> platforms when TSC is being calibrated.
> 
> It appears that we have tsc_msr.c to support Intel MID in a more generic way.
> 
> So, this patch series removes legacy calibration code and does accompanying
> clean ups.
> 
> Has been tested on Intel Medfield and Intel Merrifield platforms.

Nice series from a quick glance! I'll have a deeper look on monday.

One thing on top. From your earlier reply:

> This sounds like a stub against very old calibration code since Intel
> MID has no PIT, HPET, PMTIMER to calibrate from.

As we already know that the legacy calibration cannot work on those
machines, we really should splt out the msr/cpuid based calibration method
into a separate function, which is set for the intel MID stuff and called
from native_calibrate_tsc/cpu.

Hmm?

Thanks,

	tglx
