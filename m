Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A29CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870F21934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550193726;
	bh=Wl7PPoUzvuCUSlKvjd1wWETqmr4jShWoOsfUnAtee/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eTBkR25CqDa1XFxGu4lrejTkXNQKF7ZTMZRtDeQb7FzdK/bWOMjXtfKRF4aH/zval
	 9xujKrAEUP6S8ixr1E8Sr/127br9wOKJjPPRAC4uPDhvF1C2GdC11hQIH3bii3S/bR
	 EfhOGvkBUJTnXGtCtfyapQxt3236n02+9qDOcmiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfBOBWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfBOBWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:22:04 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1422177E;
        Fri, 15 Feb 2019 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550193723;
        bh=Wl7PPoUzvuCUSlKvjd1wWETqmr4jShWoOsfUnAtee/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUrz4IpXo2thK692HqwwAOwdQKPbmsMbUWiK5vtoY6MsPaceDv8axm/BdTMGVs73H
         yWQW1/GA1mJw6/8c0yikuFrG0VBtrDBuRWcdKLgmhPFEu7eay/5bJ9ONKtJIjsZ7pS
         MjFnyd/gJlxwj4Sn2z37JZZCQ7Ql4A+kEsmgbDHo=
Date:   Fri, 15 Feb 2019 09:21:56 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     arnd@arndb.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 01/10] irqchip/csky: Support csky,dh7k SOC intc driver
Message-ID: <20190215012156.GA3226@guoren-Inspiron-7460>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
 <86bm3esbzr.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bm3esbzr.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:03:52PM +0000, Marc Zyngier wrote:
> On Tue, 29 Jan 2019 12:24:20 +0000,
> guoren@kernel.org wrote:
> > 
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > C-SKY dh7k SOC use simple APB interrupt controller and most of driver's
> > implementation codes could be reused in csky-apb-intc.c. So merge them
> > together.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  drivers/irqchip/irq-csky-apb-intc.c | 95 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 85 insertions(+), 10 deletions(-)
> > 
> 
> So this patch series seems to contain both core c-sky stuff as well as
> irqchip updates.
There are no dependencies on core-csky stuff and irqchip in this patch
series.

> 
> Please send an irqchip series that I can take standalone. 
Ok, I'll send a standalone irqchip series later.

> If there are
> dependencies, please state so in the cover letter, and we'll work out
> something. Please make sure that everybody gets at least the cover
> letter (I didn't receive one for this series).

I guess you are worried about:

+#include <asm/traps.h>
 ...
+
+	for (i = 32; i < 128; i++)
+		VEC_INIT(i, csky_irq);
+

In arch/csky, 32 - 127 trap entries are reserved for vector irqs. But
the mode of vector irq need irq controller to support, or csky cpu will
use trap 10 for all interrupts and get irq-num from interrupt controller.

Some interrupt controllers don't support trap 10, so they need working
at vector mode and get irq-num by mfcr("psr").

Here we just use csky_irq instead of csky_trap which initiated by arch/csky.

Best Regards
 Guo Ren
