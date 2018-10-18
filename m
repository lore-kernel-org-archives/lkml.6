Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB40FECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F6F21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvIGy7RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F6F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeJSCCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeJSCCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:02:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB8A21473;
        Thu, 18 Oct 2018 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885598;
        bh=RMyhEmdtaSo5SVU0Lceu054bv4gP0s14A5Z1ltxD5Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvIGy7RMeSuUkRa7Rdr4QOWOPNX3xkL1asOL8ZEfd5y/cVKG9co0KtEBNHmq8ORUO
         j2MNrryjQbojWqD1HKBVUyml7Xi/bjXf9qTLLUXy/TPCc11eD0jDvPVqdbgJFiHYo2
         6RtiELNssHNMLKtSxOHBoCvQO88CKELLCq9wrQJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 15/41] intel_th: pci: Add Ice Lake PCH support
Date:   Thu, 18 Oct 2018 19:54:30 +0200
Message-Id: <20181018175419.573018767@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 59d08d00d43c644ee2011d7ff1807bdd69f31fe0 ]

This adds Intel(R) Trace Hub PCI ID for Ice Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -168,6 +168,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x18e1),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Ice Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x34a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


