Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B960C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A48208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sitpkOQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A48208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeH0WMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:12:13 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39447 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:12:12 -0400
Received: by mail-pg1-f202.google.com with SMTP id q12-v6so11440847pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4E1pIVBdPZYQByb8Xz2Ql3WWZBKAEMhnQdBJrpw6D9U=;
        b=sitpkOQLc/HFBTezgjYjhKUuTMtvx63HTddFpYodXSUzk9Qy/KS8zoTjFyogSM7J3x
         0nF0OxT08ahgwxp7qlcwSw1io6Xk5vsGA86TOdtzmEq6ZS1sLfqz/lIXca+BhPLMfu9x
         fIaGTt8uw4InKkxP70go437IRY4SLF5YLxmKNphDEf3yl/BIrNI9k3Ots3B1Y1C2s9dT
         tFrdkRghFZjEWqOkv3fffgl0PCHycM356pFMqVds76EEANFX6ygubj20tuKgmCCdLWoF
         9gsHy2jeA276RIqFegpeLYCIdfCzFXOcGK4i6c1GR3ntiNUkIj6c6Upe+W4PnW57K3Y+
         kNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4E1pIVBdPZYQByb8Xz2Ql3WWZBKAEMhnQdBJrpw6D9U=;
        b=tXDxbjYJNFxQV+4k/f859u55b/IjXpWpD+Ga6b039BVKfR+o6to4IlpOfNnr9yJaN6
         0et0oukvOCMrndtTtZEQeQEgkEMqzVowy5NGZ0UIJLVtNQC+VLY+YAEs7/2VgAvY2P5l
         zWKfz4CZh0QPKL7R972WkM/qLYCKC4cBQifFHZ+1MB/7vowtiZJ1TEPhRmHvI6Glydx9
         oyLEnsuk9wjXDicunE9LfP9y4TwsfI62ijz1rO/Uu9roWsSk4d6G1axLWVT4g9Vpxvzw
         gAE+Guuni/5z5TA3LKbSuGjdBUPXFwbvVKT1JE7Ko97p5WLqhQDPhWP/CfRqJhtZXNK8
         cWRg==
X-Gm-Message-State: APzg51BdXcwPmwRYskn3v6moNdvsR+EVohCK+0aJTIKRS+COHd7lX+tR
        dVCPHUUr3W3Jdi9eUsYwkmu+dAe8
X-Google-Smtp-Source: ANB0VdaxfRXZo+TD5UuuXGIm68bSsGaxGBHlTqC3gKtzxLQ3ECjAJyVKnm53W4hMge37jcgt74CT3mPn
X-Received: by 2002:a63:9c1:: with SMTP id 184-v6mr3377443pgj.114.1535394270292;
 Mon, 27 Aug 2018 11:24:30 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:14 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-19-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 19/20] platform: goldfish: pipe: Move logical ops to the end
 of the prev line
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

checkpatch: Logical continuations should be on the previous line

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 02783bc59dd7..c892a0447a81 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -532,8 +532,8 @@ static void signalled_pipes_add_locked(struct goldfish_pipe_dev *dev,
 		return;
 	pipe->signalled_flags |= flags;
 
-	if (pipe->prev_signalled || pipe->next_signalled
-		|| dev->first_signalled_pipe == pipe)
+	if (pipe->prev_signalled || pipe->next_signalled ||
+		dev->first_signalled_pipe == pipe)
 		return;	/* already in the list */
 	pipe->next_signalled = dev->first_signalled_pipe;
 	if (dev->first_signalled_pipe)
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

