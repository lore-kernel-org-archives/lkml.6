Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94120685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtB582kD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B94120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeKXH1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKXH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so13450524wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GajybAkAPlaLfU5XTYFt37+iq0+sPtbmJrRarD3iLHI=;
        b=BtB582kDs5RKpKCF5R51mFwQyZN5BwtUWueVoQl1iYugIpwyUwJ+DksESzQQB1cXZx
         HVZ9/OoNcTxIjPEFsF4Fhkg5pOMagIeev28AYw3bFgBm5cNsvugk8WqAcdwj1bv25bKW
         ie6uOusrn6JsbokeF4mIjtLpMtPqsyWvA5Hvfc5y335M8EDOjh0CSzWiJpnGSz9Vi31z
         6xA2sA43eH1aYwOP6Wl4r7LhxOrKhMWeM1GeHDCa52y1VYCONJgJa7dsFji0NGETxtze
         vFK1/cEjMPwsA5DHp3r2QtsInp3tP/t3fmG5KQZR/9VMjHWL6o3K73nfnJU7Fq5u2cTT
         d0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GajybAkAPlaLfU5XTYFt37+iq0+sPtbmJrRarD3iLHI=;
        b=Qxuvu9OzH3JQCbPwSywQgfgPlMkAT4tjpDn8uUkJGEUlr4nfWOB5CYAAcYPJ8XA531
         bRX0/Mpa9xMkuBrWSEYyFZFuC7+hAMZ+hWZaM4zyQa0F1O6yKT/4uhThBEp0xqqEEGtw
         Z+0o4AeKR4yVBZHYnENUxuVIVtOcHY7qwv21jSAui1FTL56gVerJBs1IhmRopp89ocXh
         l1JxdQS7DdEl/IVn0VATpCZCZZqaWJq9UaprCyAJ7GN508utCp9tcDr2oN9FhVWhXvoT
         ce6WbxoItnIu5VJ19p88RfIZlU5Uel0YUW/epTvO6jac7vRaJdfz2uixIC9ZEN9MNQLt
         X38Q==
X-Gm-Message-State: AA+aEWbJX+1YAKKObu4HWym8Soj+40Iu46bRKXV78XpWUHw1a35QJ/bz
        TasTT6fVSUcOgYFkxg3bcXg=
X-Google-Smtp-Source: AFSGD/Xx6PH3t/+1gpztik1B9068DKop3bVJqUPh///ISZO2CcJ4gjUTEz0B6Hf8G/y7bvAdWcLuHg==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr15709194wrw.34.1543005684238;
        Fri, 23 Nov 2018 12:41:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:23 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/9] staging: rtl8188eu: remove return from void function
Date:   Fri, 23 Nov 2018 21:41:04 +0100
Message-Id: <20181123204106.2284-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove return from a void function to clear a checkpatch warning.
WARNING: void function return statements are not generally useful

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 513b6d89a0de..824e3c669a46 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -592,9 +592,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	}
 
 exit:
-
 	spin_unlock_bh(&pmlmepriv->lock);
-	return;
 }
 
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
-- 
2.19.2

