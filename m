Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5098218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKr02Ymg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfB0GKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:10:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41372 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0GKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:10:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id y5so7461410plk.8;
        Tue, 26 Feb 2019 22:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIBepAg0Yk/poa+mjvFR+U3FDg4po3CMCiCfsEn4UYI=;
        b=RKr02YmgXOuIxHVrrzJbGyjkSMPnLEMsm7plcDw1yO+dldAY2tbWbR7MkyIUIL6RDq
         FS2HoMwv9aHAiTjyjUtLhRzgl61ww8Iy22eVsuvawyqnfHKuXngjN1cRfEu1cT7qPf2g
         F/QuWg+ZDHWzrIxX3mGS0MFBvaopIAj2VHHWjZOhC+8bsnM/TDXSDpLLNdhsi1CiN+1C
         SLWUQbTLhkfUI0l9J2Ju/X0HZ8Ma86h87OdNdmUx72mJrA/AL+er1qleUY9DGlht8+R+
         dZi6azoTUUmHY9T4VjeVIRzV+h81sMzmYjKoN6jYT3fi8OM6AW697c7LfqBHk1B1uoRJ
         91Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIBepAg0Yk/poa+mjvFR+U3FDg4po3CMCiCfsEn4UYI=;
        b=DyHb3LsckhwwKzfVMFjUjfZHsTBYC03dP4rZwZIDhYL+MpgXXRnBfUixYqT6Hg/VjA
         e1OUpnczrgh5A0y2VpRuA1/JO07xTburXvASPpxHZVOlt4NqoPOxni/q+D3PlPYCtBBV
         EMPGnu3XrIb+HvfGSgPnAezcH1wv+TuEZ7IoyDpkwmuyc0zzTcctWuQ0KLa8i4y5zPSc
         tMatKfdXNl83MwCw59MIQk1T0PLHgHhI/yS3pAgPfJ1EkwyMPxxmcfTZfw3ni0t5IAdI
         AvzFAhPg094VEzvuOzJeVUzp/Mi0j5CMfugzj+x9EFD+5OyTz8pzGUcJIi+J0PEm+8wd
         7WzA==
X-Gm-Message-State: AHQUAuYHdSQAXreDzakrbKk/vZchK3zUNx8Q0iE/feCwQN+ywnfIShqy
        ZMUH6lfNFN5CqflOutnhPTo=
X-Google-Smtp-Source: AHgI3IYev6YCk5E1fIoIQRHGdXIMhcuySnlkS0OftHKJk8EpOAZFESazG/ogzW3I76JB1ir0QSCUnQ==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr493155plb.28.1551247804713;
        Tue, 26 Feb 2019 22:10:04 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:10:04 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/8] net: seeq: replace kmalloc / memset(,0) with kzalloc
Date:   Tue, 26 Feb 2019 22:09:54 -0800
Message-Id: <5ff7bcf7b8db8daa129703e5f7b632825f25c766.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces a call to memset(,0) by replacing
a kmalloc call with a kzalloc call.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/seeq/ether3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
index d1bb73bf9914..7456cf08a48f 100644
--- a/drivers/net/ethernet/seeq/ether3.c
+++ b/drivers/net/ethernet/seeq/ether3.c
@@ -223,7 +223,7 @@ ether3_addr(char *addr, struct expansion_card *ec)
 static int
 ether3_ramtest(struct net_device *dev, unsigned char byte)
 {
-	unsigned char *buffer = kmalloc(RX_END, GFP_KERNEL);
+	unsigned char *buffer = kzalloc(RX_END, GFP_KERNEL);
 	int i,ret = 0;
 	int max_errors = 4;
 	int bad = -1;
@@ -231,7 +231,6 @@ ether3_ramtest(struct net_device *dev, unsigned char byte)
 	if (!buffer)
 		return 1;
 
-	memset(buffer, byte, RX_END);
 	ether3_setbuffer(dev, buffer_write, 0);
 	ether3_writebuffer(dev, buffer, TX_END);
 	ether3_setbuffer(dev, buffer_write, RX_START);
-- 
2.20.1

