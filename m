Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81273C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B3F205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzvW5PJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B3F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeH3AfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:35:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeH3AfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:35:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so6018133wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mU3sR+N3dbiv1TVo0KOf5OgOFAGyppm230TqZDo2rj8=;
        b=CzvW5PJpgKu0opsg9tdjfY/b5JOZ3ps//37d0MhjYtyOlJwOf0zWWLEkQmN+BsyuIa
         S3PqT/FozZoLxpuh6VgZWQfx0XDgpRpQe2eyamYO6n3NdAvUvs/xr1j6y5blf5gzN1Aq
         CNq8ipv6rwO45Q5VmaDAKKextkAcmYaQW0oUT3kVIGJv8/HHgUw6rFHel1+L/SzYZgNI
         vrNUfQ/qfCNi3At/h5EsbcZnnkay6Hdhze4AHaylhD8/c2qmh1Iv9mhsW0o/sI6gz1M1
         tzq7sC8/dNPqBFyFVlcupguRNdHv+01eZB8ozUu52Ax8FOy8ttTk5ncooR/CWBQTpZNe
         tKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mU3sR+N3dbiv1TVo0KOf5OgOFAGyppm230TqZDo2rj8=;
        b=bpaCDLbC3LU24MO2fQCGIuMbb0aTuRTHUbFsPP1GSL9kicq0J9p3NY8AOrrYZiSzih
         ljjUXnu2QDAtCsqCUQBPGT5JZ76+m8sQ0rsfYb9M6ycBNEMyAarEbCXI2c3V/NeAgZLk
         uhVUSFhqUj5PQ+OEKFlkRdBvs8n34jR14gV1VS5ovS48QJ7Ei4DTFbm192ojYFZ597Cn
         aPx6DCbinWHiZBCVQrBoXxdhhFyoj/jmxw1JVpJ5FZqNuQstn6HtvPmToYjiwJQEFEWM
         y/F2UwbkrZRz48E7tYLJsVzykkigOR4tkEeRFlXCJKr8qh8kdJO3AWKgOAEUWrZNMLOj
         xV5Q==
X-Gm-Message-State: APzg51CNwA35l1XGNdCnGpk0ytx6FdKNVc8RqqRRw0xUSFerMJOvVSJR
        0iT8NjQ8boVWPzK9xDMoIq+trURB0vc=
X-Google-Smtp-Source: ANB0VdaZ6kRMtbfgn6BvvYk7cD4JWuZijWxDmXTzbGSrZfbLtoeGiW3XgM4hWpZ3yActfydcHMgKVw==
X-Received: by 2002:adf:c38e:: with SMTP id p14-v6mr5750507wrf.68.1535574985893;
        Wed, 29 Aug 2018 13:36:25 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:25 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/21] staging:rtl8192u: Rename Rsvd2 - Style
Date:   Wed, 29 Aug 2018 21:35:43 +0100
Message-Id: <20180829203547.15650-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'Rsvd2', since it causes a checkpatch
issue due to it's use of CamelCase naming. The member has been
renamed to 'not_used_rsvd2', since it is not actually used in the
code.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 9066f309bac9..2b73279b45d8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -57,7 +57,7 @@ struct ht_capability_ele {
 	//MAC HT parameters info
 	u8	max_rx_ampdu_factor:2;
 	u8	mpdu_density:3;
-	u8	Rsvd2:3;
+	u8	not_used_rsvd2:3;
 
 	//Supported MCS set
 	u8	MCS[16];
-- 
2.18.0

