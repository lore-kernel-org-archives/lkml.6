Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F80C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD10214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GgfyM9rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD10214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeHULHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:07:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeHULHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZ2rJodlNxBae6WT+b2Zm7gQ8wbHY5V/Sm3rvAG+giM=; b=GgfyM9rNqjuIbnQqK7N1UZfAr
        nhMhNOVnHMm5F5/mFZE7tEEM8JJWsdv9cjjBhX4WMlkLspcNgEVxFS8HyDW2J/iHokRLXn8sRYekd
        ocXfa0uSuJpNaRLavCKfloeAHyV9h6bLkf1UcOlenYGrZxhpyiQrHuEcwhy6DLsbu8RbTWmK50Yay
        q6KNLXx2V9uvJbpxBSsR8eugCNFvBS3aQHU45ex1Dy3zc76qBtBspBZ/Lwe9EoP1hF8Wjp5WmFviv
        SvwulNzBlF7pmnCzXLZYOD4K/jet2vKA1/q9t/anVy6WmmDgXRlJLsPBp+9hNyYjZVDsJynxpG9oj
        5QL7zVMsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fs1Os-00008g-KJ; Tue, 21 Aug 2018 07:48:26 +0000
Date:   Tue, 21 Aug 2018 00:48:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
Message-ID: <20180821074826.GA28079@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
 <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
 <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:51:03AM +0530, Anup Patel wrote:
> Having thought about this more, I think cpu_ops should be an pointer array
> of NR_CPUS size. This means its not necessary to have have same ops for
> all CPUs. The ARM64 implementation of CPU operations also allows separate
> CPU operations for each CPU.
> 
> For example, let's us assume that we have an SOC where we 2 cores
> per-cluster and N clusters. All CPUs of cluster0 comes up at the same time
> whereas cluster1 onwards we have to bring-up CPUs using special HW
> mechanism.

All this (including the patch itself) seems a little hypothetical.
I'd rather only add all this infrastructure once it actually is needed.
