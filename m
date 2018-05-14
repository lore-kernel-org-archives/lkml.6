Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932571AbeENOcP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:32:15 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35046 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753959AbeENO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:27:41 -0400
From: Vlad Buslov <vladbu@mellanox.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        fw@strlen.de, ast@kernel.org, daniel@iogearbox.net,
        edumazet@google.com, vladbu@mellanox.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: [PATCH 03/14] net: sched: add 'delete' function to action ops
Date: Mon, 14 May 2018 17:27:04 +0300
Message-Id: <1526308035-12484-4-git-send-email-vladbu@mellanox.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend action ops with 'delete' function. Each action type to implement its
own delete function that doesn't depend on rtnl lock.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
---
 include/net/act_api.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index e634014..73175a3 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -100,6 +100,7 @@ struct tc_action_ops {
 	void	(*stats_update)(struct tc_action *, u64, u32, u64);
 	size_t  (*get_fill_size)(const struct tc_action *act);
 	struct net_device *(*get_dev)(const struct tc_action *a);
+	int     (*delete)(struct net *net, u32 index);
 };
 
 struct tc_action_net {
-- 
2.7.5
