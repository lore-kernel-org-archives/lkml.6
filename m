Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78590C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0F5206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRrBQi1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfBWLSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 06:18:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36234 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfBWLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 06:18:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so4137418wmj.1;
        Sat, 23 Feb 2019 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GsSC8kWeNV/R5tzYgG2c+8rJl0TR4KyHpnRG356StI=;
        b=fRrBQi1D01cnqbMJVM4n0JMvL8mc0axr2ZstRz/OxbFmzvrYUELvT8u4HD9R5Czgcf
         CPjnn8YS5g7G/ejmZY7pEQwdFP9GJPM/7vJlW7qkEJRKb/06UVU7iH2oTGnDMasZecFQ
         +FrK02J5qO2pa4TAxL2pmksE7axb+ZaoSvKsmG6HPj/HR/LjF0n/Mx7TbYba7Ddn/40i
         y+ayWOuT2osOwgZXdbCtD1g7is2W6oTaH70PWf37msDR5fvk5v4/UQaf4d+3tJDeDtKu
         fzzdiwn+O0W9tV0kdEHiEJWLCQO8XenlojapcqPWX7VAOV3vaJF5zoRRoWIZj+94n0yr
         /yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GsSC8kWeNV/R5tzYgG2c+8rJl0TR4KyHpnRG356StI=;
        b=njLYpb+ljwh6q2M3PHbJqb1ZRuzyAftkXPHogzEPNOADeuo2CeGP5/vXJ7DuBVgI6M
         Si7Gc/muKVjeUGRJQkJaWdcnaCTjARXiPODSqyIWYwy7EuLkLUb5rxxHbTHGhMD3QfzP
         /LOWPZ1UZMY1auaNu2KxPTYoo5RbC9NQDHgkMPMX6Noa4Uq2qIoj1CtRzCTd4M/Gqcdh
         LR+0NLkmXRfHYg45uFTaZoUxk22OqCMwlUlCpjpGNEKBrXe3Q006qyUY1AS3ruGjJmXA
         sPo4XyCB+48pxaBZdOl6av4L0pOaKsQbFk78oG3zZKSpDv9rtUXnopHa9cxD5W796tAy
         xHGQ==
X-Gm-Message-State: AHQUAuYoJdgSl/vzsDPWEwt/0kZ0d8ChQvK3oaXDp3zz23dO7/TYhY0P
        +nS9QCM96l9QHvbCplzDJg==
X-Google-Smtp-Source: AHgI3IZWB2I+ARC9etzHTiJ2IEfWscGyIH42vXDm/qcymHGxwVkn2RxPJFZlgHem3xPkJwDtLeG4Bg==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr5574456wmc.102.1550920688846;
        Sat, 23 Feb 2019 03:18:08 -0800 (PST)
Received: from localhost.localdomain ([185.61.164.85])
        by smtp.gmail.com with ESMTPSA id g202sm6940124wme.26.2019.02.23.03.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 03:18:08 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     jreuter@yaina.de
Cc:     linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, ralf@linux-mips.org, netdev@vger.kernel.org,
        outreachy-kernel@googlegroups.com, jbi.octave@gmail.com
Subject: [PATCH] net: ax25: Fix  multiple blank lines warning
Date:   Sat, 23 Feb 2019 11:17:51 +0000
Message-Id: <20190223111751.14620-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/ax25/af_ax25.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 5048790a75f6..2da349b7854a 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -49,8 +49,6 @@
 #include <net/ip.h>
 #include <net/arp.h>
 
-
-
 HLIST_HEAD(ax25_list);
 DEFINE_SPINLOCK(ax25_list_lock);
 
-- 
2.20.1

