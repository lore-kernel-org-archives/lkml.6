Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D4tRDSzMHFszLgAAmS7hNA
	; Sun, 10 Jun 2018 07:10:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9D679608BA; Sun, 10 Jun 2018 07:10:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdRmpZvi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2F90D606DD;
	Sun, 10 Jun 2018 07:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F90D606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeFJHK0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 03:10:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45383 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753722AbeFJHKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 03:10:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so8621734pfo.12;
        Sun, 10 Jun 2018 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7LZwXe/N931nWnf1U4gEmmuEbRFmdZoEZUvI1dpGlf0=;
        b=HdRmpZviCXTygLh6YYs+WHpZJhj+ClpO3tdhDUKIqsvjCXi0OF+iCkQ/nxfwmSjG/X
         1XJg6tUSET4f5ZWbz8CZopa0snrlHvpHDqrCO/9sY6hYDzYSu/Vw5CjFmhZmzHDGRxuU
         RuIwk+YTx4unMGkTzBxSmkkaGxtm26nGvjGjnDLPcLXw8QXHGLza459+J6/bW2SH8XoW
         MnU99Xk210xoOaaysrUEesYUZf/0feq5/BDLFSMTbmxAMckyh3w3ANkZ95VaOzIcJw1K
         InrrVYegPC/53SWdSahSNubufXBpWCShkwLK/OIoEAH3pnnQUgp19In0HE7gnI6D8Yq1
         bJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7LZwXe/N931nWnf1U4gEmmuEbRFmdZoEZUvI1dpGlf0=;
        b=KWtNOorDfRoBQyeyx9lZt/v9xhr9tZzK0WGJaZ1+b16iZXeC01ic8W8130U5OMDSR9
         ujLSIeI+/KSwPGmgIe40M63OHKtD5z1yumB+KO0Q8f61a/Yu3+brZeaTjyjxX13TA6iV
         htuDoyUpGxQsaORiO9Eg2ey5xal2HcTYusDx70jpNaYyCvI1uV2IXZBv4EzKqST659lF
         lTUCTUG7JQYxRjzB9HnUpJVjGbYRi59qqUohaMdzVkARlZzHM2uXmNiTfUoxQ9Se8w3f
         hkNVq+5TPpbpozEcXN6zPlynwAeh5ie9mTaDiUXwuCk/GvbvolbnidxVEuXINfxYnW8z
         3ncw==
X-Gm-Message-State: APt69E37WXYkP/HOLz26iK7H4xQOYT8dWVC2nthPwUslNJNukMkl7pG0
        UTYots0LxWmBSIIQmyxxZAaeoHLh
X-Google-Smtp-Source: ADUXVKI9x5fm0z+8sxuyA1qhZoH6KJFcpooxnmqeL1WsNdmV6fU2X+rgWX/sPEj1vxOamgf8heNIzA==
X-Received: by 2002:a63:931c:: with SMTP id b28-v6mr10836418pge.167.1528614623964;
        Sun, 10 Jun 2018 00:10:23 -0700 (PDT)
Received: from nishad ([106.51.24.189])
        by smtp.gmail.com with ESMTPSA id e189-v6sm25943278pfc.134.2018.06.10.00.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 00:10:23 -0700 (PDT)
Date: Sun, 10 Jun 2018 12:40:17 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: Fix type of argument in
 ieee80211_is_action()
Message-ID: <20180610071013.GA8771@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type used is unsigned char but expected is restricted __le16.
Warning reported by sparse. Part of eudyptula challenge.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index e248702ee519..745bf5ca2622 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1431,7 +1431,7 @@ void wilc_wfi_p2p_rx(struct net_device *dev, u8 *buff, u32 size)
 
 	freq = ieee80211_channel_to_frequency(curr_channel, NL80211_BAND_2GHZ);
 
-	if (!ieee80211_is_action(buff[FRAME_TYPE_ID])) {
+	if (!ieee80211_is_action(cpu_to_le16(buff[FRAME_TYPE_ID]))) {
 		cfg80211_rx_mgmt(priv->wdev, freq, 0, buff, size, 0);
 		return;
 	}
-- 
2.17.0
