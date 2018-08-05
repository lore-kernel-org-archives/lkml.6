Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26770C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619E218DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3vVf/i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619E218DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeHEVLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:11:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38931 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeHEVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:11:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so10284786wre.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fCb5F1FcydG4XRwhuoUj4EZSfDf+C/OcZkcj5fTdYPA=;
        b=h3vVf/i0TOK78B7rAbgKAB8itc0zXMdy0QW1woz3FHFnzLEHik3LvY9kBfF3kV+Vdf
         JTaOeoEKkyATmrzoV7jLf6ccy/PvrEqWkuPJXdXSld9TGPdYYZ7RbYwymvm7zurSlLtH
         LNSW5cG5MriWFuAWBu5oF7BjSmkr8Ui0oSASBYXa2XnCy2zpKz3bgXJhxtLF8RCsYodf
         5If/FsVYEQB1Hwq0iRPhvqKiDzXln89khCknk+a9sdCxqmD8OjOSpuWZgd/tMecgYYIB
         aQiVfhe2INvwEE3hZPM0ROvfanUW/qifmebpODyOGGm+XiOLPj7IXGfq9wTPR/Wds0+2
         bOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fCb5F1FcydG4XRwhuoUj4EZSfDf+C/OcZkcj5fTdYPA=;
        b=aGh4RqB6u5Db4fsWijuUvV7dCS0XSZrIQxFU2Cz3Or2H3iqhPsZRDBNpqz6vsxI/rI
         2GEA+P1Rc2TqjB7JZw7ItQbLWwFnyT72p/vwYQFxzF6r/hlqFNAmRq3oxJ/r0jWpprfO
         r0BtJxQNlJdGG9YrZHqm5bOy0RZWXrkAfRMxSwi3tKt5AQcq4I3Mh+eTJWWBi27LLToa
         5FEyyybJA1jFsomV9FQpNwZT0AOC200O8fH7W7cao8KwEiIkgYq0WrAPIpQiZqQWWBgH
         JqTywVqnHCE/5NUOmKHSSFllgxZf2zZw1coEZDdxU37Ra8HuxILGAMRLxHFvwneJiNWz
         luUw==
X-Gm-Message-State: AOUpUlGX1s2HX8CN1FOxcCylZG9iD/jIpJBM2AqsX3A5e8jnpFUSpg6b
        qRsG+NGOAyyQEr8cofOb09Y=
X-Google-Smtp-Source: AA+uWPziYTybUIkoXrPE6l38houP6y/WmaIWBY1YHX2BRzvH4c5qaa8vZea4xKdpygCM3K1Aj7B8UQ==
X-Received: by 2002:a5d:470e:: with SMTP id y14-v6mr4680864wrq.229.1533495932648;
        Sun, 05 Aug 2018 12:05:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id g125-v6sm4500884wmf.16.2018.08.05.12.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 12:05:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/6] staging: rtl8188eu: use is_multicast_ether_addr in rtw_sta_mgt.c
Date:   Sun,  5 Aug 2018 21:05:15 +0200
Message-Id: <20180805190516.2133-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180805190516.2133-1-straube.linux@gmail.com>
References: <20180805190516.2133-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_sta_mgt.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 53e518148ae5..34c3e2af63c1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -414,7 +414,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	if (!hwaddr)
 		return NULL;
 
-	if (IS_MCAST(hwaddr))
+	if (is_multicast_ether_addr(hwaddr))
 		addr = bc_addr;
 	else
 		addr = hwaddr;
-- 
2.18.0

