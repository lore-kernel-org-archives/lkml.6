Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F28C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF0E2148D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CWg12H+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfBAXRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:17:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mhq2KZqUZtMJuQW3pbnuTPbHweB9VmjgVeq2irU/S0o=; b=CWg12H+seyCQb819CWEDZfkkY
        x4k43RBlOrw0sGsvfHf0AHLQ8mHQa+SzSIcRBrvZGpnpoQ5VrsrxRHpVN6te1l3YtsUMyHqe5gAec
        Nx95VoUsPr0y9k5sQ7kBzf9As1Uo2eOrmf8xcJcdJbVxfqGSytV9xm2trDmpmEkpcPrPkWNZi7/Ni
        6gEDfsNV4a7gHi3KoldiGIcQ6fA+3g+hywS7ZcznsvMu/dvIsgr/+FtLTnCjImRbAjPjjLyMZhzAb
        edQjOLWCKFFV9igmDS1kKDBGyGTpG9euuROSt/J8ikaaX/LSexigJ5upgvrTzXxavsdSVK6V4cST5
        jWbefSMpA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpi3U-0007Hx-9X; Fri, 01 Feb 2019 23:17:04 +0000
Date:   Fri, 1 Feb 2019 15:17:02 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dell_rbu: stop abusing the DMA API
Message-ID: <20190201231702.GD105752@fedora.eng.vmware.com>
References: <20190129073409.7247-1-hch@lst.de>
 <4fce2a6c-2e57-bc29-0dca-8ed3bef95333@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fce2a6c-2e57-bc29-0dca-8ed3bef95333@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:28:46PM -0600, Stuart Hayes wrote:
> 
> On 1/29/2019 1:34 AM, Christoph Hellwig wrote:
> > For some odd reason dell_rbu actually seems to want the physical and
> > not a bus address for the allocated buffer.  Lets assume that actually
> > is correct given that it is BIOS-related and that is a good source
> > of insanity.  In that case we should not use dma_alloc_coherent with
> > a NULL device to allocate memory, but use GFP_DMA32 to stay under
> > the 32-bit BIOS limit.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---

...

> 
> Acked-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 

Ah, prematurely pulled in Mario - thanks Stuart.

-- 
Darren Hart
VMware Open Source Technology Center
