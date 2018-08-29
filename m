Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C550DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKV+tNLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6C12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH2FYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:24:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33348 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2FYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:24:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id 60-v6so1543551ple.0;
        Tue, 28 Aug 2018 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=joSWtHxzOx77mwzFPiNtD4qSHa2rWVAAkq9SD4K7ooI=;
        b=LKV+tNLZZ3PTu4su5rdcOMfoMO0skR98X4wuD9zsTcjAWfoOcP4UpqGm7Iqra+XVTK
         M+YIxxR8YIr4PvczWG51N6IQ6XmnYGHr/6aw/3bow3CHwFtNOuF8uuN5+qWZJrlO2lr9
         JSLrnKxy2HmFFsle6/MqN7t2L405d7XOAZraX5ARzUdwoElWuRtMq38GP82f3mwTfxbc
         APfJfu0osEbinwMs7dxLZnCMAvpya1NimdejC1u0io6JcWRSGxx+st9xOl4GB0batTb5
         gW7jik6QiYmMfjsGZV/O1kHA2dOEdqJM2HqhJGFc95d4877UURhh8OUJ+jDwDSbz8krJ
         OmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=joSWtHxzOx77mwzFPiNtD4qSHa2rWVAAkq9SD4K7ooI=;
        b=kwPEqw6yrCTnRjqzLBb5a32ZHQvYSO2Goy88zjtdSpVfpEUf6NBsJIhN1Vn4P/HrTl
         RN6QOxsA7WIjaT9+P8I60fBa+lzHJ/QFhKYCgoTAHm/72hOw/zwuFoHPgwRAk0x1tL1+
         wMMF0cLz/N0g+0gIQ16lVWBwG/i27LBZmHp8G7b8hrvPAniZHOlsS3V+ofjHaM8nzVj9
         vV7TBqBf0B0zAO+WqFXhBUJe8wyellXanG7A/P7kQKG9/WRv0goWFLcKyy5nYENXb+z8
         O1U46amDPV0G2tudZs9IMEuguZn3ZqXoe9I7v6jISPJNVPBVbwBJUaSFp93qbKDWB3Jk
         6djw==
X-Gm-Message-State: APzg51DFgJjwPF5bqQX1euQ57KE6oXvYsbtA6vr9mZin9cvyVZjCjRcs
        lKM9+NFYh215LJhBTVIufFg=
X-Google-Smtp-Source: ANB0VdZ6UcMyWwmdF8YbOue3m0/aNIddLh9OljYQkQQ1Zt8MvycXwJQCcay8GWjcz6aUU7Q3CtsQmg==
X-Received: by 2002:a17:902:d706:: with SMTP id w6-v6mr3890195ply.158.1535506221788;
        Tue, 28 Aug 2018 18:30:21 -0700 (PDT)
Received: from localhost.localdomain ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id k1-v6sm3214416pfi.62.2018.08.28.18.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 18:30:21 -0700 (PDT)
From:   Yuan-Chi Pang <fu3mo6goo@gmail.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan-Chi Pang <fu3mo6goo@gmail.com>
Subject: [PATCH] mac80211: fix HWMP sequence numbering to follow standard
Date:   Wed, 29 Aug 2018 09:30:08 +0800
Message-Id: <1535506208-17680-1-git-send-email-fu3mo6goo@gmail.com>
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
 net/mac80211/mesh_hwmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 35ad398..daf9db3 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -572,6 +572,10 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 		forward = false;
 		reply = true;
 		target_metric = 0;
+
+		if (SN_GT(target_sn, ifmsh->sn))
+			ifmsh->sn = target_sn;
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {
-- 
2.7.4

