Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF50ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC5E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC5E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeINTwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:52:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41183 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727676AbeINTwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0746592|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CqsOPFA_1536935840;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CqsOPFA_1536935840)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 14 Sep 2018 22:37:20 +0800
Date:   Fri, 14 Sep 2018 22:37:20 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180914143719.GA27689@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> > Thanks to everyone who provided feedback on the previous version.
> >
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.18.4
> >
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> >          SMP ...)
> >
> > More information: http://en.c-sky.com
> 
> This looks good to me overall. I think a good next step would be to get the port
> included in linux-next, by preparing a git tree with all the patches and asking
> Stephen Rothwell to include it there. Further comments on the architecture
> port itself can be done on top of the existing patches. I would suggest you
> base the git tree on an -rc release (either 4.19-rc1 or 4.19-rc3) and then never
> rebase again.
Nice :) I'll follow the rules.

> 
> You have included a couple of drivers in the submission: two timer and
> two irqchip drivers. Please leave those out for the moment, and either have
> them merged through the respective subsystem  trees, or get an Ack
> from the maintainers to merge them through your tree.
Ok. 

> 
> I notice that a lot of the patches have no changeset comments on them.
> You should fix that and make a habit of describing every single patch
> with a few sentences, even if it seems obvious to you. Have a look at
> the changeset descriptions for the nds32 and riscv architectures when
> they got merged.
Ok, I'll fixup them.

> 
> One big question for me is what to do about time_t. Deepa and I are
> in the process of finalizing the system call ABI for 32-bit architectures
> with 64-bit time_t, but we are not done yet and it won't be complete
> for 4.20. If you target 4.21, that could be a chance to make csky the
> first architecture to only need the 64-bit time_t interface, with the
> corresponding user space changes.
y2038 is very important and csky32 has the issue. But 4.21 is too late for
us, we really want to get into kernel.org as soon as possible.
We could remove 32-bit time_t in future.

Best Regards
 Guo Ren

