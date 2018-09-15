Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D7ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7F6208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnMm9nfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7F6208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIOIOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:14:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44185 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:14:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so5096139pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L/0FKHfIVHp1A+WUApz6gal7yjhpZvGnhuBwXrnvVik=;
        b=bnMm9nfjU9v/gBcTDyvxSunD6Ts/LAhXfvNMdEMw76mMO3FRnFVvcSQ9wOKUa2CCe1
         H7Yv+RvKWvtFPK1T25U2BVQypBHRjMaTsMOCWx+UBI47PHFAVqfiXACMaYOak9tyj6l3
         /6xde8qoIkLTZJXMlY/LiEPTslPBv0yuNN0XN1EWp66+iR6YvfiQv7K2MaYqVn4acU4h
         wfBLR6uo7b8Q4gLYp1Eqj6WGK3FVPsS4+/COrwnRI1+s71j16hcH2PR2ptUtHD1Xhgru
         X/acpvp4DvbiUEbhmnygai+HE6Aw+7XnJ79a924aDX6UDX/KIwvm8UthOzSveh2N8VEB
         xzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L/0FKHfIVHp1A+WUApz6gal7yjhpZvGnhuBwXrnvVik=;
        b=Yic+KqGpZI0aGlyeU+hX6RCJsJs1tS2XzNPKeZiowNcDxBkJS8bTGjHFaQUNcR0aU8
         8hFhI5irCuuGMHe2XB6B1lEBN1awpxDtwkXEt/O06G4OpLcxRxxGZhqcbmGzcfnkQAwM
         f6OCfMu3z5Xql8bxee1i29uZ16NiG1mGxX8wEc2lR67NYEFK8YxJDI4hHgAaSYJEWOOg
         CdVz7ag70xc+kHOHPf/y5URtoZweASFhuCd7BzJHUWWo1Nw1t/WDaJ+mXSEsvV7KS3BS
         5fBRUgiDKsytir/6IirBRwrRywqyWslX0ljSssBg9ApUqeFazlOX8kXrs9AvFUAxpc1v
         d70Q==
X-Gm-Message-State: APzg51ApBAK4Kzj2maBkLZf8C5FD25mjmEG38Pq0z8GV85xdQb1B67jw
        4L+RfDdcQWCLvLLVzoY86Ls=
X-Google-Smtp-Source: ANB0VdZ2dF5L3lelzg3YiyC+m772D3VffUQ7tLkCHw3DKv2p6kRJZ5ERnHhKi84KoQQw7NP7vtuyeA==
X-Received: by 2002:a63:ee56:: with SMTP id n22-v6mr14250119pgk.402.1536980246707;
        Fri, 14 Sep 2018 19:57:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id 143-v6sm11571316pfy.156.2018.09.14.19.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 19:57:26 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, aishpant@gmail.com,
        straube.linux@gmail.com, santhameena13@gmail.com,
        jananis37@gmail.com, keescook@chromium.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Fix a sleep-in-atomic-context bug in issue_deauth_ex()
Date:   Sat, 15 Sep 2018 10:57:11 +0800
Message-Id: <20180915025711.7414-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] msleep
drivers/staging/rtl8188eu/core/rtw_mlme_ext.c, 1536: 
	msleep in issue_deauth_ex
drivers/staging/rtl8188eu/core/rtw_mlme_ext.c, 5110: 
	issue_deauth_ex in disconnect_hdl
drivers/staging/rtl8188eu/core/rtw_cmd.c, 521: 
	disconnect_hdl in rtw_disassoc_cmd
drivers/staging/rtl8188eu/core/rtw_ioctl_set.c, 352: 
	rtw_disassoc_cmd in rtw_set_802_11_infrastructure_mode
drivers/staging/rtl8188eu/os_dep/ioctl_linux.c, 1002: 
	rtw_set_802_11_infrastructure_mode in rtw_wx_set_wap
drivers/staging/rtl8188eu/os_dep/ioctl_linux.c, 988: 
	spin_lock_bh in rtw_wx_set_wap

To fix this bug, msleep() is replaced with mdelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 1115050077e4..f47d83e6dfb9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1513,7 +1513,7 @@ static int issue_deauth_ex(struct adapter *padapter, u8 *da,
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			msleep(wait_ms);
+			mdelay(wait_ms);
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
 	if (ret != _FAIL) {
-- 
2.17.0

