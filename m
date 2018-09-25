Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1614820877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1614820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeIYPYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:24:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53008 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727606AbeIYPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:24:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08167352|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03272;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.CvbLvsF_1537867023;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CvbLvsF_1537867023)
          by smtp.aliyun-inc.com(10.147.42.22);
          Tue, 25 Sep 2018 17:17:04 +0800
Date:   Tue, 25 Sep 2018 17:17:03 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V7 2/2] csky: remove irq_mapping from smp.c.
Message-ID: <20180925091702.GA6607@guoren>
References: <cover.1537276837.git.ren_guo@c-sky.com>
 <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
 <CAK8P3a2WLCZNZ_A1qPQuEQdxEyLKZj2EY2oHzG+_GTGiWEna7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2WLCZNZ_A1qPQuEQdxEyLKZj2EY2oHzG+_GTGiWEna7w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:23:14PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> >  - remove irq_mapping from smp.c to irq-driver
> >  - Add set_ipi_irq_mapping api to irq-driver
> >  - update asm/smp.h
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> 
> The patch seems ok to me, but please try to improve the changelog comments.
> Generally speaking, use full English sentences instead of an enumerated list,
> and explain what the change is for rather than what you are doing. The text
Ok, I'll improve it.
> you have here can easily be derived from looking at the code changes,
> but I still don't understand what caused you to change it, and why this
> is better than the previous version.
The changelog comment will change to:

There are some feedbacks from irqchip, and we need to adjust "smp.c & smp.h"
to match the csky_mptimer modification.
 - Move IPI_IRQ define into drivers/irqchip/csky_mpintc.c, because it's a
   interrupt controller specific.
 - Bugfix request_irq with IPI_IRQ, we must use irq_mapping return value not
   directly use IPI_IRQ. The modification also involves csky_mpintc.

Best Regards
 Guo Ren
