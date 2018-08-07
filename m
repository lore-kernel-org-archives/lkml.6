Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AFDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ADF2175D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk22YA58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ADF2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHGX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36626 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeHGX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so80514wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ntqEMpoJkVO8X5hbs51friawpX6N9zoWDkxZgDonAZA=;
        b=Qk22YA58iiJuOwrfkAEsj35weSIxz5/FC+SBf8L/obUpfjyE0J6VWpv6OmbH6+46D/
         ugj5/UjnWi3ZB5ggPNZblo+PeKi8n8m08Uv5AU0Z1GA2Atvo/gD/Qmwe9PEw+ye02Vof
         XqibFvAzTZCgOQOffGu+Y5wpiUvCSb/JnK8NxKPbCoucQCEnq2Mqt0QiyeJ0JNUVlkDc
         dYZABpiIATGVcp37Pf18C2aLgchdHtLltRHHF4KTk4gMgNhrbHdHvM8kx2936NxY14bM
         8xB+FNo8GZmwncpF54+FlZOhcJnCeqm8cb7HCgR25xpBUyxvgYotLoHiUstNTXtF/UM+
         2WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ntqEMpoJkVO8X5hbs51friawpX6N9zoWDkxZgDonAZA=;
        b=Ru1qc5Yr5wnY60+JpKigKai+sJCyqUjTpwqHlNXaJXIqZ75odYCxwgB//IBpotOXPR
         Hc6E2EuvM2ER1B8f1w9R7X72Py1ENNJ4xCoEZYmRUPhG8LV3r20syFo24EuQMnTegQpu
         HHw767X8MHeKmqblsatg1t1B8IZXlNJUc+M3ckmCMH7rCH+kPN8H+hAnJlNcRZNsSKQR
         lqVANvEQ+C/Ab+7fnqqH4VKlFiZsh52/KDrchL2zcnhfVwgmu529HXA0zSoaFXjSCM7A
         b2DaN6S2GWTkoANXceQBXe7Ab7ev+eRtuWX8nBUrTFwOZt06VR9wWfUCmMOOWrhRJdVz
         mhaw==
X-Gm-Message-State: AOUpUlFki9k+Cc4Dilt+AsrdFi2weD0F+Ggv7+uvsETKXdqSqP6MPoDz
        e/o1pEEQxA8tg/RQTlxtnNZ/hSo2
X-Google-Smtp-Source: AA+uWPzSXh54UYro56wsm03XJgAqG7QR2SrEJ0cAEvVrQCUV2haF3KFpED9dmZMtUPsQQZQ68IgPOw==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr61908wrj.212.1533676401559;
        Tue, 07 Aug 2018 14:13:21 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/17] staging:rtl8192u: Rename Channel - Style
Date:   Tue,  7 Aug 2018 22:12:52 +0100
Message-Id: <20180807211255.29343-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dot11d_get_max_tx_pwr_in_dbm() uses a parameter name,
Channel, which causes a checkpatch issue with CamelCase naming. The
parameter has been renamed to channel.

The change is a coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index b052fae72a4c..847f5d51a6ec 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -55,7 +55,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *addr,
 			      u16 coutry_ie_len,
 			      u8 *coutry_ie);
-u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel);
+u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void DOT11D_ScanComplete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
-- 
2.18.0

