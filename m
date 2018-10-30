Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DEBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F7920827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWSkDfpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJ3UzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:55:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42768 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeJ3UzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:55:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id t6-v6so5422493plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=a3Tvb6WgPF/Sj50NwfxbA/QgtUDCwGBQ16kL8T3yl3E=;
        b=gWSkDfpf0zsGlH6r/D+H0uDs29efNc1xS5r632X945zoNbJkfnQwvQ1xF7vYsDVYSA
         Y2uaAwQXanD7lDpgvhjAWw38XT87dwHwGZARRoMlYq2JSgI9JD+KawMXDxx/7+1GWexo
         SJ41x+DNbHAu4eJMmAaDJfTrd/MvcK5JacO29VmIN43YDqyBS4Gm8Abzr0kRT1a5V4Vd
         tYTIm1aU9Q9MJCxkGUkz3Zai1ctkjUAHP++TXQSrd/6rTYgP/mV5sMT8rUHmkz78MOst
         BFic/i03Er6N+/tbFrKSNT9SEQlotH1aK2ZDOtkzg9l0Phb92qzBgtQRKsfGxvHrcSJp
         sXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=a3Tvb6WgPF/Sj50NwfxbA/QgtUDCwGBQ16kL8T3yl3E=;
        b=oZ7aEm9A+QyE8Vgz1toLJscnCPe3Xib8YBchdf5AR4mxvMp2RC8JBfKQW6AyRNwktF
         ams5bLyCo7SyJgA55FntSd+LvOm7r4RuKWxKLY56uPq+wlD6utnwFeBBSFbx9oKFvQ5L
         HXL8cqJmPmjDNbw8yxA0iKzAAMLdXQCh5dsInJcNx3bt7oQ7y8hVzQjetzwJA24di7Ab
         KjNa7rso1TjI2dPwuFmreTCWTBYpbTGbxdXugz7U1jQSJhTL4XL7gW8wS+5MZLr9tBPU
         vb20fx8/BPQVX2MVEWbA6i2OwpfrQD9W5JGAWLWZzZ3TZt6bEbskx3qtiIvFhRYcouhm
         ls5A==
X-Gm-Message-State: AGRZ1gJVlC2PndrcjaMvcscr3vGfDjtwYoKhkmmvOmSK+CMTt4rM3Zks
        PJ7pIYO4g3pE1WHr8V0X99I=
X-Google-Smtp-Source: AJdET5elw/KPg9RTFu0sKfDV1bWJYekIMOgR9+BlSNUZLetGw+qa8RLgmvnPIRnhMU4I9Yn6++iBjQ==
X-Received: by 2002:a17:902:708b:: with SMTP id z11-v6mr18998809plk.151.1540900926126;
        Tue, 30 Oct 2018 05:02:06 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s80-v6sm27378369pfa.114.2018.10.30.05.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 05:02:05 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: [PATCH 3/3] kobject: fix warnings use pr_* to replace  printk
Date:   Tue, 30 Oct 2018 08:01:16 -0400
Message-Id: <bdfdef7349f54a69eb5c57764805b8eeb96a24ae.1540886346.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1540886346.git.tsu.yubo@gmail.com>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
In-Reply-To: <cover.1540886346.git.tsu.yubo@gmail.com>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning from checkpatch.pl use pr_* to replace printk

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 lib/kobject_uevent.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 27c6118afd1c..c87a96c4800e 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		printk(KERN_WARNING "synth uevent: %s: %s",
+		pr_warn("synth uevent: %s: %s",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
@@ -765,8 +765,7 @@ static int uevent_net_init(struct net *net)

 	ue_sk->sk = netlink_kernel_create(net, NETLINK_KOBJECT_UEVENT, &cfg);
 	if (!ue_sk->sk) {
-		printk(KERN_ERR
-		       "kobject_uevent: unable to create netlink socket!\n");
+		pr_err("kobject_uevent: unable to create netlink socket!\n");
 		kfree(ue_sk);
 		return -ENODEV;
 	}
--
2.11.0

