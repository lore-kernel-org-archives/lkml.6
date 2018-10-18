Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD3ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4FD2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4FD2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJRKBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:01:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33159 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbeJRKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:01:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1441471|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.D3hge5D_1539828124;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D3hge5D_1539828124)
          by smtp.aliyun-inc.com(10.147.42.135);
          Thu, 18 Oct 2018 10:02:05 +0800
Date:   Thu, 18 Oct 2018 10:02:04 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH V9 05/21] csky: System Call
Message-ID: <20181018020203.GA12027@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <d83762614122402ba4b55524e35b418c9f6baf53.1539655731.git.ren_guo@c-sky.com>
 <CAK8P3a3bNST+ZuPjLG0_sHjC=Ac0ir1omhHvMn9tz4zs+Kg9yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bNST+ZuPjLG0_sHjC=Ac0ir1omhHvMn9tz4zs+Kg9yw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:02:33PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds files related to syscall.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I had a detailed look at this one and provided lots of comments, however
> one tiny thing escaped me:
> 
> > +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> > +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> > +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
> > +__SYSCALL(__NR_cacheflush, sys_cacheflush)
> 
> It's odd that the second one uses __NR_arch_specific_syscall + 4 rather
> than +1. If you can still change that changing too much other stuff,
> that might avoid some head-scratching later. If it causes problems,
> just leave it and maybe add a comment saying that the numbers
> inbetween are still available.
Change to (__NR_arch_specific_syscall + 1) is ok for now.

Best Regards
 Guo Ren
