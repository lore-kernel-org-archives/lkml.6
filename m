Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939221AbeE1NbO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163161AbeE1Kqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 128/496] integrity/security: fix digsig.c build error with header file
Date: Mon, 28 May 2018 11:58:33 +0200
Message-Id: <20180528100325.320727936@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 120f3b11ef88fc38ce1d0ff9c9a4b37860ad3140 ]

security/integrity/digsig.c has build errors on some $ARCH due to a
missing header file, so add it.

  security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/digsig.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
+#include <linux/vmalloc.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
 
