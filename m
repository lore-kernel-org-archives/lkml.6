Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C778ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77662075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdx-edu.20150623.gappssmtp.com header.i=@pdx-edu.20150623.gappssmtp.com header.b="nQ5Y+l7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77662075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pdx.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGRUEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:04:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45726 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeGRUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:04:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so2428669pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdx-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dzhomk6TZnWzWgwY/DjZ6dQhKCCaZiyF9AxmD7XZVUw=;
        b=nQ5Y+l7JJ6tnarDls2Xiqdf0d3+Z8rI35nMbc3zGAOwSBzuRiQB4KxD4AqdT3UQwwL
         0uVySEC49wVQOKKFN1XAhFesHvvc5s33ZNPoSi7n+lJw4BtrrpMRjkDBXPtcVdrGWbv7
         X7643OsUPQilPZwOUCIkxoLdh3PqYloNjfJhp/sb3e1yP2mZHxsqIxsSulWfTUjWWvJr
         H8eglcFeohWTs5aDyLx7UoyzI4qwsKj7XgrY/b0Cn0U1fIo8BrEtQc0p91nlunQwdNx5
         g342Z0ohDHoH8dGELIKjdjwSzTL2ORFA2WkgtMKs3FzTkFHogCqvI0KKd5I+cW4WOzD/
         QiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dzhomk6TZnWzWgwY/DjZ6dQhKCCaZiyF9AxmD7XZVUw=;
        b=ZAYyH4HLQLuQxWUiEOEp9u/UcGXA+jdS59kL5u6/n9F4xYz3P9tCDq7Anb7bflcA0o
         DXpa5K1JyPFFCOOOXMYzeGZEoYw76HNRyCWDIlGLamQZx4QdWHkeLI9L32avL2cPwjI2
         Ovsq1pKYy6/N15aBuhR6VBmWMoxAILmmg2keDnfVYASQJSDhpHnjurbKzQ+H3WwlXK+6
         AQtyEDQxytywjLNw0LURgXkffeCosWzRJXb86xthVkJOBSajZjWHEkLXSjsURl6Bmzip
         XZrqN9ZG4vFYCjtdMs/xnbhzaWHTd2/Ybqw7eF2bZXR9M/QOyZZ7GbFzdiGbg0DnAeCp
         13uQ==
X-Gm-Message-State: AOUpUlHPkjK15IRlYiXDtmOweVvYucDrc6ttUjnTxhLaPSoJnzYtXHSL
        M75Hovpn9TR7aNjNKHpvWaI3OQ==
X-Google-Smtp-Source: AAOMgpfp8Ncit5lTqz3y6IcpE6NVlqX6ozSLftUV3xuMYxV4SSqBgyR6z4z+I6ebCXhORshX2DCEQA==
X-Received: by 2002:a63:41c6:: with SMTP id o189-v6mr7110032pga.323.1531941928614;
        Wed, 18 Jul 2018 12:25:28 -0700 (PDT)
Received: from svl13.cs.pdx.edu (svl13.cs.pdx.edu. [131.252.209.5])
        by smtp.gmail.com with ESMTPSA id n80-v6sm7997550pfb.95.2018.07.18.12.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 12:25:28 -0700 (PDT)
From:   Bo Chen <chenbo@pdx.edu>
To:     jeffrey.t.kirsher@intel.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bo Chen <chenbo@pdx.edu>
Subject: [PATCH] e1000: ethtool: ensure to free old tx/rx rings in set_ringparam()
Date:   Wed, 18 Jul 2018 12:24:26 -0700
Message-Id: <20180718192426.18853-1-chenbo@pdx.edu>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new value
and the old tx/rx rings are freed only when the device is up. There are resource
leaks on old tx/rx rings when the device is not up. This bug is reported by COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index bdb3f8e65ed4..27b006b60f8b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -624,14 +624,14 @@ static int e1000_set_ringparam(struct net_device *netdev,
 		adapter->tx_ring = tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring = rxdr;
 		adapter->tx_ring = txdr;
 		err = e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
 
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
-- 
2.17.0

