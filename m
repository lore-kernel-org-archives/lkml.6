Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeDIJP0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:15:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDIJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:15:25 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: fix x86 swiotlb regression
Date: Mon,  9 Apr 2018 11:15:16 +0200
Message-Id: <20180409091517.6619-1-hch@lst.de>
X-Mailer: git-send-email 2.16.3
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch fixes a regression in the x86 swiotlb conversion.  This mostly
happend because swiotlb_dma_support does the wrong thing (and did so for
a long time) and we switched x86 to use it.

There are a few others users of swiotlb_dma_supported that also look
rather broken, but I'll take care of those for the next merge window.
