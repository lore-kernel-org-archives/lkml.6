Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26DF20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVWiXCDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26DF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeI2Xxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:53:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40864 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeI2Xxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:53:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so4913915wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h/9LQyK+PGpkRdU4jpdccd2cOV4yMwkQaDov6ziZ2o8=;
        b=HVWiXCDywZ8+y3Ie+zQiio/StNW9AWgpfpC+yg0ZPZm9IU6fc2m6BdoR/glfbc74Rr
         rKqc4bjj1ol1iM9fvQRuu/kXBILGtCobj8dbUfHE0H17wnEEtEcaERNiQ3AFQM8GgIPK
         xkFbcZ0LE8weVEFQRR5gUyW2Yt2zyQJkxqpNPPKPfN1LD8pKR3oYiJbXaOJvXMAGDhis
         B44gk2EPoiU4RSmhp7maoANk1glkmXmtwOtKIT2KHQ32WxYATvUVwUaLzTdpODoaE+Dd
         StJ5WSy/fec3e3gB08+mlUzvSu4orPTzwirp9YcKjRaol3487fmmSMkVXyrwNWMuzJvs
         3YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h/9LQyK+PGpkRdU4jpdccd2cOV4yMwkQaDov6ziZ2o8=;
        b=a+C0luI4b3K6DJsaRYwiGpfOyxbLjtfti0R//iTZv9zWFojIslLGMuaIujSRJLfqI3
         9nEtD33VG4IPStPwomLUMxyuCFPsTQMUQLJMKrUOiyEQGa4v7L6rW9GS0we3VTrJBJTT
         CNvwmefYv0gRtlXwuHdWoDN8xkVEYmbjSSvRH+89Flr9c/T2l0FvN6/haHqQvHsg67xx
         rhrgUyT+YAW47ju5TbeFlgitgXS9ervBuqSkSQp8hEXneKfNSPG0loxVo1vni9TUatow
         DMPICMB/RIsxvrBT1T8E+OYEf9p57rpfiGrUlygWTe1nxLLllZzniSE/eflPNW6nvpEU
         wjxA==
X-Gm-Message-State: ABuFfogQ6NwwosCWpZJWhs3tx8P/Q9F5Rh1R7T3/PcgvbhLokqmL0Yx7
        VB+W4YUYhqOxTFQebrYHyCg=
X-Google-Smtp-Source: ACcGV60B74dYJhxVzJX9DyqWRYHWlhsXCe0QXWYLOf44Cez6bcMRzNi3MagmnNrpXduL6w8RDrtYRg==
X-Received: by 2002:a1c:5852:: with SMTP id m79-v6mr4725333wmb.118.1538241874166;
        Sat, 29 Sep 2018 10:24:34 -0700 (PDT)
Received: from localhost.net ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id x5-v6sm4526089wmi.37.2018.09.29.10.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 10:24:33 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: Return -ENOMEM instead of -1
Date:   Sat, 29 Sep 2018 18:24:29 +0100
Message-Id: <20180929172429.21039-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ENOMEM constant instead of -1 for kzalloc failure checks in
rtl_halmac.c

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/rtlwifi/halmac/rtl_halmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/halmac/rtl_halmac.c b/drivers/staging/rtlwifi/halmac/rtl_halmac.c
index f0c6fc8c6aca..7bfc9620479a 100644
--- a/drivers/staging/rtlwifi/halmac/rtl_halmac.c
+++ b/drivers/staging/rtlwifi/halmac/rtl_halmac.c
@@ -209,7 +209,7 @@ static int init_halmac_event_with_waittime(struct rtl_priv *rtlpriv,
 	if (!rtlpriv->halmac.indicator[id].comp) {
 		comp = kzalloc(sizeof(*comp), GFP_KERNEL);
 		if (!comp)
-			return -1;
+			return -ENOMEM;
 	} else {
 		RT_TRACE(rtlpriv, COMP_HALMAC, DBG_LOUD,
 			 "%s: <WARN> id(%d) sctx is not NULL!!\n", __func__,
@@ -359,7 +359,7 @@ static int init_priv(struct rtl_halmac *halmac)
 	size = sizeof(*indicator) * count;
 	indicator = kzalloc(size, GFP_KERNEL);
 	if (!indicator)
-		return -1;
+		return -ENOMEM;
 	halmac->indicator = indicator;
 
 	return 0;
-- 
2.17.1

