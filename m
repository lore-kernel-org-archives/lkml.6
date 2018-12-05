Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8E2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BBD2087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IKQZ6VF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BBD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeLEOyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:54:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeLEOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+87eI+JEfkbPBCx04kQPJxYdbRPKuDj3Yo/fIN5ET/Q=; b=IKQZ6VF2gfcyvl1HtOrzFlfo1
        NRwmclD2fHTQgifM5ZN4N32k8bhEDQXZvSOgOx9otRjuw41xeEKMHqm5qzEtQp/TlzDEoyfcI508L
        LtVothsYBWdHT4VkhVQbT9uuUyFp5u0GTsWBkOdzTfdr8GyF3YQE+mn3xtWzAi3s9Zg5GnIqy9rSV
        m9IWjWTzXkmyCKZ54FlcRTHwWfhJw6cZHMVisAWxlpvc2DMsF7/pmiCM0G6XxXb/7DY6Z0qXJEmnx
        mlnnyGKxSB2WtPYOh9axao7fFY5TBm393gKLK2QGQx+ddDa/SPiTy9IAULyjwIIe+ffT4iCHHMYmh
        hnlqrA/SA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUYZ8-0003rC-Is; Wed, 05 Dec 2018 14:54:18 +0000
Date:   Wed, 5 Dec 2018 06:54:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Message-ID: <20181205145418.GA14251@infradead.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205143646.4876-3-joro@8bytes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void  iommu_release_device(struct device *dev)

Nitpick: there seems to be a double space here.

> +int iommu_probe_device(struct device *dev);
> +void  iommu_release_device(struct device *dev);

.. and here.
