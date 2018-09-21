Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA24ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFOSd7yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5B221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbeIUQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:02:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51688 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:02:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2-v6so2482559wma.1;
        Fri, 21 Sep 2018 03:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=twlh7GbhGfcC9UTvG9ggOQuu123y4BtnylUREQZ/5O0=;
        b=aFOSd7yK6kAXNflKr57Kkn90yqyZx8IB6wS1Kjzby2qZ/JSX6+leF63QYpIieR00ma
         1j0yuoIHtmerRL0+A1FnXsdHVwHelRxxtx1D98OiFCF8RiU5ul/YwX7T5m8NjAMSlLpK
         uatMYx6DD3lXociFLctUVZ5GUhebhnZmDmBjRoQPSnfZr7Z89Ir1QFQ2hEN4FEpJnpv5
         KKeyaHPaLY7fWITMKvejfFmBNsgqP2FY5L1LsvzYw1JBlOzWkYCWuiPVN4XITE8Cz1OR
         VXkPSlid/cCkpTBHNfqRV9zqOFo3IT0oUJD4s/xo3WoyVWGX2j59fjFHDPSBYogXgbji
         996g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=twlh7GbhGfcC9UTvG9ggOQuu123y4BtnylUREQZ/5O0=;
        b=X6XM//igbdX+rc4JDspcfqJ9XJljb8zrWl6ppsTiUlIotgvGy6NBvaBH8M5TIzW+29
         2mCGMLZZlbxuk/AYeNdBvCFzGnyRF36ycRGI9zQlSFpnca9nmU4gXNns1ZliQDkhb09i
         x7i4zTwVf6sFRdl0+2NrG11p84ZFr1OBkZfW8v4+O74NZAeOvcpxtnBIJtkuSaFaNVrC
         fajZPwc+k89k/SJrALSnjxtBUP08wtJL80Ky60Lq3fkJd9FMoS2BJ+NVb0k1TZ8gETpL
         yK2bYgDLp8X+VHXb42T9nDZS5gzRaCJFWi5RRzcDaoFu/AtiOEhNpWrPKvjQ7eDoUXyX
         q7Lw==
X-Gm-Message-State: APzg51DdRugp21/efu6S1dTv3wgiTSGUWVeb8cEnfKTVhWrjM8/t3s/i
        aJW6jT4beLMTLTav0SINiLU=
X-Google-Smtp-Source: ANB0VdYyZdwSRU0VsjiFkvZ8IJWcGuKkEQE64dT9JQ3zz/4KI+QWSDQYQyuFLVolJZVcn6we4s1tHQ==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr6789499wmc.80.1537524848953;
        Fri, 21 Sep 2018 03:14:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w94-v6sm20016715wrc.38.2018.09.21.03.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:14:08 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] i40e: Use proper enum in i40e_ndo_set_vf_link_state
Date:   Fri, 21 Sep 2018 03:13:59 -0700
Message-Id: <20180921101359.23911-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is converted implicitly to another.

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:4214:42: warning:
implicit conversion from enumeration type 'enum i40e_aq_link_speed' to
different enumeration type 'enum virtchnl_link_speed'
      [-Wenum-conversion]
                pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
                                                     ~ ^~~~~~~~~~~~~~~~~~~~
1 warning generated.

Use the proper enum from virtchnl_link_speed, which has the same value
as I40E_LINK_SPEED_40GB, VIRTCHNL_LINK_SPEED_40GB. This appears to be
missed by commit ff3f4cc267f6 ("virtchnl: finish conversion to virtchnl
interface").

Link: https://github.com/ClangBuiltLinux/linux/issues/81
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3e707c7e6782..916a98e6c0e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4211,7 +4211,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 		vf->link_forced = true;
 		vf->link_up = true;
 		pfe.event_data.link_event.link_status = true;
-		pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
+		pfe.event_data.link_event.link_speed = VIRTCHNL_LINK_SPEED_40GB;
 		break;
 	case IFLA_VF_LINK_STATE_DISABLE:
 		vf->link_forced = true;
-- 
2.19.0

