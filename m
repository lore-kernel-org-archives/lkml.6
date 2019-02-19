Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36F2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHlXNvEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfBTCQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:16:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33556 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTCQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:16:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so25732798qtz.0;
        Tue, 19 Feb 2019 18:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nb+HcHL5nNL955Nd2X2UTE163Svkf9JDL2pHNFXhLkE=;
        b=VHlXNvEuQAEOrluwp0W3jB1xvWNft5hzopZ5ZEuI1M6K1nWvfmlnP8nPH1aC6oRkpf
         YVxtX+EKlwge3Gi16KA6Aw0LujaRjO/85KnKt3KFxT9LBn3bQ3fJTjXhyfrJEY6K05FF
         DnJuXZMjBvIP9E7u1+rWoqYwWiC5WXidNeleKLezndgWZzLPhuJw0LJuxDzgzb1ZDs12
         40xgafIDPc1UyG23m89XfjeDO1y/BV3oRU700ZJzylRezl6FfMWCowJ49CYAQ7RCObW0
         +pSJ4SbC1qoPygf1IuMcq81aijSfbCMNfI0PA5gTCcS6H+nrM/DZlpMgSm+GD4VYE01F
         V3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nb+HcHL5nNL955Nd2X2UTE163Svkf9JDL2pHNFXhLkE=;
        b=QH5Js6gfnvXRSkgMV07RdQnDgUCOJ9bHVanq/wTi6P5QNeVtHxmdTYLUov7ybur7dA
         Om4ECJ0mHcUxny7jqi8WF0mm2phEMxJ4qvXcFe4T0gMHAy1SplcWvipiYmtjmB2cRKft
         ITbbZDHVc+4yrGO97niyTx1SZ+0MJaPdyVjaoifaIN7cS8VvHzmGhNIWnffRaF7buixK
         1MuSb/nRWivRGQIsB6QP6nC+Xqtrh4SLfGgkYGFV7eNQL3Kg7xeAJcCxhKo7Sm1cd8+Z
         YjjNnhyfHAGVzEFe2YVKrl91UdBjhAfFxLzIG5+qFQ6l72n4s96AenFg4TuSo4C8S08D
         pMYw==
X-Gm-Message-State: AHQUAubVlWXTxir6gpNOn7+4JzbsNQfafRzwnvJoLjekKbvbHAfJvDyU
        PQ4heg9ftTHI7Dpr53NVBg==
X-Google-Smtp-Source: AHgI3IYW9ryYP/SZxRQndVdEfNyF3fYQV6b7DKPyOM6KZ7Hh6cqaCjfiehSk+ebhSIU+iHZ2+t3q3A==
X-Received: by 2002:a0c:c48f:: with SMTP id u15mr21853873qvi.154.1550628970709;
        Tue, 19 Feb 2019 18:16:10 -0800 (PST)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.gmail.com with ESMTPSA id d55sm11000075qtb.93.2019.02.19.18.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 18:16:09 -0800 (PST)
From:   Keyur Patel <iamkeyur96@gmail.com>
X-Google-Original-From: Keyur Patel
Cc:     Keyur Patel <iamkeyur96@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: Replace  hardcoded check with inline function from usb.h
Date:   Tue, 19 Feb 2019 16:15:50 -0500
Message-Id: <20190219211558.20809-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keyur Patel <iamkeyur96@gmail.com>

Expression (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_IN can be
replaced by usb_urb_dir_in(struct urb *urb) from usb.h for better
readability.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/usb/core/devio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index d65566341dd1..29e2ff055e6e 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -604,7 +604,7 @@ static void async_completed(struct urb *urb)
 	snoop(&urb->dev->dev, "urb complete\n");
 	snoop_urb(urb->dev, as->userurb, urb->pipe, urb->actual_length,
 			as->status, COMPLETE, NULL, 0);
-	if ((urb->transfer_flags & URB_DIR_MASK) == URB_DIR_IN)
+	if (usb_urb_dir_in(urb))
 		snoop_urb_data(urb, urb->actual_length);
 
 	if (as->status < 0 && as->bulk_addr && as->status != -ECONNRESET &&
-- 
2.20.1

