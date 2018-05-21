Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4033468-1526864750-2-2339294536861126136
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526864750; b=AXNABlrAlyfPypJn8vflWUFJ0NuVzaOVQI3lXWvVsbKSNW1evb
    FDlJOFMCBna30YtU7kZ0dXtThFwYjts3GOwGHxQPY+xximsmwnwjzAh2nvabZ3fB
    AKvpmMB/YDj5SimXHqMror+dnIXemgAkhF1I45ieeECP3+Ov3KvYiFDnQQn1xHvm
    ujYvLM/Lzqiv3CKAw9GfEeTrKMy5rWLja2WHvpSR6q5xtgiM8qY4nOfutfnBB04J
    lP0geP0AYzKMVCjfZPrRi/9DxTbAbNpAekvB3vIAXXcCwUpSht/h2In2KQaTut1u
    u73hKMaErcacwkQLMXnGiPYSsJfvzhsLUgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526864750; bh=80FTDG02LcinGbOxl4B80Yzq/i3zFw
    BLffOhELFPGYM=; b=H2y8eCMI9Z+MHSZnibMrzhV3RguuUq01Z014ETybZXFCVF
    xH2lB4uoAke+vMFqRtJOzfdeDAHKEHEQbXRyUFgiVmn6IAF9W4oqyIw11rWQA1bb
    L218rYRRvWDkPcn9d8MtSw2kMD1wJ/eCGy4pdltIWnZTyNlcoMKmzZOcam7+ekXj
    eNufZW3BQYspVNT5lZIJMwBsVOdfHOEuG9H6OE9bnG0sm64n/CP503vTHoFO0jdw
    QStUZYaopJ4a56q9/8A6Yf65VvL9ADkhI06WeI+Jqti3LYsShMs33XmqLYDqeqIM
    fcRfYAMX+JqLn3UVjcoRErUcrFy1r6uzniCn02Fg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAnZBov0wA6ImA1fXhU2qx+poxb36U6LPy8iJMPj9PYGFzDn8yblDWvVbGfJLDFBc/oFnkk2VSzs5weKPWVePDzHi+7fM5awo7RQHNHJH31lmbrOe3gY
    4kFmOgmAM8jGeJ2DMF5NbL7vb+h42BFHLMwwRTVMiW0AhSy6eLxIK7nDKWRSmScR16zPaWG/r4BWlBwqZ4E5PDzywOhzf0uJHj1ayAimWGeBS9dPtFYaNW2M
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=plLDmvKwOQ-xL7X99yQA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeEUBFq (ORCPT <rfc822;linux@kroah.com>);
        Sun, 20 May 2018 21:05:46 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:57702
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751609AbeEUBFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 May 2018 21:05:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BrCgApGgJb/+U/0XZaHgEGDINDgV4og?=
 =?us-ascii?q?3SUfEYBAQEBAQaBBzR8k0qBZB4YAYRAghMhOBQBAgEBAQEBAQJsKIVSVigBDAI?=
 =?us-ascii?q?YDgJJFhOFFgylU4IcGgKIIYIPgQmHLIEMgQeBPoc4gxiCVAKMIGOLSQmOV4E3g?=
 =?us-ascii?q?22CUIUIAZIcMyGBUk0uCoJ+giAXjiQyMHoBAY8oAQE?=
X-IPAS-Result: =?us-ascii?q?A2BrCgApGgJb/+U/0XZaHgEGDINDgV4og3SUfEYBAQEBAQa?=
 =?us-ascii?q?BBzR8k0qBZB4YAYRAghMhOBQBAgEBAQEBAQJsKIVSVigBDAIYDgJJFhOFFgylU?=
 =?us-ascii?q?4IcGgKIIYIPgQmHLIEMgQeBPoc4gxiCVAKMIGOLSQmOV4E3g22CUIUIAZIcMyG?=
 =?us-ascii?q?BUk0uCoJ+giAXjiQyMHoBAY8oAQE?=
X-IronPort-AV: E=Sophos;i="5.49,425,1520870400";
   d="scan'208";a="99701058"
Subject: [PATCH] autofs - comment on selinux changes needed for module
 autoload
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 21 May 2018 09:05:41 +0800
Message-ID: <152686474171.6155.1239659539983577463.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Due to the autofs4 module using a file system type name of autofs
different from the module containing directory name autoload did
not function properly. To work around this kernel configurations
have often elected to build the module into the kernel.

This can result in selinux policies that prohibit autoloading of
the autofs module which need to be changed.

Add a comment about this to "possible changes" section of the
autofs4 module help.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 2c2fdf989f90..99fda4d6da25 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -29,6 +29,12 @@ config AUTOFS4_FS
 	    and the module name are the same as the file system name there
 	    is no need to manually load module.
 	  - any "alias autofs autofs4" will need to be removed.
+	  - due to the autofs4 module directory name not being the same as
+	    its file system name autoloading didn't work properly. Because
+	    of this kernel configurations would often build the module into
+	    the kernel. This may have resulted in selinux policies that will
+	    prevent the autofs module from autoloading and will need to be
+	    updated.
 
 	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
 
