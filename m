Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D40BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CBE20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/HHwBvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CBE20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJDWlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:41:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41274 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJDWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:41:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so3335361pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isN00gzYDRPSqD/Xx6NnnwdKGHJc8a7nlF+T4xqACog=;
        b=S/HHwBvzFwgQnr52TnMdt1qozxrdpUb/syfmQuqvyrMJZTkJY+dM9yMq+N/n0J1JFO
         jW4rwtXTdouPjqqnNPlVrc+8B4jiDZtj0Hyo6KuOHiZ9qewkKq8fwbaI73es5k/0VOhh
         9xVZYGjyT4dgISynJ/3xjsHHbFYkjDxHpkxQeHomtNgMuMyA9egbQFxG3ezBXuVhXnN0
         Oi/OMuVFReaKOvCBdeP2m6SEQLO1fT5M+/Nk9wRw1Ek+UO1d4ZIK4xHt3fxh3MdDZhW+
         6J4Zf/ijBNcu757L822JuKfjJOzZ18e6qcmVGydm8On1iI6jNyRwy5O9EkIZGwfYF1KC
         znFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isN00gzYDRPSqD/Xx6NnnwdKGHJc8a7nlF+T4xqACog=;
        b=cqkd/FE0VeJOTAUnlv5o25V7S5X5BEQSbKAEBYba6rxL6Z7WWdfnuVusticbFPSguC
         kV3WPTFMNxMi1+lRxbZSyESqU5gGSGPsHmyIiuxtN3wed0GVMU0X2mcVSb44+iSMxxMz
         1ZDTak1NR+LgLWpTz2/NXkRt3K+gN4ArO79vmYSjsqiT2L7qZ1l3SSQgVXOxlwK1cpS/
         la2Ulx4ocyugYS8T6FACMjVUrYWL5lVpLTOjJ87iXrN/nV8aK+J8yPrmp3HoLD8KENNL
         S0gDYgxNIhCap4ijSVQHwfquPi0fRvoZQa3Q0ONMji3wnzohXU9rxzYWK2gTQabwmP91
         2FtA==
X-Gm-Message-State: ABuFfojWbVyKmfTwQw427ogRVwgwagxu34IW7kX71ndYVMz8MGMA5eHm
        usWBbv6Brs6USoPgyxMVQpu83qUicAw=
X-Google-Smtp-Source: ACcGV62OVZtOVec/0c+lq5p/0+1f6wpgO2wLe6DwtMkhlJ2H6gcL815odmdQyPcLsZKmPMcNy7dkIg==
X-Received: by 2002:a62:b286:: with SMTP id z6-v6mr7462366pfl.79.1538668074931;
        Thu, 04 Oct 2018 08:47:54 -0700 (PDT)
Received: from localhost ([2620:15c:2c4:201:f5a:7eca:440a:3ead])
        by smtp.gmail.com with ESMTPSA id q25-v6sm8542568pfk.154.2018.10.04.08.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 08:47:53 -0700 (PDT)
From:   Eric Dumazet <edumazet@google.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
Date:   Thu,  4 Oct 2018 08:47:49 -0700
Message-Id: <20181004154749.111595-1-edumazet@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot was able to trigger rcu stalls by calling write()
with large number of bytes.

Add a cond_resched() in the loop to avoid this.

Link: https://lkml.org/lkml/2018/8/23/1106
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/mousedev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
 		mousedev_generate_response(client, c);
 
 		spin_unlock_irq(&client->packet_lock);
+		cond_resched();
 	}
 
 	kill_fasync(&client->fasync, SIGIO, POLL_IN);
-- 
2.19.0.605.g01d371f741-goog

