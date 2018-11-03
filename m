Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A293C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034A32081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrCmDJlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034A32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeKCQH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 12:07:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeKCQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 12:07:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id n11-v6so2014460pfb.6;
        Fri, 02 Nov 2018 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JHhrYkl8glioL91dogikLtzyd+0Fx0iTIucTVxzCO8=;
        b=FrCmDJlgjU6llk+hF1CExnJH0filDVHkKgJeE6AoCLRdHynuaxnz4amoqTMyRvu5Wm
         XH0b0GhY4uX6hJgCSbdk5kbmgcE46Ggoe7JQjGDSjGuJedJ4Vz5Ln+ONdxZukDe59yMu
         f+K6khesPwLpgzqpk9vuUc2iB04vN9uMVsXEk8TZTzfmEEW70QVFWTuOuDCMd1pXzf6+
         6ECo0Ygv1k9l7mWpF4PuXC7w2mJKRnHiNy0bbR5i9nfXDvESH9/JDTdn0FVk28wY/zo0
         FA1o/KJ3iVZt/sa5uke9mnGsPnuPu0WwYXZRGv1gWIYGYMaoXSLoh+VPs/aai9QUuxF/
         /czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JHhrYkl8glioL91dogikLtzyd+0Fx0iTIucTVxzCO8=;
        b=kiaP1U8SFAZHywjiQAlMfDafBB9WNgfoeLqSMzXAU3j0Z2Ckctxs89hJeWczzZmhGT
         wOXkBh8MbeImulE48WIcTTvYIbfNnn3vpmko11pN3+n+sOidf+7kk/N3dvga3z+wVqDt
         TbJ6FjpXmP2Fd/dVhTaJqt+014H8u54CWc1uiCwXDvrwMkxx1xW8cxpQPS43U8gxAfWo
         EMjkSYUve2l/2P1h0PEREO6teQjyXwqoqzcq4T7UZ6tLAtHnSJmQPDyR7tPW2wVGqF5w
         bSz+VGDqHxyQOZ39yUl4biQ3O/y0KBzKoASA/LWH9gLvkz5MpxTYM8MX4+PoG1bg91hI
         2sFg==
X-Gm-Message-State: AGRZ1gIlf8vaTiv+eQdgU1N0GpEojLfZoFB7M0YTax2+YxwgDcJpadXY
        lJNMm+2zvpe4ENLyPiv+kCoGd9+3
X-Google-Smtp-Source: AJdET5fEaiGddZ//OAX2OQgjLkWl5/b0qt3yikK8MkOzQinPEqmw7/bj2FwtY+JT4IKoJhcyDElZKA==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr10560984pgh.206.1541228258374;
        Fri, 02 Nov 2018 23:57:38 -0700 (PDT)
Received: from kiddo.endlessm-sf.com ([2601:602:9400:bc9f::3b0])
        by smtp.gmail.com with ESMTPSA id k70-v6sm42030223pfc.76.2018.11.02.23.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 23:57:37 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org
Cc:     Daniel Drake <drake@endlessm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH] ACPI / battery: Fix reporting "Not charging" when capacity is 100%
Date:   Fri,  2 Nov 2018 23:57:32 -0700
Message-Id: <20181103065732.12134-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
"Discharging" on some machines when AC was connected but the battery was
not charging. But now on these machines the battery status is reported
as "Not charging" even when the battery is fully charged.

This commit takes the battery capacity into consideration when checking
if "Not charging" should be returned and "Full" is returned when the
capacity is 100%.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/acpi/battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cb97b6105f52..82e194290f01 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -217,8 +217,12 @@ static int acpi_battery_handle_discharging(struct acpi_battery *battery)
 	 * was plugged in and the device thus did not start a new charge cycle.
 	 */
 	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
-	    battery->rate_now == 0)
+	    battery->rate_now == 0) {
+		if (battery->capacity_now && battery->full_charge_capacity &&
+		    battery->capacity_now / battery->full_charge_capacity == 1)
+			return POWER_SUPPLY_STATUS_FULL;
 		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
 
 	return POWER_SUPPLY_STATUS_DISCHARGING;
 }
-- 
2.19.1

