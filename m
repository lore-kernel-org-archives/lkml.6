Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krt+Mg9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfAONxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:53:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfAONxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=krt+Mg9R/fg65kiC+Zqv6esmS
        Rs876rwRP3Ig7xNhdLstMVqus99umYCtti8SDTKZ1NNqpL4VR27cX355iZy6NdRmt2q2vdD3Vrl5q
        yQK8p4ehM7GnT+RKE5f50V8vvXLHXiKBPhik78U27QethIcGcWVeXJ+Wqy207Lz+oxc0WGETY2UHH
        HEmfN0X6MKrK2kr+xR8iRUw9K9+KlVGUFqEp//UGVO0S0KWOVP4YfelZYmmuHm6wp6kvY0peUrQWW
        5m7AKHYf2AvNddDCzriaNCvqSsQDLdL9/RhTOa1UXi4WB+kgw1juUKymNOrKdD+W0QDAmae6cZZ5F
        WKfA6D33g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP9p-0001u1-BV; Tue, 15 Jan 2019 13:53:33 +0000
Date:   Tue, 15 Jan 2019 05:53:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: Re: [PATCH v2 5/8] RISC-V: Compare cpuid with NR_CPUS before mapping.
Message-ID: <20190115135333.GE28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-6-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-6-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
