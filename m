Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F2A21582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAvmAWpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F2A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeKNFfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:35:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:35:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so14608096wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N45uGwJI7bHihKcV0BSRFkJtCHSHOvuo/6e+W8z1m9k=;
        b=OAvmAWpmF2o+Fpg4Pnw6qu3ARRtaDsJAqpVgzQ9cVtk/iZ+tNIZTvHltxE2H2d5Oa7
         pLxd+hL3rb1yTlMVfOi8cY8K1hi+IIuQK3iPknUZ0aznqdNi0QWMDpTgpTSiOge3Ihj9
         tK+hcOu30HHY8T9XhIThaeLPloPpwI3oaiRrI7sjCdddq0VzeK0+tbuLuBF/rn6oSslV
         QrAazZdcLPiUs4Soz5h6oKY4Wrpox4DLR7Fd+8eTb/BUw+pPuXp+3kdWFh8e/p5Dc4a8
         h00fZmedAEPAC24f8A9JAlFoAoYYj+ILBkvZT2lVzogLMJCzqUMaQsUQUM57OxeLjbw+
         L08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N45uGwJI7bHihKcV0BSRFkJtCHSHOvuo/6e+W8z1m9k=;
        b=pSo3TNTP3JIqhYMww5CuupdLc+yaViAWRV5u6OtcpEAuHtggDOiZcO5LFYHpUs0qAg
         iqiR9lzaLhqb6XDIPcU3MTQz9hdMTX0CoSkkaWCja5S1G3PKgOhtU/v8wdhxPK28ston
         slSpmsnUYbGPf+W8xuv8ex6P6c044VK/T1h5vAHU1Hh9s400Yg8yE9i6+a6S+/83+LF2
         95FIeuOLs1Y9THMOhwR0oIs7B7lEfE9tSdc5Q7aT70AYsjXOJ7F5FehdsJx3t4atXLNf
         ylDLJpX0cFvSwOTkqU27CtSFskFJCkFak127dBaJ+NoJH7Tw4Psq5xshQ6WT6vYxosQN
         /D7Q==
X-Gm-Message-State: AGRZ1gJUmjX9PUZdvZLmfCX4J3NrGmPxuli1iO95adkrEIlRGzQOOW/H
        y+J/WKY09gRY8piZMlgiinI=
X-Google-Smtp-Source: AJdET5fkAjPxfsX5H+eBEQ24Bj5mGVULU6kWu5FZwucCUQuP8rXm8fR0u+/2mTxhPqrwu0PdEcOgEw==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr6316801wrx.171.1542137727292;
        Tue, 13 Nov 2018 11:35:27 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id e10-v6sm26269231wrp.56.2018.11.13.11.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:35:26 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: rtlwifi: Add spaces to match open parenthesis
Date:   Tue, 13 Nov 2018 20:34:38 +0100
Message-Id: <1542137679-31726-2-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542137679-31726-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542064736-27655-1-git-send-email-sicilia.cristian@gmail.com>
 <1542137679-31726-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added before parameters some spaces to match open parenthesis
on previous line.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/rtlwifi/ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/ps.c b/drivers/staging/rtlwifi/ps.c
index 0ca0532..5118773 100644
--- a/drivers/staging/rtlwifi/ps.c
+++ b/drivers/staging/rtlwifi/ps.c
@@ -245,7 +245,7 @@ void rtl_ips_nic_off_wq_callback(void *data)
 			/* call before RF off */
 			if (rtlpriv->cfg->ops->get_btc_status())
 				rtlpriv->btcoexist.btc_ops->btc_ips_notify(rtlpriv,
-									ppsc->inactive_pwrstate);
+									   ppsc->inactive_pwrstate);
 
 			/*rtl_pci_reset_trx_ring(hw); */
 			_rtl_ps_inactive_ps(hw);
@@ -291,7 +291,7 @@ void rtl_ips_nic_on(struct ieee80211_hw *hw)
 				rtlpriv->phydm.ops->phydm_reset_dm(rtlpriv);
 			if (rtlpriv->cfg->ops->get_btc_status())
 				rtlpriv->btcoexist.btc_ops->btc_ips_notify(rtlpriv,
-									ppsc->inactive_pwrstate);
+									   ppsc->inactive_pwrstate);
 		}
 	}
 	mutex_unlock(&rtlpriv->locks.ips_mutex);
-- 
2.7.4

