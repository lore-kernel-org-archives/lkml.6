Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbeBMB0d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:26:33 -0500
Received: from casper.infradead.org ([85.118.1.10]:56410 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeBMB0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:26:31 -0500
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] integrity/security: fix digsig.c build error with header file
Message-ID: <b3b7eebb-0e9f-f175-94a8-379c5ddcaa86@infradead.org>
Date: Mon, 12 Feb 2018 17:26:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

security/integrity/digsig.c has build errors on some $ARCH due to a
missing header file, so add it.

  security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
---
 security/integrity/digsig.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-416-rc1.orig/security/integrity/digsig.c
+++ lnx-416-rc1/security/integrity/digsig.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
+#include <linux/vmalloc.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
 
