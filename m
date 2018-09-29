Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8FD206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8FD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeI2XuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:50:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37543 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728430AbeI2XuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:50:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2337305|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03276;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CxVqc34_1538241634;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CxVqc34_1538241634)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 30 Sep 2018 01:20:34 +0800
Date:   Sun, 30 Sep 2018 01:20:33 +0800
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
Subject: Re: [PATCH V6 01/33] csky: Build infrastructure
Message-ID: <20180929172032.GH27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
 <20180928161110.GA19827@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928161110.GA19827@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 09:11:10AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/arch/csky/kernel/Makefile
> > @@ -0,0 +1,8 @@
> > +extra-y := head.o vmlinux.lds
> > +
> > +obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o \
> > +	 power.o syscall.o platform.o syscall_table.o setup.o \
> > +	 process.o cpu-probe.o ptrace.o dumpstack.o
> > +
> > +obj-$(CONFIG_MODULES)			+= module.o
> 
> You can't just wire up the build infrastructure before th code.
> 
> Please add the objects to the Makefiles when they are actually added.
I don't got it? Patchset should be seperated by makefile dir?
