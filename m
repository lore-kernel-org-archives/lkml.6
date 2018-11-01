Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB58C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0991204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCEzKzJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0991204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeKAJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:22:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45654 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeKAJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:22:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id t10-v6so15172367eds.12;
        Wed, 31 Oct 2018 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZDOdUT+8hHwxZCwsWNH62GriDD+REO2XNb3X0hnxVE=;
        b=hCEzKzJQfivxHWA8rXMgjQu+KDXRqurrPtH4ZjvjwIqnv9eOEZQDqiPos0T8UDhEXW
         cLEMXevNJdXt6yHdr9v0OEy8IAwa41SlhbOBTLBGRkSbklcX4lgzc2X1jfRfO7TmXkUY
         fIRd3YdHG/dEt3q0tDWV+M8g5HlzscALE/LTsI3kIZL5HuRxzQJO1N8hzpMdQAxsFyCg
         kbj8TVcsc8RUFLBTOxApLN7d0Eud81LwBpMrm8JVdC4ptHb8cVFxrQYsnQuBsWUuf2Pz
         vm7KLQLefKAbkLbgDWiJSC5OPirKHs1Ok5iRVXQj3sGm8zzXeN/Pc6fSLAgxirQa7OE6
         FeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZDOdUT+8hHwxZCwsWNH62GriDD+REO2XNb3X0hnxVE=;
        b=ifwLgjficualq3TQVjqhjXV6ki1l6UayNEtiKo4ZjkhYgXiUFwgnXYao3GXlYPTgcL
         HMZwaRDClSaLWYq+nzMJutMGGRSo0lbRuDXLaV668HDcWP2/HfDr6ETK8ufhg8X5Myq9
         H8nFBbZAfq9QFauAq2VXWlP6SHzbKVeXlroVm/gEMFH0sIpEVw0vt4vNYLXj2cjcdeQq
         TgoVwqgWiv0xf4WKH/5Cvr4WEYN74Ar059SY7PIVmm6TUHlEOjw/L/KwASHRjoURvD6t
         zQvRuW1cjQbl/Cp++nfI+NJSDFujiYWUY7DTwbx7rxWprV2I/oz/IOKCS3rq2Q+QKlIY
         j8GQ==
X-Gm-Message-State: AGRZ1gJvN0z47ORAy0Q9x3DJWMr1I+mxqOVbq85idpY98Ccdt1+DIJJH
        4Vb1dUqqSIR0J03gV09RNkQ=
X-Google-Smtp-Source: AJdET5fDIOj+Xd2KyTMTD9AhuY4yXJXC7RCrRqr+Lv6kr1P0U80M7m1dD5/a4PBhjUdm2e3xtjtI/A==
X-Received: by 2002:a50:aefd:: with SMTP id f58-v6mr3707837edd.42.1541031709188;
        Wed, 31 Oct 2018 17:21:49 -0700 (PDT)
Received: from kiddo.lan ([2601:602:9400:bc9f::a3c])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2981468ejd.3.2018.10.31.17.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:21:48 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 2/3] asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
Date:   Wed, 31 Oct 2018 17:21:27 -0700
Message-Id: <20181101002128.28884-3-jprvita@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002128.28884-1-jprvita@endlessm.com>
References: <20181101002128.28884-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the OS registers to handle events from the display off hotkey the
EC will send a notification with 0x35 for every key press, independent
of the backlight state.

The behavior of this key on Windows, with the ATKACPI driver from Asus
installed, is turning off the backlight of all connected displays with a
fading effect, and any cursor input or key press turning the backlight
back on. The key press or cursor input that wakes up the display is also
passed through to the application under the cursor or under focus.

The key that matches this behavior the closest is KEY_SCREENLOCK.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index db2af09067db..5a00a7665f9b 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -444,6 +444,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x32, { KEY_MUTE } },
 	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
 	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
+	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
 	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */
-- 
2.19.1

