Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ECCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C6A2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm7Oatqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfBFHdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:33:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:33:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so6331485wrx.9;
        Tue, 05 Feb 2019 23:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JFCGTs9kdnvqk8xoWL4nmZerkpCeyN6uS4mJVgXj6fQ=;
        b=rm7OatqsdotLi0aASmk0+ZFBKjfB3bqaswrBZCi94EmIHudg1FqCHAoHzzE1sWhG1m
         +vR1Wz2dw0EIV8Hz4CqnLObo/Cf67dy0nXpmitNPUi3EUs82qZsP3Gfv8kNZCUa2D2V6
         CTi4YI6rWtD72kTg2ZgEly/WJYeQKWB6vDZ5oT2+lzJxkqPkxEK2gKBe7J11iajeV379
         LkBxd4ZwE+WPu3/IcOFVw1rnSlpwhg4JA0NahswrljhV37xJBdCrnHz7b1zG6lsePlRe
         VG4VZSYVOgkUShhLyX4EtInJf1VDIzQBxJQxLICF3mEfmoxgKocrusqJndXU40I2bNDy
         XW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JFCGTs9kdnvqk8xoWL4nmZerkpCeyN6uS4mJVgXj6fQ=;
        b=QDr+wTJlfTiNyp0fUe4rvXZvuLd3D7nXWXTkjakr03x02fFzIa/KTz2wHzIDltZbdw
         NdoZn4OICLJFEwPjGjin0OX4oQoZdcuvg5HyMc8a7Veic00u8CV5xXgEnu1W4Q16zOCC
         Er6dINsY4mchEepAsnHf+LM5Vd3ts7ObExhYmr/50tjannZ4G4XtOrzJmINaNos0jHzx
         f06ScRxz/hTjHNBLNQAAJnve5bIyacDF4U8d6/Ctxev/eubVRoFH2dLAWzne9LkhzAMG
         FwiWvd8xBSjuxKyzFd8/jvNHoT6xBP8be7ejxJHupNdhpgMlul0fg7a2ZUNedEhD+vTv
         ri0Q==
X-Gm-Message-State: AHQUAuYj1MOJK8ujfX0WzJJmITFFfo1Da2gIrqXRN13MvRNnN8IXnySN
        aycIJ4ZZCvQKe67tgEOcwuQydH0=
X-Google-Smtp-Source: AHgI3IboMrLNxof6phF6t/gpaIByxhWFAbSsu01Snk6GjefE6Dyxre9sjktD/ww2WDHswuWGALgu/Q==
X-Received: by 2002:adf:fd83:: with SMTP id d3mr7008621wrr.92.1549438433235;
        Tue, 05 Feb 2019 23:33:53 -0800 (PST)
Received: from avx2 ([46.53.242.9])
        by smtp.gmail.com with ESMTPSA id f2sm18667411wru.14.2019.02.05.23.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 23:33:52 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:33:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] ramfs: support O_TMPFILE
Message-ID: <20190206073349.GA15311@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/ramfs/inode.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -145,6 +145,17 @@ static int ramfs_symlink(struct inode * dir, struct dentry *dentry, const char *
 	return error;
 }
 
+static int ramfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+
+	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
+	if (!inode)
+		return -ENOSPC;
+	d_tmpfile(dentry, inode);
+	return 0;
+}
+
 static const struct inode_operations ramfs_dir_inode_operations = {
 	.create		= ramfs_create,
 	.lookup		= simple_lookup,
@@ -155,6 +166,7 @@ static const struct inode_operations ramfs_dir_inode_operations = {
 	.rmdir		= simple_rmdir,
 	.mknod		= ramfs_mknod,
 	.rename		= simple_rename,
+	.tmpfile	= ramfs_tmpfile,
 };
 
 /*
