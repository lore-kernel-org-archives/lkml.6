Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F00C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6242086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6242086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIHTRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:17:22 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIHTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:17:22 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mum2d-1fg1Jv33Jr-00rrOL; Sat, 08 Sep 2018 16:31:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/11] compat_ioctl: remove /dev/random commands
Date:   Sat,  8 Sep 2018 16:28:12 +0200
Message-Id: <20180908142837.2819693-6-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:aj9N/Luw1AgvpyHqFjV+g2BVt9SmQDi1RBBVWq/UXeUyPqlGStR
 /6q8X4FurUmI69zE9AQv50siBmmPxPQrLpywDCyTYvYaof6kCkUtH82PYfXu4YDPhpepNHy
 hOnac0kSL4cRiGT6opE22cuY3OqFJyTXqmiIdu9QGevCguoZ2io/nkvHw0r0uCs1QsQqK7C
 /JRNr7SOwQ8tdku1OafmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VCdWvQt2xfM=:lk2BnzLE5H9lWOjLg2MqeM
 rBZDVqTB5qxaxwWmlgL3bDVaPOe+LTVuUA/PCtu/Gs0JMsZCiDjD2p2fBt+nHnlafA9jBnXBg
 /zC6tTC/dZaMdb9jbGg4V9tZLKtYLgffy0yfDO6xT34P/iyc8eycOl4b9XryOTxBAKTCbrMEP
 2Vq5afSIArd6k3HDbzDba0aswtojUNNbXi3lJb8q22GddmUiRIVYsjwLN+j/QoBD+rxd3zGN2
 PgrfURoFbbJIo6p4Rg8ytwxL/srNxzbNCU/SIRPhylly+GKRyKxsyUZT0sEdg1WyDeFXQ+FoM
 jzbuNuQkWKf48lDaG2bfeQ06mg5d0H+ln42SWLQ7DdUmSF/azYRIA1yqM4nPr7VnU3MLes6X3
 xuhWtwOjr24Z10B4z2Q9e60eDH3T5HQ1N4pUh5vdKQbDguq0A97d4vTaxRDv0oFPfzy7I3w0f
 b+tignH1npdju6LuBO7x/fWFq3HltOGCf5GgVTCu7eB9uV5Hvrjk8hhPaJsHO1aGffIhMOmDi
 6ySWUq7E78EnNlgdzgH1jWKvVXiFdfIde1inuZLdT7KG5ERCR3UxzMinQFcML5JI5AfTpsITH
 QWA7M6WUxkD0n5d18E6G/qHjAoiN4ZZlpMbMo1EkabJFKm0YuJj+5OA4pGpifYFnmzwbUCNyC
 BdBzSRMiLUMzhwy1RjneNJsmPs50UGXYWZyGtKm6aYd8SKeUc0wulWjH8uxQ1TWE2neI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all handled by the random driver, so instead of listing
each ioctl, we can just use the same function to deal with both
native and compat commands.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/random.c | 1 +
 fs/compat_ioctl.c     | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf5f99fc36f1..103abf82444a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2021,6 +2021,7 @@ const struct file_operations random_fops = {
 	.write = random_write,
 	.poll  = random_poll,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = random_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index b56a3842d61d..eb29188d1dbb 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -594,13 +594,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
-/* Big R */
-COMPATIBLE_IOCTL(RNDGETENTCNT)
-COMPATIBLE_IOCTL(RNDADDTOENTCNT)
-COMPATIBLE_IOCTL(RNDGETPOOL)
-COMPATIBLE_IOCTL(RNDADDENTROPY)
-COMPATIBLE_IOCTL(RNDZAPENTCNT)
-COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Bluetooth */
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
-- 
2.18.0

