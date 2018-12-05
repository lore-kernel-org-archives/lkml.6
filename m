Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD45C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5482084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY/a/V7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5482084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeLEQdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:33:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39605 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:33:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so9244939pgl.6;
        Wed, 05 Dec 2018 08:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/GK9WDIzvq3API7qrAfJPaxzXKrjKajkL0Hk3Wj5dN0=;
        b=LY/a/V7JpRlhciq+gPclmWdHb/yFqC6dERyE3g/teqR/a6mUxpzh8BglVpnRr4rpZF
         M4fB+3Pb+VqPWyCoXw5yICIH5I0Bivr9Wx9rStB8DZTiRHcCBeHNvYMgFLx09a6YuRcu
         VBVh9KD0z86a5ctkp7ZNF0V8FbkhOAzUlIj+m7ZkicigpLDG1b4m7Mc9v4HWyhASwz47
         kAMwyuJOhntPT8ytQtNX3dQn3k5wTLjCVy6YpWz2/ECSZrnrgVWBDZMkxCh0weBqhIr0
         SIckf+OyJ1pOkGMW6fqJ79Dga9RLHbRQPzhKRio/+5l7H4qfIXnZ94u+AO4hskKq4OMj
         SqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/GK9WDIzvq3API7qrAfJPaxzXKrjKajkL0Hk3Wj5dN0=;
        b=mgqjE68b5v/pxfJSVs09sekpDV5hH7Cx6H4TVlMItQeBfEy3kC8wVD332TwvI6Q5Hi
         y/MVyvCEPMfPlawGBjqbR5cwlCMSwGByb+KIJNA3V6ICsajgPERVxpqtPhtxDnyymFia
         GMo2RqmaRjdAKnF2XqbAtHchPt0qdjfDF9qa4uwa94/cAQyEHbDiIhOrHvL4XSfzyFZC
         R8y9zjwJK4zWzuQnzgDoBMTTerzdZ1d19RghfTYSBa6RezkHmLq4HqR2W10APv9+0OEx
         2K8VblTPi+DJtsn4frQxo1RdZGiEe9nZ1I/eskYZX98LAWIxgf92/bbKo8l6+bIGQzp/
         4MuA==
X-Gm-Message-State: AA+aEWbckXoxGkgwiH96aGEomTwy4AkySqGcRGphzJwC69qR+SUzKXBB
        hxdv6W/IgnSYb/9DrNLPdvA=
X-Google-Smtp-Source: AFSGD/UH/myTwdEcE07uPR1UWmQsceehGcjH3RRYeONweYI3z/SsSNVTKYkMTLqN7vDsSIlTFIPn9g==
X-Received: by 2002:a63:7306:: with SMTP id o6mr19499833pgc.343.1544027621424;
        Wed, 05 Dec 2018 08:33:41 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c4sm54908604pfm.151.2018.12.05.08.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:33:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] usb: host: isp1362-hcd: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 11:33:39 -0500
Message-Id: <20181205163339.16672-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/usb/host/isp1362-hcd.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index b21c386e6a46..28bf8bfb091e 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2159,25 +2159,15 @@ static int isp1362_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-
-static int isp1362_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, isp1362_show, inode);
-}
-
-static const struct file_operations debug_ops = {
-	.open = isp1362_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(isp1362);
 
 /* expect just one isp1362_hcd per system */
 static void create_debug_file(struct isp1362_hcd *isp1362_hcd)
 {
 	isp1362_hcd->debug_file = debugfs_create_file("isp1362", S_IRUGO,
 						      usb_debug_root,
-						      isp1362_hcd, &debug_ops);
+						      isp1362_hcd,
+						      &isp1362_fops);
 }
 
 static void remove_debug_file(struct isp1362_hcd *isp1362_hcd)
-- 
2.17.0

