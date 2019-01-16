Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E328FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE57C206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8aTffd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfAPTtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:49:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38645 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfAPTts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:49:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so3354212wml.3;
        Wed, 16 Jan 2019 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S+tBm27s7+dBmnZQf9n3TlcEVO1seLIX/LcV8pv6cJo=;
        b=q8aTffd2xkSrZg9cIezp9DK0uIzWXXjVqsGQ+T4xjhMPRKRN1iEbtC1UEah6+SPRkb
         IihnyaXitzLjY8EKpRGNlAir0Dc4MCJC4WaODjC9VNZ1J7tSFqQD4WO5lqZtaSP3fW5o
         qbLNc6S+VQatY95KaZ7UUrgYr54zABqy3l2x8Yeend83H71k13W/xOr21GDjbnr8rh0W
         dtzC1woOczxDtGwQt9r47EriFStg+D3Fr+ElHHt6vYBIkLtTaE6jklKNI1BGIF1Dx6QA
         JVTv0GF3oCdNDWGI5FfNhGE26YEgqt0npXwrXtYH3W1ioNkhsIlkQ5tGQoXCh74ufuAa
         uyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=S+tBm27s7+dBmnZQf9n3TlcEVO1seLIX/LcV8pv6cJo=;
        b=P2tewzNZSTHwcrnMgvvhySL9UwWXxhWYAkuxhb2awJY4An259pJsnud6eGRj3jhAdy
         Nh1lRzAJnij21Ny4SjQVzdpmkYQoDH2doBnMHjpyltjMGdEOzCytZB0Rmtpa/Is3EyIe
         2CIfEkXBi3jnnqhg0t1ns9Vm5JdHXc+g05gzndCwgrp7kH+TqOe5UPtIqx1aW0E+bk4r
         sYYi9eoBg+XqGtPAlJniIc6OtuTICG+3TE7qkCrEzeb1QYyrJTOUqNXC/ti9uL1CZq8P
         OxP5nPu1GSGjmg3jkUMCyg7csl3DOtF/meovFfeqTUUnvUEE4S9LQ6uPX1L3zrz3mAa0
         llkA==
X-Gm-Message-State: AJcUukeilOEfFVp8YwKSl7/HjMqVMRJrAnXq/mwGpmpHQJDGmyja2Kal
        nHpO7b/B4KL1LnXz7iSi3FHQ51Fn
X-Google-Smtp-Source: ALg8bN5WNfs5fzkfHyGAclp05Rqx3VsddL4ps14+o4yKJhXU3MrBG2wm3sWF7cgRbdLYSZntegia2g==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr9387451wmi.7.1547668186297;
        Wed, 16 Jan 2019 11:49:46 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id j8sm60840483wrt.40.2019.01.16.11.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:49:45 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 200E911423A3; Wed, 16 Jan 2019 20:49:44 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Mathieu Malaterre <malat@debian.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] davicom: Annotate implicit fall through in dm9000_set_io
Date:   Wed, 16 Jan 2019 20:49:25 +0100
Message-Id: <20190116194925.2181-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit removes the following warning:

  include/linux/device.h:1480:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/net/ethernet/davicom/dm9000.c:397:3: note: in expansion of macro 'dev_dbg'
  drivers/net/ethernet/davicom/dm9000.c:398:2: note: here

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/net/ethernet/davicom/dm9000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 0a82fcf16d35..c2586f44c29d 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -395,6 +395,7 @@ static void dm9000_set_io(struct board_info *db, int byte_width)
 
 	case 3:
 		dev_dbg(db->dev, ": 3 byte IO, falling back to 16bit\n");
+		/* fall through */
 	case 2:
 		db->dumpblk = dm9000_dumpblk_16bit;
 		db->outblk  = dm9000_outblk_16bit;
-- 
2.19.2

