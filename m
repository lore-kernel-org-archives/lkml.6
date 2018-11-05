Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2857FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A0920827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lahhwo1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A0920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeKEQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:33:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKEQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pWxxVre3cZihukewmcPWEi7E4zJtjCwC05falFMLqXs=; b=lahhwo1gLMp8/z+Vzahm8n3Ud
        +KcqwTYaWfQjpCvXm2rRGq8QAIAapLTQsN/EatiWjL5ra64XihVF0gif+JD4+t54z+JFo+BAEPGsp
        mYAXvN4Lnt9wxhn78Xm8f1NGGmMLlNGQLFNOClzXQWAPGsz3JfGo7fXxqDXBj5jf3wj2SLCooyAjN
        BaDcZywSXl1KUbBxhfkxWO9+HIPXbiEcsXuhbFhSYjJafSD1khwIjbJatoRi9ya3N7Et4FAPJit3U
        qqb1dSpbVQybp0kyzHePcIG9ygoT55/mQkVPXrVKlDPkC3BYaZNDGShKtAENRFUYJgthg3WgSgwbu
        PMKQrp+Vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJZ6H-0005Pm-ND; Mon, 05 Nov 2018 07:15:05 +0000
Date:   Sun, 4 Nov 2018 23:15:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Shared virtual address in scalable
 mode
Message-ID: <20181105071505.GA13230@infradead.org>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105053151.7173-12-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/include/linux/dma_remapping.h
> +++ b/include/linux/dma_remapping.h

FYI, this file seems to be entirely VT-D specific, but has an awfully
generic name.  It should be renamed to something more suitable (or maybe
just merged into intel-iommu.h?) and also grow some comments describing
the contents.
