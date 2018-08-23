Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A017C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E428D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E428D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbeHWMRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:17:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeHWMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:17:39 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA7ABBC1;
        Thu, 23 Aug 2018 08:48:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dongjiu Geng <gengdongjiu@huawei.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 108/324] usb: xhci: remove the code build warning
Date:   Thu, 23 Aug 2018 09:52:54 +0200
Message-Id: <20180823075001.230896709@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dongjiu Geng <gengdongjiu@huawei.com>

[ Upstream commit 36eb93509c45d0bdbd8d09a01ab9d857972f5963 ]

Initialize the 'err' variate to remove the build warning,
the warning is shown as below:

drivers/usb/host/xhci-tegra.c: In function 'tegra_xusb_mbox_thread':
drivers/usb/host/xhci-tegra.c:552:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]
drivers/usb/host/xhci-tegra.c:482:6: note: 'err' was declared here

Fixes: e84fce0f8837 ("usb: xhci: Add NVIDIA Tegra XUSB controller driver")
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -479,7 +479,7 @@ static void tegra_xusb_mbox_handle(struc
 	unsigned long mask;
 	unsigned int port;
 	bool idle, enable;
-	int err;
+	int err = 0;
 
 	memset(&rsp, 0, sizeof(rsp));
 


