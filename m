Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA973C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65F321534
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1aWeDxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65F321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeHMT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:58:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46541 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeHMT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:58:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so11774714lfc.13;
        Mon, 13 Aug 2018 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DuFSKhyYXiiAEi/6GXubJA51ktpXVO+UL/noS/eZw5s=;
        b=M1aWeDxZA9y32NI8Ibcp8r2rNIoZ/JCA0gAI2nbSKhmjpjG3Qamyww68PYGbmz127c
         /I/FqwPC7ah/KQC3VTUsrrO9M5XvmxSDVH6etdKfWaZ/yZ/FqC512uue9Ia3ioXadFja
         IWd57U144aonVc/aElZIo/l6gbRRwGBcplCWvbcC4Toex9b5fqrxeaGWKkshzi01s8mX
         PeRBVRo3KRCKAIfgeY89knwSlens4UWthO/ThU9TjEEBZrMK2CWx2HJPyG/ZF/Rl6jro
         JB18RgmmMXKdIBaa9+UYKi10xaDU0nOxsZ+rI1h+MNseE+dn5IKkrcHhn/IHZPgxo7ex
         sCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DuFSKhyYXiiAEi/6GXubJA51ktpXVO+UL/noS/eZw5s=;
        b=XgM76cyGudRNSxku5Rgd1zd738CHGfCyQuNQf6AvbdqEWmTyZtO0jsnMD3zlg7cvCr
         jzolJw32boxmq7t+duumYwNzEm+cPaxxl9TVlLVwu2O1x0f3GN1WfwJN4IQuGh/nWRbG
         P8/WKuRE60sX/eMAp56AY0PrQpxoout2VNVpnigskiRDofy9KXmt1J34LEZNez93MNzQ
         giRqN+0CnHtGgu7/Xii3raIwTxqbupYOghK+UXW8b+Em42+L8Hz+K89eM+RZGG19gXvL
         1kcvTH4Px5NMyZ9B0d2+TTliOSqTi42QRHCk2Ijlrgj1vanxJJNeuvej3gJqxoPApPah
         U4nw==
X-Gm-Message-State: AOUpUlFDD3gfDL7QBNw6ZSMosny+yFBfWPhKyH3VtU1dh8/SFf1YwhPa
        OXOyZfCaWUzyU8C6u+OxNYw=
X-Google-Smtp-Source: AA+uWPwb3KsNjIkqc9hJfCy/69zcnPeFbB2sHUoqbEkW//dvfoGQO+Ixot3vvvkGzZGmj3tEw4qKtg==
X-Received: by 2002:a19:c954:: with SMTP id z81-v6mr11075308lff.107.1534180548614;
        Mon, 13 Aug 2018 10:15:48 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id i1-v6sm3098709ljg.43.2018.08.13.10.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 10:15:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] thermal: core: Fix use-after-free in thermal_cooling_device_destroy_sysfs
Date:   Mon, 13 Aug 2018 20:14:00 +0300
Message-Id: <20180813171400.15345-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes use-after-free that was detected by KASAN. The bug is
triggered on a CPUFreq driver module unload by freeing 'cdev' on device
unregister and then using the freed structure during of the cdev's sysfs
data destruction. The solution is to unregister the sysfs at first, then
destroy sysfs data and finally release the cooling device.

Cc: <stable@vger.kernel.org> # v4.17+
Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab982309e6a..441778100887 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1102,8 +1102,9 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	mutex_unlock(&thermal_list_lock);
 
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
-	device_unregister(&cdev->device);
+	device_del(&cdev->device);
 	thermal_cooling_device_destroy_sysfs(cdev);
+	put_device(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-- 
2.18.0

