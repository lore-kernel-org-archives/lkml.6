Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8E6208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XV9FIXtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfACPhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:37:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730762AbfACPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KhW3mww2SmUz3RLln/CADN6p3e2kGZrp4327QA+hiz0=; b=XV9FIXtS4vMcykfceL0UQYfEC
        3WthkclJdlkfVC/wkVnHBgOR0fbUXW7XT0iARiZnvEidgNMrCiRuxHNc1zk5gWbKm5yNMqD+7nZuo
        kdD4I87sHSjRaEZul0e9eE7V8OygCrq7bAaKXPMzK6xk4h+6WtDzjcDjbfdi7V+rZ40BA5MFAm0Qp
        7598Ehgf6sU7DNiS+cGceoyHMv00EsyO500krEBB34RSL2znatygojaEOK4bHaKlxtY3eSv43889/
        9VQa0/dPeKYWid9+t7lNpfMYl4dX6u/zCzpAu2YtLTG/eq3tzbpQqKIMqyNziTT3FtqMOQ78U410z
        H0w6mPmug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gf53O-0004vR-IJ; Thu, 03 Jan 2019 15:37:02 +0000
Date:   Thu, 3 Jan 2019 07:37:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, alexey.skidanov@intel.com,
        linux-kernel@vger.kernel.org, shijie8@gmail.com
Subject: Re: [PATCH 2/2] lib/genalloc.c: export symbol addr_in_gen_pool
Message-ID: <20190103153702.GA18796@infradead.org>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
 <20181224070622.22197-2-sjhuang@iluvatar.ai>
 <20190103075550.GA11147@infradead.org>
 <20190103101159.GA8656@hsj-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103101159.GA8656@hsj-Precision-5520>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:11:59PM +0800, Huang Shijie wrote:
> On Wed, Jan 02, 2019 at 11:55:50PM -0800, Christoph Hellwig wrote:
> > On Mon, Dec 24, 2018 at 03:06:22PM +0800, Huang Shijie wrote:
> > > We may use the addr_in_gen_pool() in the driver module.
> > > So export the addr_in_gen_pool for the compiling.
> > 
> > Please send this along with the driver that plans to use it.
> The driver is still under develop with the FPGA, and our hardware chip maybe
> tape out at next year.

So lets wait for the driver submission or another user before we
export the symbol.
