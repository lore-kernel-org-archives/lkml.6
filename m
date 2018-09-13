Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEB5C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA4920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeIMK3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:29:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:21315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeIMK3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:29:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 22:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,367,1531810800"; 
   d="scan'208";a="262175720"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2018 22:21:10 -0700
Subject: [PATCH] MAINTAINERS: Clarify UIO vs UACCESS maintainer
From:   Dan Williams <dan.j.williams@intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Sep 2018 22:09:28 -0700
Message-ID: <153681530631.454480.6512525122403854324.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Al, let me know if this is ok. Alternatively we could just fix the file
mask for UIO and not add a new UACCESS section.

 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..be6c29cfeb55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15344,13 +15344,19 @@ F:	arch/x86/um/
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

