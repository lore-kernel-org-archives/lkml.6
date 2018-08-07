Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE02C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1242C21717
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvR9kc8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1242C21717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeHGX3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55523 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHGX3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so499814wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7gA6g3w43p1h9ivdpV2wtQqClWXvy8bvYiU5DbF/hA=;
        b=nvR9kc8dw04YA6Ctt2r3hqxBK9P+UvD8lGZXfXUUSZvrDdxPKTKVYEJlgmMFw17pDx
         O/fZ3/EEtIkOjJzbxtPelZRLFOvc701ZPQYGW9KZWYIK1+nd5rfaiwV2ItIAzKkrMbiF
         DmDF42NUoOG4ogcrUw0QykclLrsPteMJjCaBFHQJA3lpb1fuyAJT6Y2PCmW5jWXbdPbT
         lZxJ765ORZkBX+J+R/9j9cLcas782d3glr7TGuJcTxWcSzUz1LTY8qbUlMsdCrXhy9YB
         tUZdQ1ELmaYnMdEe53PVBD7GaGLAJnxvPA9a1OcZeIaYWG1ky7H+KhHPeScwPqT5KZ3H
         8uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7gA6g3w43p1h9ivdpV2wtQqClWXvy8bvYiU5DbF/hA=;
        b=oCzvwldfYI0syBJ5q62Xsi6dz+hzbqqdn52aC2P+s6Y6/BUBs03uTMed0z8dgvwMK8
         miimTt+KtXXdbyhfCXQ/8p/inlS53xCp0LtV7wDlihMb2S1ogfFNLlqsGwD1WBn/7GAc
         mUi8c0MRg9zTUMc66liCuPltO8kwlbdMEb5yQzzrkrY6b2nYbD2EC7BWnIW1vL3zMIMm
         DgKGSeL1BCm94a9cHYx49P2Awsyz8zDaPqw8g38b3MfXIVFDvQsrPkghQK8HG77zBmhE
         Mmut4h9h3JPyyUdfOzkCop2KtkIo/EzmVh0W2y0mcTMzhYtVxoHA0YyIbWe2o9sVtFjM
         vezA==
X-Gm-Message-State: AOUpUlEyiZO4mRc9L04DSUKoy3Mc46QP2WS3f82MC6AGmgKundAOAcdT
        5QkBhecjc5KZgE7RzPGHJmzPIA5u
X-Google-Smtp-Source: AA+uWPzkJNIJRDhP/76pkDaIRQaKGn4d/9xzwKcyLMKVy76TEdW3ESqctP6uBWNp1AxdWYWps/9mWg==
X-Received: by 2002:a1c:a989:: with SMTP id s131-v6mr54797wme.136.1533676383038;
        Tue, 07 Aug 2018 14:13:03 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/17] staging:rtl8192u: Add spaces around '+' operator - Style
Date:   Tue,  7 Aug 2018 22:12:40 +0100
Message-Id: <20180807211255.29343-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' operator as required by the coding standard.
This clears the checkpatch issue.

This change is purely coding style in nature and should have not
effect on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index d4c8c28190ff..8d4d5e582782 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -24,8 +24,8 @@ struct rt_dot11d_info {
 	u8  country_ie_src_addr[6]; /* Source AP of the country IE. */
 	u8  country_ie_watchdog;
 
-	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
-	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER+1];
+	u8  channel_map[MAX_CHANNEL_NUMBER + 1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
+	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER + 1];
 
 	enum dot11d_state state;
 };
-- 
2.18.0

