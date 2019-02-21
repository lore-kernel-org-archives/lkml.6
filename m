Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44335C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139A42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759889;
	bh=WsMDLGZocREFRmulQedfFW9Xc+/cuNj1ue7N+XRPvuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tmuo6ctro7I0iEQg92I6sLOpdfVbA3lhPAMEGnlL6KCeZiWptN5TEGkkcpppGLMn8
	 XlcjYxkhJSoxEv/4mh8fPUSqm4poQk7D0Q1G6Ria7XCLdT7NO2S039BEvAuq8HTx1b
	 mRL/ZBkFo8t7VIlJr3V6ZPPRju4uhCeONNWBUNYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfBUOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfBUOiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13AE220838;
        Thu, 21 Feb 2019 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759885;
        bh=WsMDLGZocREFRmulQedfFW9Xc+/cuNj1ue7N+XRPvuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALciSSD+1lKYLKOd3IuYrcNJd5Oif6sZoejh10+lN32VviSBxzfu9Koz1S6piaHzf
         5v389ugJp9JQGs9AZCVna6pKJHFpiY3zE909aVG3PB2BdleXc7L0SeOtn5yOMDOIMI
         hIVQOYmuT0WQF4gTw+/+tvPTajE3pIHFBhlu1h4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 05/20] sky2: Increase D3 delay again
Date:   Thu, 21 Feb 2019 15:35:35 +0100
Message-Id: <20190221141946.930684172@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 1765f5dcd00963e33f1b8a4e0f34061fbc0e2f7f ]

Another platform requires even longer delay to make the device work
correctly after S3.

So increase the delay to 300ms.

BugLink: https://bugs.launchpad.net/bugs/1798921

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/sky2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5079,7 +5079,7 @@ static int sky2_probe(struct pci_dev *pd
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 200;
+	pdev->d3_delay = 300;
 
 	return 0;
 


