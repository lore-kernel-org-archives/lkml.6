Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 52E24C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074EF208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ATx6MNx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074EF208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935929AbeFNMAf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:00:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754912AbeFNMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NRdc1yCyreCJvxMM+mZb0ScwiKpT3ergAQ6nrrMxO3I=; b=ATx6MNx0dXkEZrvPyJjsTlSZC
        HHbF8YZyxLENquYCvsrYI+LvAUl9Bl90MzdfVjoOhRotGS7RnSbqPhm5x5b9ynTkXMABi/K7ExDzL
        WAHDXmt18qIVyiofUJ1cCX+Yz58rCRN2S8eDhX6oJmi4IRGj8e6+rHQHEx5mnZBulRFwOyHrx11Ym
        du2+J9x8wY/xZ/RD/I+k0iDifcQcgGPu2G8fmYxDAGTuQo+OjM79PD0pex6jTL+086ivQKs3GO4yH
        PtAp/IciuHApN50hM/mn9QcfD8GMym1pgWriKW+8Fh6DqjLVfJrSgRmSn4sl137ve3oQ7qv0DYouM
        XYMy2Tgbw==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTQvX-0002sW-ES; Thu, 14 Jun 2018 12:00:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC] move dma mapping code to kernel/dma
Date:   Thu, 14 Jun 2018 14:00:27 +0200
Message-Id: <20180614120029.27315-1-hch@lst.de>
X-Mailer: git-send-email 2.17.1
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm tempted to send this little file move series to Linus around -rc1
where it would cause the least harm.

Opinions?
