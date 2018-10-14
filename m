Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38EC71127
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CC720652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKGIxR7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CC720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJNR6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44163 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so15148771edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HAs8u/HEINqDlv1Xm9lw/3+z5jvwycqS6FPfz/HTCc=;
        b=uKGIxR7X9PhaY7yZH5/ghV2eaTZ2Mx6Ovf7Y53Yb7ac/G56Z5LoT6KD1rBQbfuCcLy
         to9QheKwuP56gV0qjbCEx5OYyHAR+TFpz9XAGldhmjtNsrdozW/H41gpz6gKOIzjCOA5
         Ye0VXlWqJYnWlkHrtTLmn8z5Uoo+f3Ds5ASVkdt+LqMAKO4EowVt2wUBw9MjkSzoXiDg
         2GJ6M1xfruX9Y8XNf65bdR1YAHWwSsVpMHBW8MTNjWKNylUbgpxCzrCD47YN7hQWnKcm
         ffRYt3N9S4p+qhxHhbC79FwQVg2VsVNO8tawSzHKiUH3Ip2Fu22eHenAwjn/98Wmtjhw
         XLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HAs8u/HEINqDlv1Xm9lw/3+z5jvwycqS6FPfz/HTCc=;
        b=EKaO5qCBahT4FzNHN7TCbnoC8Klo/l076+YfQnTJ3IfKJ9ZcrWbQ2oA5zr6dUP3nYH
         5VZnL9mkWIMqmfeDy5hVr19T4KLV0wBUw/lxQgWBQ5eRD8yz9y8Cru/9ikyEPWB7tHuX
         n9Vd2h8ClI407ZXYe4pvbzfvHMXaFsd56hCSjAb3a7Hx1a/eN4S9PzDUrkP5d36jN+xH
         nxsPP08vOrDu/ktF9HOtxS5MEeRm5g3lblbjSJrlv0GG2PBb1BJc+MIsQoESj2xF1WUt
         cnjdKWfmF8KdBn+Y1CkLUjlOApuzJkd61Fl+EzXRlspMx07dI0PTgj+oczwUHYhhmZbF
         QBeg==
X-Gm-Message-State: ABuFfoi7PUm+J6dgOS4PxI82mLvD8HUnrT5AgA3afJhed5SWlmk1kfB9
        dSZ9J+8ihXKlELI3ssYNwTk=
X-Google-Smtp-Source: ACcGV62BzvoGfGgOYicddvbPuWTl2oR25JO17qKLKpqAwe5qFM46PRIAnJE0ETly1p0IoZdqSQlECw==
X-Received: by 2002:a17:906:6812:: with SMTP id k18-v6mr14540034ejr.47.1539512282551;
        Sun, 14 Oct 2018 03:18:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8188eu: remove unused parameter of hal_com_get_channel_plan()
Date:   Sun, 14 Oct 2018 12:17:38 +0200
Message-Id: <20181014101742.10952-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter 'struct adapter *padapter' of hal_com_get_channel_plan()
is unused, so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c           | 5 ++---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 3 +--
 drivers/staging/rtl8188eu/include/hal_com.h       | 8 ++------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index 9853ebc6056c..3e93760a2816 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -45,9 +45,8 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 #define	CHAN_PLAN_HW	0x80
 
 /* return the final channel plan decision */
-u8 hal_com_get_channel_plan(struct adapter *padapter, u8 hw_channel_plan,
-			    u8 sw_channel_plan, u8 def_channel_plan,
-			    bool load_fail)
+u8 hal_com_get_channel_plan(u8 hw_channel_plan, u8 sw_channel_plan,
+			    u8 def_channel_plan, bool load_fail)
 {
 	u8 sw_cfg;
 	u8 chnlplan;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index d95940485126..31e80d693f32 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -505,8 +505,7 @@ void Hal_EfuseParseEEPROMVer88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
 {
 	padapter->mlmepriv.ChannelPlan =
-		 hal_com_get_channel_plan(padapter,
-					  hwinfo ? hwinfo[EEPROM_ChannelPlan_88E] : 0xFF,
+		 hal_com_get_channel_plan(hwinfo ? hwinfo[EEPROM_ChannelPlan_88E] : 0xFF,
 					  padapter->registrypriv.channel_plan,
 					  RT_CHANNEL_DOMAIN_WORLD_WIDE_13, AutoLoadFail);
 
diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index 0a87595c3a7e..7c2bc77a1dc1 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -139,12 +139,8 @@ void dump_chip_info(struct HAL_VERSION	ChipVersion);
 
 
 /* return the final channel plan decision */
-u8 hal_com_get_channel_plan(struct adapter *padapter,
-			    u8 hw_channel_plan,
-			    u8 sw_channel_plan,
-			    u8 def_channel_plan,
-			    bool AutoLoadFail
-);
+u8 hal_com_get_channel_plan(u8 hw_channel_plan, u8 sw_channel_plan,
+			    u8 def_channel_plan, bool AutoLoadFail);
 
 u8 MRateToHwRate(u8 rate);
 
-- 
2.19.1

