Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F71C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B89721582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j73wiH89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B89721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeKNFfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:35:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeKNFfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:35:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id y3-v6so14622450wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UtKKgibYbN9+8xoPeGbKs+nomifQiQH74EyGSmoPWEA=;
        b=j73wiH89Hf+CkkdEwbRdt90Ypw/HGSwRxrpXEki+5lSuqj4Y41+6I/EMMACprq2DrK
         yGjE5pjE9xcuGXFXIcKGGE/4YTR1/jb7RXdtPN2s/yVejulkzw/BUeL6Zm058mNqGh79
         PGcZsxwztZ0e/7EP5xnwhr/4Oa6Js34+H8CPK4gby10Qxdduf2XUJkRx3tuX3fNfP3fi
         z/GqgQ/zk03DQ47961u+OK/J5GRJunF0K4sYEwf3dUkUc7+ZaSVU0E509WcjcnKst4sl
         nJh8xpCYNfUFdT/ZLtnT7GstUKpScMLVvtfOC0inx0/vIy1/VEBRewFvhCeFaYJJhL+K
         ahZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UtKKgibYbN9+8xoPeGbKs+nomifQiQH74EyGSmoPWEA=;
        b=f6ed1ZmSbYaHM0xlw+UZ4/TqtaHhHoRJGo5Unuz3fXMtAVpmlsAJ0RI5aoeOuHhlup
         nQuEQzXkZ/F0AbASQoczmGkQiAHGaCuzqvIZt4e8FWKSiKVejlHLeQqeeS14IHYxL2p6
         LRzThLgxmc8OFAbDleYaq941F0sak+eGPuzRklPZV8y50qrAgKVgeaRElrhWBZQE1Y3d
         dh4EpIYDm9PWPpzb9PZBXY3EmQh+l9mXI37VnLpU21VK/vHyuQuABrKFmbvBvfMMdcgy
         ui0fP7MUBSZeWTUrnQ+8HhGy5T4S4Zk95/o9r65KvdyHe6ZAYOUD8VI0kUcE2Zc2L4zz
         61cg==
X-Gm-Message-State: AGRZ1gKdHDvNzS7Datx+pg5Zv7boJEc2Ia/Us9j6eI9r4tuPPGET2XwK
        9tKRTvOUl/mrQB2FAkhlfPc=
X-Google-Smtp-Source: AJdET5fmVSRtVngu+1RmJuUZhjRlrZm8apGLtPnVlK+U/Raev0isT1MY5/4lnqCaxCBGjAwwr2c0fg==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr5952645wrs.44.1542137729672;
        Tue, 13 Nov 2018 11:35:29 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id c14-v6sm14510237wmh.44.2018.11.13.11.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:35:28 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: rtlwifi: Add new line to stay in 80 characters
Date:   Tue, 13 Nov 2018 20:34:39 +0100
Message-Id: <1542137679-31726-3-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542137679-31726-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
 <1542137679-31726-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is sent to next line to stay in 80
characters

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/rtlwifi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
index ca37f75..a990281 100644
--- a/drivers/staging/rtlwifi/core.c
+++ b/drivers/staging/rtlwifi/core.c
@@ -1882,7 +1882,8 @@ bool rtl_hal_pwrseqcmdparsing(struct rtl_priv *rtlpriv, u8 cut_version,
 				return true;
 			default:
 				WARN_ONCE(true,
-					  "rtlwifi: %s(): Unknown CMD!!\n", __func__);
+					  "rtlwifi: %s(): Unknown CMD!!\n",
+					  __func__);
 				break;
 			}
 		}
-- 
2.7.4

