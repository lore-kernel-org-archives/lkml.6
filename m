Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5FBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C0C20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6kwa/r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C0C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbeGTVLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53600 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbeGTVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so10562801wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Vqx2IcrE7rT/VHEwCnnSe1/FJ/1AK143Y8P/k37SRw=;
        b=j6kwa/r6XyMRCBTMyFCreDsC8wMFkqM+OkJp4aksy0vZqDWFpk9sVwk1k8C0kIMfUA
         H3W3/7Uf398ekhRmHWtmr3XhW5WWzSoCq62h8JlqHDxq752W8McR2X65ooWbdgjrEhpx
         fH/aXKyXkRT7SljGsoIgQsAI/7YJLXWTcJbk0MnlXwCChd1qIoCyQcJFbNySorPSnYpv
         kwPCA08yKCHqEYM1qlQ+7XybRzQhaWGvGfnd5Qg2FSvmFjbUxHWump1hARx2fGVCstu3
         6xRjQDTXFcwbDBvRHAUbdGBVjL0cLTPz4E7yOdyrp3z+m32LW9ZTLkHMWo437PEBnrNy
         /obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Vqx2IcrE7rT/VHEwCnnSe1/FJ/1AK143Y8P/k37SRw=;
        b=cecq0oddhD++8QYF15bzxc8ieV7/KAA8VbgmtJ+eSQTX9xTwvpNdLEpF6Z7z+MMySz
         ihAu3XA7Ils2DEHZerETRlqGQMRoUKXGyNOKmRqHgBpMBs0FlkhxFILLrau5CEtvAu31
         p4/mcDvG/OUDc21iT8TJhLIW0roW+XYleTCir401WH37q7r4ZenKYw4wNdEPi5jNpHwJ
         gMBU7hw52xwJ9tQo/OvJRyzzw7UexNhWMeYY/OmDr1G4AUb8WONyYIjkA6YfdhNas9Ny
         5sDCYYNe2kNpPj49CStjDHG0l4c8KTkiDmkPNSnbx+K6JUO+iPbSN6LFuG09y1OtdRwK
         26wQ==
X-Gm-Message-State: AOUpUlHmFOriNfRI5f/vi6C18qXNJwPn+UaIMuMUTqxUnBVVJncocPBo
        BPYt1jErM1Ds96uXQSBhqgsZmtG0hlw=
X-Google-Smtp-Source: AAOMgpdZgqJBjDypSEy9uvwcdX7Hd54qd5/A7ytFFgKIKd4I5TQEtsoqB2S00Eh55LqyCseLp6UgjQ==
X-Received: by 2002:a1c:e043:: with SMTP id x64-v6mr2438574wmg.58.1532118118298;
        Fri, 20 Jul 2018 13:21:58 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:21:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/14] staging:rtl8192u: Remove multiple blank lines - Style
Date:   Fri, 20 Jul 2018 21:21:29 +0100
Message-Id: <20180720202142.26312-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple blank lines which cause checkpatch issues. These are purely
coding style changes which should not impact execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 88bc298305bd..23ab2dae8347 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -4,7 +4,6 @@
 
 #include "ieee80211.h"
 
-
 typedef struct _CHNL_TXPOWER_TRIPLE {
 	u8 FirstChnl;
 	u8  NumChnls;
@@ -59,7 +58,6 @@ typedef struct _RT_DOT11D_INFO {
 
 #define IS_DOT11D_STATE_DONE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->State == DOT11D_STATE_DONE)
 
-
 void
 Dot11d_Init(
 	struct ieee80211_device *dev
-- 
2.18.0

