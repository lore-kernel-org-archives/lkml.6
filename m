Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EBC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55932085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhotvef0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfAFR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:57:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45337 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAFR5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:57:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so35891985edb.12;
        Sun, 06 Jan 2019 09:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVEHZzCkVqjbbwpl1Hi8T2EJhcJ+fDuzpOWplghqKVY=;
        b=Fhotvef0XLrXGWiAZMR2vdcgiFh1vfMF+B2LTqQtP/XAsqwqc2XDlp2gqywwLE7mPa
         ecMnhP8flfVv2BBirK9dogtuED1zqQiivx3NgfidhKfE5P12fR7XKuCB7v3ZIuZqCyR+
         rQzRPIX8ioLMbuRrzbqWaf0LyrTH3+ss2MN0larfeWEovBAWgxVfjGqVKN5AaAA01vmM
         OgSGdcPuhw2XNaag6r3ZM5BOqRBF5y0z/Sv4sKtgkfkCKWk1yRqyp1LHBhvzhu/vC9Vb
         cj+HNujE+FhVCO131F0anm1501QFYd1Njo0dlrmHGtDRUTHOljwhxynZNdk4qGLsmNMI
         X2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVEHZzCkVqjbbwpl1Hi8T2EJhcJ+fDuzpOWplghqKVY=;
        b=UJm67hiHsWmFA7FtUTfpy25aRIC7V55fvg/sg+Ppap2WSYeRrKB4Dd5pXm87pGTpuY
         nXs1pRU4x+aiQRCOsTXHB6cE0cn5aCm+J2Yo3s+Uz+3xASik1Xn5eYxLl7fSgetFD4Mf
         GRTJgYkforbbHEm8WgO6KPo3qz2vmbH9yS7KmXYUvjd/PPBYupGJ4f4mhjMXXR5HVOW8
         JaGKpWRjhQggEyvCGdOGf6HbworHX5cS0gt6yHeW5YRvkEbVKv1+a/pRws+58I+eDaVS
         6riF748dmkDqSgdS7689QOpk+JePY+d0+PArJjDUsciw8nAzziVXTrHCqTXoXrV6iE+Z
         U+Gg==
X-Gm-Message-State: AA+aEWaD+/35QdFIEgnXnhMYzQdmEdBCf0I1K6Vf+VV+dzPSJDMKItwO
        cFMzoz2rF49JIwCzIpGAiQ==
X-Google-Smtp-Source: AFSGD/VJdaMahe5iwiOL9n/9b5NXdnOEO+Si3RZM4nWvdHct2DqLml9iw9+5Qv4u4q/X4UJSOTCccw==
X-Received: by 2002:a50:cdd0:: with SMTP id h16mr54350608edj.151.1546797438630;
        Sun, 06 Jan 2019 09:57:18 -0800 (PST)
Received: from latitude-7275.home (2a01cb04006a0a00478c38b296055568.ipv6.abo.wanadoo.fr. [2a01:cb04:6a:a00:478c:38b2:9605:5568])
        by smtp.gmail.com with ESMTPSA id l20-v6sm17542438eja.18.2019.01.06.09.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:57:17 -0800 (PST)
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= 
        <jerome.debretagne@gmail.com>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chih-Wei Huang <cwhuang@android-x86.org>,
        Tristian Celestin <tristian.celestin@outlook.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel-hid: Missing power button release on some Dell models
Date:   Sun,  6 Jan 2019 18:56:44 +0100
Message-Id: <20190106175644.24872-1-jerome.debretagne@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power button suspend for some Dell models was added in:

commit 821b85366284 (intel-hid: Power button suspend on Dell Latitude 7275)

by checking against the power button press notification (0xCE) to report
the power button press event. The corresponding power button release
notification (0xCF) was caught and ignored to stop it from being reported
as an "unknown event" in the logs.

The missing button release event is creating issues on Android-x86, as
reported on the project mailing list for a Dell Latitude 5175 model, since
the events are expected in down/up pairs.

Report the power button release event to fix this issue.

Link: https://groups.google.com/forum/#!topic/android-x86/aSwZK9Nf9Ro
Tested-by: Tristian Celestin <tristian.celestin@outlook.com>
Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/platform/x86/intel-hid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index e28bcf61b126..bc0d55a59015 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -363,7 +363,7 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	 * the 5-button array, but still send notifies with power button
 	 * event code to this device object on power button actions.
 	 *
-	 * Report the power button press; catch and ignore the button release.
+	 * Report the power button press and release.
 	 */
 	if (!priv->array) {
 		if (event == 0xce) {
@@ -372,8 +372,11 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 			return;
 		}
 
-		if (event == 0xcf)
+		if (event == 0xcf) {
+			input_report_key(priv->input_dev, KEY_POWER, 0);
+			input_sync(priv->input_dev);
 			return;
+		}
 	}
 
 	/* 0xC0 is for HID events, other values are for 5 button array */
-- 
2.11.0

