Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeCERrQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:47:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCERrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:47:13 -0500
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: use generic dma-direct and swiotlb code for x86
Date: Mon,  5 Mar 2018 09:46:42 -0800
Message-Id: <20180305174655.9878-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series switches the x86 code the the dma-direct implementation
for direct (non-iommu) dma and the generic swiotlb ops.  This includes
getting rid of the special ops for the AMD memory encryption case and
the STA2x11 SOC.  The generic implementations are based on the x86
code, so they provide the same functionality.
