Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C39ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84482146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84482146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeIREmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:42:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIREmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:42:02 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE2AC707;
        Mon, 17 Sep 2018 23:12:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 107/158] PCI: mobiveil: Add missing ../pci.h include
Date:   Tue, 18 Sep 2018 00:42:17 +0200
Message-Id: <20180917211716.226029918@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit d3743012230f8dab30d47caba1f2ee9e382385e7 ]

PCI mobiveil host controller driver currently fails to compile
with the following error:

drivers/pci/controller/pcie-mobiveil.c: In function
'mobiveil_pcie_probe':
drivers/pci/controller/pcie-mobiveil.c:788:8: error: implicit
declaration of function 'devm_of_pci_get_host_bridge_resources'; did you
mean 'pci_get_host_bridge_device'?
[-Werror=implicit-function-declaration]
  ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        pci_get_host_bridge_device

Add the missing include file to pull in the required function declaration.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-mobiveil.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 /* register offsets and bit positions */
 
 /*


