Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C026FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A793D2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktSjO+1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A793D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeINVPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:15:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34684 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:15:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id c29-v6so8323248lfj.1;
        Fri, 14 Sep 2018 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wdEjuRoM2Ma9DSrHzNOkIWl0Z0bNG8ziqUwV8PLgZos=;
        b=ktSjO+1qz2iiH3pizThqA/pHoh9vxjBXhANyImM+ndRlz0ke1c2RvSP0FOXIKtKDdb
         Eb26uK4xOza5wF63vvhWx3AlDcZYFNgnfXYIK1+CZZxNc0OElOSWjCPGq7R0KKUTPdr0
         vOJNi+zTal9AU9slCps+FTL+AUNA4SCizGzEBaXelTwRB6eoeMZFNj8Lp+Nt4QxV4UcN
         nQgs4tOiX9bv1YW68XTzloYr4rBTjiWaBVZDyqDQdetFE5ErI8vhLtdU1gT2zeJTAOz1
         faIOgphYlY0lVBsI5WJTF+zzxy10UaqVKH1+003kEIxvGJp82x+J6vEwGXwi10YhaL2J
         JAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wdEjuRoM2Ma9DSrHzNOkIWl0Z0bNG8ziqUwV8PLgZos=;
        b=PkuDajvPwMnnscLUpNOYP81bU8IG1P5l3i46kmb9K0tlX5ofsGzmPlgZYexH54CcAr
         ayXgtTQVFvJ9KCN4qztPb/lrvbPzAjdo8dAsN5am4vpord3+z0XpMdw8dt3w46W0kMns
         YfXPV2Bsy2pIQNkPFCV6+4oKRZNDxI45JdiAHfn6zN1aEm0IEhSvIK4EZ0089tKbX2CF
         Kg5RV9P2jdAk9oObZmbPUDNTAeQbjzV/BmEx8ql2OXgBba/5ov+HHdBDtcYBzRtbnuoj
         sOsCC83NuNwe/gUSTEGDdfCOwAUEhzpDGGtsTuZjF2jLT17/DGkMUrjBgOXYKqBzSxCU
         8izg==
X-Gm-Message-State: APzg51BtIRKcV771FZM4+RON+68pwZYnjZYJI6NjFJ8rDJpoPpyfYw5S
        dtMRo9ekhFwzOJX9tsCl7CIxDPcgCss=
X-Google-Smtp-Source: ANB0VdYrXDmjNVL70/FxzYK1zlyjNm1ZnMSyNSfEJEG2OU1KsOFcZc0AiGRrZsz4zad+OG5MMkoixg==
X-Received: by 2002:a19:124d:: with SMTP id h74-v6mr8859845lfi.107.1536940843044;
        Fri, 14 Sep 2018 09:00:43 -0700 (PDT)
Received: from localhost.localdomain (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id j135-v6sm1317521lfj.91.2018.09.14.09.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 09:00:42 -0700 (PDT)
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH] mac80211: fix issue with possible txq NULL pointer
Date:   Fri, 14 Sep 2018 18:00:34 +0200
Message-Id: <20180914160034.2753-1-erik.stromdahl@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that do not have the BUFF_MMPDU_TXQ flag set will not have a
TXQ for the special TID = 16.

In this case, the last member in the *struct ieee80211_sta* txq array
will be NULL.

We must check this in order not to get a NULL pointer dereference when
iterating the txq array.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
---
 net/mac80211/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 36a3c2ada515..ef5d1f60a63b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -264,6 +264,9 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
 			struct ieee80211_txq *txq = sta->sta.txq[i];
 
+			if (!txq)
+				continue;
+
 			txqi = to_txq_info(txq);
 
 			if (ac != txq->ac)
-- 
2.18.0

