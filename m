Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C720854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhaFkeim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4C720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeGUUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44626 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so14098598wrt.11;
        Sat, 21 Jul 2018 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sl+s3hBPqjopTCQADLj9mbVwdM7xh5MKSKS3p+FB1sA=;
        b=OhaFkeimJHC4ZvLwwvGGCdCBNDvXcp9Keiz7eEdCjBMZK0RKh6i08ArTd2xKZRU6hu
         ug9HWRmtx1xP1WG8W077k23Oe4cwq0Gs87LlsyEN9WZUL0eMw9Mc5u1jWt4qfKI/vzNG
         FUsAgFGTGXcQFnKaB9CZH+e/8K/A8POecw4lwgpxUWQaey31NlF1dWjHjZphk8DfMUrI
         9heanN/dtRDUvYzJWvRTHSYI89SNYIAvHaEm/bSDp9vB9Xgwt987QZebn++js/xjzzPg
         FCy07wwUrgkbDt9qwhSaPMSNCBPtl+ylwHbQL2jJhRWbdIkUJQPJupuYo7r+0+QBkWN2
         q7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sl+s3hBPqjopTCQADLj9mbVwdM7xh5MKSKS3p+FB1sA=;
        b=RPb0dxMmH1K0iLM4nXcBVuvTkUqmrBONSz3s6j7LPSrx+Yh8DUDUeOjEiZ2S+ZcWL0
         BZKnwsxKotFVU72ghNLPeFf3UkuDOilHYdCAsWXpX72k5u1jxVW/XtTXZCEMrBFhlSbU
         X66pP9P94O+mFr15l/4FQiokk/z07mlt7rjjAzbWWzqhEWR+FROsIkyDSnbUfV4XHtom
         jcmCQtaRHi+Ei0NHCXRZNlugl9ZPSat9vjcusZBaHPkida3lWUw8hIaKsbHfeAcgj2Ok
         fHJ0ilrMa45hf1GAKiy8uwXQ21+OX5U5LofsF1VBefUoPR4qR/LAuLJiEKOIorz5w8DE
         z4nw==
X-Gm-Message-State: AOUpUlFZR2V9HhUDYnkT3m1UxUOBrpFhESbdEq8RlY2l5ROWhCOVI8hK
        mIpi4oI7izNc5QBPKxMe2xtGFBOvvBZlnOYU8vk=
X-Google-Smtp-Source: AAOMgpfOeRulexFGxICcwu3ebWns7McUxLPF7Jpk6oRk7y539kmGInbLIJwb4jutOAnC6YFpCRHnYw==
X-Received: by 2002:a5d:480d:: with SMTP id l13-v6mr4808524wrq.234.1532200271016;
        Sat, 21 Jul 2018 12:11:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:11:10 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Martin Kepplinger <martink@posteo.de>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] touchscreen: tsc200x: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:51 +0530
Message-Id: <20180721191029.25658-10-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/tsc200x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index e0fde590df8e..daefeca101ff 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -336,7 +336,7 @@ static ssize_t tsc200x_selftest_show(struct device *dev,
 	return sprintf(buf, "%d\n", success);
 }
 
-static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);
+static DEVICE_ATTR(selftest, 0444, tsc200x_selftest_show, NULL);
 
 static struct attribute *tsc200x_attrs[] = {
 	&dev_attr_selftest.attr,
-- 
2.17.1

