Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655618-3-9229794665392793335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655617; b=KYERgOplJ6uGXZ/5s2jvUtvtIMV49/rm3X6K3GCYHIK2h7+mFh
    cH5oqEI+fZCNpZgHUpIPrLxaBu3h3cRyg+FMlboSn85wxeGfKnYlvB4W5CUOo98C
    mRxgBgJrRoXcF9hNUMjFKaCbQR+lyAzog+yEj+9lPjJ3mWjyYzdHJfB307jHXewp
    ip9Vvz4Ctrt3P+CWCBaqQcUqWRbPXR9kR3f/TXr7V/rVFmuL66IWnEiI6+op0V9b
    0xP3z9F6P2hSL3YM1sUluHsDSk3RmSHcUH2iCNKqFro7YMBqW0jQAg08LKzkWeCn
    bZpzI3kZDg6nWVEEvOXeS0GqthpCwfwCcN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655617; bh=sk0Rg
    /O/wEepGBQiObduqfKgXeC10qAaqOthfeqegS8=; b=e8Qf5EdzFUF2u6Wpthbs1
    BGl7e/BJ4LxwbvICHDSy/tMNrRZkQuEZdqyxzNAEx56AnyaiTc68R5XpvZBW53Cq
    foLc7YjOceJml6Db5uLU9dGa7MZa5BZyjQ+fLDSv2i/GBEC3DBfdsx498/YrUf8H
    zASvAHYy9IojTZCF4TW6s8rLw3ouCptXYX5mmuX9Zgq9AxqwmBI7R8c4jWG589U9
    hMkp+qq2blcCpmBPzgvNKGoaW8JYu8Udwa8CJ0BlywBMW7k7BgTQJ3GT2UX+8NX7
    yko0hLVRvrJh1SMkhy1DWM339Cf4B9FmPwigNrtDXyYfVQzbnxa0hfnbs8XWDWkW
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=G0g+Mz++ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=iPHTzsHX;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=G0g+Mz++ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=iPHTzsHX;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIE2beRrrxi4ST5P1yXqST7q0DBCOyGT1U10+1zhyqAjWZbftmwfyXN//JrIE4fasbMobtZ+Mw/6GWiix7otnb3zuZM4BtUF+OBGvMgjJmNAu8SyLzJq
    WG6chs/A7Wa3bmkyltb4G4J3NCK0ohHwf9hnbutM39nQNpLaaHNzXxDw6OlY+cj3qBl0tIO5MIP2O8vLd8wv9+vmgZ6qAoRk0jrcSJi21LGFtnL8SMN0Y8dK
    ghfpopdid4A2+SQBmOlV9A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=1XWaLZrsAAAA:8 a=UV4Khlu7AAAA:8 a=DDOyTI_5AAAA:8 a=9-dSKzyp9CycMYwSpNIA:9
    a=CjuIK1q_8ugA:10 a=g3FnbuhPxHiixQM06tVt:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoTzwQ/9ejgE0ZOkZpsB/wlmn/cbofjyafmwjEm5piXrAWm1zOZPUO7lpnDLgajHICoXalrWg==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 2/6] staging: android: Clean up license identifiers
Date: Sun,  6 May 2018 18:13:24 -0700
Message-Id: <20180507011328.11982-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507011328.11982-1-natechancellor@gmail.com>
References: <20180507011328.11982-1-natechancellor@gmail.com>
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the identifiers when missing and fix the ones already present
according to checkpatch.pl.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/ashmem.h        |  6 +-----
 drivers/staging/android/uapi/ashmem.h   |  6 +-----
 drivers/staging/android/uapi/vsoc_shm.h | 10 +---------
 drivers/staging/android/vsoc.c          | 11 +----------
 4 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/android/ashmem.h b/drivers/staging/android/ashmem.h
index 60d7208f110a..1a478173cd21 100644
--- a/drivers/staging/android/ashmem.h
+++ b/drivers/staging/android/ashmem.h
@@ -1,13 +1,9 @@
-// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
 /*
  * include/linux/ashmem.h
  *
  * Copyright 2008 Google Inc.
  * Author: Robert Love
- *
- * This file is dual licensed.  It may be redistributed and/or modified
- * under the terms of the Apache 2.0 License OR version 2 of the GNU
- * General Public License.
  */
 
 #ifndef _LINUX_ASHMEM_H
diff --git a/drivers/staging/android/uapi/ashmem.h b/drivers/staging/android/uapi/ashmem.h
index 5b531af6820e..5442e0019dcd 100644
--- a/drivers/staging/android/uapi/ashmem.h
+++ b/drivers/staging/android/uapi/ashmem.h
@@ -1,13 +1,9 @@
-// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
 /*
  * drivers/staging/android/uapi/ashmem.h
  *
  * Copyright 2008 Google Inc.
  * Author: Robert Love
- *
- * This file is dual licensed.  It may be redistributed and/or modified
- * under the terms of the Apache 2.0 License OR version 2 of the GNU
- * General Public License.
  */
 
 #ifndef _UAPI_LINUX_ASHMEM_H
diff --git a/drivers/staging/android/uapi/vsoc_shm.h b/drivers/staging/android/uapi/vsoc_shm.h
index 741b1387c25b..6291fb24efb2 100644
--- a/drivers/staging/android/uapi/vsoc_shm.h
+++ b/drivers/staging/android/uapi/vsoc_shm.h
@@ -1,15 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2017 Google, Inc.
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
  */
 
 #ifndef _UAPI_LINUX_VSOC_SHM_H
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 954ed2c5d807..6ef7a011d789 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/android/staging/vsoc.c
  *
@@ -7,16 +8,6 @@
  *
  * Author: ghartman@google.com
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- *
  * Based on drivers/char/kvm_ivshmem.c - driver for KVM Inter-VM shared memory
  *         Copyright 2009 Cam Macdonell <cam@cs.ualberta.ca>
  *
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
