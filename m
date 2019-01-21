Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02620C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD83220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079905;
	bh=a4Z/VIJhSfaXp8+alFgL9AoiTm6KJS/oPZk8IPnJNZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uwUisl9CAK5cD8obocfEe1JtvCzB2a3YOkl8f0fHbcY+VqzjTR/bP6roAY7cfpxrw
	 6jb5azw5DrUS5PghgaQM0FsiMmISyg3CZJNL9E3EqM307i6754I3CeP6jjpT35RcE0
	 S3t+TwpJKuIRz8gEA6+nAY3mFDfL9Fzj8mcXj5qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfAUNyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731393AbfAUNyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D32B2084C;
        Mon, 21 Jan 2019 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078841;
        bh=a4Z/VIJhSfaXp8+alFgL9AoiTm6KJS/oPZk8IPnJNZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYmcOilvumaC6j7jleJRrGXIFd8hzOkhFlwBpc7R//BPDROGPYfCUfrIJ/y7kS8Xq
         c1ftv3QpOoNMMIrZMwSLQG4qJSXV3CZwrFaNbIpGWTFfl0gtPqjJFByfmgUnBtGl8r
         ySNW0rn5aZuatPCRy4yfwsIxdNCpqvn+NeH6tqYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YunQiang Su <ysu@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, pburton@wavecomp.com,
        linux-mips@vger.kernel.org, aaro.koskinen@iki.fi
Subject: [PATCH 4.14 36/59] Disable MSI also when pcie-octeon.pcie_disable on
Date:   Mon, 21 Jan 2019 14:44:01 +0100
Message-Id: <20190121122500.659521204@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YunQiang Su <ysu@wavecomp.com>

commit a214720cbf50cd8c3f76bbb9c3f5c283910e9d33 upstream.

Octeon has an boot-time option to disable pcie.

Since MSI depends on PCI-E, we should also disable MSI also with
this option is on in order to avoid inadvertently accessing PCIe
registers.

Signed-off-by: YunQiang Su <ysu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: pburton@wavecomp.com
Cc: linux-mips@vger.kernel.org
Cc: aaro.koskinen@iki.fi
Cc: stable@vger.kernel.org # v3.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/msi-octeon.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/mips/pci/msi-octeon.c
+++ b/arch/mips/pci/msi-octeon.c
@@ -369,7 +369,9 @@ int __init octeon_msi_initialize(void)
 	int irq;
 	struct irq_chip *msi;
 
-	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {
+	if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_INVALID) {
+		return 0;
+	} else if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {
 		msi_rcv_reg[0] = CVMX_PEXP_NPEI_MSI_RCV0;
 		msi_rcv_reg[1] = CVMX_PEXP_NPEI_MSI_RCV1;
 		msi_rcv_reg[2] = CVMX_PEXP_NPEI_MSI_RCV2;


