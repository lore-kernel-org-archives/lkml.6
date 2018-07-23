Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0793D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7UrOhTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0793D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeGWVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:54:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWVyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:54:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so1998163wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YzZHRiLHnnsXQdUrlUIbvmaFz7skMxUVrE157gwcw0o=;
        b=l7UrOhTuawdQLx+D3HNsKxlyLQJrGrI1efhtmesF09/+fRWmCzSZdrs7/7+klTp30g
         NypNhcHpXgZJfln5B9xHyOAzR4cOQXFlo8xxyblu9o+7KVFmnn0fb3I0njBC3Je9q6NO
         ECeAN+RfM+5cn5PYuPb4Z/oQTjJpKJhhp1AOGoRwXR2F335NKf51FaUC8gTJ00ll5fQE
         a3W3UeYbcgbLZGjdUAN5Y6nAtDhf2WSjcBfWSjklyFXcFolBWMRBac0A6CrR5pabjzq2
         GAsSAzFV7mciGNipzZW02ALf0Vr/RYLjqABOoEvyyU7+MYYEXAMokSI/NDBGevkyWoyf
         qlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YzZHRiLHnnsXQdUrlUIbvmaFz7skMxUVrE157gwcw0o=;
        b=H4q62ju7KcrT4yHXtweTLxilWHPk/uUycVwLRREhWB1bqDgVwVVZS/zkOl6laCVtvT
         gUl2FILr+GSdzCyj8lDRFMojTgc8GgwGQqlUkVMIXwcU3/bfCFrwDaKaMP8JpLKDynLq
         8+oVQkg0QLGxPLF6ihiyhXm37CDDCdbzQcxtgEzBSzzuKLxpP/zRCFfvpC52LBRqTnM1
         kZd4nl4biMH/N4tNmzaH1RI+E5M7MeD/UIMCwT8lNtigTz1+pTjiL5CejXZDHwYNh05T
         7By/txu0vhP3nqSpL3INAkGsdAWf0en5VNn0lWTkHNW4KyghgyTBM1zA5di4Be0SneGF
         t7Eg==
X-Gm-Message-State: AOUpUlHxs3HCWWeg0WZdzTqKy588e/By6w5gQ2nseDb/vS3fi++j+eoa
        EhhGaqKpI4kvRE3KOFHQbr9orawb
X-Google-Smtp-Source: AAOMgpdDaPfOyG5CmCKd1noLuJkFfcjqAnse6vytrlVPlafdP/RZgVb3bBeORp4lGbKK1hz1yQ1s9g==
X-Received: by 2002:adf:ec41:: with SMTP id w1-v6mr9447643wrn.128.1532379066973;
        Mon, 23 Jul 2018 13:51:06 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:51:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/15] staging:rtl8192u: Remove unused definition of sQoSCtlLng - Style
Date:   Mon, 23 Jul 2018 21:50:31 +0100
Message-Id: <20180723205031.19816-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sQoSCtlLng. The constant sQoSCtlLng is never used in code so has
been removed. This is a coding style change so should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 471874dd8cb5..8ee9370520f3 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -189,12 +189,6 @@ typedef struct _OCTET_STRING {
 	u16             Length;
 } OCTET_STRING, *POCTET_STRING;
 
-//
-// Ref: sQoSCtlLng and QoSCtl definition in 8185 QoS code.
-//#define QoSCtl   ((	(Adapter->bRegQoS) && (Adapter->dot11QoS.QoSMode &(QOS_EDCA|QOS_HCCA))	  )  ?sQoSCtlLng:0)
-//
-#define sQoSCtlLng			2
-
 //Added by joseph
 //UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DSCP
 //#define UP2AC(up)			((up<3)?((up==0)?1:0):(up>>1))
-- 
2.18.0

