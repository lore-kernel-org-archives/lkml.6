Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E1CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979DA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979DA2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeIGHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:46:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59237 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbeIGHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:46:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08803213|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CnWMU.6_1536289645;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnWMU.6_1536289645)
          by smtp.aliyun-inc.com(10.147.41.187);
          Fri, 07 Sep 2018 11:07:25 +0800
Date:   Fri, 7 Sep 2018 11:07:25 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 09/26] csky: VDSO and rt_sigreturn
Message-ID: <20180907030724.GA11594@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <0f6a6aa2e458df2c3734cf60a68e6f69f0eb1e68.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a2z2=0qNWZft6rokx0i=8E5ZbEg1WL5HMYg_DE1wPvZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2z2=0qNWZft6rokx0i=8E5ZbEg1WL5HMYg_DE1wPvZQw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:02:42PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > +
> > +       /*
> > +        * __NR_rt_sigreturn must be 173
> > +        * Because gcc/config/csky/linux-unwind.h use hard code to parse rt_sigframe.
> > +        */
> > +       err = setup_vdso_page(vdso->rt_signal_retcode);
> > +       if (err) panic("Cannot set signal return code, err: %x.", err);
> 
> __NR_rt_sigreturn is 139
Yes, we've changed to use asm-generic define, and I forgot to update the
comment.

 Guo Ren
