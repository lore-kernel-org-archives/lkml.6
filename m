Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E35214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E35214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeHVSvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:51:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44830 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHVSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:51:38 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MdqcT-1fT1gN0TWf-00Pg2b; Wed, 22 Aug 2018 17:26:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Nogah Frankel <nogahf@mellanox.com>,
        Alexander Aring <aring@mojatatu.com>,
        John Hurley <john.hurley@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net_sched: fix unused variable warning in stmmac
Date:   Wed, 22 Aug 2018 17:25:44 +0200
Message-Id: <20180822152608.4173947-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:9c8oY3nZCLYeCLWxxhoXId82NQxwAYJ+x5Cz0arpKbdoI/pqQ5E
 xSOWWxuz19cP6AQFBQXe3NTfI+3Bb4oKsnksqvKBUSYdLaS05oyLwzfO4U8T3G3ePZusKc6
 hFH92/Xg2oVNn31Ea4aQPwmKFntmWi5xxteefqKnxWqlx/rPDgzUgcAYCBE4X8l3poepXq4
 bTwEVhk17a83kmAxFXHPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9ZPzOdt6e8E=:Qw+HzdL7oan1mYyd3PG+pM
 XQsQTEkXY8209dMTgCOKuV1600ccnX4O0zwGSvuzQLMvph0EOz4hNXqk2Mhq6E+4EAKiPq4Qq
 niwaFWLqS03Bef/ctW3u7eSkrNZmdKwOXkKg4Su2/83eLBtY6IjWgwfXLTxeECKiTSH5C9QY1
 Kr0C6eJfBG3PZeeBKq7KWSoVus7KonoUxRXtUmrlq57UqHIsbYj+TDpflVw36CuNh2p4g330+
 dp8+SLf36Hb+9sSvDKasD+Ou0TV95fL3LPEQHQRWW1zaPnoUd8iP6DdVbzrR3BTfci6i9M39u
 qwmxgGmCKFpI132Yecf2Ox9BCr1okB8EvEBV26+GPYSWp6YZ1cxcLZP20JIabJlmrNiEp/rkH
 9cCWsAjdWbU9eH9YIt+hKeF0c1Ekh8oQObJXvfW8FxOzDpL2IL9LKwjf3xlVupEEDMRD0m40s
 dzDefapjRcX9ScoeuM8/AvlZt5AyffnYzzjlC21CF6UQR2+ajRYY3C0sTw/3Z5szDq+gDESQS
 Ac4s4sMDS/RlhI/jg/WWVn0rKkaUlXtqBQAKTx82sE24TakEvjlAQIL3ZNukeVZi0JgI3cfuW
 hYv1MPhIHhMOxODMNkRhywzDcuD1QjiOez7OBi0+Q7ClGp+Ki8UfULIh9EWSLxypI1+kretQ0
 9ckNL6WDuAKIKUTqJ9sZuSNFvWeNX5tYaCFsSKT03iv8MGGaHlxwhvGbniW0oYHlQstY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tcf_exts_for_each_action() macro doesn't reference its
arguments when CONFIG_NET_CLS_ACT is disabled, which leads to
a harmless warning in at least one driver:

drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: In function 'tc_fill_actions':
drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:64:6: error: unused variable 'i' [-Werror=unused-variable]

Adding a cast to void lets us avoid this kind of warning.
To be on the safe side, do it for all three arguments, not
just the one that caused the warning.

Fixes: 244cd96adb5f ("net_sched: remove list_head from tc_action")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/pkt_cls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index c17d51865469..75a3f3fdb359 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -303,7 +303,7 @@ static inline void tcf_exts_put_net(struct tcf_exts *exts)
 	for (i = 0; i < TCA_ACT_MAX_PRIO && ((a) = (exts)->actions[i]); i++)
 #else
 #define tcf_exts_for_each_action(i, a, exts) \
-	for (; 0; )
+	for (; 0; (void)(i), (void)(a), (void)(exts))
 #endif
 
 static inline void
-- 
2.18.0

