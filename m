Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7976C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634F62054F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLx3NdyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634F62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeJ1FLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:11:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37165 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeJ1FLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:11:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so4351564wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eft9QMieeSDWyxPFMS6iWfKDbE239Uh8QBgvlsrV9wY=;
        b=ZLx3NdyMB+hiHQTZCUdr5VGe6cJbDJBKUuHgBLlhMj4eEwqhkqyC/6v5AW5PMov30n
         gif5B4s8YpFrBRyMgJ7GPbMnl15it077+R7kDitNY9HEFQyshqKejSn/5b5hxXqSM0DW
         X77yFkZIRDOabro/n0lqqQMf60C75tKiKVOwgDpJ5pIYC+JQ1PAbhZ4lGds2XlL0fpep
         mMm/NKmMkf2VCsTOPWxrq/CxBbjtGyQv4beUU9fDJ80bhYOPxa5yc2Tgt9riat7rpS+S
         SBNUniSldvpsnTOQBQOURi5GFtgJAxGRco3ZZ6mQE+hw75pxasz34dSwFvFgmYs3QIZ9
         mffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eft9QMieeSDWyxPFMS6iWfKDbE239Uh8QBgvlsrV9wY=;
        b=l5ehPuT2RVWOUaZ6c23R6vfO9I8NpItY307CE+HnB4ULefzXaTNZnVOPkj92h0BiJU
         WRf6L+7LElLbs0UB2hkHxqIGrJR+GtM/ERndhLlWN8kwDHfH8tK4zSF03zoQ2/oKqq2f
         6QKgmxPmrvEhQaPxHO6L5gdpHiXnsQQpa3TPjhndrALFCJmJzPvKZexcpJE6z9uNmqXc
         WweqJYUuCJYj02AIzfCEbhLIEKYEMaH4qKSoLCWG+J6kQdHfz/PYBKpjhpVMb+xD2G3Y
         hRchsLXaB5ZLvqGysgptY/YcJZK/ch/NDj25AlmCXnkxss8J+m6MXU2unS/HH6pp3Kqj
         pQYw==
X-Gm-Message-State: AGRZ1gJVbKHZZBUqj/4b3udKWbyugBpknEdB2TYUrHxpYzo8D/pJ3TQT
        p6xZ0YoEEKqPVKOSUg9Xx5fl/fSz
X-Google-Smtp-Source: AJdET5fqMkOOW+08fmTgRwCOFbeBAPCS2FoBJ2y0NIDsgeSq15+pmorgI0ziWlS+sxWGRt/zcCz1xg==
X-Received: by 2002:a1c:1694:: with SMTP id 142-v6mr9527297wmw.113.1540672140435;
        Sat, 27 Oct 2018 13:29:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id v16-v6sm5335784wrt.32.2018.10.27.13.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:28:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8188eu: remove unnecessary ternary operator
Date:   Sat, 27 Oct 2018 22:28:46 +0200
Message-Id: <20181027202850.25636-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field accept_addba_req of struct mlme_ext_info has type bool.
Use the value of accept_addba_req directly instead of the ternary
operator in an asignment.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 3e05e2c7f61b..d678dcee7312 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1504,8 +1504,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 		tid = (param>>2)&0x0f;
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 		preorder_ctrl->indicate_seq = 0xffff;
-		preorder_ctrl->enable = (pmlmeinfo->accept_addba_req) ? true
-								      : false;
+		preorder_ctrl->enable = pmlmeinfo->accept_addba_req;
 	}
 }
 
-- 
2.19.1

