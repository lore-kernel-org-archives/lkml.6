Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602AA20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQqSFAnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602AA20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbeGXKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:12:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388183AbeGXKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LnRtPCzjtqPyA1bIeiKzRLggHqhK6KPMwRNG3gUGTm8=; b=tQqSFAnOfY1OUdwkRe7RBQ6A7
        JF1KsEYmTVxeCrZbWowh0LelvaZ6bsBX42dCPcD2YC2dzyVYGuHZalfqSUY3svwZ4C7Nd7PkxXxbD
        J88rMOE4ea6T0kX9PBNJ/QDCqsCOh896QYIRSyB7kkGF55myfBjR7mav2wHi8ZokGHOvAidLc0QSt
        0NIswmRsVkGUh+7yHXbWwJaufWUUJtmSfPJMmo7ChHPot6oY8/oCb2vZRrqkiNnhX0LtfdA0yKO7e
        jMpiwRKkiPy1/RjUPn6bY5GRyV3MV057eQ9MkaQIbhl0NOFj/INYLMnlDT8+Sg1UgGoArlFM+DDwc
        MVeEGaPWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhtHR-0005kv-RD; Tue, 24 Jul 2018 09:06:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FAC520275F47; Tue, 24 Jul 2018 11:06:51 +0200 (CEST)
Date:   Tue, 24 Jul 2018 11:06:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jiang.biao2@zte.com.cn
Cc:     chen.lin130@zte.com.cn, mingo@redhat.com,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        tan.hu@zte.com.cn.cn, cheng.lin130@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: [PATCH] sched/numa: do not balance tasks onto isolated cpus
Message-ID: <20180724090651.GK2494@hirez.programming.kicks-ass.net>
References: <20180723084031.GX2494@hirez.programming.kicks-ass.net>
 <201807240911372861670@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807240911372861670@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:11:37AM +0800, jiang.biao2@zte.com.cn wrote:

> >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> >> Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
> >> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> > 
> >This SoB chain is invalid.

> Mm, we don't quite understand what the *Signed-off-by* precisely means,
> Does it only mean DCO(developer certificate of origin)?
> As we understood, multiple SoBs could be used to indicate co-authors.
> If SoB only means DCO, how can the patches reflect co-authors?

It specifically does not allow for co-authorship. I think there's a
Co-Authored-by: tag invented by some people (check the git logs) but
especially for such a dinky little patch, I wouldn't bother. Maybe have
your co-workers review the patch or something.


