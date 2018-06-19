Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D80C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977212083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKI4Lk+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977212083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967066AbeFSQY0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:24:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34145 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966208AbeFSQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:24:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so302951wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cj0WsDlqHbO9uZygIM6FHZzW1EO+bWc3SeUHxvu3tDM=;
        b=LKI4Lk+tODLytye+gg/yj6iKVVQ08vPrNxh3ncImGbOyRsLIMzEAJFcK/z0Msv/r/e
         0Wp9TojQhxOEqjC1gFCi7xcrU5oFvVv0+8PuEj3vStouF77dMd9+JWsLs3bYfkuesOP5
         mP2NldECX2LtX+DG+Hv0QmGhU77gj0peaSeDKw8EXN70PZ2Rn48Tl7w9OtFmbthRH6rR
         Tx1pfejSY2LTLlt8GQ7BNbJ3UVKKaPref6jagjVu7u8k1IiZ7VHkciNbaSlk1a//DSko
         K4F51LzUUG5Ck+wgeFPw8SYqLZBLMtCPxqVePH3FerjMOhwSXE+nHRXp9vDGkVOQSiVG
         nDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cj0WsDlqHbO9uZygIM6FHZzW1EO+bWc3SeUHxvu3tDM=;
        b=lk7WEmKWLgKYKZFZo9/wF9aoqmm6o+VzdtntYO0WTdBXTGfHSvavWX4YRTp99OEYvE
         7Gr/td0L65Gl9Wzxk88Yn7Jxv+M5gwH+7ry0xQpB2eXbkWJ6frkQUL7CI3+mxYePWuNU
         XRXujCQjBPP15g82gQSG+YJ40MLOIobLjUhhkpXZZ3q/5CScn8vu3v+W85+PMekI3kEo
         8KJcFMVPa75kTXdrfJY4JKrw7Z36DtjiwGjDbxDslf8QWJmAHY+idiZojUDOYaGCDAp8
         1KRfLXzYL5h4fRvwWHwlCkl0plznROopkvjH1iWyt3XYBFLJLz1OuvjlNJkFxxb4+m17
         rcgQ==
X-Gm-Message-State: APt69E3QlTcfYIM2GI17o2bHaxjMRcWHHbPGLJU7loL+LpOcd1ibFjc3
        1SPvcZ3ZCHDHFmLC/5uf9bM9Tqgq
X-Google-Smtp-Source: ADUXVKJ1VX/3RzzRNKHvFscQGkC/CkWX9xsIvUy5Bi5RrEuS8rk4znhAHTHv3MFqFZclEa4Ve3ZkPQ==
X-Received: by 2002:adf:8837:: with SMTP id d52-v6mr14318511wrd.41.1529425463269;
        Tue, 19 Jun 2018 09:24:23 -0700 (PDT)
Received: from localhost (m85-94-188-39.andorpac.ad. [85.94.188.39])
        by smtp.gmail.com with ESMTPSA id l5-v6sm33325wrn.92.2018.06.19.09.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:24:22 -0700 (PDT)
From:   Vitor Fernandes Ferreira <vferr.862729@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Vitor Fernandes Ferreira <vferr.862729@gmail.com>
Subject: [PATCH] Staging: comedi: fix operator '=' coding style issue
Date:   Tue, 19 Jun 2018 18:23:52 +0200
Message-Id: <20180619162352.12324-1-vferr.862729@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor Fernandes Ferreira <vferr.862729@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 1f3b1106f478..e18b61cdbdeb 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -79,8 +79,8 @@ MODULE_PARM_DESC(comedi_default_buf_size_kb,
 		 "default asynchronous buffer size in KiB (default "
 		 __MODULE_STRING(CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB) ")");
 
-unsigned int comedi_default_buf_maxsize_kb
-	= CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
+unsigned int comedi_default_buf_maxsize_kb =
+	CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
 module_param(comedi_default_buf_maxsize_kb, uint, 0644);
 MODULE_PARM_DESC(comedi_default_buf_maxsize_kb,
 		 "default maximum size of asynchronous buffer in KiB (default "
-- 
2.17.1

