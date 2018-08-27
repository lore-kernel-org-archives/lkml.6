Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CEFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A234208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUJ1/smi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A234208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeH0WLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:21 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:33207 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:20 -0400
Received: by mail-qk0-f202.google.com with SMTP id l11-v6so15797490qkk.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xkhK5sf0DcS79bXN9uLT+9rmt0rflsNlB4ymD66cZwg=;
        b=NUJ1/smiR80X5FshUFqgr3yqp9QMGMG5eyA0pEzrTNfSxsVI5Aa0p/2Dc1qKvbqWxc
         95CyAAUsTzaNc4ZE3n373m4ut/8zppZBInWruhZc6lc1J+YrLIIkMA3y6+30wa6MPqNR
         mX5FvCemkaNLa3kcO+rTFNFv+X2UJZYO86KdNshLQNIPCoh868aBoT8i7GekTuqQSiSa
         +ZilVHv1+2VZ/P7uNWYpvF3HakuZkVt5/oqpOSITMnFEELqIZklPj0S1kG373L4OTQNu
         cniyNDAKsROUju+3VkJI9HJRX7jGhY0ai1PZOu8Y9ffv1g890rJmUgb0delD0Yak48FJ
         EXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xkhK5sf0DcS79bXN9uLT+9rmt0rflsNlB4ymD66cZwg=;
        b=kmEGsRiZ9WbUeVkzylFj/oNDHHKyzN4//HwL8yoce+WuL8WIKDvLLb+IdKyzdI+qrQ
         LR5YiTDgz3pDOT8Etp8y4X3+9aZ43+F84aG1CvsypiEnbd2kdpO0+r9ED1ijFpN0RjoF
         YUsCyT0rE57VDvna3wBoO1IRwVj5jvc3P2+KZdkuIBPamRRJRJuzOckfjwfWagOp3CR0
         V5RCmWeNz7kaVZ40wLBlUw9K7eJMv0M0tvoOE6RHva78BXw1FmR7eidNrRb9RWucxZgs
         P0YC8CNjrjqktmdHjjBquPvW4Kt/ypphvHgcBBtWnv2SOh6EkAajUw+3mAAPUDaIgR2J
         dOWw==
X-Gm-Message-State: APzg51D33gTlfQzqOVZo5EXN1WrPfMG7ihF6n6YhCVIKexmb5zQcdSEj
        R55b/FS3PsVqDfYpXrs79oAnIUjh
X-Google-Smtp-Source: ANB0VdZs8YkmW3KRMBw+XDCrjhSdE6ab7z5fheJoDawuVOLbAV1th6dZcLti3pjKA86Z8a+J1WzvVqwW
X-Received: by 2002:a37:bac2:: with SMTP id k185-v6mr8461887qkf.45.1535394218676;
 Mon, 27 Aug 2018 11:23:38 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:22:58 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-3-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 03/20] platform: goldfish: pipe: Move an opening brace to the
 next line
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

checkpatch: Function's opening brace has to be at the
beginning of the next line.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index d2f0582f445e..4e7e100dc7a0 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -588,7 +588,8 @@ static void signalled_pipes_add_locked(struct goldfish_pipe_dev *dev,
 }
 
 static void signalled_pipes_remove_locked(struct goldfish_pipe_dev *dev,
-	struct goldfish_pipe *pipe) {
+	struct goldfish_pipe *pipe)
+{
 	if (pipe->prev_signalled)
 		pipe->prev_signalled->next_signalled = pipe->next_signalled;
 	if (pipe->next_signalled)
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

