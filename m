Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FC420817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbsqPHwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FC420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeK0Ghj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:37:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55473 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeK0Ghj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:37:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so19407216wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pkaTvPPKSU01wBGO5BO0kWCiq09sSnxs4D6/zXEcW8Y=;
        b=mbsqPHwaSbv/1Adcxq1or/cRNCqvSKQN6rdOSxBq8YyHlmvJxyiqOeSLIgYI5Lcnln
         kKWkerKvKMhcMxWOUcEVLHe+chWwPmEbRWhVJwGsP2EmhNx7iOeQuPlhOXb4f/EpVweB
         vVC0yawXVq78o7BwJCd2rsOX91snFGxz8eSf9wKweYqHRZKAoK3njM4dB+Ad5U80h9RY
         3+VFbuXGxtV4RDHmIDerIjXZBt1iUuchkbJwjyFON8OZkgetwTYIDyTwud+EpPX58ENC
         d7sH2dmK08pbnn05QDLTOrT4BK2489kJ89/kXFUPNrZf9xJjuWY8fKXtrzn6L0ooGNED
         8Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pkaTvPPKSU01wBGO5BO0kWCiq09sSnxs4D6/zXEcW8Y=;
        b=Ko80NR6dm9+8FQBoui77cUEx0f9dWG8xtxnFkH6269GGh56mhRhnCCXiAr+TYvzLn4
         DWoq4VgZ5hrne14S67HAFY3nK05Bik8hxZwzvAhN/67jUInRnqcIsWraKK9RfpZBpT+b
         qAbDlU+qTO1WXhViaR4pTJOdQrcsg9/OM42AQWS6Q5l9Go0kC+SjTNgxHEFJfibXiJ57
         yk1TzTnZ5bHRDaMFZag+kuXrkFLfBe0N7ajYwYMXsbkzyzTdLUt7AXp5Z+LdrNZE5yPc
         SQA7dfsyvo88WvYpDG0It3Ap68ThG0ekUMYCXn5RMFXjfbvGsQLLCCtdZLtwWr2F/n12
         giDA==
X-Gm-Message-State: AA+aEWb18sj2CYiKxrvqspwuLEuWmE+RfTPfUpe9xf2E+yC0kUCNvvI3
        1/sxglRm7po8VAkzZGdhz+Q=
X-Google-Smtp-Source: AFSGD/VMB2couyKuuVNDNOWn/8JFlHLN+gf1q/DiC+WiLIMkRvb4CwS5dhzeKHRyEQ3j1Nr3PLj4sw==
X-Received: by 2002:a1c:d78b:: with SMTP id o133mr19926112wmg.121.1543261348086;
        Mon, 26 Nov 2018 11:42:28 -0800 (PST)
Received: from ubuntu ([85.88.131.204])
        by smtp.gmail.com with ESMTPSA id z83sm2083601wmc.7.2018.11.26.11.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:42:27 -0800 (PST)
From:   Ricardo Silva <ricsilvs1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Silva <ricsilvs1@gmail.com>
Subject: [PATCH] staging: rb8822be Change line not to end with '('
Date:   Mon, 26 Nov 2018 11:42:17 -0800
Message-Id: <20181126194217.40327-1-ricsilvs1@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To comply with checkpatch.

CHECK: Lines should not end with a '('
+u8 rtl_mrate_idx_to_arfr_id(

Signed-off-by: Ricardo Silva <ricsilvs1@gmail.com>
---
 drivers/staging/rtlwifi/base.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtlwifi/base.h b/drivers/staging/rtlwifi/base.h
index 4299ca181365..591f433be1c3 100644
--- a/drivers/staging/rtlwifi/base.h
+++ b/drivers/staging/rtlwifi/base.h
@@ -151,9 +151,9 @@ void rtl_c2hcmd_wq_callback(void *data);
 void rtl_c2hcmd_launcher(struct ieee80211_hw *hw, int exec);
 void rtl_c2hcmd_enqueue(struct ieee80211_hw *hw, u8 tag, u8 len, u8 *val);
 
-u8 rtl_mrate_idx_to_arfr_id(
-	struct ieee80211_hw *hw, u8 rate_index,
-	enum wireless_mode wirelessmode);
+u8 rtl_mrate_idx_to_arfr_id(struct ieee80211_hw *hw,
+			    u8 rate_index,
+			    enum wireless_mode wirelessmode);
 void rtl_get_tcb_desc(struct ieee80211_hw *hw,
 		      struct ieee80211_tx_info *info,
 		      struct ieee80211_sta *sta,
-- 
2.17.1

