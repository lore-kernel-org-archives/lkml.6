Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3502089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3502089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJICSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:18:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:25179 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeJICSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:18:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 12:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="77189193"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2018 12:02:02 -0700
Subject: [resend PATCH] MAINTAINERS: Clarify UIO vs UACCESS maintainer
From:   Dan Williams <dan.j.williams@intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 11:50:09 -0700
Message-ID: <153902452503.3147008.1742604660028168607.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UIO file mask in MAINTAINERS was incorrectly directing UACCESS
(include/linux/uio.h) patches to Greg.

Tag Al as the UACCESS maintainer as Ingo and others have explicitly
required his ack before taking architecture patches that touch
lib/iov_iter.c.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
I got a bounce last time I tried to send this, hopefully the situation
has improved now.

Al, let me know if you want this entry. Alternatively we can just do the
UIO file mask fixup by itself.

 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22e7fdfd2ea..7abd97b96725 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15366,13 +15366,19 @@ F:	arch/x86/um/
 F:	fs/hostfs/
 F:	fs/hppfs/
 
+USERSPACE ACCESS (UACCESS)
+M:	Alexander Viro <viro@zeniv.linux.org.uk>
+S:	Maintained
+F:	lib/iov_iter.c
+F:	include/linux/uio.h
+
 USERSPACE I/O (UIO)
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	Documentation/driver-api/uio-howto.rst
 F:	drivers/uio/
-F:	include/linux/uio*.h
+F:	include/linux/uio_driver.h
 
 UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>

