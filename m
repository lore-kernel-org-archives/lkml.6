Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC50120665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+YgwUQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfAJHKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:10:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36088 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:10:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so4909640pfc.3;
        Wed, 09 Jan 2019 23:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=ObYxdDGJ2zSLu6xRokSDq7FzdVG5WljlQjPol6AlDF0=;
        b=c+YgwUQa9ynByGelH5fwgLPGF9NSBYmTYnsV68CvIxpY94KxWyanliRLjYuxPoxDS2
         n3bcFFuf/vfCupmZHxj3JzQz74pZNmuGkwGgBP0VUECjDKV41JTAL2rYlL8XngkuGfwX
         S5WqHXM+FHpQNTX3VEoCyZEE8tSCpv4ifscc9pAQBpcXh0Ig3uUmDSbrlRXxLaSFpr61
         q8aesLocqDZ6g3c8TTIxu67d6B1Fb1MUw9ZHGfhgpvzK3Nl6AW82vZc5O8R7H1LmozKg
         g5WKAxxnKADp/345B9I6y9JabcYop3nZwZWMCJB1ZPoT0E+45s0IBK0lw5rekGzpICy+
         Zt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=ObYxdDGJ2zSLu6xRokSDq7FzdVG5WljlQjPol6AlDF0=;
        b=Dx32QNfr/3LC5fViqOl3tl2GoGYKIWMnuREW9GxDwT2kvxiA7SNUpxYHGOjmTEDKmz
         R4RXj+0jfoD5x88SDWuhgcPWupBrE3z67MVzLLU5JRGbVh/qC7OoG9VKOE3Md0vMISGN
         AYtIkn083GX/p+RMxFTZFJudMpwGc2N2WD40FFi5jZwfurdXA/YcavtO84HNrIvbJpBI
         UM7nP34+QkIcZ/lNaIvHm324jwUJp69y2R4kB2aJM7tc9HBSzbyAwtM5hE91VV4L7iMy
         24nUQB6TfgerSqL1HsEFFldrFqVdijRJrhKcUvXKwXSFvmR+Bz3yyuaO9uxwtvNdttnc
         Dy0w==
X-Gm-Message-State: AJcUukdKJILp9vmLjpXNib/8reoHwRuZXL5yxNk+j6wvMStCtOGWbvUe
        OwVez3lqQOu1owghRrYfomGltle7
X-Google-Smtp-Source: ALg8bN7AEi4RoXUss2sWXbn1/HGGM/t2R30Yz65v3/8PKbv30zCx/JFQJUvgPSImSNmRkV3SDoR3OA==
X-Received: by 2002:a62:2c4d:: with SMTP id s74mr8997248pfs.6.1547104214722;
        Wed, 09 Jan 2019 23:10:14 -0800 (PST)
Received: from sabyasachi ([2409:4061:2019:ef6:e468:6878:1f4b:258a])
        by smtp.gmail.com with ESMTPSA id w3sm107976946pge.8.2019.01.09.23.10.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 23:10:13 -0800 (PST)
Message-ID: <5c36efd5.1c69fb81.4964.9e80@mx.google.com>
X-Google-Original-Message-ID: <20190110071007.GA25614@sabyasachi.linux@gmail.com>
Date:   Thu, 10 Jan 2019 12:40:07 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     jrdr.linux@gmail.com, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: [PATCH] drivers/usb/storage: Remove duplicate headers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/usb/storage/datafab.c    | 1 -
 drivers/usb/storage/ene_ub6250.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
index 09353be..4b1bd56 100644
--- a/drivers/usb/storage/datafab.c
+++ b/drivers/usb/storage/datafab.c
@@ -102,7 +102,6 @@ MODULE_DEVICE_TABLE(usb, datafab_usb_ids);
 }
 
 static struct us_unusual_dev datafab_unusual_dev_list[] = {
-#	include "unusual_datafab.h"
 	{ }		/* Terminating entry */
 };
 
diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 4d261e4..79a07bf 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -65,7 +65,6 @@ MODULE_DEVICE_TABLE(usb, ene_ub6250_usb_ids);
 }
 
 static struct us_unusual_dev ene_ub6250_unusual_dev_list[] = {
-#	include "unusual_ene_ub6250.h"
 	{ }		/* Terminating entry */
 };
 
-- 
2.7.4

