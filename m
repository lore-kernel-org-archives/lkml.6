Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF560C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AB820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSP16BU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfANUiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:38:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35184 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:38:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so1018955wmt.0;
        Mon, 14 Jan 2019 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eJnjQW5IPzpeYQGufmmv3JMdNFkJ0jzBZNxHqBNDZk=;
        b=BSP16BU5BszWqZolP7r369EbMSL+9KTAt2sdRaUgVWPmdapaDiAz3UwsbSf3dtSw8s
         tHPDzv9YTaFzQBSEYvFqUGjHGzI+MgWNuO9Kfa+AqBIvDExO9V5vVQ9qX0VMFoH+p+bv
         5K5SkVqwBUOkwBhJELXTiFw4ttN6QNyIJ5/8qcnVbxMTLfJNiR1fXEk5risFnGk9tGy5
         88SA8WO5mAo3oEsPmx7KIE/g8m0ws6qz8ND2qvWJ+MAolup2cOgnOsN1Vqp6lD59CSgh
         egHBjd1PSjZ4z0fegazYwrOcSqelYCiKPga1glOkHx74JuBI+kHeJHeRdIMDdVSNI2O6
         VEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1eJnjQW5IPzpeYQGufmmv3JMdNFkJ0jzBZNxHqBNDZk=;
        b=WdqmAUDZ8ea5l8q98RY0414LJiUAE1cR6BQgE4QenSaulkaAuzaCsok8BcUJGq8HAB
         kXYY6QEIUB3+Rkq7T7XKyiPGzFPWZHM34bRlrG9uAyOBlNGfZlsw+tkP1s+V5t6joPvx
         YD0kAbnoFRWZUUY8kLSocnVQ6B09/y4T4HyyR2Ml6tTA3vXqkByRLeEtrQN/siu5hnt0
         sDe0OreyW1x4PoOYokJBaw/ImY61gjNnOa7ey+TEuf5fnsoQOw3KFBLSrMYFtL/3jDWR
         EnjffTzRpfzPy5+lLD/uuBYNIqvQJFnM853l7Whrwzn+guaaT/erPpPloyD55Ie7PluH
         YWPw==
X-Gm-Message-State: AJcUukd5TK09g/UYYlFQRR/UMTMa6ZZanM9KNvGpPrX1ytzt2HVHzcY2
        qhmDehaO7e5qpdYoYA5FnSI=
X-Google-Smtp-Source: ALg8bN4KvF0LnCwCbM0qpPlPnQDPgtCV20gHZt32VY/tth0NAXAbWGRAb9rNmti4P6Yd8dYXydxaRg==
X-Received: by 2002:a7b:c853:: with SMTP id c19mr625033wml.61.1547498284468;
        Mon, 14 Jan 2019 12:38:04 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id c12sm70904420wrs.82.2019.01.14.12.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:38:03 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id C733F11422AD; Mon, 14 Jan 2019 21:38:02 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:37:59 +0100
Message-Id: <20190114203759.19578-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  fs/seq_file.c:319:10: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/seq_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1dea7a8a5255..abe27ec43176 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -317,6 +317,7 @@ loff_t seq_lseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
+		/* fall through */
 	case SEEK_SET:
 		if (offset < 0)
 			break;
-- 
2.19.2

