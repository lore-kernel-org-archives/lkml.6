Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E77ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B5820866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyKR+JIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B5820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeIOIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:06:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:06:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so5105060pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mjALWib+L4hxdbK0MhaulUQlIsQhFr2agUDXPHnudZE=;
        b=kyKR+JIqZu6wDANcAM15G4QAf+ucyiDMqGIEHccSJcDK+XkctjcoVtxwxItJsV3Ixk
         Iz/9VdCJyi7ZvNRrMu7UWbDUhVTymBKsYo8UBa4i1615PxBuMz++GrkrZz9yLxdvz+0t
         SFCpkBHdTNnpRDW6IemgVu+YNgC2a+oQvMMXaUtdJ6pyMCnWwOp9OrMplRrrUQpXhfPx
         hBxLZlh4oypFMnaYOGQXPpR1mpCyLiyPa3/biVKSlB2q3YHyNS1HqgYv8u9CQBcLA/Ir
         e9OYtfRsq44JPMSQlC8jozd2weiCFvdHYu0OT/r/L0HOwqt6jWAbUfo5ETnkqlNXHA84
         lPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mjALWib+L4hxdbK0MhaulUQlIsQhFr2agUDXPHnudZE=;
        b=DAc2KvZW5r7D4MUpdEOJaYxRjUGteMnIaNsXLNA+3Cv+cG/avhOjegEYW9YT6vd6Lj
         KaiCbhrN7hgOmGzKYH5wWOUT4Y4OqT9sYefL5xmda6Tp3HPZS4wWn1bBZX8hJyaQk5b9
         tp/X6Yokfhhv5HN6/plVkV7b8tYRVi9AeYgtcxJL9+Zh+nJQpmgHVT8CKX0slcYtbpTu
         YwNXMzQfYSS7CIXDBIUx2EncmBu+FVYvtysyyluLDb1pdC2dMMcM2KbL24pdMx56r7fm
         +AUkzhg1YNc2d2XBj00Ml7tkuSCaVJ3VbLE/GYh97uMuxRfOBrSGI8bYWokbn37HNP3Y
         Gt2Q==
X-Gm-Message-State: APzg51AY8BMQIp/vSTdoXGH72Q32o3lefr98jTihBh+ij12vKBbsW18G
        wla3Js1uP/EH7nb/MKaGdCA=
X-Google-Smtp-Source: ANB0VdZC9fLn3d1HphQSjygfkZ8DC4I/RIEFvgjaH8AXUvfcCXxZUDhaMbtoQdrXe0N4WSOgYefrIA==
X-Received: by 2002:a65:6109:: with SMTP id z9-v6mr14353914pgu.243.1536979776691;
        Fri, 14 Sep 2018 19:49:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:947c:62c0:a59c:7c99])
        by smtp.gmail.com with ESMTPSA id d22-v6sm18839721pfm.48.2018.09.14.19.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 19:49:36 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, tavery321@gmail.com,
        natechancellor@gmail.com, julia.lawall@lip6.fr,
        florian.harbecke@fau.de, keescook@chromium.org, joe@perches.com,
        aastha.gupta4104@gmail.com, georgiana.chelu93@gmail.com,
        aishpant@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: Fix a sleep-in-atomic-context bug in issue_deauth_ex()
Date:   Sat, 15 Sep 2018 10:49:28 +0800
Message-Id: <20180915024928.30953-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] msleep
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c, 3805: 
	msleep in issue_deauth_ex
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c, 6336: 
	issue_deauth_ex in disconnect_hdl
drivers/staging/rtl8723bs/core/rtw_cmd.c, 963: 
	disconnect_hdl in rtw_disassoc_cmd
drivers/staging/rtl8723bs/core/rtw_ioctl_set.c, 506: 
	rtw_disassoc_cmd in rtw_set_802_11_disassociate
drivers/staging/rtl8723bs/core/rtw_ioctl_set.c, 501: 
	spin_lock_bh in rtw_set_802_11_disassociate

[FUNC] msleep
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c, 3805: 
	msleep in issue_deauth_ex
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c, 6336: 
	issue_deauth_ex in disconnect_hdl
drivers/staging/rtl8723bs/core/rtw_cmd.c, 963: 
	disconnect_hdl in rtw_disassoc_cmd
drivers/staging/rtl8723bs/core/rtw_mlme.c, 2256: 
	rtw_disassoc_cmd in rtw_select_and_join_from_scanned_queue
drivers/staging/rtl8723bs/core/rtw_mlme.c, 2204: 
	spin_lock_bh in rtw_select_and_join_from_scanned_queue

To fix this bug, msleep() is replaced with mdelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0952d15f6d40..bf055935ef65 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3796,7 +3796,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 			break;
 
 		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			msleep(wait_ms);
+			mdelay(wait_ms);
 
 	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
 
-- 
2.17.0

