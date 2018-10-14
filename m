Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F231C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0504820652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhAL7U4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0504820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJNR6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39453 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeJNR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so15174587edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVe3sLA7Li9tmLx/ZBk6UE4ok8H8C6nGEYSEtwjE+os=;
        b=vhAL7U4d4hvvS09ysgDbk47+OQ/WLwxiBCciAWn7rDcMvKIyom3Ruql++Ik3+e3v5A
         IM4pLH/1qOunwg15LzuyaGqS+fmVok5Ncdv550pNOR7LJZrWG1NH8vFRWDNQofsy5tOB
         jCHwsCUxQl7mbxvD9w+Z6fNYG5lk0OnEVYRJBOd5A4epqJQFkGa8OM39+LInaqBQ/zaN
         TO4fIVaOAHwkAyXwjOBbgN0g7pyFCbHvG5RouI/0E/pQZnnDBYfbCnhn9hm1kmXaWBS4
         08bZEIKD8EjcFIVEYf7M5DDgDMh3BVi5/i9OuxDsJThZwzHEA7x9C0eroVRAJ9QxhQqt
         wp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVe3sLA7Li9tmLx/ZBk6UE4ok8H8C6nGEYSEtwjE+os=;
        b=oCWWsTlme5CsJOTvJfaxsKnmAZlLCtd3gzjWbgMzRzZRXuTARN70PTTXSpR3wlEwpi
         Wb3DlneZVF0FVz+Ov65tNcHVH/dBDgo+ro1kYJ/g8wJ/C8TwJv0E6ojOwAGNV9FbDxPF
         yUAizx/rlW6hoMNhIOxP48uL8ZGAWTlxGp7yE+zJUlSMmPJqfjKImdW0AavGpxsiGzAZ
         2yeP2fi1Zuow6+xLCvcqCLxmRKFk3Nb7+7mAMQ8CuP6p1ilIiItusKKEmFrzcE7ybtdf
         VJVRj2OjqgH6VLD/us9NYzjPN0LKS+qg59N0sPvvLqpWf2PFhhORxTjIHjRsjzVt3q+I
         NNCA==
X-Gm-Message-State: ABuFfohz9kQ3xrI3YXLN8Abl0LYVag39audraKE4ZJoMdvqYfK+LAdrG
        U0ozZo9yXNbREuQeU5mlVPg=
X-Google-Smtp-Source: ACcGV62097CeNBTveIGCDNF5Tm+GzppJGKYJXwrE274Aii3HnFCGZiom7SXrTEhN/6cG4TnR1y230A==
X-Received: by 2002:a50:862e:: with SMTP id o43-v6mr18823204edo.209.1539512283529;
        Sun, 14 Oct 2018 03:18:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: rename parameter of hal_com_get_channel_plan() - style
Date:   Sun, 14 Oct 2018 12:17:39 +0200
Message-Id: <20181014101742.10952-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameter of hal_com_get_channel_plan() in header to avoid
CamelCase and match the name used in the function definition in
hal_com.c. AutoLoadFail -> load_fail

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/hal_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index 7c2bc77a1dc1..613aa35ce10d 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -140,7 +140,7 @@ void dump_chip_info(struct HAL_VERSION	ChipVersion);
 
 /* return the final channel plan decision */
 u8 hal_com_get_channel_plan(u8 hw_channel_plan, u8 sw_channel_plan,
-			    u8 def_channel_plan, bool AutoLoadFail);
+			    u8 def_channel_plan, bool load_fail);
 
 u8 MRateToHwRate(u8 rate);
 
-- 
2.19.1

