Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B8E208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl1wcZmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B8E208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH1DEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36012 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1DET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so7268edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yj4y8eTpQ0R3ShrvEALICNFx33TktyV8V3ebc5F433s=;
        b=Gl1wcZmfKP+S482JvnZ52hnU8qUqTnkZPYsq/x2eXDxx7exHfgHVR+1YJXSli6eDlw
         uYnf7HXi5JoJ8WDXWayIhZkb/XKANByru6I6Cn0k2ONTuhS0+0cHm5Wk4+oW3U8ZVpHR
         7lgcqjTV+Svc23iy8kVCfVZbIDbaxE3ygsKq/qsnqqDUsgt9gyg6irn622YXCDbrM08X
         u/I0bb9Mg/mFv5K2tL9jfe0Is2jsrxKOgm12e2UiUrTNNUvne8xPGXb8xGwMFiX2wGzW
         C1kC75zMJICJGgh6JumXhfVTcFC4KOQaf+TBN5UOLKJdZUR0vFMiOunS5P+6iu0UtKVN
         L9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yj4y8eTpQ0R3ShrvEALICNFx33TktyV8V3ebc5F433s=;
        b=VyVH4h2pJPr5kBMo3UgDp/6ZIyBta9AzJWZ9ssynWZpQglORNg4S753Qj65kMA0kWJ
         a1yq+Nt+UTGoYNj0AXJDn+9ThvwcDExOGnFs95C57Z/bYzRgmEdOTMue14aRMrugFJS+
         JE82nTXMpyQXEm7CTG/LWZ8sg/IbVyYGa5ukRcV/Ei8Gwbca7zRhujiyVXKRLFKh6i5V
         vbP8sBPLBTbidRGsqf3vx8/Kez+PRKM3joD+1zF8h7jCEUYnklK30BYsXDUCvK0HOX2W
         q6o2IvnBLhvqsRXRBt65rBYSQp3xkIqqpquHvR2BB09WQgEX2rUnJpdqBS5pkakgfXuJ
         Dw8g==
X-Gm-Message-State: APzg51DhNCT4a1WqBP4ok7XlpeirBsvonQAwexhffKskkwT/butNLHk4
        FRglpk/LHrKHXB+3aZZZpQ==
X-Google-Smtp-Source: ANB0VdZjS1eNZv+iSQWr/BCu7Up2vlCGb1uYYP8rjndFNzwT0cfAAFV+Z9StIXjjaEQ6Yzl50MI4sw==
X-Received: by 2002:a50:90c5:: with SMTP id d5-v6mr18806881eda.76.1535411732791;
        Mon, 27 Aug 2018 16:15:32 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:32 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 01/13] seq_file: rewrite seq_puts() in terms of seq_write()
Date:   Tue, 28 Aug 2018 02:14:51 +0300
Message-Id: <20180827231503.26899-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space savings -- 42 bytes!

	seq_puts	71      29     [-42]

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/seq_file.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1dea7a8a5255..0c282a88a896 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -653,14 +653,7 @@ EXPORT_SYMBOL(seq_putc);
 
 void seq_puts(struct seq_file *m, const char *s)
 {
-	int len = strlen(s);
-
-	if (m->count + len >= m->size) {
-		seq_set_overflow(m);
-		return;
-	}
-	memcpy(m->buf + m->count, s, len);
-	m->count += len;
+	seq_write(m, s, strlen(s));
 }
 EXPORT_SYMBOL(seq_puts);
 
-- 
2.16.4

