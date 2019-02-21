Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9373AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A3220700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760470;
	bh=jf8rqTZ7eDTxnVjslXmrwZFaIrOui4gga27j9JNhJXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPjPcxooKPCkPtRCVLaYbVIDSiTLcFNxBWGEsw5pom+J1WFFidVLp30hIw5zZaeUu
	 QyRAy68xdaQc4TbPb910PD9gafHyCG+by3Bi9zHBl0W3lzz64kFByl/oYgixM6tCb1
	 sT3OppWbvBMwa6nq7dF2xC6zFO3w7HfHVo+TfJL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfBUOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbfBUOk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B792085A;
        Thu, 21 Feb 2019 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760057;
        bh=jf8rqTZ7eDTxnVjslXmrwZFaIrOui4gga27j9JNhJXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRwWQIx+miytjyop1tOrB+t6nSmGafz3KSKEspqh0pO4n0FeZWWE4WddJiuDww5Ob
         6BrvGgofVbqnK0R+VE8wOn35usGyXqjna498a5AYBfPt8/7EDDRXRO4qWEyI/6bUiN
         J8Mo41cxd6nlvE0Vc7k7lakRwODsCSqYaV7vC12Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/30] sky2: Increase D3 delay again
Date:   Thu, 21 Feb 2019 15:35:55 +0100
Message-Id: <20190221125251.251700308@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1765f5dcd00963e33f1b8a4e0f34061fbc0e2f7f ]

Another platform requires even longer delay to make the device work
correctly after S3.

So increase the delay to 300ms.

BugLink: https://bugs.launchpad.net/bugs/1798921

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/sky2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 697d9b374f5e1..ae2f35039343b 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5087,7 +5087,7 @@ static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 200;
+	pdev->d3_delay = 300;
 
 	return 0;
 
-- 
2.19.1



