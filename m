Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F951C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D740920869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/0Fmcm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBIAPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:15:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51324 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBIAPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:15:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so6309441wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wyReugPXrxIiS774VlKOeus0XlUa4VY30FlEPNXHAyg=;
        b=o/0Fmcm87YMga4x6C8XfsoX8sIlAjswRgK2YhRPfwuCLV30yCBSIuRJJ7QiIOWCfMN
         shWksOAsWQzyvXB8ucSAmGGU/ys+uWb+updPeL1B8hzcjpHqLV7KtZdhMo/QLscK43sP
         /5InNCTrYlIX3rt2xxFw9+gbV33Fx+/NJm9h4s9sNrPUgWACHNAHypWpHo62L33E8geb
         ujAdHjZPC7BliI8jnvA3d055z09KOG0ozRmKuQp41AOQO49Msf3YVIds2rstYGXGagsI
         eSl/iGRpaj9xauF3OvRPFJlbceqbUWY51LtJACO5+mFhkaxaD9mkl0uiLB5r91RMtGlR
         BpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wyReugPXrxIiS774VlKOeus0XlUa4VY30FlEPNXHAyg=;
        b=f0JKEQMnfQYCyGr+6Tew/MniUofdmPmzluS3CGtMhLjpv5QDe41pPmsGs6MdZK2UCS
         KYPu4VkhTrmgQnY6QOn69v4MWuInIJAY/4Y5l/40sXuWQOcrxW6dZj3ziMVu2farzn/n
         Qn71Y0l6E1wi3QMnQ3i8hSPjwlnu0NnurKLuEkZjpisAd87chmiYsvRrKk48lvvrtZBA
         AKbvPBJg4iMRbLkfzVaLY5BnCmcAHcJIUakKL7v9LFJynAIiKipagZz0I2Zpq+WMYUdB
         TdMQ+XF5R5vuQTskMCe1JQwBnpj25cbKPqVqY9nvIV+Uim032SGMxYpOW4bL0aDrkEjF
         nZ9Q==
X-Gm-Message-State: AHQUAuanrD6JmR11KEXtlXa/80AJuv+c3vZC94NbNz8Htam7ch91s6y0
        g9mKHGRKuu/7kQPkEgkQS8U=
X-Google-Smtp-Source: AHgI3IaLHeZcarkdZ3PF4sPwwSjv5yRWS6VT3DwNGORZBkPmscnJK4AZNciQMHhzXRGY+DRNB+oxKg==
X-Received: by 2002:adf:f692:: with SMTP id v18mr17492386wrp.229.1549671329355;
        Fri, 08 Feb 2019 16:15:29 -0800 (PST)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id o64sm4975481wmo.47.2019.02.08.16.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 16:15:28 -0800 (PST)
Date:   Sat, 9 Feb 2019 01:15:22 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Robin van der Gracht <robin@protonic.nl>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: ht16k33: fix potential user-after-free on module
 unload
Message-ID: <20190209001522.GA11769@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On module unload/remove, we need to ensure that work does not run
after we have freed resources. Concretely, cancel_delayed_work()
may return while the callback function is still running.

From kernel/workqueue.c:

    The work callback function may still be running on return,
    unless it returns true and the work doesn't re-arm itself.
    Explicitly flush or use cancel_delayed_work_sync() to wait on it.

Link: https://lore.kernel.org/lkml/20190204220952.30761-1-TheSven73@googlemail.com/
Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 drivers/auxdisplay/ht16k33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index a43276c76fc6..21393ec3b9a4 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -509,7 +509,7 @@ static int ht16k33_remove(struct i2c_client *client)
 	struct ht16k33_priv *priv = i2c_get_clientdata(client);
 	struct ht16k33_fbdev *fbdev = &priv->fbdev;
 
-	cancel_delayed_work(&fbdev->work);
+	cancel_delayed_work_sync(&fbdev->work);
 	unregister_framebuffer(fbdev->info);
 	framebuffer_release(fbdev->info);
 	free_page((unsigned long) fbdev->buffer);
-- 
2.17.1

