Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B27C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8E12085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNM8tTol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8E12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbeKFAML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:12:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbeKFAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h2BlDet/fPD6Y2d6KY/ZuaiOLYAoAZYhd+pP1RMcruo=; b=XNM8tTolA6avQkCJUimzwV6Xs
        eaYYuXHqTmgMMKPP7IrwssNN+yRR79Jz4sbxWBHFAEvJmjFphvea+80AtifxJ7FQqeZxInQvPeAo2
        a37q+KfFefAylUSH8P/ZM5JuqwwZZRUrh9Ggp9rhnh6xDKzXwqmJAH8UlG6yVmt9IruKooeQl24dT
        MG0XRy3tFNemOeowm/mg82ZWG+jeTuU4xlLIw8SYR33fMs4ZotxUGENus6QKbrTNVvAoB6Xz14OI0
        Fi+wCn3siPaEOFKoQaJtbVHaKRhT+RPdiMijdM3H5VE0RN26sfiKzB0kuu0ZnDcHII+pGqkuLIMn5
        cyxWG5eLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJgEL-0007qR-LR; Mon, 05 Nov 2018 14:51:53 +0000
Date:   Mon, 5 Nov 2018 06:51:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Message-ID: <20181105145153.GA24925@infradead.org>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105073408.21815-7-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use EXPORT_SYMBOL_GPL like most of the vfio code.
