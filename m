Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7939CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CF420823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXNotICH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfBVPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:25:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:25:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so1973827ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 07:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFbrY32NXUwup51qKdt/oIHZov4twGH23PmbEaftP40=;
        b=WXNotICHc85DVsqB0RFUEdDKvFzYnweGa08nK+8iCeM+OBTuuWlLi0sJGOHqCqvrrQ
         uzwGQbK4x+L889I7caEjO7EPQ2+Hv9Z51uvvlFlVdkNVD0E+F0r36QfTN6yTT6tRcyyC
         ukfMFuiQdnM9ikeOFcpAY30qa6wf7mK96dki/N5wY8i2P3Qz2KWhyOyYv3XFzPSrKh2K
         zXzGJf9mewgl6DqQOTht8eNLNaue87ZsV6453g8rFBlgS7k/nG5H8z+lDsrxYYYOYNdb
         w/r24OEuD6gtBUaO8rc7BMSTqFQmQtY7YHoi6W1v9yTtMKonkebYXeKHp0vwOQE+ArF9
         qcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFbrY32NXUwup51qKdt/oIHZov4twGH23PmbEaftP40=;
        b=uJN/VHuO/hWir6kJ640xQ0VGH0WIuPfLMJs+NQ7z731/uVVqjaSI2P8GyMcp7uxDMA
         veYxbgxKSuZ7mWyZWoAc2mxC0VdUBtLUQ9nHgSZF4g6X5KJYZLlgQONL/neiRh2Vh7Q+
         WfJdiC4SXpHgiZpJCAHP7p/+KSzgXq7m/8e/i38usLUFbZ5Uo3TR4bcqBXp41SuvfSUN
         Ix2bJUxKtvgPXK266/hfU0RNvgdnzK1upQ3eA19+Qoojo3PVcfnb/Km012qTfCHjMdPH
         cn8skPIAVFrHqJ4lsRsGJ8vQDN9tMaZSLXXjjyZzye1x7lkC6v8irO/z/ivmMja5vCDu
         gOaQ==
X-Gm-Message-State: AHQUAub57o4HT0++kABtP7iON/OOu3HkM+W3HzIPIPMFv2YcBv23PFWx
        l5SOIiAKlu8muOqd1EmJMek/ig==
X-Google-Smtp-Source: AHgI3IZK1H3fL+Ht/MlRCv0jSWpnFf6U7dZ1Dp9vUfvUgguco6YmdDZXIAQ/lhMJkwsG1yF5k/rrkw==
X-Received: by 2002:a2e:6309:: with SMTP id x9mr2601367ljb.75.1550849156868;
        Fri, 22 Feb 2019 07:25:56 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id r80sm624932lff.33.2019.02.22.07.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:25:56 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        davem@davemloft.net
Cc:     b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] batman-adv: fix warning in function batadv_v_elp_get_throughput
Date:   Fri, 22 Feb 2019 16:25:54 +0100
Message-Id: <20190222152554.30006-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CFG80211 isn't enabled the compiler correcly warns about
'sinfo.pertid' may be unused. It can also happen for other error
conditions that it not warn about.

net/batman-adv/bat_v_elp.c: In function ‘batadv_v_elp_get_throughput.isra.0’:
include/net/cfg80211.h:6370:13: warning: ‘sinfo.pertid’ may be used
 uninitialized in this function [-Wmaybe-uninitialized]
  kfree(sinfo->pertid);
        ~~~~~^~~~~~~~

Rework so that we only release '&sinfo' if cfg80211_get_station returns
zero.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index a9b7919c9de5..d5df0114f08a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -104,8 +104,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
-		/* free the TID stats immediately */
-		cfg80211_sinfo_release_content(&sinfo);
+		if (!ret) {
+			/* free the TID stats immediately */
+			cfg80211_sinfo_release_content(&sinfo);
+		}
 
 		dev_put(real_netdev);
 		if (ret == -ENOENT) {
-- 
2.19.2

