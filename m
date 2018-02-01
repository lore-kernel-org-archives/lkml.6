Return-Path: <stefano.manni@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517512503; cv=none;
        d=google.com; s=arc-20160816;
        b=IterOEM1oWqlKQjIN1CuUTjukidH8Agrjg4QfULxAbBvcnrcjMpKUABy6cZIJfCcLz
         E/EgfZgGnHAhPXw35Yibu1lUmuQWeynx9ZUrqUOQKzt++2CI7UX8Q3NXrPdol/hrkf0R
         XsI3P/KNVrGGdsiY/C45yOEtD3czAnNfNaiNBZZGaEJ5L+RAAnkqveq08j0DmmpMVSJK
         ZLpuRzUPVx0Q5JuF5zSKQtfHFq74BEfNr7EK98tRsnw2DfCDDSMLH1nHVA1G8oax6v1r
         ULd6BJalpxk6extQXvCqUzlGE2fQETNeB73a6BCPN8HNMfVghP90qfIcccmMsMUPUcgu
         0CoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=p83qmBeGAQ/d12XvTyXM5yBzZKTRzeXBrdukmuEwou0=;
        b=kww7j9X3sATbzPxKXVJznWxDFg+oLp2SzoxIlsYJp5w3rS2UP6oDsabgzJdL8cS9yt
         5mk61fCtjKDmRxzvMQ5+p8Tmkzk8thCamW3zXXN4uT5kLoLC0SB+K2lbt/WAM6pQWaZT
         jtisCLu+EBXQeYevvzJpiRG/hOFlSkcIvysR1InvV3/5yNqhFq8R6D8Z3rgC457iwNO3
         qUckvdu5z4jra8FC26/LN2rqRGsfgNb30NH45x3ZQ2WtulVex/kMrtMpp7YbgLVWJgfh
         RNmxeDhMKAxgIbhtqZhVV/IHxfeOqgBxsyBvl5rFwUsWBfSDph1pkpZOxh2swMu9xg57
         376w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U7KKZURm;
       spf=pass (google.com: domain of stefano.manni@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=stefano.manni@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U7KKZURm;
       spf=pass (google.com: domain of stefano.manni@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=stefano.manni@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226R7RMbFhUQUvjLyjRu1bYIOqLU0msltrQYNr0UVvdhRq2v5zVV6Lx5QRz/XQWlDzVmb/DS5A==
From: Stefano Manni <stefano.manni@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 2/2] staging: rtl8712: fix signedness of length to rtl8717_set_ie
Date: Thu,  1 Feb 2018 20:14:53 +0100
Message-Id: <20180201191453.4611-2-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180201191453.4611-1-stefano.manni@gmail.com>
References: <20180201191453.4611-1-stefano.manni@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591227191128320280?=
X-GMAIL-MSGID: =?utf-8?q?1591227191128320280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

rtl8717_set_it() takes an unsigned int pointer as length,
fixed signedness in code using it.

Sparse warnings:

drivers/staging/rtl8712/ieee80211.c:191:53: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:191:53:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:191:53:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:197:57: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:197:57:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:197:57:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:199:63: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:199:63:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:199:63:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:202:67: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:202:67:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:202:67:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:206:73: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:206:73:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:206:73:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:209:75: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:209:75:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:209:75:    got int *<noident>

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 35e29112006b..5095af13a6dc 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -166,7 +166,8 @@ static uint r8712_get_rateset_len(u8 *rateset)
 
 int r8712_generate_ie(struct registry_priv *pregistrypriv)
 {
-	int sz = 0, rate_len;
+	int rate_len;
+	uint sz = 0;
 	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
 	u8 *ie = pdev_network->IEs;
 
-- 
2.14.3
