Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03564C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B163821471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cII4nuTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B163821471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeJBVep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:34:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeJBVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LoTEVUpsbl6ySs3MMrl6YM2D8VBiHyBCAof5+e/2Zo8=; b=cII4nuTMtXhC8SZFH541cN22l
        UWm7GmaNhhpeGKk/6TF3wQOz77EUsR+UKRBP5vsgalJpHkGymXC873aDr/QOtwHO2Q0wVlO6qcAC1
        fjGGNPrqoix2bxbAQdStNPAjUXPQusggGcik2ZZ5HtqP/O3ctgAPSxkVHqRukkIjM3e1X2t1tj0Kf
        Fv0aWYjcqrDy0bluDqfzr8dYOgr+R/E8L1b4rYGH+ee2hojWEG8ZC/OSCaWNWBLO81GYaLjDkj1gg
        PN1fv/Us+xW7sWtLFpvEYpazCDXtElhPcJAEindwrB7evxHLaV1Fpqi4k1lZubYBROTBK6JNamKYx
        qp7AAlj7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7M0n-0002lx-9s; Tue, 02 Oct 2018 14:50:57 +0000
Date:   Tue, 2 Oct 2018 07:50:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
Message-ID: <20181002145057.GD3889@infradead.org>
References: <cover.1538470103.git.zongbox@gmail.com>
 <3f1967e8be0c25910bf04181e84b46a788a156d7.1538470103.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1967e8be0c25910bf04181e84b46a788a156d7.1538470103.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:52:30PM +0800, Zong Li wrote:
> On 32-bit, it need to use __umoddi3 by some drivers.
> 
> Signed-off-by: Zong Li <zong@andestech.com>

Which drivers?
