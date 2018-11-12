Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F0FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830021104
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6BvRBfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbeKLKkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:40:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34215 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbeKLKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:40:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so3460209plo.1;
        Sun, 11 Nov 2018 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xjSh9IEeLwxH8OYYNLpYFM6p8XZN0FQyzo1oAiZRkkA=;
        b=q6BvRBfr+PQTzT9l3oyCY9r7ch1thXhQpR2rTd0BiJYHifmD7hpJAh1pGhwfF3Eozy
         w61UB7NyrqNgjr3A14Y9TPRxc1eFDSGe2Mq6m079Qtts3NfWwrYlt8cI5bsUDeFcZDv/
         6jxPMBFO626JpCDvwkHXdOqQuZ+MZKeKvZMMqzTxlP5fQ0gSQIdgNeAJ6EjlPea/OMB6
         N9HOUI7wpUS89TAnrGcqxw/6QGUbpyMrX6z/YO6jh2JoIzz9TrzEowzZwK9gSt4JRv9u
         5hmcJ9OlEC51ER6goQdxraBM4T7VNxULaTKeQnhVilYqjIbtCQ3CCIW9asBOC+hDQOfT
         /9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xjSh9IEeLwxH8OYYNLpYFM6p8XZN0FQyzo1oAiZRkkA=;
        b=d+oyFUzqjXkAIt5GZnOJZ6F/89Baedt2Y6ArOXSKyfhX81j2YnLCyMMfwvupvje2Q/
         32t0vxHJ8rtCzgnFr/Ap+yDsPPt9uQ7JQlpTLLMLeV5iYBar2ieKRjZBmKZqRv4AI+Nl
         62tEMmW4REr0hy4qkbJVgTUcz/u4p6IeiYG/J6TUMocsA7fgihZ2Z4MQaP8FWMeV3wI8
         eujoVL8R9MVUz9P5Rk0XD0y/L8YzEIhzpX0zSrD+fvJuIGFg9oBIOFCEHl5naxrqcvZj
         4byo8uf5LpnPdMUlQ2yDvM0uoKzgaiForGLTG05jV81jaDHdSAKPgm+5TtFWCb7YmtwD
         t4nw==
X-Gm-Message-State: AGRZ1gICsrsrOCJlqqdT2PC/0vvFMZf52DzELGkRqznd1x2A11TmxtrK
        AJahrVP9CbGK6hHGa//D3WM=
X-Google-Smtp-Source: AJdET5ePHvk3DqYgoflARKCWCrFRjAQm62K7Mqfd8q3TucMljfKqz6s2ZDoQBr/7JCirFyfLRpZW+A==
X-Received: by 2002:a17:902:a614:: with SMTP id u20-v6mr17960921plq.77.1541983796211;
        Sun, 11 Nov 2018 16:49:56 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-88-98-70.san.res.rr.com. [76.88.98.70])
        by smtp.gmail.com with ESMTPSA id p6-v6sm18242940pfg.30.2018.11.11.16.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 16:49:56 -0800 (PST)
Date:   Sun, 11 Nov 2018 16:49:53 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     pawel@osciak.com, m.szyprowski@samsung.com,
        kyungmin.park@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: videobuf2-core: Fix error handling when fileio is
 deallocated
Message-ID: <20181112004951.GA3948@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex that is held from vb2_fop_read() can be unlocked while waiting
for a buffer if the queue is streaming and blocking. Meanwhile, fileio
can be released. So, it should return an error if the fileio address is
changed.

Signed-off-by: Myungho Jung <mhjungk@gmail.com>
Reported-by: syzbot+4180ff9ca6810b06c1e9@syzkaller.appspotmail.com
---
 drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 975ff5669f72..bff94752eb27 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2564,6 +2564,10 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 		dprintk(5, "vb2_dqbuf result: %d\n", ret);
 		if (ret)
 			return ret;
+		if (fileio != q->fileio) {
+			dprintk(3, "fileio deallocated\n");
+			return -EFAULT;
+		}
 		fileio->dq_count += 1;
 
 		fileio->cur_index = index;
-- 
2.17.1

