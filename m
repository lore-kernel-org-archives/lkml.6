Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AEFC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123472173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cMfu2SGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeLXRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:49:40 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:43150 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:49:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id D26B49D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 17:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JT-op9U6DMA2 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 11:49:37 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id A5972744
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 11:49:37 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id o22so14109219iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2Ao+gJbWRf5uI9O3Ydh6HJbnkX7WsBud85/G+qeySFc=;
        b=cMfu2SGG1FjYVLehH/K6zaPyFaSLQG+GueW22MwaNqcUyhONdRMdiE6tH+RRx1r7Mp
         p2QvxWwZuGcI/a9NnJdB1aMC2C4V+swE7AIwXFOEjQLd2KCqGFKpx28BLq2VO7t8UmE1
         huZOmutrFwgcd5NCgBkEmTkI02bfMZ27MXMZrbtZnVYs1CGHWuzL4Er6xhfxGgmfFQNg
         Oahsf5UigCkTN3MDn0X6xb4lKXbrBoIKX2ld/fwHJZQsNOjUWZnkaPHmHYojg+qd4BxO
         3JmZqEvw6t+UAblku/LKaur9lP+J1te3vuqbx1in80ZfDqz+/sxro8BQGeKElGuSwNEe
         Twug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Ao+gJbWRf5uI9O3Ydh6HJbnkX7WsBud85/G+qeySFc=;
        b=HijuGXZKh+3lgus7LBtbY5rLg5ryY/myAP7FZM1mRWqHYIHKnTRdv47DbPArSWTcNq
         JvG5xR4bntE2NNaoeNiCrBkgB1fYQuNcmBjRwTOzBBQr4flIuUoRAU+TH9HcAa0fSRhK
         dmzgXuNgxaCMqEsZBgi2FQab4WZndW+46k4JwfXuKDuXwzkCMZBiW9COliet72+noZ00
         LLO+7K8lc8vxK07ty782Mo5NR5Ht0pYu5qRS/K7Tg06lo5SCf2/NKKLZD97p69doOM3j
         X0aH/85Se2BN70XuNWCvDz6Z0JVGsCPZamhHrgSGRfwOsILi2gprfHb0e967B0AI8Hzb
         F/zA==
X-Gm-Message-State: AJcUukc8oo9suQqoMSJH4GWqszszA+sHkrb9xsAVbSyR7vINVKyu7Xkg
        +xeLk9jJYbQPOWGhZXgFVDGvlcpOhQPVOH+FrKEfW2jb/oyfJHeWC3MBKd+xQZqTwLVqBRnyIKf
        fedv1RFxWDXVgOJ7kAGwbzGFMiibJ
X-Received: by 2002:a24:bd0e:: with SMTP id x14mr8781542ite.123.1545673777297;
        Mon, 24 Dec 2018 09:49:37 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WQ1NalqcExE04UEJQucz4zQ7nbL2L6/4EOVdP/yEAyxBM4vrGcNqDC6FCXa/0nGbvbM9iYYg==
X-Received: by 2002:a24:bd0e:: with SMTP id x14mr8781531ite.123.1545673777055;
        Mon, 24 Dec 2018 09:49:37 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id h16sm11440229ith.25.2018.12.24.09.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 09:49:36 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] batman-adv/main: Fix check on return value of rtnl_link_register
Date:   Mon, 24 Dec 2018 11:49:26 -0600
Message-Id: <20181224174926.20321-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtnl_link_register() may fail and can impact registering the device.
The fix checks the return value and pushes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/batman-adv/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 69c0d85bceb3..e0007f242823 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -109,7 +109,10 @@ static int __init batadv_init(void)
 	batadv_debugfs_init();
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret < 0)
+		return ret;
+
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-- 
2.17.1

