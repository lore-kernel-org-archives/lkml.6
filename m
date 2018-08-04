Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF8DC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156DC217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhyVPDv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156DC217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbeHDLTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37608 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbeHDLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so7596890wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4BuFoqcatKlKO/syYa9B+EXY2kid46lrcFKRMLnX4OE=;
        b=lhyVPDv6jjavVCvRdejkNRmjPXcOMRVbA1LtOwl8J6zQC4Z7hYN6GYFDy86gIQaNP7
         p8bb/z1S4GrNmzh6H7HoQjM7UvJzsNbJwPDG5yGGMCl0AOuo7/mgshUyPJqZjK5xpwsb
         2qBX3BJKHwRqkctriUiHw4tMPmUF+M7d676vxTVa0rH7QfCnWYAvMwUrSV40Sz1DSWKF
         6Fjo9o7oMbcSA3ZTydb51UPimlBpnKpS8LlA4hTOx+rxrb883xIwpo88UTqANh4dkoqD
         SbnjJbCZS2F0nPgutUWjeS5oME1B4xr9xAAaTblwOLq60XMUlh2GTwakQnvhS8xxfS7I
         eeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4BuFoqcatKlKO/syYa9B+EXY2kid46lrcFKRMLnX4OE=;
        b=WVaLSXaEicDVESB96teNGKNUAgQaVjA/+EdzeSBJjpg1THAYWsaxC87bre7XUSyOgX
         pDSQfrCtlFt8ba0qW7yZAYYVi6t5JJ4OGcEAiszsaPLL9bl9NHK7PjruieqO98LZaVyE
         M2/jEnuibVRXezc0odt58n9ZQ2Wcr3KQ7mMd5FxX3BnWEOktRqVscL7n8m8TYjTI04rX
         eTTXHl+HnoGqsxQ9Cb1zuFJJxXrp3RPFPNfSXZtQQCEJinn61HFtSTfFoWlbGn+Cf2WO
         a59cNA4ZIJ8MWFDCA29z8wifDSHGRwXu1ZgqEjPb/uh9/tJJIz/es0PBly5uOwOOGyZH
         GzLQ==
X-Gm-Message-State: AOUpUlE+CrH5OIgyU9eWsUF9av9mCXNYCwgudEKlZvlcz57B4E8BiYQM
        eaOmXC3EWNkdWY1n3ltdtcihwT9/8EA=
X-Google-Smtp-Source: AAOMgpeZcKq15b5uTecefeNooczMJsYvQeK+algUDUAlJbFuhQnktl+GMnnTwzwMvQKM3AeXU4b8Mg==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr4624469wra.19.1533374353494;
        Sat, 04 Aug 2018 02:19:13 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:12 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 6/7] staging:rtl8192u: Remove unused member variable - Style
Date:   Sat,  4 Aug 2018 10:18:58 +0100
Message-Id: <20180804091859.6729-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove name of 'reserved' bitfield member which is simply used to pad
the bitfield to a byte boundary. The actual bit has been left in place
so alignment should not change. The name, which is not required has
been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 3cfeac0d7214..fc449806dab8 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -114,7 +114,7 @@ struct cb_desc {
 	u8 bBroadcast:1;
 	//u8 reserved2:2;
 	u8 drv_agg_enable:1;
-	u8 reserved2:1;
+	u8:1;
 
 	/* Tx Desc related element(12-19) */
 	u8 rata_index;
-- 
2.18.0

