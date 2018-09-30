Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E7C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1702075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CziLtOrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1702075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeJAC2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:28:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54025 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbeJAC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so6653937wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ckLRTydEsYgGgU9bOFz0mvqHutDTi87ODPgmXspK/s=;
        b=CziLtOrFADuFeUBzGoSfWKvOUtliKmQ7khuWN98S3o4YTrWCOR9jCFfRvlX176akLz
         rceWg7P+GNnUyIJtX3i7wR17dc5QGz7Wcx5FvxG+fLWG6GmyP7Wx/2B9yIgFGXX04x9B
         nw+UDEd/Wn0dPjiztYKMzCbJABJPjwMT7Dvb9tB9CGWlc+6CyPmvM4ToZmLSpydGcINy
         V2h6sCz68kGG5lX/T8IEPzCcqeZel/6XFzEWkmgOahjLOpTpvoAkRmCHIeZ4G2zV5+Ch
         8xVW6sM6XPImRzMI90H+hkMNiWTFD4iNcvCCJwXd9LHONmexxlGJA6eeFws8c9YgZ6AL
         sDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ckLRTydEsYgGgU9bOFz0mvqHutDTi87ODPgmXspK/s=;
        b=N4Ce4Nd5A70JQXgz3+Cr3IJlIOqDFZInAdvpi6kAr+FQwx8iZMxXRpvEE+49Dz9H1h
         9fIeqlvBBdNABVPPB0evOKksfKE5W2zKT4RK+WdyH5SysTHVeOIfZyywjo/Dm3nrdgfV
         FhA+cVWrryZ3AMsM7yij7sa950CHWDtloWVe3aqSH+QjtP81mmXYAqxqO9RlwHMuycW3
         Bhp+o08SQNgfZDJ3tNGq97MS7t67hiPelciNinZinRt8ltIBiJGf4KBTVSjLGKc3dWvU
         HnF+xLYX1/ktOqBRdAEqa2oUlBKU6QMRNKC2GU7WtT0ww8CTeKm12r2obRQfcYJML41c
         +8KA==
X-Gm-Message-State: ABuFfog3mrzdf5xNiR4a+KAf+LjUNyPh2Gz7H8slQepJEN88OMLToki5
        q41nETRviOBqzGJHTW3uJqY=
X-Google-Smtp-Source: ACcGV602sRe/CBBg2YK78v8L62L12tV7bKfXwB+1jURWRMa5SIsWiXVFzYbqR+7WQx0LF3RxxJt5eA==
X-Received: by 2002:a1c:974f:: with SMTP id z76-v6mr6883204wmd.84.1538337208872;
        Sun, 30 Sep 2018 12:53:28 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/19] staging: rtl8188eu: rename parameter of odm_EVMdbToPercentage()
Date:   Sun, 30 Sep 2018 21:53:00 +0200
Message-Id: <20180930195310.1531-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameter of odm_EVMdbToPercentage() to avoid CamelCase.
Value -> value

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 07291ca90681..a3a85ad5c66e 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -49,12 +49,12 @@ static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 	return RetSig;
 }
 
-static u8 odm_EVMdbToPercentage(s8 Value)
+static u8 odm_EVMdbToPercentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
 	s8 ret_val;
 
-	ret_val = Value;
+	ret_val = value;
 
 	if (ret_val >= 0)
 		ret_val = 0;
-- 
2.19.0

