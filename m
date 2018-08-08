Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBE21A85
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBiL3Hcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFBE21A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbeHHXWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41245 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id s24-v6so1886135edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XM22dR95dJo0uUy5jshMTQXOHXXQWus5cDswJSIVEOs=;
        b=DBiL3HcmsHcI3t2X9I7WkoQU/jVrTA3/GqAaOHXE9nP4WTZmgKfkQcEHRtcHt0BefD
         4UdgWCQckmWBWfHrOy5SB8DH9s4aIz+/tMOTFY/MHRYRceKnNTcb16StM6YDYZtQ1mYe
         If2eeLUzr6iFCgRU1Ap2MiPhK82AVB14hQm2VHHaJEzq5CxxAcsp9yK8mRPuEzIkFt9R
         FAYqp9JuItTon3FPNuPWfifYwh03WCOodMmGoWW8TvapjfX5I3NvgfExaArB7Adk5lvH
         u5zjvN1Dxyxw+8JCS/eJCPlq7Oe8nTt3ux8vc1Evitsxk4dAafokKScNCCIJF+YfyDjF
         H1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XM22dR95dJo0uUy5jshMTQXOHXXQWus5cDswJSIVEOs=;
        b=fjZ5LSOIW0FsHGbaY4ppNeM4mbRa67Vxt1Jk2AJrwq/64YmyzihQYc2n9vhgy/Kh4k
         T8R6vvfrCbmgslId1mqdyP86HrX7ypPDVrdDNUksUFVHpPPGZxjEcf/ctN3nOgoEwMaK
         pHX88B9JcxRkH4RtKEkHrQVr82dNPcPC/j+UNkS/yhh03USlj0DHve3KTF4UR6KCD1Zu
         hOszxR1/bRY+jOmWPnk336hw4+pcJ+CNuJBll1WpyIVbvzCxyaYKdxD2QA0bVMzzHnsw
         8Z1/wl3ZkL2xzKrMT1JCg1IeeTrDty3jxfIG7oOQKn1xmrByyBqzH17Vmb9aPKj+Wj+r
         k0ew==
X-Gm-Message-State: AOUpUlGNW9SXy1FAFQMgA3u6vWSKry6VKIQW4sq8diDV9Vmn1jCuc7Yq
        B+EKQKhOz9YsUFO9QILxH1y9IBt2meY=
X-Google-Smtp-Source: AA+uWPzPGt4DORUuBYozE9QCViVT6XWY0aUBaXXiAZEcUJygt6N4wRUiLLj3FqVsruRoG7MA2eMwjw==
X-Received: by 2002:a50:c8c3:: with SMTP id k3-v6mr4898034edh.193.1533762069878;
        Wed, 08 Aug 2018 14:01:09 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 10/15] staging:rtl8192u: Rename dot11d_update_country_ie() parameters - Style
Date:   Wed,  8 Aug 2018 22:00:31 +0100
Message-Id: <20180808210036.22580-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dot11d_update_country_ie() uses parameter names which
cause a checkpatch issue due to the use of CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index a45223171a55..ff18ad26ea0d 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -46,9 +46,9 @@ struct rt_dot11d_info {
 void dot11d_init(struct ieee80211_device *dev);
 void dot11d_reset(struct ieee80211_device *dev);
 void dot11d_update_country_ie(struct ieee80211_device *dev,
-			      u8 *pTaddr,
-			      u16 CoutryIeLen,
-			      u8 *pCoutryIe);
+			      u8 *addr,
+			      u16 coutry_ie_len,
+			      u8 *coutry_ie);
 u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel);
 void DOT11D_ScanComplete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
-- 
2.18.0

