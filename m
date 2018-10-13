Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B9BC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E520877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0E520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeJMMWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:22:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:40237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeJMMWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:22:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 21:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,375,1534834800"; 
   d="scan'208";a="77702745"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2018 21:47:03 -0700
Subject: [PATCH v2] MAINTAINERS: Clarify UIO vs UIOVEC maintainer
From:   Dan Williams <dan.j.williams@intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 21:35:15 -0700
Message-ID: <153940527415.1426279.4626543256133656257.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UIO file mask in MAINTAINERS was incorrectly directing UIOVEC
(include/linux/uio.h) patches to Greg.

Tag Al as the UIOVEC maintainer as Ingo and others have explicitly
required his ack before taking architecture patches that touch
lib/iov_iter.c.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
* Rename UACCESS to UIOVEC

 MAINTAINERS |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..c1841d58d7ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15344,13 +15344,19 @@ F:	arch/x86/um/
 F:	fs/hostfs/
 F:	fs/hppfs/
 
+USERSPACE COPYIN/COPYOUT (UIOVEC)
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

