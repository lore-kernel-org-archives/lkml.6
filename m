Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A60E21A5D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxGadMS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A60E21A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbeHHXW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43227 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so1879874edp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BD7ojQDDair9njVs6J6jAOqbWYVkSKT5lT4mfY/9GLs=;
        b=SxGadMS+9m4qtvmo1h22o/PkfavM2DMAajQC8fJf4m5j5dyr1dNOoEjUp/Usi2DMRf
         1WeQbG2tt/CnsJRYPiOwtQa0Q08aSIofjngQXCioep0gNGUSJs4THKr38LBvTVF2tJvT
         MdtVlPsIyMOKX8W7qnFR6zSTRsYKY2mhOlBzv4RF51Z7ST5vZiD7pFBRx9hfDwz8Og8I
         s2+sriawcm25t7VroEJxCLxoEWrxLeFzu9bRPN7lKBMhMIkur9WEgC6t7ArlBRdY17Cg
         XClO+c0rDz/Ny+TFN694bidZ+Zg8h/WHpVf3xlltPx9p+rn1oGnqgkec7tClmqVFl1Li
         lIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BD7ojQDDair9njVs6J6jAOqbWYVkSKT5lT4mfY/9GLs=;
        b=Tr5xOzDMvX+pYrCkE2TghVa7Nwbo4TcQstAg8BTMtDNsal1qbRJeXZmOHBcQZM5q9D
         5GGNSl1Q779pWw++CLBtBJsVX6xE+7PNkf3wM4Vk0aI9SlbIHSUimk0IyiyNn/6jwfLQ
         k69JFfP250hcX1UyJOftKW9zBphItaMrSFwvmGezXMKwlQcsLcwoNe3PylrtCq9NyUk3
         6G5FZ2BaTWAzUFS0TtJ36wKdJPmZejbOvoMfh52f8d8bqawE0K8eZM9qQHLW0ekCgppG
         CU26IbiLXV57ugo8oDzEdFDsO3Y/RlecClmEvplS+9m7O9j120JnQFW1ONnqbtpXTIhn
         tw1g==
X-Gm-Message-State: AOUpUlGV2hKEEILbG1ChL1VMFluUxWLx1NHOqGoYRlzeaevPqcIGgTZY
        opqoJC9MlE908u2nNUnf7qVYYCCK84U=
X-Google-Smtp-Source: AA+uWPzdkC6OsuW2G5Nv2quL9N9mkpi1MuSFqPpMw3LAunkv+4WleyK3sDognwThpzufGjHsoRntRA==
X-Received: by 2002:a50:b8c5:: with SMTP id l63-v6mr5070331ede.80.1533762062902;
        Wed, 08 Aug 2018 14:01:02 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 05/15] staging:rtl8192u: Rename __pTa - Style
Date:   Wed,  8 Aug 2018 22:00:26 +0100
Message-Id: <20180808210036.22580-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro parameter __pTa causes a checkpatch issue because of its use
of CamelCase naming. The parameter has this been renamed to addr.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 0f0e10fa645d..0263eca375fe 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -36,8 +36,8 @@ struct rt_dot11d_info {
 #define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->enabled)
 #define IS_COUNTRY_IE_VALID(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(ieee_dev, __pTa) ether_addr_equal(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
-#define UPDATE_CIE_SRC(ieee_dev, __pTa) ether_addr_copy(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
+#define IS_EQUAL_CIE_SRC(ieee_dev, addr) ether_addr_equal(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, addr)
+#define UPDATE_CIE_SRC(ieee_dev, addr) ether_addr_copy(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, addr)
 
 #define GET_CIE_WATCHDOG(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_watchdog)
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
-- 
2.18.0

