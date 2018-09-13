Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B20C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368A620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368A620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeIMS71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbeIMS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:26 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BF86CFE;
        Thu, 13 Sep 2018 13:49:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 095/115] uapi/linux/keyctl.h: dont use C++ reserved keyword as a struct member name
Date:   Thu, 13 Sep 2018 15:31:55 +0200
Message-Id: <20180913131829.298662284@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 8a2336e549d385bb0b46880435b411df8d8200e8 upstream.

Since this header is in "include/uapi/linux/", apparently people want to
use it in userspace programs -- even in C++ ones.  However, the header
uses a C++ reserved keyword ("private"), so change that to "dh_private"
instead to allow the header file to be used in C++ userspace.

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=191051
Link: http://lkml.kernel.org/r/0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org
Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/keyctl.h |    2 +-
 security/keys/dh.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,7 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	__s32 dh_private;
 	__s32 prime;
 	__s32 base;
 };
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
 	}
 	dh_inputs.g_size = dlen;
 
-	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
+	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
 	if (dlen < 0) {
 		ret = dlen;
 		goto out2;


