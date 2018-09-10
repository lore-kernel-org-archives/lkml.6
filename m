Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A93C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeIJMXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:23:31 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48760 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727584AbeIJMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:23:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08141791|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CoocMlg_1536564640;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CoocMlg_1536564640)
          by smtp.aliyun-inc.com(10.147.41.120);
          Mon, 10 Sep 2018 15:30:41 +0800
Date:   Mon, 10 Sep 2018 15:30:39 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V3 10/26] csky: IRQ handling
Message-ID: <20180910073039.GA4022@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <a881fc9d1009f7b3ca1cfa50dd7f1ead7844d521.1536138304.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1809061535040.1570@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809061535040.1570@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:39:01PM +0200, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Guo Ren wrote:
> 
> > +static void (*handle_arch_irq)(struct pt_regs *regs) = NULL;
> > +
> > +void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> > +{
> > +	if (handle_arch_irq)
> > +		return;
> > +
> > +	handle_arch_irq = handle_irq;
> > +}
> 
> Please don't introduce yet another variant of that. Please use
> CONFIG_GENERIC_IRQ_MULTI_HANDLER which provides that in the generic code.
Ok.

> 
> Btw, some of your patches have tab vs. space inconsistencies, e.g.
> 
> +        siginfo_t info;
> +       int fault;
> +       unsigned long address = mmu_meh & PAGE_MASK
Thx, I'll re-check.

Best Regards
 Guo Ren
