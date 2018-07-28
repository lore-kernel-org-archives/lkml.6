Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE4CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EF120878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmKj3aeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EF120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeG2AnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47045 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbeG2AnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so8708315wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zic9By+GlvZKw2S7FiYXuD9kxh4GjhuJ8CuhOKq9TGs=;
        b=PmKj3aeDwj271WdmG1E43ANyCtaiu3NUEefPrpMP+/uM3h04dIrwxsTHnIT7pAmbwe
         2ZiXyVXyNjTjHPX4GfP/eiJlJgMSZ3+cqoOjoaTiRrJ/7HWkT60Rlge6IdjU5rg+eLD4
         SfGnQGwkBBS+hLPIaZ5UzSOU+Tov/FmqyCi4Dg0WoshdPOJpq6PqGe66zTCYJSQUIwgX
         heeNaYV22ZajsNoU2meTvfJ1ZdRycfXWvMttVDGUAtDyPDjuOb/kf321uDRqjzSUCM+v
         sogmSL+U7jzX+J9U0ln74byqlhDoqYf8K+Gk4EgPrFmVYtVJzMd5xHZF9M2fPB9C19Fa
         OlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zic9By+GlvZKw2S7FiYXuD9kxh4GjhuJ8CuhOKq9TGs=;
        b=DAisc2CicQwcerixNBaPnB882aaGHBKmO71gOkETmRx8RiJnSJbbtsJB+TijX/kl/B
         XGBoQdGcM+Q4MQcqh3fbvKwIlNfYYCm3RRvAvjprOOZfmc5X/9Q0jvCDBtALTxsPtWz4
         QD7DajOa2ho4Qj2qdqeEum2SpSIEmjVSGa55BPXxXvhpaTOnFpS+h+RBt8Bh/7I8elAm
         tN1N3jP1hwRyL3NTN8yBopNmunWE6dbC9SViFTJdBsY6TwqDYEcuW39aO6Tmg5/ZYsFX
         H3v72obnWjzFSn3sPyF8fKJRAHPQXVAPRpUmAt/i3WeCTwsOYmwePel9Nqoem/mETfMf
         E6Nw==
X-Gm-Message-State: AOUpUlGHgH/nlqS+hkjseLfJWpmElobrtb59D9V9pL7/E0avhnEqy4dd
        xDTe9Z+ZDrrWfkzK6Ve3a3CLhHe9
X-Google-Smtp-Source: AAOMgpfcB4QpVgTDkeysrayrWNSHtHQQYto5ZOMKQFwvIPGi59GEQYmrpnxpMIdnfN+Q9CGX07ZaPQ==
X-Received: by 2002:adf:8796:: with SMTP id b22-v6mr11230073wrb.92.1532819706282;
        Sat, 28 Jul 2018 16:15:06 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 05/08] staging:rtl8192u: Remove unused union ECW -Style
Date:   Sun, 29 Jul 2018 00:14:49 +0100
Message-Id: <20180728231452.20107-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union ECW is never used in code so has simply been removed.
This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 43edb830ad5d..65d7c9f4d840 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -24,18 +24,6 @@ union aci_aifsn {
 	} f;	// Field
 };
 
-//
-// ECWmin/ECWmax field.
-// Ref: WMM spec 2.2.2: WME Parameter Element, p.13.
-//
-typedef	union _ECW {
-	u8	charData;
-	struct {
-		u8	ECWmin:4;
-		u8	ECWmax:4;
-	} f;	// Field
-} ECW, *PECW;
-
 //
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
-- 
2.18.0

