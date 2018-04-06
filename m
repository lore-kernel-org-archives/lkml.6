Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeDFS63 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:58:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeDFS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:58:27 -0400
To: David Howells <dhowells@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a
 struct member name
Message-ID: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
Date: Fri, 6 Apr 2018 11:58:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Since this header is in "include/uapi/linux/", apparently people
want to use it in userspace programs -- even in C++ ones.
However, the header uses a C++ reserved keyword ("private"),
so change that to "dh_private" instead to allow the header file
to be used in C++ userspace.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=191051

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-416.orig/include/uapi/linux/keyctl.h
+++ lnx-416/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	__s32 dh_private;
 	__s32 prime;
 	__s32 base;
 };
--- lnx-416.orig/security/keys/dh.c
+++ lnx-416/security/keys/dh.c
@@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;
