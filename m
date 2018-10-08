Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DBBC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2065B2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKjgnvLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2065B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJHOBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:01:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34293 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:01:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so7396581pgs.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date;
        bh=6GL5Got849NgxaKHgCNqnO2F9SDVP3AMUXGGmTFDH98=;
        b=WKjgnvLcQ2lTV/BwaLDobehdmYZxpfp8NQ3M//PUBco9emDrX33gYbMUHDZmYRjEKx
         cNk7wE8tgZnDdwNLkVfbqWefbiAbX8nnC8gO0pqC3v52QQFpVnda8ZVPd6JP7oHsiy0r
         pupuEMIuuOWqhGuHzpk1ppsXEmrCzVzJcZoyDgeWhBserkYcckvCTJK1//B2Ijhgvq8l
         vKXkbZ9X3QWXhWA6l6yXr1Q+SxQq0p5+KUb6ero8jrIgv6vLdeXXS6j7gTAVMPsQalQV
         KDIBPzyppkRFw6pj3e0wNofiwYOBZXQbtKuEOMtBcITuEf0Gqy2YDwbqG7QOYtZsxquF
         /LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date;
        bh=6GL5Got849NgxaKHgCNqnO2F9SDVP3AMUXGGmTFDH98=;
        b=fa6HxcmphfYAmk+5X5LS3iRkv4kNWzr1fwsBzpulJ066o3QvwUfBbaqyisDvFo+Xzr
         9mN1xBRbSR5nHCJjBaTBZIzmx8HoBL5WtIaRKatJtRhz0NwwmUh1/cIYJAXSrSJnMVnl
         Fb/9KX4Okn727uXxIqJOdlIfk8FXHluG+aL9ErbuABGGwogt+Ty5VFuRy21VGiRhGQlF
         TQjiVOZnLXmCEHAS4aZchZojzKiVhQKu8oyWUWQmetVtaxNaTVwFJVGZAtyoQTfkXrTg
         vNgtoXbPOYyCqUqphleWHfnkv8i1QWenBnBh+8vfXvYa1N3/eCEhVDiWyL87UsJvyp2J
         C8eQ==
X-Gm-Message-State: ABuFfoiHsHKcPH14itmIgpNKWgMnWgbJuKtsG0jRVtAeL8jbtIZhBBg2
        smxlGcvOvfMnUaaW5Pk7KYh1LZwc
X-Google-Smtp-Source: ACcGV62kj/Ql6ze5X2hJHMJfkI1mKYQIjwm5hsii8FnXTtkslo1pY1NvsmATcc3lWCUUQ1t2dLZjZg==
X-Received: by 2002:a63:bd41:: with SMTP id d1-v6mr19862594pgp.309.1538981461407;
        Sun, 07 Oct 2018 23:51:01 -0700 (PDT)
Received: from localhost.localdomain ([118.193.167.117])
        by smtp.gmail.com with ESMTPSA id u184-v6sm30447270pgd.27.2018.10.07.23.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 23:51:00 -0700 (PDT)
Message-ID: <5bbafe54.1c69fb81.954a9.deae@mx.google.com>
X-Google-Original-Message-ID: <1538981441-11687-1-git-send-email-y>
From:   zhouzhouyi@gmail.com
X-Google-Original-From: y
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] RCU: Adjust the comment of function rcu_is_watching
Date:   Mon,  8 Oct 2018 06:50:41 +0000
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

Because RCU avoids interrupting idle CPUs, rcu_is_watching is used to
test whether or not it is currently legal to run RCU read-side 
critical sections on this CPU. 

First sentence and last sentence of current comment for rcu_is_watching
have opposite meaning of what is expected.  

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1..adb04ea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1010,12 +1010,12 @@ void rcu_irq_enter_irqson(void)
 }
 
 /**
- * rcu_is_watching - see if RCU thinks that the current CPU is idle
+ * rcu_is_watching - see if RCU thinks that the current CPU is not idle
  *
  * Return true if RCU is watching the running CPU, which means that this
  * CPU can safely enter RCU read-side critical sections.  In other words,
- * if the current CPU is in its idle loop and is neither in an interrupt
- * or NMI handler, return true.
+ * if the current CPU is not in its idle loop or is in an interrupt or
+ * NMI handler, return true.
  */
 bool notrace rcu_is_watching(void)
 {
-- 
2.1.4

