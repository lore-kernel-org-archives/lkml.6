Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9073DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B09208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueEfX4YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B09208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeFTC6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:58:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47089 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeFTC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:58:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so823402pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9a6e6R658LXV+18WbeRydHx1KHp2v/X+TL3DzccSFoE=;
        b=ueEfX4YK7MIY+WKFZf+L1rIPgefFaMEJP0LZcuhPcQxyFGowAAKZZS7a7PgxAr+6Rq
         LSUFZs9SDJfwd1m0II15ISwhkoCtgGFO9N36Xr0eqBYLgPbaPCQORch5D1EKFR5OezrV
         sBwMbXMp5TjUfK1fY3+bl7YAo5VWhKusslY/fmkmt/UWQQu21ONOmNSJDk7UKBPUf2J2
         DZfFrtOpwmAtBVpnhR8Edu8D7lcfZCENV3XaakbTglm92KOWO9Lix41+82bDmcBWdX/F
         rkl5dPopUpPEW7vONe+pywd/4CiNUL5Nzk8bBZxmtDax7A97ViAlpYj768HVPEH+8IVa
         3Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9a6e6R658LXV+18WbeRydHx1KHp2v/X+TL3DzccSFoE=;
        b=QgEp3e+AfLDEzG5VUinRRtKRAIKr5J5mVmEPgsz1rQ4kpec7ZXk9BF7CsSb2RXRX8d
         O8XkuK6agEbf9wCuM8AgAioGYFkoh++iaeOvRBa+7bG07iW67LoKG8iRv5GVrkH+mVbE
         jaFFGmmvB89IWBHw7EYXVTo3a3PYvXlQfec78MkdiwnGAS5kc8A2w2eYL35WRVbu1k4p
         aaK52fHMSKol2HUCJyIm0/P6HLMzMJMqvQ/kgzmY3V5L1zwVx7WSNHBaQWqHhltlgHon
         YH/RBgBLdp+LTW61ySoU4Mvt574Q+4fO7ndB8YFKRUXxHmcseFzuHjuaFzW0OtJcQ152
         RlTg==
X-Gm-Message-State: APt69E2fHn2pHsaWZg2R98DiaEfU9gQnXauRDV+zJfn3B2qhFbAI2dX0
        FlphJBQVKQgVdD2KGDhA6iE=
X-Google-Smtp-Source: ADUXVKLQIictYKjYigU0bzNmDXqfYH828rROtf7enobvnZhGw4hnJkU2Dy0h6k/5v61owuRz/NbEhA==
X-Received: by 2002:a63:755d:: with SMTP id f29-v6mr16974131pgn.278.1529463495443;
        Tue, 19 Jun 2018 19:58:15 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:d85e:ce7f:5f7a:fdfe])
        by smtp.gmail.com with ESMTPSA id s134-v6sm987935pgc.30.2018.06.19.19.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 19:58:14 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        garsilva@embeddedor.com, pkshih@realtek.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: rtlwifi: Fix a possible sleep-in-atomic-context bug in _is_fw_read_cmd_down()
Date:   Wed, 20 Jun 2018 10:58:01 +0800
Message-Id: <20180620025801.30956-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.16.7 is:

[FUNC] schedule
drivers/staging/rtlwifi/halmac/rtl_halmac.c, 884: 
		schedule in _is_fw_read_cmd_down
drivers/staging/rtlwifi/halmac/rtl_halmac.c, 912: 
		_is_fw_read_cmd_down in rtl_halmac_send_h2c
drivers/staging/rtlwifi/halmac/rtl_halmac.c, 907: 
		_raw_spin_lock_irqsave in rtl_halmac_send_h2c

To fix this bug, schedule() is replaced with mdelay(1).

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtlwifi/halmac/rtl_halmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/halmac/rtl_halmac.c b/drivers/staging/rtlwifi/halmac/rtl_halmac.c
index 66f0a6dfc52c..e921a62e72a3 100644
--- a/drivers/staging/rtlwifi/halmac/rtl_halmac.c
+++ b/drivers/staging/rtlwifi/halmac/rtl_halmac.c
@@ -881,7 +881,7 @@ static bool _is_fw_read_cmd_down(struct rtl_priv *rtlpriv, u8 msgbox_num)
 		if (valid == 0)
 			read_down = true;
 		else
-			schedule();
+			mdelay(1);
 	} while ((!read_down) && (retry_cnts--));
 
 	return read_down;
-- 
2.17.0

