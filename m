Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE0ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1CA20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfulVMZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1CA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeINU1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:27:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36993 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbeINU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:27:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so10968816wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVx8WmW87VghpDBLCiQVby24CGj0iZ6HJYpFvH/63nk=;
        b=mfulVMZ4w/I3HnKxxLztJnVb0fbaju16GQHTS5xCRXH+djUF5a1EiirfLcgK4bBLwo
         buT9k/U3FLFDXoh7CcRwdwq2UZvVKYLKtvxkXLTIjGnwZogt/mYWtIrSnD5iK+87HINw
         GFE3adrsvZ6+iKh9LV7u1mts7nIat65vrrw4aZPxvjaylAZQ2GYRUczHW4JFLGDPv7ls
         sC9adQZRMc9y/pXsnMH5PIvZo1W0EpmaSR75DaFeXQ4HGZiXETkiUfCiDH7EVAuVuYy/
         ODXJ5XFFWdjouW0GkRRUURroiFIpR7v//vixu+9Yp2zUMwoQ6XgD2zNb04TwDECPchfC
         G5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVx8WmW87VghpDBLCiQVby24CGj0iZ6HJYpFvH/63nk=;
        b=OAB5sljxTKBjTyxtb930q6Ix770XUGNlkneUTfVIec0hlIEArueH5qTI4fr4rps7db
         +hWeg5FJsLb1oP4LlHuRkg9ZHOdXaX4E8dcmLsXi0xmD6whCdT6fmYcANpCeGkVoUJJq
         vVlgJu9ZRetjJLem+bP4hmiPCs5GJfFy0fVh5csvwfppMyfKqIdAL/MVMvoJFEL+wkn7
         R3WNW/VnzivIxnjAniiVfr6+kA/Q49XxivuoMEud6P08MuSb9+KI5r19FdpxbOOWfRRv
         1P18z5LHNRKKDurkRJ/NZ6DMoEfT83SzQmbQwGvPcAxDctI1jIcufPQQuEnVO46zKCcJ
         DRag==
X-Gm-Message-State: APzg51AFHFnIagymysy+gRWS52iydN9zh19QKDAo1/RcYqVCDYXgVNI5
        aVMs3gq7KVqylt9hN7Kvo9GqGPjdOXM=
X-Google-Smtp-Source: ANB0VdYSeErWtL15XtBl6140l/zMsM1HoqSv06rk56ydKb3Cb/OsXjGEq6KBZTJ2TP8paQZLziRHGg==
X-Received: by 2002:a5d:404a:: with SMTP id w10-v6mr9633898wrp.147.1536937926814;
        Fri, 14 Sep 2018 08:12:06 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa89.dynamic.kabel-deutschland.de. [31.18.250.137])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5198502wrn.58.2018.09.14.08.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:12:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: simplify function comments
Date:   Fri, 14 Sep 2018 17:11:42 +0200
Message-Id: <20180914151142.1179-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914151142.1179-1-straube.linux@gmail.com>
References: <20180914151142.1179-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify function comments to a single line.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index c291d3a0fdcc..0b3eb0b40975 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -530,12 +530,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	return ret;
 }
 
-/*
-* rtw_get_cur_max_rate -
-* @adapter: pointer to struct adapter structure
-*
-* Return 0 or 100Kbps
-*/
+/* Return 0 or 100Kbps */
 u16 rtw_get_cur_max_rate(struct adapter *adapter)
 {
 	int i = 0;
@@ -586,13 +581,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	return max_rate;
 }
 
-/*
-* rtw_set_country -
-* @adapter: pointer to struct adapter structure
-* @country_code: string of country code
-*
-* Return _SUCCESS or _FAIL
-*/
+/* Return _SUCCESS or _FAIL */
 int rtw_set_country(struct adapter *adapter, const char *country_code)
 {
 	int i;
-- 
2.19.0

