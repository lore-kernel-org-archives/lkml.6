Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9415C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7E2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/ZuC6cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeLXQLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:11:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42115 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbeLXQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:11:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so5714562pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/AG8WoIQSfApW11qcR7PzwG2jjuXJC01VnXaY8jYjig=;
        b=u/ZuC6cvMSoSF0OSxB9q8n3/FKzqoK9TnUJeHU6j7Ly0oICMqVMiNLKOHhIUs7MdcZ
         iVhL3guune1YIO6hTY9kT2S91QOpg+5JXzn24rdYZTrKTCRlIbBmwjPnFk2YBzkmCqQ5
         T1mBBveBCPD6w4/Sk9Q8D92qHW7LF/B8fX6MPLyqte68yPfsSpXzDxCh1fKsFNuac3Zx
         dAysdc4vsa5ifVdK4/wR6Yb+h8N91/6TVlSo6Ra2jpUrMJMaYw0utZTkJRUpSs5lhyqb
         yjhsWX7G6UjhrCNvIjUmQ3YeKJqepVDyLOEz/lwQp0S7s2D9ZjJLbVnl5qXpXS7xs/f8
         fxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/AG8WoIQSfApW11qcR7PzwG2jjuXJC01VnXaY8jYjig=;
        b=Pt9o33D9XD+tX8hqZxjmdvTR3UxidUc96pgRb8EZiCjwiMVENfxKlhcoWzc+tyB/1Y
         VFMNoYu3+U7Eg3qXti7aZUixKLaZKJDIXpgDV2H8O8whdAoVdPdhJ9oIqmXtyx0x62sb
         RH2SMoh97Nq5A4gJRwSs39k+tcGOLSD0SUE31DkDKwiDOQIWsDP5/yINrfLsSsauOluO
         MjUBJ4COUVuZQJkYpqPo9a7RHMg2XrU05uzZwZUapbZ/SJRSuQcph7Oh2xUOBzzAUm3c
         0ZGtilXcuyIKUdArAPkVkBBFttA5xxQVRwYZqms8M+U/UMkWVW3AaDM+eXYvLavVu4RW
         uD7A==
X-Gm-Message-State: AJcUukcGqo9FqOwX8D+FiySZr3nP9AbTJN2Xx0HmeHJaoid0hvgFV+Hp
        r0zlQfqKp2ZxO/zStG7Sa4E=
X-Google-Smtp-Source: ALg8bN5bthZ1gHTlnIEcshuGw4dhDquu8alAlpgQyLrX7bPu8uEJk0pBS7maNvNQ/+4TeFLjl2W0/Q==
X-Received: by 2002:a63:9e19:: with SMTP id s25mr12840535pgd.203.1545667905236;
        Mon, 24 Dec 2018 08:11:45 -0800 (PST)
Received: from localhost.localdomain.localdomain ([116.74.222.141])
        by smtp.googlemail.com with ESMTPSA id h129sm51519823pfb.110.2018.12.24.08.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 08:11:44 -0800 (PST)
From:   Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To:     osdevtc@gmail.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        prathameshdeshpande7@gmail.com
Subject: [PATCH] staging: wlan-ng: prism2fw.c: Fix "Possible unnecessary 'out of memory' message" checkpatch.pl warning"
Date:   Mon, 24 Dec 2018 08:11:28 -0800
Message-Id: <1545667888-38999-1-git-send-email-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary out of memory warning
message from wlan-ng prism2fw.c file.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/staging/wlan-ng/prism2fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index bb572b7..c040066 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -557,7 +557,6 @@ static int mkimage(struct imgchunk *clist, unsigned int *ccnt)
 	for (i = 0; i < *ccnt; i++) {
 		clist[i].data = kzalloc(clist[i].len, GFP_KERNEL);
 		if (!clist[i].data) {
-			pr_err("failed to allocate image space, exiting.\n");
 			return 1;
 		}
 		pr_debug("chunk[%d]: addr=0x%06x len=%d\n",
-- 
1.8.3.1

