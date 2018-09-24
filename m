Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B03C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DEA20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DEA20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbeIXSUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:20:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbeIXSU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FF73C058CB6;
        Mon, 24 Sep 2018 12:18:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7B24891EB;
        Mon, 24 Sep 2018 12:18:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] Revert "uapi/linux/keyctl.h: don't use C++ reserved
 keyword as a struct member name"
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        lkundrak@v3.sk, rdunlap@infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Sep 2018 13:18:34 +0100
Message-ID: <153779151491.28003.1935104275920340501.stgit@warthog.procyon.org.uk>
In-Reply-To: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
References: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 24 Sep 2018 12:18:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

This changes UAPI, breaking iwd and libell:

  ell/key.c: In function 'kernel_dh_compute':
  ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
    struct keyctl_dh_params params = { .private = private,
                                        ^~~~~~~
                                        dh_private

This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Stephan Mueller <smueller@chronox.de>
cc: James Morris <jmorris@namei.org>
cc: "Serge E. Hallyn" <serge@hallyn.com>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: <stable@vger.kernel.org>
---

 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 910cc4334b21..7b8c9e19bad1 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 dh_private;
+	__s32 private;
 	__s32 prime;
 	__s32 base;
 };
diff --git a/security/keys/dh.c b/security/keys/dh.c
index 3b602a1e27fa..711e89d8c415 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -300,7 +300,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;

