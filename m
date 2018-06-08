Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Kvu6FOtuGVu9WAAAmS7hNA
	; Thu, 07 Jun 2018 17:49:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7A5276089E; Thu,  7 Jun 2018 17:49:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUdHHDS9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F05AC60590;
	Thu,  7 Jun 2018 17:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F05AC60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935014AbeFGRtz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:49:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42247 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933071AbeFGRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:49:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id p9-v6so5093142pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1MEFx8OKq4FPi8JwBok+9N4dEue8IfEuoq1xzWB9aZo=;
        b=WUdHHDS9XW5zP+iFAy2nZL7vukklXcnZnc6r0v5Nx7tTW0TFfSuMOM8zcVVsdqeHFu
         SSM4TShOn/f1jt0SmAHzlpKMLNEGwJTrZ/89opNZ3VAxCcMEHuBwZAoh3v1nBqVQhIY2
         3EHqsHKhMPv+3h7I84Dvu5v5gAkXQYEYA6a0WEGgAbV/oB1RR+CzuPNUbxRXzE8mEO1P
         9N9ZnwzsrfaK+acNwPwAuDXRCOBmCRhVDX//uXvAyEyS6kRXOkECGPe4AsOuCQqi8juP
         Wy+UnF+hhXcwUiqqbIxldcFKuiLcy6sPPT2paEUN5UxY7bzu1JY9Se5BIcldK7lm/N7g
         w5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MEFx8OKq4FPi8JwBok+9N4dEue8IfEuoq1xzWB9aZo=;
        b=L4l5M1px5fTZrVpDsKifBYxi+rneg6YVrdjPmoKLN0xqBkgxRiBGy+rpECyHrIP7ab
         gCundMxR7A3tWjvBn61TmC6yjFzc0LTAlr+4IHvBq1t4UYpPuLeUN0XGYxpSFLt7VtFk
         /TJEtTTVXAcyw/beGrEa6RZCnLhz2u0r3prgLflTiEngiPXZPpKIrhlmpzCDR+ENzvgO
         dnFP1NSfhWEckOY9Krix63rWaRdbt1hHX+zQFx5FhCZkiPFaUZdiXCIq3nzP08wTW9n9
         CJlCDi2JHZijMlWqkhZ7vNnX5lzjlvIX71+iHYpYp70UR22DmwFH30+Ck8yS4h+QXi8A
         J4pw==
X-Gm-Message-State: APt69E1c+xyloStZJOE01JwVrBu1o2sEg6FJDLu7TxqScozipLTOXrqg
        9rLH/zt/k/SUzF2rYYjzstU=
X-Google-Smtp-Source: ADUXVKK3nz+E2iXKJVpIrs3yKBqikBev1j8PkLe/M3B1JugnyGqUFoizmq0YYQ5786xTgNo1ZjKoKw==
X-Received: by 2002:a62:9804:: with SMTP id q4-v6mr2674156pfd.65.1528393792079;
        Thu, 07 Jun 2018 10:49:52 -0700 (PDT)
Received: from localhost.localdomain ([27.62.191.206])
        by smtp.gmail.com with ESMTPSA id s17-v6sm117175370pfi.165.2018.06.07.10.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 10:49:51 -0700 (PDT)
From: Janani Sankara Babu <jananis37@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH] Staging:rtl8192e Replace function names by using __func__
Date: Thu,  7 Jun 2018 23:29:15 -0400
Message-Id: <1528428555-7884-1-git-send-email-jananis37@gmail.com>
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
