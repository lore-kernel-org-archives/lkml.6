Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF001ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7646120C07
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks2Yrcsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7646120C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGQCkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40587 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbeGQCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so13843070pff.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TftPCUPwfmc5ZcdU96Tn9M0gpvgY383LiLn7FPvDdEE=;
        b=ks2YrcshbXS2aML5D6F7ywX+6q4zSdJeqYeND/GOyKxxc2jUbdmYBuSiZGRfEebiyq
         19KWX57HygcBbOYhMcsBpn2XFLKs06Is1Q2fsTMq7m72mjhs8MdPZT4MqO5RU7it2wU7
         iA9B1wcpjVG/04seMHwqg7bK0jVIFepXydLUkMYGOTbt0rbH16zeHdRTg29kuoOX0O+d
         5L+tfJWVn3TF3B/oem1zV/0RZFx8K/f64JhWdL/CauDtwHk1Oxew3/sQXroH3lTZ5c+O
         l3g+O/WLLUuOsaX51VoFiVeNJqK0Z9RGSWVoLJCed5IxZAtM31n3ndGK1Hp6WzIl3PYJ
         yCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TftPCUPwfmc5ZcdU96Tn9M0gpvgY383LiLn7FPvDdEE=;
        b=Zs6wjLenQisQxkWl016axmJhj2BwlF2UgyJLnLGHzLX110BMeOaipYIDjYLxY3CNmq
         CUPaAwgawpY2FL+Ym1DxQAAacFPhLBw//x7Zcrv8B9FxfZofwiF9dJAsQeUuoKtDbvpP
         KJ1PZPGZivAp4unlsWPL+u+rAj8w+rJ94QMX4Dy27LQRg+2Fy+gqdavaq8f6132RzEci
         qHaWvxPYI3pg9HZuEyvEYXYh5oGclStdYwyRVq1X6HSBq0psZI8Z5ZyVvRWrsjrI6XOV
         0jHifixfqdRZZJgtloXhI01SPUO5bAA49+NTwotjEO0EzzpDX9WYmN+AZ0oKaafEz6wM
         LmPw==
X-Gm-Message-State: AOUpUlF4rXwI980iOl3JAocYgLT8ZByonDqgQrA2bwFKNVjt8vRustoW
        2FE0wPFzuP0fkzpNibx2i3g=
X-Google-Smtp-Source: AAOMgpci7GZq5Wyzk+WFzf9uXbvVWrJEF9ZModnf9L1N65+xoZWxhPiJoLqQDSpD8Xo/nDs7V/l2aQ==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr20192087pfa.96.1531793391955;
        Mon, 16 Jul 2018 19:09:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:51 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/32] staging: gasket: hold mutex on gasket driver unregistration
Date:   Mon, 16 Jul 2018 19:09:00 -0700
Message-Id: <20180717020926.176408-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Take the global mutex on driver unregistration updates for proper
ordering of updates and consistent access procedures.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index cbadab7544c81..2ff328652356a 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -371,7 +371,9 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	class_destroy(internal->class);
 
 unregister_gasket_driver:
+	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(gasket_register_device);
@@ -408,7 +410,9 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	class_destroy(internal_desc->class);
 
 	/* Finally, effectively "remove" the driver. */
+	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
 
 	gasket_nodev_info("removed %s driver", driver_desc->name);
 }
-- 
2.18.0.203.gfac676dfb9-goog

