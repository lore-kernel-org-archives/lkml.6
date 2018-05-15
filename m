Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeEOBif (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:38:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:15551 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbeEOBib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:38:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,402,1520924400";
   d="scan'208";a="41805036"
Date: Tue, 15 May 2018 09:38:20 +0800
From: kbuild test robot <lkp@intel.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org, davem@davemloft.net,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        ast@kernel.org, daniel@iogearbox.net, edumazet@google.com,
        vladbu@mellanox.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: [RFC PATCH] net: sched: __tcf_idr_check() can be static
Message-ID: <20180515013820.GA78657@lkp-sbx04>
References: <1526308035-12484-6-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-6-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 446adedb5339 ("net: sched: always take reference to action")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 act_api.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9459cce..27e80cf 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -284,8 +284,8 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(tcf_generic_walker);
 
-bool __tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
-		     int bind)
+static bool __tcf_idr_check(struct tc_action_net *tn, u32 index, struct tc_action **a,
+			    int bind)
 {
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
 	struct tc_action *p;
