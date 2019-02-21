Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007912077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760242;
	bh=JEQWEtlmWgJuvNxY2k5V1HNMTLm4K69yOsCnnUg+ePo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZxKakfHRuLKi2uCh7Bg9jiX+ozLUvWJxT6jTFj8pB3tUFqCo/CwVO21b1koU6aH8
	 f+gR+mUazRiRw/BWDxeRQsUMi4NcrarGgs/uVMMg907yi0rmqpQNnsi7+aemgVyT1m
	 aJvoXsmEs0LKaYsZWqVlAaKadheORui3CUg+d8Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfBUOoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbfBUOn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2210E2080D;
        Thu, 21 Feb 2019 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760235;
        bh=JEQWEtlmWgJuvNxY2k5V1HNMTLm4K69yOsCnnUg+ePo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWMBTzKeUsw/spmQAPqupgfskVEhyeSMeNKzwaeKDAXTbNZ/VYVY4NX3QxtxAS0Oz
         t3NgqzqtaXHZuOtdthrOuhrwLh6fIcitOLXXl4Dv0f9WX6WNEyZ711mY/U0zxsyjZi
         E2FpInAuzmrwjs8WaKh1dESYlQ4ctnuvX6yas3ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 14/32] sky2: Increase D3 delay again
Date:   Thu, 21 Feb 2019 15:36:02 +0100
Message-Id: <20190221125251.686940567@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



