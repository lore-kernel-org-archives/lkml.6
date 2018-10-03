Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D02C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5B20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFq56dUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E5B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJDAH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:26 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40701 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id o3-v6so6009695pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CdKGNqR3BlHtl3PidCbP3bQeUJbihaRmimPhu8do5Co=;
        b=EFq56dUg7QU5g3Q5YCOTzIH5TKIRXSgVrk+6P+wrZ4mcTXXzv4wvLG/dSmcsfZgiW7
         7Gh7XBsdalREsFnB5ZoFeN7O4h/xnqB1dLgHgk4I9/oJ9J9Cc/DoipOy3wvlasEPHL4H
         7NNSffvT6Dn4lcod3oSSNp/Afk+JhMpJK9nOe0je47S3CQS36b13NQ4XtIPM57XJTiuT
         Pmp4MfmI1dG4EAyBV+FnxVdNzCvmzRQb6ZdIWJNgzdvxmbPErcn/l59VGmvtKEVKMT3v
         QB0+XUALnpF1epaS9GkIP38r0oufeRC7BQoKKlfPA4uVJvHX9xL7Gp+G147Aks0Crl9s
         9VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CdKGNqR3BlHtl3PidCbP3bQeUJbihaRmimPhu8do5Co=;
        b=OS8wgHWyLB5es+JAFZF2CP8iX6MOvcoaj1vcCNJe9oRkgEGkHRlHXDSP2b0/tW9sXN
         sPWekpgL1nRIgsCiqgNOvMTmYNDrqY2fYNtcxGHu76vPJ443hyMEUIvvUbgAtl26UgkM
         qiC4gjOLZhbgfH9+6hq4MRrERPpCUl/Qn5sYSGzrtZO5Pglu2NdOc6EeURnZyhSj6FC7
         ENDjeEYmQnyVWo7zExZCKucYpSgbJp01DYp2XN1pulq8M67o5kxuB9nmMSt4s7X1Yxpu
         FD7Iag5p70EwNckzhJm1vPma9gkeLmEhboN2MeOgHD9MryWcNm1SM38VxFqg2UonqH0A
         ADdw==
X-Gm-Message-State: ABuFfojoZRAAJiH8Wk2tkgxV2iGRLCUFpIgemw5QCkt95WPyHgGMu8KZ
        aCE2S2I9xOkfQRdCyeBxGMyqb8Ng
X-Google-Smtp-Source: ACcGV63wFq7N0oCPPb7sPW+ByKkbo0RFMsiQZf3EyztcOYZzb7tOjozG/4aGMjkKEohRYAii91i258sQ
X-Received: by 2002:a63:4965:: with SMTP id y37-v6mr977608pgk.72.1538587088008;
 Wed, 03 Oct 2018 10:18:08 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:13 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-8-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 08/15] platform: goldfish: pipe: Add a blank line to
 separate varibles and code
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

checkpacth: Missing a blank line after declarations

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 1822d4146778..a1fbbf49cc3f 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -713,6 +713,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 
 	/* Allocate new pipe kernel object */
 	struct goldfish_pipe *pipe = kzalloc(sizeof(*pipe), GFP_KERNEL);
+
 	if (!pipe)
 		return -ENOMEM;
 
-- 
2.19.0.605.g01d371f741-goog

