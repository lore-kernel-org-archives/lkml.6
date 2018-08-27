Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CAFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA56208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCVDu7Fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA56208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeH0WLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:41 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:46430 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:41 -0400
Received: by mail-yw1-f73.google.com with SMTP id 2-v6so9250037ywn.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vnN/QAOiVt/124A6R8Pu0YT3mNz/CjGud2FsWxuH7Wc=;
        b=fCVDu7FjTix24TUSXOmP7z4tF8hRxBLf4gkaQC6gA6HC5qOvTCJvzqTpEf+sMuEk+Y
         dzHWzsgkpZv1l8DgBl2w/Js/AaFmKast5zEuJn1DUg1uDM95zxVmlakuM/a8gXPkL4Fc
         09uhfdbhmF1pIyWAxKL+bHo7QePpiTk7ZcZzaauu7Avy9kiwNDwFwx6c83rJdGFKCh3S
         xCCr86FRW45BM4w3qzdldJuxeeiAau01hp4ZYoOHbI/ZDgFHFnCVtGxAwRzoPrgjeTV/
         +rSEIE1cZeTpYFBpBBikYitbPFBlCk8yr6oDUMHuDhlQ79FO46OdDur4FUOqTmfXBkqN
         MqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vnN/QAOiVt/124A6R8Pu0YT3mNz/CjGud2FsWxuH7Wc=;
        b=bdx/oRufE4Q50SlCTm49SYTxwyA5idnBLyLAixrY1Ui0hOQFQGOSb3J1Uxev4pw58O
         t6syqUhL+Jvk6LrnzZTD/GCIqlt5y4+NAEL7geYZAkGJCE5LNBXGaUddYhEB3BNJvgw8
         dT9FcukwtitbOMvZBsmVPTNcWciwhAYC4HjSRFaon5jK7mqeIckaEpLRUMRFZeebRJ2g
         ifLoPQhgX3DWyDhNaChKUW/GXCcgp93U/JMzYmwg+ncqJVUUkrtXzGATPs+iaj72c/qZ
         gWmIZL+ZGJVxnurcKcwo0tIRHx7OLvnHQQ/2QOc6CEEov3rbJ7UEW6+NewvratYodW29
         ZxjQ==
X-Gm-Message-State: APzg51AYaUkeVQWZRwYpVJcRLjIlRFSyLirFU2VQ1vm2QnERK+ySlnOw
        FlTRHoCTnLLdPVFa5HzD4SY5uBxJ
X-Google-Smtp-Source: ANB0VdYe7GS2bQhVnOb+yDLbHzMspMonvKYiIpmdPFKz2rrJIqHe79h6yYNF+oIhVV5ULi8Y3P9/iH3w
X-Received: by 2002:a25:d86:: with SMTP id 128-v6mr4287664ybn.27.1535394239603;
 Mon, 27 Aug 2018 11:23:59 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:04 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-9-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 09/20] platform: goldfish: pipe: Add blank lines to separate
 struct members
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

To improve readability and to be consistent with other
struct members.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index a61cd444e8ff..62422a4282f5 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -130,11 +130,13 @@ struct goldfish_pipe_dev_buffers {
 struct goldfish_pipe {
 	/* pipe ID - index into goldfish_pipe_dev::pipes array */
 	u32 id;
+
 	/* The wake flags pipe is waiting for
 	 * Note: not protected with any lock, uses atomic operations
 	 *  and barriers to make it thread-safe.
 	 */
 	unsigned long flags;
+
 	/* wake flags host have signalled,
 	 *  - protected by goldfish_pipe_dev::lock
 	 */
@@ -158,6 +160,7 @@ struct goldfish_pipe {
 
 	/* A wake queue for sleeping until host signals an event */
 	wait_queue_head_t wake_queue;
+
 	/* Pointer to the parent goldfish_pipe_dev instance */
 	struct goldfish_pipe_dev *dev;
 };
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

