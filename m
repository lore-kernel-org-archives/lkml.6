Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1AFC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeILUUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:20:38 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41872 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeILUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:20:38 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0X4e-1ffQiF3j9A-00wWny; Wed, 12 Sep 2018 17:15:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] compat_ioctl: remove /dev/random commands
Date:   Wed, 12 Sep 2018 17:13:05 +0200
Message-Id: <20180912151422.571531-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:hSUqusCADk7mydLYK6fqtVhE9PT0heRLSjr4I7VVbXmaU7cZ+uE
 NWpB2VxCe9Vriu/Vd+rdSmS/zOYdeNkgMTQ6w37m4votc/aexuQBDY4aCWjALsudMeU5hYt
 KHYUJN8vplrjC61n14PgFWVmq3KE9iB4OBDwx1axDoci3HiA0KmmNGVGXO5dG2q2tXX8dAw
 FzSC8d48GGHmaKJ5T6UzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l0D5jQcBGgc=:QvIWYYyviCHXjsF3HooZWZ
 ZldE9L4rb1o3v6U5Ce2MfEkvYVW91WfbB4qUiM86RB1NqNBoauXo0N3Ul6WKPX5fuOYV2ATmC
 u3thsX03A/IuvBOwWrEkNQWTPVK65dW06KCGI83MfPlJnT3GbziLD1bzRUT/9fM0lMaBtfTab
 5JujdXnndHFUwBye1zUDZw+hCgD4f/9/38Lg6AqTnrt6/QL20WtnRLDjTUe8ML+lg6zESXk63
 d4ccwTm+zXv4IKYo4A1fS/BFzmgqICM9R9YVNATfN4ylcz2YWkDHNd/VjS04nRRK7A6tkP6f3
 t3QQ0yqF73DfjfiXIdr7D66rvffZZt1iCCree5TRLb6Rd/h2ujEYeIwXT/fU97TGd4Gw+E+B0
 rIXSRV7+hsrYqs53QRF79d7m4mbZnGNISlaS/dSblW6CXsWFcQpWEL+/9peWTUTrS2i1bQRx7
 4JaSCp5Lz/kcWO8Bce/ceWNv9ULrFYEKbMNIk52ec/CGvXJCaRm/wP3B/RV/0dfN72jxvzlAI
 E2diRF3hcsmmZ/ROLiQGudG480vRVqG0CczafvnqHKnJ8aXsbodH8IDaY4iU1T3azWdvVlSj9
 wjhWPag7gfdi3m4xbVCRelzxiP5Os8DGKEj0vF1Bu6j6IDBnlwQlDxl4dlWwiK7ZBiLydY7vL
 npuNrH8TfR4D3w9SwHVI5jfsGiinG71UWDcrENROVGalhJsY8c/Jr4G04W71YCqHslaA=
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
index bf5f99fc36f1..d1b2cdebc598 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2021,6 +2021,7 @@ const struct file_operations random_fops = {
 	.write = random_write,
 	.poll  = random_poll,
 	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = generic_compat_ioctl_ptrarg,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index ca7f83976a3f..d5b8380fb1b1 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -764,13 +764,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
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

