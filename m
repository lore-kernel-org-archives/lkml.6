Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F85C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25E20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760711;
	bh=gjFqwqywYu4sxRpIYK3PB9ZMFq6jcGkDkefVcJRXX7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D3syV3EItkRLmveUyBjHO9v7xg9Ftpy9ZSfIiLGKNC8qFlOCOBe/9bAvTQxw//wiI
	 d5YQYt6y34Jyzqr1vhj99elz4TlQa5zGIxbSl0VnFv95QsbnYRLmTUfRfSRMmJggFp
	 EUFxm3dv/ma1Nk1SSbEu9WSFEZs6JX9xK8+QCQ40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfBUOvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUOgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:36:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2994A2075C;
        Thu, 21 Feb 2019 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759813;
        bh=gjFqwqywYu4sxRpIYK3PB9ZMFq6jcGkDkefVcJRXX7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl7uv45tgmbBXnoTP0bWnJC7hSnBf3KT80utsGhS2OQ1xzlvOEKGC7TMo9FyNRi5o
         PPjzKinItt5lFbtGITfM7X/7DLIK99pMU+1T/7O6kDa9n1TIVQHo1tgBZyz+fAUwY8
         Xp513JpgU2rzXcEUr/evJjyRg2rsdzkeN0arsWLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 02/13] sky2: Increase D3 delay again
Date:   Thu, 21 Feb 2019 15:35:33 +0100
Message-Id: <20190221125240.350025722@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
References: <20190221125240.091472334@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5069,7 +5069,7 @@ static int sky2_probe(struct pci_dev *pd
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 200;
+	pdev->d3_delay = 300;
 
 	return 0;
 


