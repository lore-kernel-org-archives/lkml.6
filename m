Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF90FC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE40120866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bG8rBtal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfAONpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:45:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAONpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7zIMozIfpLIlfZhxNasaMCwzLcBBuGWx9uKWQ3qVsiQ=; b=bG8rBtalH6iOh6ASuhrjOfYhn
        obI+Nd4ksXUK/+kdL1lDV0vKSbMluFmFUcqCUGb4jFrZdrUEEUaw1brpu3AturSipNEpJ2b+c+XyB
        9pUP9VTiAGAMgRQdVq8IwzChjV5VYuyoeWHD6Ac/YPgYqTE1yuLKP/ZECOenKVzr5EaR0WDeyfarz
        mCX1roKrwf9iq1Yn+NH9BCbyAB+DbZ87UJVoAuQzGRwDM3Dj2VeJtMUSYESTdrhzA3cj8gypluycI
        lXs3fGy74zo8DcFuzt/xPQrIwXH09qzWc185uZF2MC+dJls+zXvjE4bhfHWRtWqHpPCdJlp8xWWVA
        F/idXNR2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP1l-0007BL-A3; Tue, 15 Jan 2019 13:45:13 +0000
Date:   Tue, 15 Jan 2019 05:45:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/5] RISC-V: Move setup_vm() to mm/init.c
Message-ID: <20190115134513.GE13216@infradead.org>
References: <20190107161047.10516-1-anup@brainfault.org>
 <20190107161047.10516-5-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107161047.10516-5-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:40:46PM +0530, Anup Patel wrote:
> From: Anup Patel <anup.patel@wdc.com>
> 
> The setup_vm() is responsible for setting up initial
> page table hence should be placed in mm/init.c.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
