Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C253320652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="F9oB2UrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C253320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeJAWLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:11:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54472 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbeJAWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:11:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so5237257wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+FIFbQ65mMe5ZYlTSYZP/ejW67TLwtgZHYuN0iEMkjY=;
        b=F9oB2UrOGi4kD36d1jDLf11eh6QV9XAOlmz0bebLD9nrYmkya8z+xqvVixoSfU5CKr
         vuGCSyq7tG5ziJg72uao7kghkl5NEREsbaKDipjAWlhmhwacNofIk7iuA9pIzmCA09LG
         QV4VguaErbXfyD9kihOCAixvVGH6PIHGhTuNlHvee4U1B4DroBLY/TykkiQg/FN7Bb+S
         HegLf+HZYqtjP1ZJh+E6ERioOzdplOqexO/n1qJa2+OitFd5wiwM4stUv1PjVvk4CC6o
         ty77jSylHguV6iM2M0l2Q/WXSPPp5hAGJk+bwLjN4qhVnBQjrhi/1Mcj4OdCWFqhbpww
         WE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+FIFbQ65mMe5ZYlTSYZP/ejW67TLwtgZHYuN0iEMkjY=;
        b=KPWZFM/Cb+MJgFrtIqAvu9blBJMB18t09Dxh9QUUrsf78uzwR/Jk8AlpHZrt27OKL7
         R/gOsU++8jcY0tGoEvR8C5gWMM5HkeoA42k2rzFnSQaZuVe2k8uYhk/DEYq0LzQ4WlI1
         wOEVijQzguxLyCYFHu/r9IR+cllqgrTDC9sPfFDWQOLFW9bTWCStV4yILwMjkOlPW7NG
         qMjPOp4uogIqQqCWbD5ahATDLhZg0/lUTYQZlDcbvwpu26UfGO7z56omfsVRrJhMOckb
         I4pkIez4luQ2l1mGSK+ewtcmOFAwgiieMy+vGWaC69bTv9BMMoEEoJjdKDd4M5nJbGSi
         Pe0w==
X-Gm-Message-State: ABuFfoib8tSyqojti9J+lvBpU4IGkti/IZNCgjmbRClvQvM18GBLBKVQ
        k9l/tvNmhEVJuP7lB5yYWUTWYg==
X-Google-Smtp-Source: ACcGV63uW3EFx22Pq/DMg3Boq9afiWfYKmzFx/8q7zzzg5NcUiRAEAAQACpUZ46pspqfHLAhoO00MQ==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr9785426wmd.100.1538407992211;
        Mon, 01 Oct 2018 08:33:12 -0700 (PDT)
Received: from pathfinder (host-78-148-28-244.as13285.net. [78.148.28.244])
        by smtp.gmail.com with ESMTPSA id 20-v6sm13405094wml.10.2018.10.01.08.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 08:33:11 -0700 (PDT)
Date:   Mon, 1 Oct 2018 16:33:10 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ufs: Convert ufs_set_de_type to use lookup table
Message-ID: <20181001153310.GA13006@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify ufs_set_de_type function in fs/ufs/util.h to use a lookup
table rather than a switch statement, as per the TODO comment.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1907be6d5808..1edf4c6454e3 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -155,37 +155,31 @@ ufs_set_de_namlen(struct super_block *sb, struct ufs_dir_entry *de, u16 value)
 static inline void
 ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
 {
+	/* type lookup table, DT_UNKNOWN is default type if no case holds */
+	const int mode_table[] = {
+		DT_UNKNOWN,
+		DT_FIFO,	/* mode & S_IFMT == S_IFIFO case */
+		DT_CHR,		/* mode & S_IFMT == S_IFCHR case */
+		DT_UNKNOWN,
+		DT_DIR,		/* mode & S_IFMT == S_IFDIR case */
+		DT_UNKNOWN,
+		DT_BLK,		/* mode & S_IFMT == S_IFBLK case */
+		DT_UNKNOWN,
+		DT_REG,		/* mode & S_IFMT == S_IFREG case */
+		DT_UNKNOWN,
+		DT_LNK,		/* mode & S_IFMT == S_IFLNK case */
+		DT_UNKNOWN,
+		DT_SOCK,	/* mode & S_IFMT == S_IFSOCK case */
+		DT_UNKNOWN,
+		DT_UNKNOWN,
+		DT_UNKNOWN
+	};
+
 	if ((UFS_SB(sb)->s_flags & UFS_DE_MASK) != UFS_DE_44BSD)
 		return;
 
-	/*
-	 * TODO turn this into a table lookup
-	 */
-	switch (mode & S_IFMT) {
-	case S_IFSOCK:
-		de->d_u.d_44.d_type = DT_SOCK;
-		break;
-	case S_IFLNK:
-		de->d_u.d_44.d_type = DT_LNK;
-		break;
-	case S_IFREG:
-		de->d_u.d_44.d_type = DT_REG;
-		break;
-	case S_IFBLK:
-		de->d_u.d_44.d_type = DT_BLK;
-		break;
-	case S_IFDIR:
-		de->d_u.d_44.d_type = DT_DIR;
-		break;
-	case S_IFCHR:
-		de->d_u.d_44.d_type = DT_CHR;
-		break;
-	case S_IFIFO:
-		de->d_u.d_44.d_type = DT_FIFO;
-		break;
-	default:
-		de->d_u.d_44.d_type = DT_UNKNOWN;
-	}
+	/* shift (mode & S_IFMT) right 12 bits to index into table */
+	de->d_u.d_44.d_type = mode_table[(mode & S_IFMT) >> 12];
 }
 
 static inline u32
