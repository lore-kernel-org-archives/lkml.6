Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD348C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648A4208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7h0FHmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648A4208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeH0WMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:12:07 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46937 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:12:06 -0400
Received: by mail-pf1-f202.google.com with SMTP id x85-v6so12318328pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2c4GrvMVIN+90M0LSZ+sVRiyBlUKjkTDXgUoXJHIdRc=;
        b=e7h0FHmrIZhLyT1B1v1NjH3Wujf0m9h3bgjRg1kdvenPa6ospPMk4EnsB2L1pg5X9E
         6X+Vkl2/PG9TGu9CAMjA1W2iA0Xgsb8dPuQfz3jfNPrwy9gWpFPzauOra+/+iHQrmasg
         208ANrDzXuoS7V9cITCDpqmgzYxDH+VI96LBCHa09MwuxeQOxDfiKw0hKjHlIM1S9zKI
         Ozucp1OPqB2fmfhDlNJl62MXMPStMPRz71frrvW09esSTf/GhcQGLmgP2el7FqRF3t3R
         z/7JJbApzJ7V6woVeB4T4ptUsaK+6IVkj5WqQKahBu+i/kgRxD9aKQzBidgncQms2Nta
         ONaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2c4GrvMVIN+90M0LSZ+sVRiyBlUKjkTDXgUoXJHIdRc=;
        b=WxqPWjC27AOV2N60r3SzD/TGDX26CBivSgV/OJih13EPFilTdk5QKAuaGjIaTmAVu3
         9j+aiwBE+aaSv6TWGHoIWrnn0nNjSHMTIy74tEgobkuEVlZ+ohBgD3/oEgNP7N72wD5P
         L5cTTBh3sVmjKfKYwAO+tQdOHqXHZFkPhcgrjPUUz+u7komkfQJSV5lUNqcb93PmS00K
         OySjrFcPbmak45oWZV886oZYC5+Rd86XZZy0faOSVtZtfiz1FfbCYi9N5tFct71hw7QJ
         GeUhNzwfAnfkwBr99dJtbu35AOYaMDsGMxFKaroEyFDLn+0/J13U5VbQ9qzGu/EJdcJc
         yf3Q==
X-Gm-Message-State: APzg51DZ+k/Ej1iiT9M34UF34qyd8LXGbcf65CrcRoeBsAw87TIGTO63
        O89PrYlgV0u1GUbTMV1BEY1D95od
X-Google-Smtp-Source: ANB0VdYmMjtLV7/T6XermCYkSsgaZK1rbJO+CNNfyXSKYea7yqT8QAgb9geXoEwvD2MUkMzwpdFSqd6t
X-Received: by 2002:a63:a06a:: with SMTP id u42-v6mr3401135pgn.32.1535394264542;
 Mon, 27 Aug 2018 11:24:24 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:12 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-17-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 17/20] platform: goldfish: pipe: Fix lines to not end an
 opening bracket
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

checkpatch: Lines should not end with a '(' or '['

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 95256a5c593c..324129879b09 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -122,8 +122,8 @@ struct open_command_param {
 /* Device-level set of buffers shared with the host */
 struct goldfish_pipe_dev_buffers {
 	struct open_command_param open_command_params;
-	struct signalled_pipe_buffer signalled_pipe_buffers[
-		MAX_SIGNALLED_PIPES];
+	struct signalled_pipe_buffer
+		signalled_pipe_buffers[MAX_SIGNALLED_PIPES];
 };
 
 /* This data type models a given pipe instance */
@@ -373,8 +373,7 @@ static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)
 		is_write ? PIPE_CMD_WAKE_ON_WRITE : PIPE_CMD_WAKE_ON_READ);
 
 	while (test_bit(wake_bit, &pipe->flags)) {
-		if (wait_event_interruptible(
-				pipe->wake_queue,
+		if (wait_event_interruptible(pipe->wake_queue,
 				!test_bit(wake_bit, &pipe->flags)))
 			return -ERESTARTSYS;
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

