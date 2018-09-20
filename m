Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F1ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297D221522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297D221522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeITL27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:28:59 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34288 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725725AbeITL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:28:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.136235|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.CtHGZ6H_1537422434;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtHGZ6H_1537422434)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 20 Sep 2018 13:47:15 +0800
Date:   Thu, 20 Sep 2018 13:47:14 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 1/3] irqchip: add C-SKY irqchip drivers
Message-ID: <20180920054713.GA5198@guoren-Inspiron-7460>
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <86in35mfas.wl-marc.zyngier@arm.com>
 <20180917020928.GA22452@guoren-Inspiron-7460>
 <86tvmoz22k.wl-marc.zyngier@arm.com>
 <20180918084331.GA10950@guoren>
 <86r2hqu82l.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r2hqu82l.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Sep 18, 2018 at 04:41:22PM +0100, Marc Zyngier wrote:
> > +#define IPI_IRQ	15
> > +
> 
> It feels really bizarre that the function that maps the interrupt is
> specific to the interrupt controller, and yet the interrupt number is
> defined at the architecture level. I'd expect this to be just as
> interrupt controller specific.
>
Ok, move IPI_IRQ to irq-csky-mpintc.c. See my PATCH V8


> > +	irq = arch_ipi_irq_mapping();
> 
> How about checking the validity of the interrupt and that
> arch_ipi_irq_mapping is actually non-NULL?
Ok. 

> > -	rc = request_percpu_irq(IPI_IRQ, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
> > +	rc = request_percpu_irq(irq, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
> >  	if (rc)
> >  		panic("%s IRQ request failed\n", __func__);
>
> To be honest, I'd tend to question the need for this level of
> abstraction, unless you actually plan for multiple SMP-capable
> interrupt controllers... But at the end of the day, that's your call,
> and the above code looks mostly correct.
Thx for the review. I will consider your suggestion.

Best Regards
 GUo Ren
