Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD2AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0863220856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efU634T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0863220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGTVLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbeGTVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so12348094wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g55OB7vq5Q7ro8lceEqreX5u8FNldAPVCEFCAxbWUHM=;
        b=efU634T/AoFde9cj+926YEhtXf2IdsZDKt9W4PCnu9wefpmz1f/oONk47hGjRFv857
         x7GOeM1gPo+2uH+qO13vOERJXUyboK28FW6et3Vv95+SxSnA57UDNP7sc68DQIfz2ZVM
         KkwiVRivnyiM0GFZ+UXcJzODJQgi6fin5+eGKoeTrt1JecZnxiDcURRLHHQ1dyFGlrz2
         UHgWRp67UxIYg2AHBnYNz4NXICmmJrVmetrtUIqo6RhX5L+CSNzDtT2XVwyFTRGl1pGM
         G8O0imKmhlJK0yh8OtGu6NtFSJxroUx782CZ82hVWfqruGFr75xmmLLBZYKERZRvZ28A
         s7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g55OB7vq5Q7ro8lceEqreX5u8FNldAPVCEFCAxbWUHM=;
        b=iuoqt2Iv15YFP6lNwkH0NyHIHY0PxYJyB+DnakFRcvpOcHzJvyKvsJqLTNo7Oht+3s
         gKhJ5BfFXxrrszo/TRUGURlRBKPOCjDoiPghl1YtCi1xJ8HlWwu/RkgTXBmqDYz6JxBz
         MVBaZmkMA0azMoUkluel00olOXh6kcFOJPbYt9eLdsxQuvgsym7p0PcS+zDuls2ujuWB
         zyTk6tBd6ndHO6TlbRGnHG033+fMAuSIc7ebyBG/CrxJnDEixAHNLtJ9VStr94xA1HdY
         3okIdwb3NirOLLur5UDyiAYEctizFQhZHClYj5haycoeTSVETnBssdJZTFop+TrwI6Db
         /t0g==
X-Gm-Message-State: AOUpUlHNP3p34o+TIcTs4Dpslqkh/eGyZgiVZ26AgjIT3sEFSqlyjwOB
        t3qhRKGp9yq2c+/UWLIXcL5t8pPoah4=
X-Google-Smtp-Source: AAOMgperUQ60FTc8x+zANrLCW6yRyWnNwl4QDJ0NUU0wIxkzN5DW1sQbulys1f1i0a4t+kMRFSgq1A==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr2409488wrg.230.1532118123023;
        Fri, 20 Jul 2018 13:22:03 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/14] staging:rtl8192u: Rename variable NumChnls - Style
Date:   Fri, 20 Jul 2018 21:21:32 +0100
Message-Id: <20180720202142.26312-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable NumChnls to num_channels. This change clears the
checkpatch issue with CamelCase naming. The change should not impact runtime
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 4 ++--
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index f24dae97bc0d..17bccb7bf594 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -69,7 +69,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 			netdev_err(dev->dev, "Dot11d_UpdateCountryIe(): Invalid country IE, skip it........1\n");
 			return;
 		}
-		if (MAX_CHANNEL_NUMBER < (pTriple->first_channel + pTriple->NumChnls)) {
+		if (MAX_CHANNEL_NUMBER < (pTriple->first_channel + pTriple->num_channels)) {
 			/* It is not a valid set of channel id, so stop
 			 * processing.
 			 */
@@ -77,7 +77,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 			return;
 		}
 
-		for (j = 0; j < pTriple->NumChnls; j++) {
+		for (j = 0; j < pTriple->num_channels; j++) {
 			pDot11dInfo->channel_map[pTriple->first_channel + j] = 1;
 			pDot11dInfo->MaxTxPwrDbmList[pTriple->first_channel + j] = pTriple->MaxTxPowerInDbm;
 			MaxChnlNum = pTriple->first_channel + j;
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 968c622137df..8c2b11d12185 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -6,7 +6,7 @@
 
 struct chnl_txpower_triple {
 	u8  first_channel;
-	u8  NumChnls;
+	u8  num_channels;
 	u8  MaxTxPowerInDbm;
 };
 
-- 
2.18.0

