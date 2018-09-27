Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628EE21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628EE21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeI0Ri0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:38:26 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48459 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbeI0RiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:38:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08068142|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.CwXstet_1538047199;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwXstet_1538047199)
          by smtp.aliyun-inc.com(10.147.44.145);
          Thu, 27 Sep 2018 19:20:00 +0800
Date:   Thu, 27 Sep 2018 19:19:59 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 06/30] csky: Cache and TLB routines
Message-ID: <20180927111959.GA20967@guoren-Inspiron-7460>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
 <20180925072407.GA6999@hirez.programming.kicks-ass.net>
 <20180927052737.GA28407@guoren>
 <20180927070859.GC5254@hirez.programming.kicks-ass.net>
 <20180927081138.GA308@guoren>
 <20180927090134.GG5254@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090134.GG5254@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:01:34AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 27, 2018 at 04:11:42PM +0800, Guo Ren wrote:
> > On Thu, Sep 27, 2018 at 09:08:59AM +0200, Peter Zijlstra wrote:
> 
> > > That's not what I meant; I meant you need something like:
> > > 
> > > #define flush_cache_range(vma, start, end) cache_wbinv_range(start, end)
> > If you remove the tlb_start_vma in my tlb.h, I want to use cache_wbinv_all() is
> > more safe. And I'll improve it in future.
> > 
> > My cache_wbinv_range(start, end) won't care vma->mm's asid and they just use current
> > asid in mmu reg. If current_mm != vma->mm, then flush_cache_range will be broken.
> > Perhaps, I need improve flush_cache_range first ...
> 
> Ah, ok. In that case I'll leave it to you to either use
> cache_wbinv_all() or improve the range flush. My only request would to
> stick on a comment to explain the reason you're not using
> cache_wbinv_range() if you choose to use cache_wbinv_all() for
> flush_cache_range().
Ok, the comment is necessary and I'll do it in next patchset.

Best Regards
 Guo Ren
