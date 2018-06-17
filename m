Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D156C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E2020874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mY7iS6Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E2020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeFQByF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:54:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932815AbeFQByE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MQSFtpj+CzW9VjzahFIgMfo/GQZ+SLB7lEps/OqJb5w=; b=mY7iS6Dnb2oOIVPVDoM+3v18v
        /YSlsrKL8vPJbl/AiFNWZIGJuxgKQBkbuzAUjebAOH3clbYMQK2MUwQ4uksMMSWtmliwo++ywh6Ck
        r6CswJB5ncBiZozzUbek0cmtla/v2lmV995CCCWxtuCHZr8PIHi0EAuJDZK0rUGsyunpL8CQZ72Tk
        vm8HrQ/qzPUbP43EnI8on0MIfMIQT7ofi5cQ9VbJGHkgICuPVNZdoV6fuuzXKXTnCI12xwqF0UcAI
        t63uXgNCVHf+oSIWbMkHI2jrO5xDNEK/SxTvGR2Qpz8yUrtdv2fGF2eF2l3/O8jPfkoAnY2LftE/s
        QiJ3KHnMg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUMtD-0006uB-Bj; Sun, 17 Jun 2018 01:53:59 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nipun Gupta <nipun.gupta@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] linux/device.h: fix kernel-doc notation warning
Message-ID: <9316b40a-c098-043d-25db-faaa83885d4c@infradead.org>
Date:   Sat, 16 Jun 2018 18:53:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc build warning (missing " *" at beginning of line):

../include/linux/device.h:93: warning: bad line:                         this bus.

Fixes: 07397df29e57c ("dma-mapping: move dma configuration to bus infrastructure")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nipun Gupta <nipun.gupta@nxp.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 include/linux/device.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-418-rc1.orig/include/linux/device.h
+++ lnx-418-rc1/include/linux/device.h
@@ -90,7 +90,7 @@ extern void bus_remove_file(struct bus_t
  * @num_vf:	Called to find out how many virtual functions a device on this
  *		bus supports.
  * @dma_configure:	Called to setup DMA configuration on a device on
-			this bus.
+ *			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU


