Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA940C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB272168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB272168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeI1TdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:33:14 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38954 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbeI1TdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:33:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1176559|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cx.iHGS_1538140158;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cx.iHGS_1538140158)
          by smtp.aliyun-inc.com(10.147.41.120);
          Fri, 28 Sep 2018 21:09:18 +0800
Date:   Fri, 28 Sep 2018 21:09:17 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 10/33] csky: IRQ handling
Message-ID: <20180928130916.GB2082@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <fbb4e798d1588e9df2da16818932747430068baf.1538058840.git.ren_guo@c-sky.com>
 <20180927154918.GB15985@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927154918.GB15985@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:49:18AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/arch/csky/include/asm/irq.h
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#ifndef __ASM_CSKY_IRQ_H
> > +#define __ASM_CSKY_IRQ_H
> > +
> > +#include <asm-generic/irq.h>
> > +
> > +#endif /* __ASM_CSKY_IRQ_H */
> 
> Just wire this up using generic-y in the Kbuild file instead of
> creating a wrapper.  (Same for any other header which is a trivial
> asm-generic wrapper).
Ok.
