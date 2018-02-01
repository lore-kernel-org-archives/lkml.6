Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeBAL41 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:56:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37901 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBAL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:56:25 -0500
X-Google-Smtp-Source: AH8x227zZnmjrHSY6Tr5pDUpD1ZLgGfDZiTv39AKeGq852Is0/Mg8zRey/DWxhxuS3eSiT18orMNuw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jbenc@redhat.com, nicolas.dichtel@6wind.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net] rtnetlink: remove check for IFLA_IF_NETNSID
Date: Thu,  1 Feb 2018 12:56:00 +0100
Message-Id: <20180201115600.29334-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTM_NEWLINK supports the IFLA_IF_NETNSID property since
5bb8ed075428b71492734af66230aa0c07fcc515 so we should not error out
when it is passed.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 net/core/rtnetlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 204297dffd2a..56af8e41abfc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2802,9 +2802,6 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (tb[IFLA_IF_NETNSID])
-		return -EOPNOTSUPP;
-
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
-- 
2.14.1
