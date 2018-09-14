Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3DDECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B8020882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Emajc50H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B8020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeINXIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:23 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:40579 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:22 -0400
Received: by mail-it0-f73.google.com with SMTP id k143-v6so3696735ite.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pO2cWwRY6FfALdvOl1JG9Zk9ToSO/GaoLclH+TJFN1c=;
        b=Emajc50HrUHBreVyp5DGVl+BT265SrrT541V2A/fEk/tuxq0TSbZxBdJ+QrrGHP0hW
         YIrArFQ+HCGnO6gpi61aYtIbvXLC2UkrU4c91czn4W4SZc/89apE9rjWC6U062/01HEh
         tILs6N6E8E3uSOUkMzDxojP6VDH5FMS2qn5Thi5CEbSkV8LX9oBhYExIa3QvMjFYc/bf
         HvfVgRJnGYVjGoAWN3uzv9uxSSrN10N+/bufzKWZSGTc27HGFe1qe6LMu3kIdaenqe5r
         F+8vT2qOqjc4a4yxHaSDguKDUeARt2a4thq+5Ro6qQLHpzsAhM/Vv5ipDlItRVLL2Sii
         ma9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pO2cWwRY6FfALdvOl1JG9Zk9ToSO/GaoLclH+TJFN1c=;
        b=FgNl3x/3+0qy04ZdqiWV+iAfeY/cshKNMOk2q/aCzkhnM44inthycXI/sk/F8zi/bv
         LFXfRWyniCfkzGG3mCofdQwXWaOcLb2Y3JkLLN9/FoYK1QQiGRKghIe3wlq6l7csZzdK
         eR9P7h/jK0C6IETlDXkmzs2GvY1YHUH6lms9tLoprRYNTeKD1lmY/Vnt91JWRVVc9PFh
         Jpuw5nlQj77EAPSwNUCEn36mP559WeNukQfMDbJDlv9gGMz6+eMKVsHbCTOXNTNP0StO
         RdLe3VkWPgvkoNjqKOFYnMyGdTw9OqyzIe7mP9YP3ZJv4CHkveZnwPZmNQSazI+01Xn+
         R86g==
X-Gm-Message-State: APzg51AN68V3YpsOBag5DNo7yhIc6EwXvhi4bAyEm6nrZORj+k57x54U
        Hwty9UyEWVMe8hKm4x+TvLzoy9b0
X-Google-Smtp-Source: ANB0VdZJAGznXzPMjVmvA+7JPmDpy13OgunIQ97este8rTbKeZq/ErelNcaMDelsAdsK1K7dxrlIWoO+
X-Received: by 2002:a24:b713:: with SMTP id h19-v6mr2949581itf.28.1536947568503;
 Fri, 14 Sep 2018 10:52:48 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:15 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-14-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 14/21] platform: goldfish: pipe: Add a blank line to separate
 varibles and code
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
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
 drivers/platform/goldfish/goldfish_pipe_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index d653e5a2ffcc..6a8641c7c36e 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -747,6 +747,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 
 	/* Allocate new pipe kernel object */
 	struct goldfish_pipe *pipe = kzalloc(sizeof(*pipe), GFP_KERNEL);
+
 	if (!pipe)
 		return -ENOMEM;
 
-- 
2.19.0.397.gdd90340f6a-goog

