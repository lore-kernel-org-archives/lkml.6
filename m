Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A322086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SLI+hIQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393426AbfBMRvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:51:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393352AbfBMRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e0XajKUJVgWIZNiGpSTC786uoUx/+gkARSonru6qXcU=; b=SLI+hIQXsOv9c+uAxbTOEMsIt
        NSNCkr+kl0uEl0B2SXBnxCZz4QB2EjL3T2YQ9YW+trwyVDm9NSpqehw1PT7VVzlKcKjbv4UXwp+38
        OUgj5c04JPqSbGNCImnP5rNfJFsNah/uLFl4ax0NXhj6G2IfQErQb7PWeklkwbztMx5P396pLu+cX
        Zxhd9zWmRSwGJ+P61DeUjpH8ekp9E35f2pgEgde098oPJVCf+jRkdDuX8IV0YptXLNHuec0xuwB3l
        5/1y9s9tOSQitVllBQyowN1jOZ6c266vbjtLL2Mmq41Xn/D+iYhx0Qnh8lx2vCQ6Evc0jA03YbSSX
        2p/CePLDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyfo-0002hA-80; Wed, 13 Feb 2019 17:50:16 +0000
Date:   Wed, 13 Feb 2019 09:50:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v6 5/5] RISC-V: Free-up initrd in free_initrd_mem()
Message-ID: <20190213175016.GA4625@infradead.org>
References: <20190213115301.103989-1-anup.patel@wdc.com>
 <20190213115301.103989-6-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213115301.103989-6-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:53:51AM +0000, Anup Patel wrote:
> We should free-up initrd memory in free_initrd_mem() instead
> of doing nothing.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Note that I just sent out a series that implements a common
free_initrd_mem, so if that gets merged we can eventually remove this
copy entirely.
