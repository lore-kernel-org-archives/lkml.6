Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79D95C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3026820020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VAvcsjkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3026820020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935485AbeFML6N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:58:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935242AbeFML6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fk2Yiqma8gMrVgqe7N8ODufD5s7YBzZY48mwm1IluqE=; b=VAvcsjktIWEcZJsh79P1mOku9
        MNGNPU8hshv80yLDixPt5wEPtbsHE34JhD2Ws1bipg4BN9D/v2Iz2GqpNAWB2pQ+iztcuObfG+gAE
        SPiK6r0sjAKSd9JY+vaIojMz5+2P0ku4e6sXIBqQFG8vWPHc/ChBfqaAt4biiFOR/yXOYZ4j0Ijrc
        GqnJwXbjRsQcLzRjHdyd/rXKxtQcU/tzEZr7D1Bv93YFX27rm+dhsgZWZGvlau++IHC8RhdVOd2Bq
        rC+4FAb7WYMSKj13H2+rdfKmrMdvdGIBz1RxwitW05765cV5GZW+6gGxqzsyyJmvd2D8AQ0gDAbzU
        BzWIep9bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT4Ph-0003ZI-68; Wed, 13 Jun 2018 11:58:09 +0000
Date:   Wed, 13 Jun 2018 04:58:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] scsi: check for equality of result byte values
Message-ID: <20180613115808.GB12438@infradead.org>
References: <20180613075349.7509-1-jthumshirn@suse.de>
 <20180613075349.7509-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613075349.7509-3-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 09:53:48AM +0200, Johannes Thumshirn wrote:
> When evaluating a SCSI command's result using the field access macros,
> check for equality of the fields and not if a specific bit is set.
> 
> This is a preparation patch, for reworking the results field in the
> SCSI command.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

