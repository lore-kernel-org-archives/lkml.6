Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 33E4DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D1D208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw0UWdG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D1D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeFLEeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:34:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46973 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeFLEeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:34:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so11399215pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gYSp71olMKMamF+jwuSrnKTDB+rrLt2g7gviGYiZIrg=;
        b=fw0UWdG+OXJM6p0wutRNBvMuUTYUnakGKVNbC0tXZnnQty/Z15zeD7AHQ1OWzJqpGl
         ZhKuuO6NNflyXurLZ5phMikqrvjBVSSx0R3O1FfCEFYYKV0FrBuftuCNB9lz3atYjyFp
         RkFkKpmXPlLOvowreMTtoH5gcFoQkE888qeixKl4VA1Q8nn/TFhSF3sN4UtRhPqQ2IEu
         YQeeB19kDc8usT/TZ/8uEMOfBvjFqQtU4W9qkVx8M34VPXFTn95l3qQkvZJB/CEcb92f
         YfPiUMWuWdwnRxwzpLVBw9x1Fxsxx/Z2lyjydRU8KCrVAfwvU2vyet2FmWIn1A5dohdD
         WW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gYSp71olMKMamF+jwuSrnKTDB+rrLt2g7gviGYiZIrg=;
        b=CELRE2upzSl3qPcOhoXn0CAfB2ASEBAMUu21TjzOy984/iqA0WSsHZrp8U/3k7y237
         XhQp6GqlRlK8y4ONmqp39JPJ6eTvOz/a/jlkhEbJXfUz88jyq40Ymd/7CeMPSL2kqVbZ
         wW7T/Pp27gcnmFLewljhmMYSTaf1ncFDUuoOnYC6t/Sc9XlyJEcayyEUffGmGhKq+z0L
         tLIH+0UgvTOTNOpVAuN/3WfBk0Bup9NmlFjBoqWv0w1b37KwzJCBL9kpM8MX+zZMO0tv
         cHjpibeBe2WO1pWpqjKjZnPDFqdDi2zAiq8zj3SorUoQNsWTeMtInMf7ldTFcpKyWnoA
         TZKg==
X-Gm-Message-State: APt69E2CztH2QphEAoKE31t9v2hn5dAPJ7a6gPGBo/n2Ey94aHa8JAPv
        3d1R9k8fUZnj3KYVlxvdmmYdNeftchA=
X-Google-Smtp-Source: ADUXVKL9zckJLv90siwb40CzNlv0C+xyBmHndal/2bAIj4vE7bCtKPlWUq9vQ+4fT17M6ihcGSNmLg==
X-Received: by 2002:aa7:8298:: with SMTP id s24-v6mr2127343pfm.136.1528778058630;
        Mon, 11 Jun 2018 21:34:18 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id u14-v6sm14079259pfd.103.2018.06.11.21.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:34:17 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/coda: add error handling for fget
Date:   Tue, 12 Jun 2018 12:34:12 +0800
Message-Id: <1528778052-41025-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fget fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling fget.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 fs/coda/psdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c2..55824cb 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -187,8 +187,11 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 	if (req->uc_opcode == CODA_OPEN_BY_FD) {
 		struct coda_open_by_fd_out *outp =
 			(struct coda_open_by_fd_out *)req->uc_data;
-		if (!outp->oh.result)
+		if (!outp->oh.result) {
 			outp->fh = fget(outp->fd);
+			if (!outp->fh)
+				return -EBADF;
+		}
 	}
 
         wake_up(&req->uc_sleep);
-- 
2.7.4

