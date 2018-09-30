Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C98EC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341802075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXtT3DbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341802075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeJAC14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbeJAC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so11508174wrw.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ekz7I1l7aFO/kDmgxYdvgPP0OU19HTcgWVQcWRwFIkI=;
        b=qXtT3DbAWxVZNjfEDZrVBi0+OKN0rZKgPH5CnkDN0k9HPcZ5whnn5IOy5XG0lJbDZT
         ZLcaMPpXjrsiDM07C48sUPObPctzmlcTVcz8nojcAtP7q9NooaVTdGvPUaN+YiOXOAJb
         sFxqV97Jqnsa+tX76PKnOqKOqwzV2m4xyPlM0ZkqDdVWh97TFNTVonSlbNKrjpB0z80U
         PKHV2jr62odtZ4hTl4N5Nz5HcNX+1bC46CN82r2pkNQArsri54CSyAn784slTq8LB6bH
         hkMG9yx88pBP/j/N0ggt3FcJpYnXvvbKPrzUA2WStkO+jyk6v2daZn9mli3ZFs5KbQ3t
         1ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ekz7I1l7aFO/kDmgxYdvgPP0OU19HTcgWVQcWRwFIkI=;
        b=PQwiUOQPCShH7UPtIgwi8H165mdrBdNM/HrIHmo8IVbH2wkQ+a53CG/Pj5tVf4ofqk
         b5eA8Sun7TWZMg3BespkJxyJ4ifBHcSmmX2nd/pb1vcr+ywS9w4bnR/kgND5u893p9OW
         zrlr2SEZxkUGZhYs1vMkFMELrDWkcO8isxinS7rBNGSJ+2W4/OPmdMGYgQ+mmtp+/s9Q
         SVq4DJzY0of+FGcg1okjaWJc7y8WUraY+Es8tURzHIqRyUHmqvgnvw/RCCEAKbmcIjJy
         2eSJfh3TQYR3yreii24MIj5ujiOhg6L+j9DRVy56Xt2xEVHbHUEMDmmKSfXv1eK2J/o0
         xm/w==
X-Gm-Message-State: ABuFfogt4CovEutqy0etM4OGF8P9j3jacUvQ6OgVWk0d9keo/s53ePAs
        M4viXQKleVPoYW9OeuiO4nv+evdf
X-Google-Smtp-Source: ACcGV62ZT8/03LKpzzndiqSmaaVroKLue3YkW2CRRYqcmwliBg1OE9saONnFepejizEgeLuQtjik5A==
X-Received: by 2002:adf:fec9:: with SMTP id q9-v6mr4464149wrs.164.1538337215218;
        Sun, 30 Sep 2018 12:53:35 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/19] staging: rtl8188eu: add spaces around '+' in fw.c
Date:   Sun, 30 Sep 2018 21:53:07 +0200
Message-Id: <20180930195310.1531-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' in fw.c to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/fw.c b/drivers/staging/rtl8188eu/hal/fw.c
index 1b8341f40995..486ee4bd4744 100644
--- a/drivers/staging/rtl8188eu/hal/fw.c
+++ b/drivers/staging/rtl8188eu/hal/fw.c
@@ -98,9 +98,9 @@ static void rtl88e_firmware_selfreset(struct adapter *adapt)
 {
 	u8 u1b_tmp;
 
-	u1b_tmp = usb_read8(adapt, REG_SYS_FUNC_EN+1);
-	usb_write8(adapt, REG_SYS_FUNC_EN+1, (u1b_tmp & (~BIT(2))));
-	usb_write8(adapt, REG_SYS_FUNC_EN+1, (u1b_tmp | BIT(2)));
+	u1b_tmp = usb_read8(adapt, REG_SYS_FUNC_EN + 1);
+	usb_write8(adapt, REG_SYS_FUNC_EN + 1, (u1b_tmp & (~BIT(2))));
+	usb_write8(adapt, REG_SYS_FUNC_EN + 1, (u1b_tmp | BIT(2)));
 }
 
 static int _rtl88e_fw_free_to_go(struct adapter *adapt)
-- 
2.19.0

