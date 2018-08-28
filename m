Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA305C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799AD20856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfeuqmK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799AD20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeH1Wsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:48:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42044 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1Wsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:48:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id r10-v6so2124756edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xc93W2yA28AjETSZUBd5uEFs7Ai3LRx7KjsEjagnKXo=;
        b=GfeuqmK1QqUfcVkSzVmKzLfkheWONOnvmekVbSLMOvpKghSv9/slA7neV3r5MQZ2su
         tWHSC8Bq4H9OqQhxcFkqIMGqUjeA8tvwC+eozvLqjBJILWB/x3EQvXhZqMEU1M1Vnl2P
         e4/nHrL04KmGbjBZp+n6JvwQ6/m/flhpb2V6P+mkcGW79n0PagkQJ1QIhbb1P6wxRDOk
         C5cictnlpps1W04Wmi1xXZIfGv/z+1uwK/vL4UbbtU4OA3TBMzyWjuFSlpaO5XtdrWdS
         Lpku/eRMPSU8WoU4z8fIua4wgBFr232nwjiZjjwip/AN66rDZhFSUwKM2I0oC9NioVkG
         mzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xc93W2yA28AjETSZUBd5uEFs7Ai3LRx7KjsEjagnKXo=;
        b=fTKRmqwJx8kDOzeMDtrJs7vNzdZZb/QrdSRT8APClhuR8Al/sj4OPu7k2H8he1qT1A
         aD8qWDqV6+u2+C6pg57MKMyuTiTJr9ROZyrNAaC5hJGFvJgNTvV8EC4wjN83ySF9IbPy
         ww4YUYVUYNBdyoxfl9kTFEsF7PtBMMKPEIilNR2fNFamsFhFhRuMs89vj2IK8ralkLKV
         bPAZOGkFyYAPDrViC5OvnzAJyXEI9eUeFMDPcgUc1FkuwIb8FsL9ve3uOvVp1ur57pMj
         ATt+2rY8exP3ItmPyVY81QBVX2nVfq0NGNHD2LR8zd2FjmgKJeVDViZYkqNSDmKRxXh6
         HZ/Q==
X-Gm-Message-State: APzg51Dz/G+2BOGPyoJEt8mixYsTHkz7XQ368CMMOdSb9KpKiUkmxGDw
        eqg8qPXaG5I2f1dVGE2s75HNmIUf
X-Google-Smtp-Source: ANB0Vdbch1dTfRl/bvbNdvuHGSD+aWqufhko2BVvIztIgEpVs3gmZyllcfFXrbqCXtuoMSpQ/W42iA==
X-Received: by 2002:aa7:d7c5:: with SMTP id e5-v6mr3839194eds.195.1535482552888;
        Tue, 28 Aug 2018 11:55:52 -0700 (PDT)
Received: from localhost.localdomain ([109.79.175.209])
        by smtp.gmail.com with ESMTPSA id o24-v6sm742975edr.64.2018.08.28.11.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:55:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/4] staging:rtl8192u: Refactor member variable enabled - Style
Date:   Tue, 28 Aug 2018 19:55:34 +0100
Message-Id: <20180828185535.28808-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828185535.28808-1-johnfwhitmore@gmail.com>
References: <20180828185535.28808-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure rt_dot11d_info contains a memeber variable 'enabled',
which causes a checkpatch issue as it is declared as being of type
bool. The type of the variable has been changed to a 'u8', to clear
the issue.

Additionally to aid searching for the member variable in code it
has been renamed from 'enabled' to 'dot11d_enabled'.

These are purely coding style changes which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 drivers/staging/rtl8192u/r8192U_core.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index d3b13f0cfc09..f3aa60cb3227 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -7,7 +7,7 @@ void dot11d_init(struct ieee80211_device *ieee)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 
-	pDot11dInfo->enabled = false;
+	pDot11dInfo->dot11d_enabled = false;
 
 	pDot11dInfo->state = DOT11D_STATE_NONE;
 	pDot11dInfo->country_ie_len = 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index be59f720ae20..df37678b806d 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -28,12 +28,12 @@ struct rt_dot11d_info {
 	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER + 1];
 
 	enum dot11d_state state;
-	bool enabled; /* dot11MultiDomainCapabilityEnabled */
+	u8  dot11d_enabled; /* dot11MultiDomainCapabilityEnabled */
 };
 
 #define GET_DOT11D_INFO(ieee_dev) ((struct rt_dot11d_info *)((ieee_dev)->pDot11dInfo))
 
-#define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->enabled)
+#define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->dot11d_enabled)
 #define IS_COUNTRY_IE_VALID(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_len > 0)
 
 #define IS_EQUAL_CIE_SRC(ieee_dev, addr) ether_addr_equal(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, addr)
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 6b22aaa40ff9..34ea47366b72 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -211,7 +211,7 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 		/* this flag enabled to follow 11d country IE setting,
 		 * otherwise, it shall follow global domain settings.
 		 */
-		GET_DOT11D_INFO(ieee)->enabled = 0;
+		GET_DOT11D_INFO(ieee)->dot11d_enabled = 0;
 		dot11d_reset(ieee);
 		ieee->bGlobalDomain = true;
 		break;
-- 
2.18.0

