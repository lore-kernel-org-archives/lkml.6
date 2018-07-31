Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F5320870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nimNPq8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F5320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbeGaPvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:51:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45462 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbeGaPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:51:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so7211498pll.12;
        Tue, 31 Jul 2018 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DIdKv9Pqy5ibPUBuIdtbeDMZ3EsvI4Zo5Zj0c/0E5us=;
        b=nimNPq8SyRVJ5q6CzhXyRjd1d2O6CK2dw5ysq14Ve6VnEQy2a1jURQS21iJnkCFNXk
         3HEMuxrSf+iknPM7mC2EimSsBEKqwjJZJnFoRz90MQSYHiEeLE1qKkAI0RTIXpx5lC61
         TV/w/uDS8OnrL7TvGAuOzrOBxKcI94k4yvzP1XX89i0Jg4C5DZtI3KhH8NFSUjXBWpXf
         U8B/Vj2KIIeBtcqMG/imRfZLrDYakT4qMEOcchSZDEeqF8QaN/QZ0vE5F2QacsGsW7bX
         KZ5gr1L7d7/XghkquyKkVkPaFx2k0KrUxXwA03u8GCIr1/87pOI5eAHv8jboE3WtIcsV
         XI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DIdKv9Pqy5ibPUBuIdtbeDMZ3EsvI4Zo5Zj0c/0E5us=;
        b=AR8DnywaUbzSLqPoMgnLo5ITOQqpwRVzMO08KiIDAI+GLzzW6UdNEV98/5rHDmEtvN
         124IJQGEr2FgX5H9YA/1TkC2uP98GSG2vnZjX4YIIvRhxTf2g45nEuqFm74YRYhkJ2+E
         JGIFIAU7ICrfkPMOGgIdGkkfZVIRwVxMAxKqI3t1C3ZLhm1cJT/NaU3eRzK9dofCITC0
         beKcM2fWdCqEyyzKWGf8oji8Heu6IDkINqVrnrfKKQGUq9NMkfeVb1MrxTKqPN5mLXG0
         f/26qdP0cjKo/UedyqybBj09Rdid/ORmwf/0j63soZp+zLKrpSzfWpki3wc/Q73garUI
         eigg==
X-Gm-Message-State: AOUpUlEW9wQoL/bvd/F0uakK3JbFeCjCl/jMz9EN3UHrNezgSz7esKIh
        Lzp/FTAX7M0akgKK+Dr8nGQ=
X-Google-Smtp-Source: AAOMgpc1FWDxuNTJwmyWe15ecx1y7KK0bD+Wf6TwSTeDLLhoRSUd1grrJsLXVrOOavla77PjHV4taQ==
X-Received: by 2002:a17:902:8482:: with SMTP id c2-v6mr20749341plo.45.1533046247247;
        Tue, 31 Jul 2018 07:10:47 -0700 (PDT)
Received: from pjb1027-Latitude-E5410 ([58.227.15.43])
        by smtp.gmail.com with ESMTPSA id r81-v6sm26125519pfa.18.2018.07.31.07.10.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 07:10:46 -0700 (PDT)
Date:   Tue, 31 Jul 2018 23:10:40 +0900
From:   Jinbum Park <jinb.park7@gmail.com>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] mac80211_hwsim: Fix possible Spectre-v1 for
 hwsim_world_regdom_custom
Message-ID: <20180731141040.GA8936@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User controls @idx which to be used as index of hwsim_world_regdom_custom.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of hwsim_world_regdom_custom,
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @idx before using it to prevent attack.

I leveraged strategy [1] to find and exploit this gadget.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 998dfac..b41fdc3 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -34,6 +34,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <linux/rhashtable.h>
+#include <linux/nospec.h>
 #include "mac80211_hwsim.h"
 
 #define WARN_QUEUE 100
@@ -3350,6 +3351,9 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 			kfree(hwname);
 			return -EINVAL;
 		}
+
+		idx = array_index_nospec(idx,
+					 ARRAY_SIZE(hwsim_world_regdom_custom));
 		param.regd = hwsim_world_regdom_custom[idx];
 	}
 
-- 
1.9.1

