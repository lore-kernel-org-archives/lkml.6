Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5012520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8NHpXHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5012520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIJRDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:03:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44108 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:03:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so10367287pgp.11;
        Mon, 10 Sep 2018 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y6W2DMrA6gopnMGP8sgDXgSgxIoxIp4dbY0wK9B7sCQ=;
        b=K8NHpXHAreESO9540NQVwHsq0QbSIA9CMQ9kSQsXlGqDGqvhBeVcnm8zfOoEIRRC+V
         4OUjBdqhbJl4v4TymgS3WARwcO3yrC6LlvzpR7RID5P6mGwFxuOmzJPUx0pPuh2+ogAZ
         CmE9nbGqYnbIKjQH9HhuM+omXB6ge+jYbhdx+1mVgRKjwx5OxPdh2lP6hMKzYpudlmNk
         N+0tIbTk1Jxai2eTevLAcgGx4IyttbrAeqsPNHVjVjZWH/UK6Q3f7xjahT/Rtw3Bq3ut
         3d5EPzCYH+TAyjN0M/jrvZXSFzhO3uxZGViPieDsNxmu1si2Nkl+FzN/1Ypn4k031uoy
         TvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y6W2DMrA6gopnMGP8sgDXgSgxIoxIp4dbY0wK9B7sCQ=;
        b=mESJG/cjFmBJJembb9W70vD7/FM+pM5ih68WBKaDtvLtdM/SnPX9BtZQPzoFF+de1/
         g7YgvS82RKiwtMJTcDhtr4uzSeHUFtk3sNMFOn9kCJIHzZR70R3fnnykVeZmyFd5zP16
         FM/pn7rJgdtucNjlfBJRXAAr8NyRtozL3VZXlimY8Pjytd+UJXz83hxd3itQ67gTsQlY
         d4PSQQ9Dk19Irwc2mFg+aCTz7laOj5M0UCn3MlSYKvruP5dQbfutuG+xzausrVuCBbLh
         tK1iFiQNUXdTHnQQSw0muS1GTJg0HrAKc3hsq9sIlvOzaDWDhvv3d4heA2rHkQ2Wwn+9
         tnRg==
X-Gm-Message-State: APzg51B68QZC504t6pP97y69X9PKTqSyDQ/Emh82qjwYqJpRPUERRCIx
        OTzR46Cx26FFTVIqX/y7nF4=
X-Google-Smtp-Source: ANB0VdZri3sahvv/ihA6KLE5QG10ztPWIwy6HaEKxH5KzhJppfsBMYYR3hUSsqUZkTLRXscSm2erwQ==
X-Received: by 2002:a63:f713:: with SMTP id x19-v6mr21808043pgh.233.1536581399705;
        Mon, 10 Sep 2018 05:09:59 -0700 (PDT)
Received: from localhost.localdomain ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id 74-v6sm22803857pfv.33.2018.09.10.05.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 05:09:59 -0700 (PDT)
From:   swkhack <swkhack@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        swkhack <swkhack@gmail.com>
Subject: [PATCH 2/2] fs: list init in the critical section
Date:   Mon, 10 Sep 2018 05:09:52 -0700
Message-Id: <1536581392-11343-1-git-send-email-swkhack@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the i_state init in the critical section,so as the list init should in it.

Signed-off-by: swkhack <swkhack@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 42f6d25..d3e07e4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -905,8 +905,8 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	if (inode) {
 		spin_lock(&inode->i_lock);
 		inode->i_state = 0;
-		spin_unlock(&inode->i_lock);
 		INIT_LIST_HEAD(&inode->i_sb_list);
+		spin_unlock(&inode->i_lock);
 	}
 	return inode;
 }
-- 
2.7.4

