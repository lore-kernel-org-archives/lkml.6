Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD22C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D062073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROW/twvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D062073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeH3SIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:08:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42079 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbeH3SIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:08:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so7399457ljc.9;
        Thu, 30 Aug 2018 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SWU3YA6rp5Zxn6M8r34q9FmGlg4VWGf6JWI6inQVZVM=;
        b=ROW/twvBxbYZW4KEplRW8jFQDXI3ejvBSy7eaCVBfBECqmS2V55Ivy47TLq89HRQYZ
         45UTfd23Dkpg/U0craxCTlpKsMQ6uZYy1fvJ1BM3iaEcGAvbqdHQ0WAs2e9xPL3KiQS6
         ZPIs3Dl2ZUPHwOU2K5+18X0mVH6iZ7ahAH+KEwqMz5HboAij3ABYUCr1kQUB/svFlrRN
         tin1kvGbePi7h2lY8/aHcTnKdjaoWCE6LXdm2+Yh8dZIVtgss707OSenDqOfiUtQjCgW
         meZwffo7vVSE/yx/1+YxtJ4DzePB+JwA7GoSPrVQOftkJAKTeKVUK09msC/CgP4JdEgg
         +BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SWU3YA6rp5Zxn6M8r34q9FmGlg4VWGf6JWI6inQVZVM=;
        b=RgU9JbuIqdOVi4g2n3pI8wPyGU5jdKS+LNM9bDZXA3DZ2cyC+ayw98IRE42C5NDpnY
         /pDKNXlxa9YrtwkThMibCXdK7p+2fs8YW3SIujhtKSNDDnYXeADV0JPITwoXfXxTAIY9
         Y+6gkqRJlqv92nuQQnXg8ozFcBoGTqR+yXQfAwKvKrHxYoS4y1YXMWpMcHSNGaBhgYKm
         GGoNf3msEkDK4fRgyDhRA11HmQ0gBlYyKqnLwiraFbMakcNBfOJyE6F+OoGJWSutXsgp
         pBFAZaBWttTX/ERVmAMC1upVUrufmlEHl/lCiQO8BOTduYszmRg1yMlB7/ucZ9v1tJaZ
         0d9g==
X-Gm-Message-State: APzg51AnmrF0RBL+cfm/GdBLDFAnknGSi1HSHX64iOeSIPqwf/QsZinl
        bvJUNDaoN7GWyGQLNkOZZq5Qlns=
X-Google-Smtp-Source: ANB0VdZcBnPH0wVTi/kmJ0ix6hK6BmoLDw8dOTWK18FTC/NfndMpIp6z4QEaiR1sFJo8Lzw+4Kz1LQ==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr7344174ljh.6.1535637979272;
        Thu, 30 Aug 2018 07:06:19 -0700 (PDT)
Received: from natsu.teplo.pdc (mail2.teploobmennik.ru. [95.79.26.27])
        by smtp.gmail.com with ESMTPSA id s74-v6sm1312464lfg.79.2018.08.30.07.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 07:06:18 -0700 (PDT)
From:   Aleksei Mamlin <mamlinav@gmail.com>
To:     Jes Sorensen <Jes.Sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH] rtl8xxxu: Add rtl8188ctv support
Date:   Thu, 30 Aug 2018 17:05:41 +0300
Message-Id: <20180830140541.31964-1-mamlinav@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek rtl8188ctv (0x0bda:0x018a) is a highly integrated single-chip
WLAN USB2.0 network interface controller.

Currently rtl8188ctv is supported by rtlwifi driver.
It is similar to the rtl8188cus(0x0bda:0x818a) and uses the same config.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 505ab1b055ff..73f6fc0d4a01 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6231,6 +6231,8 @@ static const struct usb_device_id dev_table[] = {
 {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3308, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 /* Currently untested 8188 series devices */
+{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x018a, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8191, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8170, 0xff, 0xff, 0xff),
-- 
2.16.4

