Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C8C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3700D2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYVzxwR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeLXQy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:54:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42522 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:54:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so5745277plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0oIDr7LJHmhL8x3TH2lkx0xdbV435W2V/4q3XUscdfE=;
        b=PYVzxwR33i61xMu8hEuiHdba8B2ii/4cwKIt/vKwP+hsDA+W4k/OJ0P6WNuB+08yAr
         52sqPGkHctcMUAnbg8bqKHRRxGU4ebIB6IRnlxKQkawRmXxeXv+IdeYOxIoSU5C8E/dx
         9uOJ81kqJSM/BdiqV/xfyJp0aWkOKmRMvL9iJfRakjrxMKdCJtGn/ed0X0lY/h0fOCbD
         Q9ArPe8ZQwdMLffGqMpoEqeHdy5aHjGrthfC8KYXmT9sfCAzNKMKk2Tl5mnmrs/ZOujd
         5l2dn2CK0FlfuEJcw1YptWkWOCP76E0MsVwtKa7UBJr+YbgR1/ePzEMfBE37CRM86EaP
         g4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0oIDr7LJHmhL8x3TH2lkx0xdbV435W2V/4q3XUscdfE=;
        b=n3pLGNVxEQy9Rp6rexLU2FkydxGiI7owp6qPlsHt5vMsYgyiHDGOPB3esXqccobear
         FLTpawZiKZBCc6AyYRzrzqlrj8GCmsSpPty1+h2RGKGVHBFPJMUIFUE/FIp2OsLMle6p
         09sqOc9nW0EzsggObPFYhkN0KInYBd7FSFQk3w7LvZFbL4jAaPM4qnjRsg1n1XFz6AgG
         kM2OFz8eCHLxAOEj+Asak6ggGdKG2VevIWGQKzVwDTRLfK7fMYQXXGh0Ash899FOEFWb
         JkRpiAOpfBIGK+WDEAR6ZQ/101QbyZR6ZywVpQ+mjqLj1Bd0LV3ceCdYn6amPjntauKp
         jPpw==
X-Gm-Message-State: AJcUukfQVbgKHd0Qp96017PFV7HwxjXl2/HRRLMp/DPA2PpoJTKKCDyn
        Y+XlzeH4kpKINa5KgATSqTY=
X-Google-Smtp-Source: ALg8bN4lmvSlA4CqOEeRxqKiXZAFWLqEhF8A+hm/bHG2Z7MsxD3L3GD3iN9Hn++gszP52gj4k1CJCA==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr13802421plo.205.1545670466310;
        Mon, 24 Dec 2018 08:54:26 -0800 (PST)
Received: from localhost.localdomain.localdomain ([116.74.222.141])
        by smtp.googlemail.com with ESMTPSA id f67sm62599156pff.29.2018.12.24.08.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 08:54:25 -0800 (PST)
From:   Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To:     osdevtc@gmail.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        prathameshdeshpande7@gmail.com
Subject: [PATCH v2] staging: wlan-ng: prism2fw.c: Fix "Possible unnecessary 'out of memory' message" checkpatch.pl warning"
Date:   Mon, 24 Dec 2018 08:53:46 -0800
Message-Id: <1545670426-39823-1-git-send-email-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary out of memory warning
message from wlan-ng prism2fw.c file.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/staging/wlan-ng/prism2fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index bb572b7..94800c0 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -556,10 +556,9 @@ static int mkimage(struct imgchunk *clist, unsigned int *ccnt)
 	/* Allocate buffer space for chunks */
 	for (i = 0; i < *ccnt; i++) {
 		clist[i].data = kzalloc(clist[i].len, GFP_KERNEL);
-		if (!clist[i].data) {
-			pr_err("failed to allocate image space, exiting.\n");
+		if (!clist[i].data)
 			return 1;
-		}
+
 		pr_debug("chunk[%d]: addr=0x%06x len=%d\n",
 			 i, clist[i].addr, clist[i].len);
 	}
-- 
1.8.3.1

