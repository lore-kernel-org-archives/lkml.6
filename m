Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB13C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A52C218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKgNahiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfADR4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:56:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cFhh/SpczrtPJ7xHqkNJnPu29+v6tO2n6e+8LLbs2lM=; b=eKgNahiLRd5ko5k90O/tS/8r6
        19xDAFf87DSyh4c6+8kz+fh8Dlsy7JK1oX4TgfSsHLCSwXAGEc/2UHm3kMLOIzSdsXmpRM8DVz7di
        yHTYM+hCWOmr2qj+yEVs5PVDX0vteRPunVSrc+Irq0zj6J4BRZwMcR2ynNSf5rEtowUDyVrlV0ECk
        66CybBYhPLnlGKQEHl5M0+U4nlHpdwNd08VC2qrxT+0u/9yih7uExV+1ETQvSm/IUg0PEvw9FD20e
        xc8OKN3zdrLIZXNw1MB9r7ZlMfPVtjV9BUh/LMfRRcWomOelDDlovJi53S3zY5oP6PcQR9903N9DR
        cj+RmJj8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfTi3-0002y7-Sj; Fri, 04 Jan 2019 17:56:39 +0000
Date:   Fri, 4 Jan 2019 09:56:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
Message-ID: <20190104175639.GA6347@infradead.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au>
 <20190103080229.GB11147@infradead.org>
 <alpine.LNX.2.21.1901040844380.658@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1901040844380.658@nippy.intranet>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:08:13AM +1100, Finn Thain wrote:
> On Thu, 3 Jan 2019, Christoph Hellwig wrote:
> 
> > > +
> > > +const struct nvram_ops arch_nvram_ops = {
> > > +	.read_byte      = nvram_read_byte,
> > > +	.write_byte     = nvram_write_byte,
> > > +	.get_size       = nvram_get_size,
> > > +};
> > > +EXPORT_SYMBOL(arch_nvram_ops);
> > 
> > I think something this internal should always be EXPORT_SYMBOL_GPL.
> > 
> 
> By "internal" do you mean "not involving interests outside of the Linux 
> Foundation"? TBH, I don't know who's affected.

Linux Foundation doesn't matter.

But as far as I can see you export the struct from arch code
for nvram.ko to use them and no one else, which is clearly internal.
