Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51102C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CCD20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UynjGKnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CCD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeIRNjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:39:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53783 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbeIRNjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:39:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so1368973wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVx8WmW87VghpDBLCiQVby24CGj0iZ6HJYpFvH/63nk=;
        b=UynjGKndWS2hQkVr3RrKsKzRMs5ikzVn0fhFiJ1mb93kw9xUlASFhwFfujaBiehd/F
         g2ceM8ylWyiE+zlx49ozkWn8IToEoD8M3bh0hLWMpIRNs939Vlh/b9oSRCm1t867jrGZ
         QZAcEEy+9s2EMHBrHYAav6OLu8afXmfsiBIVZe911In0jNw2bDxZaBsO6x5oYuUoWro7
         0NB9AR9i1ayon3KVPaRpmSoK1XIxzxmOWOZcI3/CYPxdazR7NjMKYNx7rCr7qRAlvi4q
         oMQ76puUV2YM1hKV03dGcx3JAOLaqHPmso1ov8tXtIv+/Dawf6JOj+2SV+YTzF0X3i0E
         u+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVx8WmW87VghpDBLCiQVby24CGj0iZ6HJYpFvH/63nk=;
        b=jfaeFUnxvLbRVuq6/0rw7OO8D8IgteEpXJqha+voG9SiEGeLjA5QoWdFnqooEFNUY3
         6kScsQMxdmCvmgmjPi6sZJD5fbHLesTvYFH7HebxUIIuZ7EAHg7+GXdP6uR63ys207wD
         wQ5S1CRHPi/rVmOwo5TkmN5QQuE0sEb+1NMV2ocTWjEYxvBUyQZCXC5s01Nl8ylSOqy2
         6FssjkVbqKn+d0NTyjivL0gp8j7IYsE5ePgPust64wyj5gScC+XCxdmdCFPADXzBIOV+
         NrHDKFaZMHJO1FArcuhMbBf1JZFs89Scqvy3ZJQ75lEoTFuFexypH3XHHHO+r2FRo74G
         4qJA==
X-Gm-Message-State: APzg51ArdMMpywxSlgCpxThLI/dMVaJGBDUu18ue6CyH9PhWxKqJW94z
        24pTPhTTyywcqzwuPw8mZ6k=
X-Google-Smtp-Source: ANB0VdaLq0NeAHvglD56D/2OS6Qs6zeeB4W9+FHvtREBsg97gWUAhqGlJz3eW3kauBAgVowGTg37yw==
X-Received: by 2002:a1c:a941:: with SMTP id s62-v6mr13740237wme.76.1537258067616;
        Tue, 18 Sep 2018 01:07:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1386869wmd.7.2018.09.18.01.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:07:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 8/8] staging: rtl8188eu: simplify function comments
Date:   Tue, 18 Sep 2018 10:07:11 +0200
Message-Id: <20180918080711.21594-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918080711.21594-1-straube.linux@gmail.com>
References: <20180918080711.21594-1-straube.linux@gmail.com>
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

