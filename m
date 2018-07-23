Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E401ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EA420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLgWcDEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EA420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeGWEwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:52:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40106 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeGWEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:52:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so7647270plp.7;
        Sun, 22 Jul 2018 20:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D9EdVxyjb4U6oRwc+8S2kmFfMTkbe6FA783T3foX4lA=;
        b=tLgWcDEYPhlQSfIBDVO7U9J8UI/KRLPWpTpRZDlLffOPZYvCmDh8Eps/fSlEV3M8K5
         tGfyzara59x8F2PFgPkgkO49LdpoBmdMvISR7uYsX1T0JPB6mGXDYtgNXniokVKKJxLU
         iX64Wpu2sbglGkqyBjoojogxOh6daVSn6rEJaUpcmhoIcniwAwNRJqhRwOf6/y+hAa+v
         Wc5sAlUD1wTwdhADKmGgtK8GrnlCZrlJKEEC8zGUCsVmb+sbTM56A4KGkKbO1fPaO+Mz
         FuevfbPcRMboHF4+SQiZZ/X7yD+Dl2/7+wklG3eBF7+1QBjseHSAEL+i/ANlqkwBnjwj
         WTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D9EdVxyjb4U6oRwc+8S2kmFfMTkbe6FA783T3foX4lA=;
        b=ekjSRj9gnkpRwrU/kDx53gt2zaJ1vP67RKtw8TQrMuOQ8hDqUtGnJjus278hUykCSI
         Vm4Le6wJg6uI+8BSrOYtAaBt9Oj5hOokY0oAYDtBMasSFOVyXRhYvx0ioda7xiQizDf5
         iy9ngd2/9iKN7c6SVEL7R5USQyc9Je+HXo4ALp7OwvAl9ir+oW8zScAjYEE+CgbaPETw
         pjgDgvMisvlEK+/KYAjUQUVuSZLIpIM2VJARjT+yHSpUcMrEsrBqwgAF29eEQbVEzJm8
         sI1Njc9ODIHpJaush9P6JfwP1cKIDxwA0d7SDFFLMPJslzfKzmH6HyT79cCl6v3RIWdt
         jLyA==
X-Gm-Message-State: AOUpUlGESHuXNev4aSv7ePyIfERkXwf3glH3aCDLilXkRl0YDV2dtJeP
        eb9L5ibBjcZvCxHJ9StVrC0=
X-Google-Smtp-Source: AAOMgpenk8L1zZ+dWN1uuFoW5cewntv8YNLUwdZsqOQOHB3lV/Xq8Uu6LrwDOxqGCzqY+6AkvqyEwQ==
X-Received: by 2002:a17:902:b785:: with SMTP id e5-v6mr11277064pls.339.1532318010188;
        Sun, 22 Jul 2018 20:53:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id l4-v6sm10161111pgn.46.2018.07.22.20.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:53:29 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: hci_intel: Replace GFP_ATOMIC with GFP_KERNEL in inject_cmd_complete()
Date:   Mon, 23 Jul 2018 11:53:21 +0800
Message-Id: <20180723035321.8270-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inject_cmd_complete() is only called by intel_dequeue(), 
which is never called in atomic context.

inject_cmd_complete() calls bt_skb_alloc() with GFP_ATOMIC, 
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 7c166e3b308b..46ace321bf60 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -458,7 +458,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	struct hci_event_hdr *hdr;
 	struct hci_ev_cmd_complete *evt;
 
-	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_ATOMIC);
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-- 
2.17.0

