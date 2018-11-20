Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9718C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D62E20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CPNHLAd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D62E20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeKUCtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:49:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeKUCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jdS2Sdu/yFhH1LL1OwIuLdKpJ2CmEgtb+qzNiSlaKHc=; b=CPNHLAd206Nzj49fUmRDUXApw
        M/rFPrfmbprNwUF2MUr92v+fuU60OCx9TZO6HynVha5NLrgSD342ltpZD5JeIZlJFojzllqYee2xn
        2gYa+v1isf7e9YA7oK3uP/3rkRdNLVuRUyJtn6sQCQA1AJbJEFnN5jEDfpsVKWpgxdz0dkLGBVCs2
        zCyEDJd/ojVP5uxOaGilF76zqC/RVHELaF6uMhmbZjimfn+YlSjE3hdQ90TxblOTrz/JzGfega/gU
        M51Og6aijik2Z/ZUty3E8J18CXP7Xu766KRegi3DsbbkxrbcTYUa7XSwCS9/ytD1C2XdobUrpEzeE
        T5d8n5l/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP8kW-0003Qg-H3; Tue, 20 Nov 2018 16:19:40 +0000
Date:   Tue, 20 Nov 2018 08:19:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] scsi: Add scsi_prot_op_normal()
Message-ID: <20181120161940.GA10454@infradead.org>
References: <1542725944-244183-1-git-send-email-john.garry@huawei.com>
 <1542725944-244183-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542725944-244183-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline bool scsi_prot_op_normal(struct scsi_cmnd *scmd)
> +{
> +	return scmd->prot_op == SCSI_PROT_NORMAL;
> +}

This "wrapper" just obsfucates the check being performed, please drop
it.
