Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800236-1525644186-2-7942539206287056853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525644186; b=aAd74Mui2mIdcHn22OaCSNnGGzT6w/S5+7ErsINvACkaUjqJE+
    i3rOwZAAESgutNvBI484BAuwoL6SpretXYvECVpnpJKEutC/8eX7b/73NdjCihLL
    B6R40LwppGC+fq//FUiedbg9b+mWYBb4xqotgQRsONkYX2f7dIEluRxSDSo0z9j+
    G9LphfxUnA9XJmYILEBNJLqxHwYgK/RdsG2X8ELD8RIdr2ida1lEczaJtuYemtl0
    T3DZkLEKfESSDMMoqiAJTVe/oFtgnJs4a2HJRU3aGbA2n/j5PxlKhPwGyKHrIV7Z
    vx7pYsZ9OmGpR3Jmm7hTUmnFT//NUZxsptOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525644186; bh=svGfi
    ones6af4cjWLnzblLdHWbVquceGqtaYmksAiIg=; b=dGc3GnyzvL+rxfBRuT22I
    gYGdoJEj9zbIke0I2RF1cPK9Z0tKXLPF9GJS1wtACffRtTkP9BF6te6TG0Zkz7Bh
    W1NhJphy8JhnwdsBm29fMtTIYfZUK4ATbyi9fAncgCZoxVg7znfdua86Xf+MSf16
    CW4dzYaopGRKHDqFG9dVs4fSVutx1TsZiTT1V6xueurTYIa9YR/OXHFhAlUQt0a3
    RWIq+WvEsGqmmcQiPPo+xNGBjVpk7ED56pHgPK38fyajVw8ySBHq2vKU5FSkECKW
    00qU0vV5DY+z0oNQOStskqZuh8gWXU09f98La2sUWNRZ7XERazjCDvUalURi8jCz
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=eOLugyPZ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=q7HgYUMO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=eOLugyPZ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=q7HgYUMO;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBm7h5/fUHTm9Sd+pa8PLeyV6ngsiQb1VHExVSdBxYMWfMhBUiswoeoxi2Fs5CF2078kjFlT9Zf2PzKRLVc4gEgaUmvKuWdKire5ncHmq0wq2WE59mSL
    X6GYKTLwAvNs6QxiFu0jFBKvvvzQN2G70EZCPmrklGjDsBs9wET/8QDyw2EfMkT6dWjcys31s9FeTNmGgr9k4rDy8Y99F0PdXDtvQSE8Ju3DxV3YLzvT4jpA
    riV83mLl6MXMeQlT3mp1nQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=1MfEKbhfEiSEufBaib4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqlype1EjXnFQQKOKM+1Pein8LwJRERr+SPRMnbjqS16gSaonkQRrP/rYl8WFFrPLkFcELN4Q==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 1/7] staging: ks7010: Replace license boilerplate with SPDX
 identifiers
Date: Sun,  6 May 2018 15:02:58 -0700
Message-Id: <20180506220304.13040-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This satisfies a checkpatch.pl warning and is the preferred method for
notating the license due to its lack of ambiguity.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/ks7010/ks7010_sdio.c   | 5 +----
 drivers/staging/ks7010/ks7010_sdio.h   | 5 +----
 drivers/staging/ks7010/ks_hostif.c     | 5 +----
 drivers/staging/ks7010/ks_hostif.h     | 5 +----
 drivers/staging/ks7010/ks_wlan.h       | 5 +----
 drivers/staging/ks7010/ks_wlan_ioctl.h | 5 +----
 drivers/staging/ks7010/ks_wlan_net.c   | 5 +----
 drivers/staging/ks7010/michael_mic.c   | 5 +----
 drivers/staging/ks7010/michael_mic.h   | 5 +----
 9 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b29f48c421cc..6a5565d479ac 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   Driver for KeyStream, KS7010 based SDIO cards.
  *
  *   Copyright (C) 2006-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
  *   Copyright (C) 2016 Sang Engineering, Wolfram Sang
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #include <linux/atomic.h>
diff --git a/drivers/staging/ks7010/ks7010_sdio.h b/drivers/staging/ks7010/ks7010_sdio.h
index 95ac86b94a7c..831b2f105f58 100644
--- a/drivers/staging/ks7010/ks7010_sdio.h
+++ b/drivers/staging/ks7010/ks7010_sdio.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *   Driver for KeyStream, KS7010 based SDIO cards.
  *
  *   Copyright (C) 2006-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 #ifndef _KS7010_SDIO_H
 #define _KS7010_SDIO_H
diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9a05374d950e..c0a9a67dc0b4 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   Driver for KeyStream wireless LAN cards.
  *
  *   Copyright (C) 2005-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #include <linux/if_arp.h>
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 05ff5ca5da19..172d38f17595 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *   Driver for KeyStream wireless LAN
  *
  *   Copyright (c) 2005-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #ifndef _KS_HOSTIF_H_
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 2894b0c3816c..5070af86115f 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *   Driver for KeyStream IEEE802.11 b/g wireless LAN cards.
  *
  *   Copyright (C) 2006-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #ifndef _KS_WLAN_H
diff --git a/drivers/staging/ks7010/ks_wlan_ioctl.h b/drivers/staging/ks7010/ks_wlan_ioctl.h
index e45a33291b46..97c7d95de411 100644
--- a/drivers/staging/ks7010/ks_wlan_ioctl.h
+++ b/drivers/staging/ks7010/ks_wlan_ioctl.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *   Driver for KeyStream 11b/g wireless LAN
  *
  *   Copyright (c) 2005-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #ifndef _KS_WLAN_IOCTL_H
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 694decc05c88..e96477937f65 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   Driver for KeyStream 11b/g wireless LAN
  *
  *   Copyright (C) 2005-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #include <linux/atomic.h>
diff --git a/drivers/staging/ks7010/michael_mic.c b/drivers/staging/ks7010/michael_mic.c
index 2128c8441405..e6bd70846e98 100644
--- a/drivers/staging/ks7010/michael_mic.c
+++ b/drivers/staging/ks7010/michael_mic.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *   Driver for KeyStream wireless LAN
  *
  *   Copyright (C) 2005-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/staging/ks7010/michael_mic.h b/drivers/staging/ks7010/michael_mic.h
index eb22fdd660d9..f0ac164b999b 100644
--- a/drivers/staging/ks7010/michael_mic.h
+++ b/drivers/staging/ks7010/michael_mic.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *   Driver for KeyStream wireless LAN
  *
  *   Copyright (C) 2005-2008 KeyStream Corp.
  *   Copyright (C) 2009 Renesas Technology Corp.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License version 2 as
- *   published by the Free Software Foundation.
  */
 
 /* MichaelMIC routine define */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
