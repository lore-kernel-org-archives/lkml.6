Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3+z7EvF+GVvBcAAAmS7hNA
	; Thu, 07 Jun 2018 18:53:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 99766608BA; Thu,  7 Jun 2018 18:53:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUpKXWTL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1631A60590;
	Thu,  7 Jun 2018 18:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1631A60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeFGSxi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:53:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42681 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeFGSxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:53:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so6692790pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1MEFx8OKq4FPi8JwBok+9N4dEue8IfEuoq1xzWB9aZo=;
        b=uUpKXWTLLCfsuv6wIU5d/8yL0z21U09SpLrkexYsrF1jlmbOuNOC3W/KM9tvOudcZB
         mA8LeFz8RJl3pBxzT+Y7z1AncjPrIMKTAdRqr+nKhsd5EWB2yxKerlcEFOJJO8+G5OCt
         oJDqLJxRrBm7Gpr+kDJw3RLAL7KaxHL7es5+t4Tx5FZjwhnSv7M3oZRNHRcuq/bWbSI8
         FpFAkgPwKTUGGh8TrOJBOBRxvDja0HqJKtHbUhk04VRk+wWGehIZkkowgJPWpXuxGJTJ
         cBMrTmVF+Pz2yjfwEWkrRdNP30w/SJzJcE1d6s4I3IIQGt8NAI9qZ8qrJ6V9rjUAhY+5
         HG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MEFx8OKq4FPi8JwBok+9N4dEue8IfEuoq1xzWB9aZo=;
        b=pcn9EkXEuUpvn0u6iF1J6RL7ZVO9bn+SeQUivXL/VrbiXRQw6Z9pwtLOqJn+0A3umR
         lKw96+6MoolfdFVZlhAbC/dBPDwGYupzMUkp4lg0x5HJDNfm6rIhEAJ9mn/9TmMAtMnW
         yzDNKlLRtwz41C+BzVu/DOZRkqy5ox9kamlf7OwKS1LybqpiEpw4gtPXDvDfZT+GRgjr
         xMz8RMkEiM5pFesOwRkVFd60IGmQt7GPJ/5x2IAOxqBNVWsQbMXD1IM5RmXpl71POqKY
         xvVoDXtLchUX4rb4+92JRgEd7kTazM/lkdMqJbkiKt209/QF0d59WRbjGX2lZ2CuSe2B
         KWoA==
X-Gm-Message-State: APt69E14KeZ4Ejv21u+lEVkk07qphlLkCis/Uag0NTWD83hJAb5hFzVI
        9rxAcAyTlwE5SfK7p3TaIl4=
X-Google-Smtp-Source: ADUXVKKzAoZoJBAW0KxvpOW7FEgZaZygTuP0oaprVxzI4lL6+wmeVsL3A41Q0a2qp6okm5tzOtOStw==
X-Received: by 2002:a17:902:5390:: with SMTP id c16-v6mr3313178pli.104.1528397613414;
        Thu, 07 Jun 2018 11:53:33 -0700 (PDT)
Received: from localhost.localdomain ([27.62.191.206])
        by smtp.gmail.com with ESMTPSA id t134-v6sm44779749pgb.93.2018.06.07.11.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 11:53:32 -0700 (PDT)
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 1/4] Staging:rtl8192e Replace function names by using __func__ identifier
Date: Fri,  8 Jun 2018 00:32:59 -0400
Message-Id: <1528432379-9605-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is created to solve the warning shown by checkpatch script
Prefer using '"%s...", __func__' to using ', this function's name,
in a string

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c466a5e7..3c7ba33 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -127,7 +127,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	}

 #ifdef VERBOSE_DEBUG
-	print_hex_dump_bytes("rtllib_ADDBA(): ", DUMP_PREFIX_NONE, skb->data,
+	print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE, skb->data,
			     skb->len);
 #endif
 	return skb;
@@ -178,7 +178,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 	tag += 2;

 #ifdef VERBOSE_DEBUG
-	print_hex_dump_bytes("rtllib_DELBA(): ", DUMP_PREFIX_NONE, skb->data,
+	print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE, skb->data,
 			     skb->len);
 #endif
 	return skb;
@@ -243,7 +243,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	}

 #ifdef VERBOSE_DEBUG
-	print_hex_dump_bytes("rtllib_rx_ADDBAReq(): ", DUMP_PREFIX_NONE,
+	print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE,
 			     skb->data, skb->len);
 #endif

@@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	}

 #ifdef VERBOSE_DEBUG
-	print_hex_dump_bytes("rtllib_rx_DELBA(): ", DUMP_PREFIX_NONE, skb->data,
+	print_hex_dump_bytes("%s():", __func__, DUMP_PREFIX_NONE, skb->data,
 			     skb->len);
 #endif
 	delba = (struct rtllib_hdr_3addr *)skb->data;
--
1.9.1
