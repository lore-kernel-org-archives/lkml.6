Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1721C214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="CESVJ4V3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLZEXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 23:23:51 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58824 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeLZEXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 23:23:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 11AC5BC9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:23:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6DnfLmdPTs1u for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 22:23:48 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id D7A6F84F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:23:48 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id b8so2813097ion.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K4vGsDXoZ9YBto0vSt+ap3Jo70DWTWXEEPbaWHrmIHc=;
        b=CESVJ4V3hxDr2o5dfxc90NzFpqRsKsSpWsmckXprdF9wLnb1FpH5dYgNs2yr683j/W
         +pmQID7oMBmK7rzGAoPcxald42PxosTj5MtneJl96bQMDXwLr1fpkVb2ykLn/jBI8JTR
         AEim5+9GLSFO1K4XFk9fFMu5o1vfIQ/2SznkiMRtNFcLxczCX7lbQjWsO2Wv4igeWKE3
         ON1WYhRfQJS7wxk6GdlTzyCVim/zuFKjXk2Y8s8kQ8o4MB+8bDy7/UijpA+YwYM7R13Y
         jrHgBYxbNRzxm23vawoCQcEpcFqGapjkZ0bj1r/9IEqnwZfTPAHnM95k0cnGdRTjd9Y9
         3xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K4vGsDXoZ9YBto0vSt+ap3Jo70DWTWXEEPbaWHrmIHc=;
        b=Wo3EnJ5bE8EUipUCoMBlig3ErKqIgOJwzoaR531l8M6lNXvXP5jjN7nhT2uC3fHxUz
         NwFvCE71OsT0/tUOT5jkqOpckTfeDeu+s5sSxufriYprLHC1wH1D0Qw7zI33Y3DsKs8d
         dFBDYHWlK8UW/V0IAyt+TQ9PHc4XD/hjoTwEfaxXN8rSRnIMk0mdcW5eH+8eEVhrqkj6
         nMBCkQRhrXPG4PPfx9pjb5D3DPNpEeCG5beGNgvviL8uwA7zpRvxb0qRDz1seiA+nYNo
         V3G6oVU7zUNTBbFRpaYWHiQuEGjkocIJw3hwFHGZOtxtRuDBt8dStTEn6ivjtvDQOp0Z
         7MUA==
X-Gm-Message-State: AA+aEWb8qCZbuFFc9ZFnI+jbnSW1agyHArvyGyTFDkPpu7IihGmL+qZP
        eMqO8w5zxug3btxikNb8qjZXvv9A/VKkLzNPPrOZMjLpoIFUjMERl3qDLdxGUM4xV4vsMqCWk4o
        TVvEQpHjxjr48wbUIYRYQZJeHih6f
X-Received: by 2002:a24:630b:: with SMTP id j11mr11601813itc.28.1545798228518;
        Tue, 25 Dec 2018 20:23:48 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WB2krFu28sR784p9dqHGWpSuob+EC0OXznsKtbyHhaD8tNtGjouWDcFWwE1vtWLbCqlksYJA==
X-Received: by 2002:a24:630b:: with SMTP id j11mr11601805itc.28.1545798228261;
        Tue, 25 Dec 2018 20:23:48 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id g186sm11671941ite.39.2018.12.25.20.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 20:23:47 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: atl1e: checking the status of atl1e_write_phy_reg
Date:   Tue, 25 Dec 2018 22:23:19 -0600
Message-Id: <20181226042321.74123-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atl1e_write_phy_reg() could fail. The fix issues an error message when
it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index 9dc6da039a6d..3164aad29bcf 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -473,7 +473,9 @@ static void atl1e_mdio_write(struct net_device *netdev, int phy_id,
 {
 	struct atl1e_adapter *adapter = netdev_priv(netdev);
 
-	atl1e_write_phy_reg(&adapter->hw, reg_num & MDIO_REG_ADDR_MASK, val);
+	if (atl1e_write_phy_reg(&adapter->hw,
+				reg_num & MDIO_REG_ADDR_MASK, val))
+		netdev_err(netdev, "write phy register failed\n");
 }
 
 static int atl1e_mii_ioctl(struct net_device *netdev,
-- 
2.17.2 (Apple Git-113)

