Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0A0ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414162150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gP/D4wsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414162150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbeIUMpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:45:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ztEZGenQ9hqJNbL3xUezLpt5k3LQdxIMEwxQy3h+6Qc=; b=gP/D4wsYfIxFo9ELR6PalDxvj
        6syG9FhUfqRKaXVx5YMog7yhZPQCOY90FPwBl/KCePzCFvpd8SI9XyyFH1oYe2SWbFDax1rbt9blP
        8YOlmMayI3tdunSQmyr8S+3Mu0VjpD5aZTs3URJCOneYmNlf9pwOEHD50f8q4HGB07OcovAyb/Pdk
        Jev61KxVDP1fHqpZ4gSscidCTRWaOsI3WYVrubaGi7fwgVXaOltZgK82V7Qm3b0jAzQVM312Dhe1X
        cu+2Vk+3glOi/r5OWRBMNnlyldKROPtsNAE6xEutnnubLZMqhly2j9YPVoZyRFwDj4xylU7qLl0Te
        NrJPYxpow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3FOA-0003mu-R0; Fri, 21 Sep 2018 06:58:06 +0000
Date:   Thu, 20 Sep 2018 23:58:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, vincentc@andestech.com,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] RISC-V: Build tishift only on 64-bit
Message-ID: <20180921065806.GA8401@infradead.org>
References: <cover.1537260207.git.zongbox@gmail.com>
 <40c77db9ee2d23479ff90f2658539d29d7a30896.1537260207.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c77db9ee2d23479ff90f2658539d29d7a30896.1537260207.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:19:13PM +0800, Zong Li wrote:
> Only RV64 supports 128 integer size.
> 
> Signed-off-by: Zong Li <zong@andestech.com>

This looks fine.  Just curious, what do we even need 128-bit integers
for on riscv64?  Did you see any issues if you drop it entirely?
