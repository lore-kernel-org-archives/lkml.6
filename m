Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7393C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8955C20850
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f732d2KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8955C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeH1GOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:14:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeH1GOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:14:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so26334pff.9;
        Mon, 27 Aug 2018 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OuDh+rSop8MbDoLv8M5z5O04x6WWGmISPVvgrj3h3i8=;
        b=f732d2KKPq9Fr1SsCiDdZdHeVHPwocvZ7GhVN4oZsFuKqncwaToCMox658WegT7Ebc
         nZZC4jgNow3fZRAFmIR7EYrIKbWsV0xrCbNRQJzC7UFyi2W2Y4WCSLb+orZbyFqr+eSn
         uclg3PtOUWs0mYrTHI8zK2E9d/5LOn0fCtpllbKiM3WXeOSDGji7mdfhyQXXF7nJ+rG7
         cBDdZqCXZ/0sYndruhJHRa/57eWPLZJhySQqHIqFT/YpTJqcx73XmRa+VqLuc75B9Q8c
         cXe7HED2C0jEnkv2ZuPAS3crqO/E7/HAZdGHuFXVMopjPGzJBAR94aft2KmRae0bZoxf
         JRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OuDh+rSop8MbDoLv8M5z5O04x6WWGmISPVvgrj3h3i8=;
        b=DwcOJZOjFhFWXl96s/QGPSIM5Ztva4nVsiwnplZqzRHl4JflYY54bSYQYahzPHoaLL
         xe6Bgm0M1BlE7qkyqN54f6qi6kCAGVZNZ8g75n6Tx02Sm3HvWe78cs1Jc5S6lVPi1JZM
         wvKEJ2KpxrEY+8coy5leDeoml1Lbn96mf0XZksAC4CJcgQ3RfKbTqPQivEHm5frrab32
         tnUKI/LAUic20SlG/eXUZ8ledrmAv+V6vn0P5dhVqjhpnIl7bhMkQh6ZRu2SAZAd6ztU
         M80o1wRSC/GiPgbLb7l9i1OE70Q339i+RN/117HGOspRBR4gZ2rP/GzAlknEKAyrJElb
         a0xA==
X-Gm-Message-State: APzg51AqDtbDKodDwGsKSD6sFqT5Yt65tlicAT30JLV4SJxIvZgfnDSj
        QUzKVFJp8lAA6Qfs2sU2+dxWECshVZ4=
X-Google-Smtp-Source: ANB0VdYst6i/aNoloZvDAo4OuVEK163/wMYcRXQ9UYqfkL6Y+e/PD4aInuf8QMrOz6II9sFhSuuSpg==
X-Received: by 2002:a63:65c2:: with SMTP id z185-v6mr14548279pgb.276.1535423110523;
        Mon, 27 Aug 2018 19:25:10 -0700 (PDT)
Received: from localhost.localdomain ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id o62-v6sm720823pfb.0.2018.08.27.19.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Aug 2018 19:25:09 -0700 (PDT)
From:   Yuan-Chi Pang <fu3mo6goo@gmail.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        fu3mo6goo@gmail.com
Subject: [PATCH] mac80211: fix to follow standard
Date:   Tue, 28 Aug 2018 10:24:34 +0800
Message-Id: <1535423074-130862-1-git-send-email-fu3mo6goo@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
If it is a target mesh STA, it shall update its own HWMP SN to
maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
immediately before it generates a PREP element in response to a
PREQ element.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
---
 net/mac80211/mesh_hwmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 35ad398..6c21a26 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -572,6 +572,11 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		forward = false;
 		reply = true;
 		target_metric = 0;
+
+		if (SN_GT(target_sn, ifmsh->sn)) {
+			ifmsh->sn = target_sn;
+		}
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {
-- 
2.7.4

