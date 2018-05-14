Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267081-2-5183186899977468499
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267081; b=aQzspZbc+kqBWqef0IwmlAombuOz3FmYg1T0B8+IS47lqNpNB4
    4Srog7JW0JZKhzf6ZpNtoN95CFBOGzTJkFczhtoeQOMs8ilCD42NXd04vGzrgE3c
    5xByZlqSuf9DW9K9uor7j9/AT8UBdHLsaAup7ishIv9nLe7aPp+WNhv2rgJwGCz9
    afEFog7UFqatAkn/p96n0Uesij7fax36wjOhViynVDbIjlENli0IUYmKlWzD9IEI
    ja7LqeQBhvrJVkomHKN/IXX904uowA0GeShss474W9Macc6kUH3LZ6osmmXQ+suV
    XIS3iswyJ4faPyoG9pk806W1RXXc1igqXRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267081;
    bh=F771auczyIvSojz8L5PacWlnw5jjE89/9TLlamhFoW8=; b=DkWc2heHqk8i
    XLgYpOaptz5HO5p6zCNz14b5yNosZ27P3PF9xcVmGb0tuYjyc5ahajbViW9fgx2r
    p/Lj2vI6xBXjATdlZSNj5hwwAT3R7XWefh+aGUZIobjuF8twStauQ/SRC2HYij22
    Hn0ebcfvEyQ6YTgBZAnLz9sU1i38gmjUb1BiQYKi71FXunlpXSnkndZznevhx8tC
    NmfjkDJOrheviEdRd7mvudZYXsIE1hzgx6opDLaB6FAxx1I5QyVun6Y1cK3Y5HZQ
    T+gYyDjAhnOoiQL4pCRtomiSmgddzv+IQ26he7pXybLSZTwTyAb8zgpbKt7T+yXx
    QqlOLQ90Ig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDpz1OneKf9OZrDTbJRWrdSNpfONMKXqDE5kTKjuQH41wdUozlAoFbTq1Tc17HA+zHOh5yN1xJmX6T7EXL52DFnfMreeJ6nS7FwuQYzgySXKzDIAAT2+
    Qt9W2mjpETD13uQ6250ll7ijxRI38kG/nYy59R/VpUvcjWcsWSiwvW8tvBHxs4ieaIw+1EwkLB7HXL8H6X1yZP2V/wsxESYskZnbMzYWK9nr8JkpCme6J+C7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=VwQbUJbxAAAA:8 a=GX-Q3UpT-RqOhBGqDUsA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeENDEf (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:04:35 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:38052
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751953AbeENDEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:04:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C4CwBP/Pha/+U/0XZcHgEGDINDYXsog?=
 =?us-ascii?q?3KUcEUBAQEDBoEHNHyTRoFkHhAIAYRAAoMJITcVAQIBAQEBAQECbBwMhSkGI1Y?=
 =?us-ascii?q?QGAEMAhgOAgJHEAYTgyWBcgwQqW2CHBoCiCCCIgWBCYccgQyBB4E+hygPgxiCV?=
 =?us-ascii?q?AKHOIRgYos8CY5RgTaDZYJQhQSHSIpAMiKBUk0uCoJuAQEBDYsQhUsyMHoBAY0?=
 =?us-ascii?q?bgkYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2C4CwBP/Pha/+U/0XZcHgEGDINDYXsog3KUcEUBAQEDBoE?=
 =?us-ascii?q?HNHyTRoFkHhAIAYRAAoMJITcVAQIBAQEBAQECbBwMhSkGI1YQGAEMAhgOAgJHE?=
 =?us-ascii?q?AYTgyWBcgwQqW2CHBoCiCCCIgWBCYccgQyBB4E+hygPgxiCVAKHOIRgYos8CY5?=
 =?us-ascii?q?RgTaDZYJQhQSHSIpAMiKBUk0uCoJuAQEBDYsQhUsyMHoBAY0bgkYBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179598"
Subject: [PATCH 05/10] autofs - update fs/autofs4/Kconfig
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:04:21 +0800
Message-ID: <152626706133.28589.11994171621899212952.stgit@pluto.themaw.net>
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update Kconfig and add a depricated warning.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Kconfig |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 44727bf18297..53bc592a250d 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,5 +1,6 @@
 config AUTOFS4_FS
-	tristate "Kernel automounter version 4 support (also supports v3)"
+	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
+	default n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -7,14 +8,25 @@ config AUTOFS4_FS
 	  automounter (amd), which is a pure user space daemon.
 
 	  To use the automounter you need the user-space tools from
-	  <https://www.kernel.org/pub/linux/daemons/autofs/v4/>; you also
-	  want to answer Y to "NFS file system support", below.
+	  <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
+	  to answer Y to "NFS file system support", below.
 
-	  To compile this support as a module, choose M here: the module will be
-	  called autofs4.  You will need to add "alias autofs autofs4" to your
-	  modules configuration file.
+	  This module is in the process of being renamed from autofs4 to
+	  autofs. Since autofs is now the only module that provides the
+	  autofs file system the module is not version 4 specific.
 
-	  If you are not a part of a fairly large, distributed network or
-	  don't have a laptop which needs to dynamically reconfigure to the
-	  local network, you probably do not need an automounter, and can say
-	  N here.
+	  The autofs4 module is now built from the source located in
+	  fs/autofs. The autofs4 directory and its configuration entry
+	  will be removed two kernel versions from the inclusion of this
+	  change.
+
+	  Changes that will need to be made should be limited to:
+	  - source include statments should be changed from autofs_fs4.h to
+	    autofs_fs.h since these two header files have been merged.
+	  - user space scripts that manually load autofs4.ko should be
+	    changed to load autofs.ko. But since the module directory name
+	    and the module name are the same as the file system name there
+	    is no need to manually load module.
+	  - any "alias autofs autofs4" will need to be removed.
+
+	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
