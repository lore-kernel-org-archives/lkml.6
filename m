Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF5421582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x/A9oP/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF5421582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbeKLITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbeKLITI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:08 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605362154B;
        Sun, 11 Nov 2018 22:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975352;
        bh=bImf6TPBjL37HW+tU7wP8MHIz3R//HXsF+FW9QHB2q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/A9oP/oLKZjfYf1PQ2anCdR0/Nj2XPI3UZsEDYAJ9rRi9TAmkErWgEWpdZlJuehS
         tdzA0AK3hriFAIFLKzCnnqvGyOsP3L8ZHOZRHDJ89Ya/+jMDjujeyBkO71eNHGldrH
         o24thd10RyvAeCSA8dQT6c5wAmsljbHHSJ0NidMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.18 003/350] mtd: spi-nor: intel-spi: Add support for Intel Ice Lake SPI serial flash
Date:   Sun, 11 Nov 2018 14:17:47 -0800
Message-Id: <20181111221707.234104204@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 42460c31ae96cbad5ae226ee6c10bd8d70d764ae upstream.

Intel Ice Lake exposes the SPI serial flash controller as a PCI device
in the same way than Intel Denverton. Add Ice Lake SPI serial flash PCI
ID to the driver list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Marek Vasut <marek.vasut@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/intel-spi-pci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/spi-nor/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/intel-spi-pci.c
@@ -65,6 +65,7 @@ static void intel_spi_pci_remove(struct
 static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x18e0), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x19e0), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x34a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
 	{ },


