Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA03D20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxDhxdBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA03D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeGaWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38420 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbeGaWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so5862046edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdXv8EKwpMUgByX+zVu3uf9GhxFFjm8s1x3G6rtKbLM=;
        b=bxDhxdBouipVW3wzsZQf2PFxko2RJ3txvbOxVJrt9VfJ4pPnAChPvkQDa8UExO7m8k
         Roq4QrzyeSwvHS8Awm+YBfXl+27t8z3fC0j8GjUWRwCCrcqbpbo57mcsp3hqyy2wtGOb
         s/qNk7duQ9dLEavTlywtWNhrgeYc9InbxFaVMTYYF94uq49fi5xVJUT8Ym9DpCF/+ui8
         OB9EJy8YiTiz7wxrNDmEqG6ykf58RtCrR/cXrJfRa1cm7/KYodLyxMBvvNgyYZUgvSZJ
         BDXVJlGX+/1T7pKXYDKDB3BffmYBLypra6LA7RublZzN9ZhK9vZhzIMhoYaQxJ4Rv4y3
         KOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdXv8EKwpMUgByX+zVu3uf9GhxFFjm8s1x3G6rtKbLM=;
        b=JotMeVJEBGAVSxWHm+R9mmMGx9PwHIuUywd7XmgobJ2dSY1FYqQgvji0duFNV54B9r
         Jp3B8/Zm4Fy0WllDNxK0Kr4p1/QaHMCI4v3eH2NWpppndqa3JU2kRez74hHijAsOm0n4
         yldX2VkEq7659fjEcd4B2LdTh7sMu9LtYNfCXB8KWeWxZuoaST9y/gvay3zGDWsXuRwh
         gb/4/XcNZjhYVBgwRyqIPr/0rJDIsfTWFXNBLBX6viDnIptf11MWy5wZDY7TNsua08ph
         UK0b0iy88EcVCOrAi8npR9XII58ir/q0gqOD7GoVavma5koSc8KTAN4puaDg7b5bQlGG
         uwpg==
X-Gm-Message-State: AOUpUlEp9DrrSJ+bz1+Sbc31ZSkyZnu7nJjh+4585bSc71h7EdFYRISw
        ZISggJD87M+VnAToIv8io96i0Xbj
X-Google-Smtp-Source: AAOMgpcwN5dAne2C2f1aDKSWDSpZEmfM9Ye5vZKfYseHqZVY0VhIWM/9BvgI5UBrNZ8kcnyVIsIHaw==
X-Received: by 2002:a50:a725:: with SMTP id h34-v6mr1068630edc.297.1533070839195;
        Tue, 31 Jul 2018 14:00:39 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:38 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/14] staging:rtl8192u: Rename tspec_body members - Style
Date:   Tue, 31 Jul 2018 21:59:58 +0100
Message-Id: <20180731210005.17452-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variables of the tspec_body have been renamed to clear the
checkpatch issue with CamelCase naming. As these member variables are
never used in the code the changes are combined into this single
patch.

These changes are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index db0392cfd6d4..025810c93160 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -53,21 +53,21 @@ struct qos_tsinfo {
  */
 struct tspec_body {
 	struct qos_tsinfo	ts_info;	//u8	TSInfo[3];
-	u16	NominalMSDUsize;
-	u16	MaxMSDUsize;
-	u32	MinServiceItv;
-	u32	MaxServiceItv;
-	u32	InactivityItv;
-	u32	SuspenItv;
-	u32	ServiceStartTime;
-	u32	MinDataRate;
-	u32	MeanDataRate;
-	u32	PeakDataRate;
-	u32	MaxBurstSize;
-	u32	DelayBound;
-	u32	MinPhyRate;
-	u16	SurplusBandwidthAllowance;
-	u16	MediumTime;
+	u16	nominal_msd_usize;
+	u16	max_msd_usize;
+	u32	min_service_itv;
+	u32	max_service_itv;
+	u32	inactivity_itv;
+	u32	suspen_itv;
+	u32	service_start_time;
+	u32	min_data_rate;
+	u32	mean_data_rate;
+	u32	peak_data_rate;
+	u32	max_burst_size;
+	u32	delay_bound;
+	u32	min_phy_rate;
+	u16	surplus_bandwidth_allowance;
+	u16	medium_time;
 };
 
 //typedef struct _TCLASS{
-- 
2.18.0

