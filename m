Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 468B4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E263520020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EACQdxua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E263520020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935464AbeFML5g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:57:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935296AbeFML5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NTDDelqVXNU1rxqJEKZgqcKcApq4OwLTlcAFp6ZNusc=; b=EACQdxuaf6Uwo/23L/nivjpWJ
        Puk0uw5k9FimjGdQc5gSqEV04OQJLm7UJD3gXFZN2plncWJHL8sjWU95PfVclX1ivlplzGii3r0rH
        iEaTabU1JeBKJfp3xsYft8B3tmJMmbhGcMviDRKEzZpbsf3XYm7SoNIPDXylHDs/WKkF2xM/sJ+Hi
        4LDGy1PzIrV7RzoJo30SeocEAWAf4NWjsgKZ3WTUCnoXLrRmxUrE8JKUwO8GkN+ooLQpt7/7Dy3wt
        UKeflYYrHCsshXGj4N82o/IFLgumAD6kw2hGnYfWG6KKP3GaLpkEirjUK79g3iI4+lPmEUOuic1EV
        TTpAp7k4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT4Ou-0003K0-5J; Wed, 13 Jun 2018 11:57:20 +0000
Date:   Wed, 13 Jun 2018 04:57:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] scsi: remove Scsi_Cmnd typedef
Message-ID: <20180613115719.GA12438@infradead.org>
References: <20180613075349.7509-1-jthumshirn@suse.de>
 <20180613075349.7509-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613075349.7509-2-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 09:53:47AM +0200, Johannes Thumshirn wrote:
> This will make subsequent refactoring easier to handle.
> 
> Note: this patch is nowhere checkpatch clean.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

Thanks, we should have done this long time ago:

Reviewed-by: Christoph Hellwig <hch@lst.de>
