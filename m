Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B413DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879CA218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m451D72X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbeLRSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36832 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbeLRSfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so3560156wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4inWB9VUllPK2WQJTgUqIr/F3vknOkQcDIJGPHtalLw=;
        b=m451D72XW8KpX40H+dQuiKpkkitWhOBrd4XMXdei4/F4rZJAsLwZzAPWZhpCtApDfm
         ddbQl3zQVx4CEhQjvPvIOpwGCK88qg/CQRzbUvxK6kG5Q/E+XwdwpSnFhXsp1/htVwUP
         h6zzDpQsiqzgcr2mYwd5dXT2rwyLU6J96yEEl3QK9rfqzjLz9Ftl2idC8wNScT58Mxpk
         orSSprmCp1nBzX7U1IWjMW1S+n3zjZhEtqa3h1WyU8kVWiDn0u3BzmmzS40tzwS3b79e
         tUrxSi/M5XDtIUH3RrRXBleNK/7t/blTeKZKRnVpuRsXCozScz7sVhl8Rgrn6k2KwgS/
         CEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4inWB9VUllPK2WQJTgUqIr/F3vknOkQcDIJGPHtalLw=;
        b=W8ZIdDrTUlhA3UMgnmpvkZ8AQJpE4TOAJP7qlbzWweVCG1J0up+Hhh2RYErTYV4xDF
         oOjsGF43WLc+9oDLHbXsbz08cMqErUL0+E905KIYdk9wrFHxyTvzrp7QXyqL64ki7iWf
         Ehxy+g97DPOgX88oTG52cfDa9emNkes7E5z8HwJSqR1t9q8wExsHjkYO+AmGram5QAAm
         fYTNfnrIIZvjjUm1qYHBjY53zucKmb08b7m0LNay7605NtYGGokFM1tDE2IpP2IwOUgB
         L/Pth7OHhoqlJA6wV56a3n0Zus/Aj/PacqU00E5/3sJVwbUvT7Ycakr1C+zyDPQWg3g8
         MDkw==
X-Gm-Message-State: AA+aEWaJ9y5WiD/0HYyBxp5uemE8j/wjKixcfXjGb/fizG9vNrks4Z34
        ZyrGPOEhyAVwZ14rCiKzjBgDzgWs
X-Google-Smtp-Source: AFSGD/VU7NRoGgTu8A+EXeyUGz4P1OTHlOa3tTfbs5/zcgNpxOD875zWla9olHzGrFmAFh0B3IvnnA==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr4222297wmj.142.1545158120071;
        Tue, 18 Dec 2018 10:35:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 13/17] staging: rtl8188eu: change order of declarations to improve readability
Date:   Tue, 18 Dec 2018 19:34:47 +0100
Message-Id: <20181218183451.18692-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the order of array declarations in rtw_mlme_ext.c to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 30ae42c17796..d3d211d8eeee 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -23,8 +23,8 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 OUI definitions for the vendor specific IE
 ***************************************************/
 const u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
-static const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 const u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
+static const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 static const u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
 
 static const u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
-- 
2.20.1

