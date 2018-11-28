Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895E42082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIfzD5F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895E42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeK1SFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:05:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeK1SFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=WIfzD5F+K5raFMdUD0Da5mY1d
        cBUV4GHgHODXZecSs0FMlMMR3Pv+vwdjq0SmRSkCwkjTjxqBcHGnVRNszBh5A9r92EVkRcNO3piXQ
        Ef2N6nqJv2EdwU5gB6Ss0snvP9Up6euWAaMgssWysPJCBb37gpuSnEYn8iCP/Q6cUpXnLHY6cR1q8
        R2aMZpN0DyIAGI2bFJ0B+wYCF2bEt5tkfT0h8nXv1BtuwrHnG2kxKPZCcEbs5Ec9VSPlP2RZWpRmq
        vAumspAc5G/Q7dLVF/rL+gZhTA7lExkfe4qmydBUexqY3HHwpWSgOz1J9/7nH67EAfVYqPEMsu+mW
        aYM1r8KPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRtuH-0000xo-AY; Wed, 28 Nov 2018 07:05:09 +0000
Date:   Tue, 27 Nov 2018 23:05:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: read ->revision before dropping pci_device reference
Message-ID: <20181128070509.GA30936@infradead.org>
References: <1543369243-64252-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543369243-64252-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
