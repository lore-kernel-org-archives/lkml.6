Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE3C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1384217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZL05PQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1384217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbeHDLTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeHDLTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so7596821wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4nyFEIx4XsmrL6vVGckKm/wmwzQEI+1UUGuHutiz7c=;
        b=kZL05PQyLF32UxUYKb4EhPxGwHjIJW+SNl2BZTQFglxQlrq2Emo2RAhTbXgrZ436rQ
         tPpM+LzDw0yJS/Eas1POH47gVAYjujYVEjkE6yxCjB9hsMBx8PvZOa/CGMCA/IiVcRw6
         jFLyeoA42t6WJYis1rB36KyXpBQhdxVAzzpx73SvECpfQ9OikfAXMDtywCROrUeYpprR
         gtg+TvSqXTm4n/wJTtzeiHlrNVlypWMaZGYAsXzPypKkH4HTFbvHDM2yYecCgowFOHj7
         Tq9yZLtNV9/rFVT383YJtZaU3tAUoG6Z82c/8qk9LrW7o3RiOQYLKFVbLFAREwy/Mxel
         DQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w4nyFEIx4XsmrL6vVGckKm/wmwzQEI+1UUGuHutiz7c=;
        b=l11W1ybyPfjuhkm33Irw2smkXb5Ku/RZ7HdCxX+dNWcKKuZQO+sySeE6Qj1KVdkLjt
         rzPhRkQ2KtyD+sekOOlOvEDbk0erWo0Aj6XWH3XmBYfoOVnJKZaXXJA+sYUTBSjp3X/1
         EyzFz6I15+piqphQTq6693rLl99V7XVZftdi7zLarrM4n1YHyOilqs6MYLuC9PBvCERH
         GMwC6BJWplKGJ897MoSs76f9+4c9LWDQS/5VSkIFdB4xVYti+7W6Lpm5Vl5rERa2BBJV
         EhjIeb/2ATnZJo9XZN5BkoLoJ+ehTt9akUhhmJh5rIPOt3wLUG+5fJkXDxkWsNZR34Kw
         ozwQ==
X-Gm-Message-State: AOUpUlHHm7tIEtrcb1zDqnbkpbULBUoig2iVZjpMBX1DBk7PBsdmzNWK
        CcMNpBpt48/bvpMs7zTfz0UbgJCsl3U=
X-Google-Smtp-Source: AAOMgpedsw1VIihbG6vUzPA/YUbuV/i+HBE/WbOD3EQy8rsLk+MTyhmyX6CUeU7sTOEf2hIooXmRsw==
X-Received: by 2002:adf:9142:: with SMTP id j60-v6mr4434513wrj.180.1533374350815;
        Sat, 04 Aug 2018 02:19:10 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 4/7] staging:rtl8192u: Remove blank line - Style
Date:   Sat,  4 Aug 2018 10:18:56 +0100
Message-Id: <20180804091859.6729-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of a blank like which causes a checkpatch issue.

This is a simple coding style change and should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 508ed639cda5..93984e8e87c3 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -15,7 +15,6 @@ enum tr_select {
 };
 
 union qos_tclas {
-
 	struct type_general {
 		u8		priority;
 		u8		classifier_type;
-- 
2.18.0

