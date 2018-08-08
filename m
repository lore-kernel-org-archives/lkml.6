Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6996621A5B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxJiBsRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996621A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeHHXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35702 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1904366edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IrKPTITFvNaTzqZq/dlLdAW6PgwhQ55P8EDENmnVvHs=;
        b=OxJiBsRVZYNM6c/ex2OTNzaFF2WZGxm5WURy27G3P/+Oc01r5ar31/6KOIo1uJ/c2Y
         8PeNUNGGTCKiBcFvhcgp/XdOLWofo2kGTmzpfNNb4mvRaSuMCLE8RCuLNehLr7KW1pLR
         +7TwBrV6//XUypvnOlo/P7d4zRuL/4RNsmoFwi7hzV/RMFj5HFaIhUG9womd/DU3/zvB
         Ka3bRcANK7iIEJuzhuwQBiB9dZdrJEix4sGOWbFiqus8dNO0ZYsHpHj448BX/ia5Bwv9
         l/l2pxrv60mU4a3jMfUnPUBviJXwvfyRWozbdOioJC9nJ02ju0FgcssJCXfNNCj9SUQw
         lP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IrKPTITFvNaTzqZq/dlLdAW6PgwhQ55P8EDENmnVvHs=;
        b=KtgsggTgnfTWnIxOrQC4kv72iU3XrwpHCt3Rh6rKj6daLgTdqQTs+ffpbuly3DlvO2
         2sj3l9+tHL39+cO4rzOiIEjMZO3FKDOF++Byf5PRxIuMkuY4VI+YpxtJyhLrY3jytE6s
         zvX2M4Cap/PcR32X4vrfdKRJcN3iujt+4C+Vu4JMB31w185nNaHCNe8bdO0u9ku3RnDJ
         HshpCq9D2S9mVt9fDFkXFNGAqN4jFGwW5sC+JxTB4qNVhNTaxNS5SUxDIueHYkh722I0
         VnH4HPbHna6Jecg/1dcGCTMOJcJUSzC5G9T5j6LCQNKhcrB7rrSfX/SmEkTB8164vzzN
         SMYw==
X-Gm-Message-State: AOUpUlHrdcAs5ul7NSsjo2swKBSH8uKDVAUxRQimFgUyNjufbTjy49ub
        C+r0KpFoS+W1bM8z5GU/cMvKbi+cMX0=
X-Google-Smtp-Source: AA+uWPwGPKVERP0hmeu3L8VY0xTO/uBDnUt6OTQ3ZeRzMTndikbGmb+xsgPc5E/0Qv6ue2IzRuMiNg==
X-Received: by 2002:a50:81a4:: with SMTP id 33-v6mr4928970ede.200.1533762060141;
        Wed, 08 Aug 2018 14:01:00 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:00:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/15] staging:rtl8192u: Replace magic number 6 with ETH_ALEN - Style
Date:   Wed,  8 Aug 2018 22:00:24 +0100
Message-Id: <20180808210036.22580-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array size 6 represents the length of an Ethernet address so the
magic number has been replaced with the defined constant representing
that length.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 14879bc0fe6b..4ef609abc68b 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -20,7 +20,7 @@ struct rt_dot11d_info {
 	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
 
 	/*  country_ie_src_addr u16 aligned for comparison and copy */
-	u8  country_ie_src_addr[6]; /* Source AP of the country IE. */
+	u8  country_ie_src_addr[ETH_ALEN]; /* Source AP of the country IE. */
 	u8  country_ie_buf[MAX_IE_LEN];
 	u8  country_ie_watchdog;
 
-- 
2.18.0

