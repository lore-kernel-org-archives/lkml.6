Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39071C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22522084C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SclGeF/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfBBNFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:05:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36416 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfBBNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:05:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so8855433wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 05:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mmywxse0Hot8Qok1gcJfSbINc+XX1/PHxykZhjM3t4Y=;
        b=SclGeF/fMtSsqWRRYr2cVkPnGKKAPYqhx8KtDXcsZ3sfKRaaEeFYgS7WbPpJQ1UcS7
         J1NLgoEed1xdzLE1FRw9+xCADRGPT7BpR8sBIzYXVZXIiSNS7guLIUHI1iX+k1MZfu37
         kFccBbBf7DhQbdUp8woaFkb52weSuf9ssF4OC1O5m5EX38n7XihtxPuORmr0Bvic02/B
         4ewekMIypjosT5gjRXC2qxtsuI+U2biqGBLRslZKsyQ+qnqd5iOvQc8Z17pVTy5hD42H
         B3wbIFnlAFHWguCPx2RHDj6a864BZj7cpF6KCzAuAZz0OlJ5vVoZB7UCpSd7AOmkR0wP
         igcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Mmywxse0Hot8Qok1gcJfSbINc+XX1/PHxykZhjM3t4Y=;
        b=AvS7RkfLEHT/jRFNrXGO7M25Rywubnr4OyyDmrmXE0iwzChfVqlIet53EqU12RQAo7
         nZ02dGcueIfHDiLZ5U2k4I1EraCsu1tdh9KJdjrfWBso61GpGIYAHeLQD9cE6krTbA76
         gx1pQ6ojB9csHrv+qBx6bbt8S0lbrBLFeAUBbMP9W+I1EbyK1jdTfw/KbCkX74fAmqRF
         8S0JPq+IdUJOT5ToaQIJCNXmPCam1BnJWNShPJ6eI0SH+Pk9GUuup5uwoTaDpsoZ5f6D
         e6MZ2jLIwgsqsPmoYFD2JUmgQ2tSl5qJEYgOV8AqbMEa9Xz6EjTyNm6j/ikgmccdvBLo
         rpZQ==
X-Gm-Message-State: AHQUAuYE9uF1esrd0Y+BCA9cukuIwMSV96otlU0RbwLw6vPx9DzRjeX7
        vb8aaCnbLAcWuKDU2uLhC6Q=
X-Google-Smtp-Source: AHgI3Ibq4KM1CZA5ZzLxN0XUjm+gY9XEXL37FRimAMjX/t4wyIC1gWkO2vEABpxB2LtllcVOQjxRjA==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr6225509wml.121.1549112747734;
        Sat, 02 Feb 2019 05:05:47 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id s5sm3784900wmh.37.2019.02.02.05.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 05:05:46 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id F00851146681; Sat,  2 Feb 2019 14:05:40 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Move static keyword at beginning of declaration
Date:   Sat,  2 Feb 2019 14:05:35 +0100
Message-Id: <20190202130535.2761-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword around to remove the following warnings (W=1):

  arch/powerpc/platforms/ps3/os-area.c:212:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
  arch/powerpc/platforms/ps3/system-bus.c:45:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/ps3/os-area.c    | 4 ++--
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index f5387ad82279..4d65c5380020 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -205,11 +205,11 @@ static const struct os_area_db_id os_area_db_id_rtc_diff = {
  *  3) The number of seconds from 1970 to 2000.
  */
 
-struct saved_params {
+static struct saved_params {
 	unsigned int valid;
 	s64 rtc_diff;
 	unsigned int av_multi_out;
-} static saved_params;
+} saved_params;
 
 static struct property property_rtc_diff = {
 	.name = "linux,rtc_diff",
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 5cc35d6b94b6..7c227e784247 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -37,12 +37,12 @@ static struct device ps3_system_bus = {
 };
 
 /* FIXME: need device usage counters! */
-struct {
+static struct {
 	struct mutex mutex;
 	int sb_11; /* usb 0 */
 	int sb_12; /* usb 0 */
 	int gpu;
-} static usage_hack;
+} usage_hack;
 
 static int ps3_is_device(struct ps3_system_bus_device *dev, u64 bus_id,
 			 u64 dev_id)
-- 
2.19.2

