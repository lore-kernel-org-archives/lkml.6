Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267079-2-15221009234504658223
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267079; b=E/4slhkxtoNtwLZSrUA6t7kGo9VM6PhU8BiQPXSPdQdcKqHHlx
    ik44wovdOYFrQgyzo0viD2BQdMWqW3fwJ8tOlIbu7CKeqZw3PP8ygydEbwQRaqtH
    43eF11Jx36Ma5oAjyGDpUq052052vVf76YLICd21yoO+Wtj65ZTwA/uLWlCn4o+e
    Cp0xQtkkCSVb1vOrCLx/AtMFiy3g15kqi8XtEKAACJj/GShCghCNnXv5+uCn6Hsb
    X4KOvjOdPCtztZprFPaP7OayJ4Zl211BLPvdK46O2SRczC1f8KDIctvvt5gT3xNi
    oMmsWW4NGxQMuiKv+o+C8sEmQJfunuY0xlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267079;
    bh=uo14rSYhlYzjQBFCRxlSUqb0KSCgj7gDivisrTgCXyc=; b=DbMQiTl+IcyW
    i10/b5DTM+DQQPEG+DPfeW3s+gJhohRWqJVkkDmA6CFovHnbK3+xgxsUF0NmEOAq
    AR19RFZlKUIpWZtlmEyFeZgU7HWpgUZSo3128jU5k45jIzbEhG+oAx0eJG7Vh7im
    AIJQj7AYjAKAGA9y86XCXztbVcHAx5Ad+dQywkk4wY1xU1ckpnOlP7vY5mfvo8/N
    39jrf3yUDhorBvd7XaQ+9yye6AKzEm+hS7Wf2x3X5FWzQx8Xzq7WXYKWYU9s1dOd
    M2rK+lR+Ywr43/Lqdl6gQYNfdoBCNm5vmdxadrK8xKkvagGW60c4XB4bHJuYyyM6
    t1obz0b9xQ==
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
X-CM-Envelope: MS4wfAETZE2rN738Fh6By1EFDEx+QPyPad0XBa3xy1W9fOOugD3wlP7cP7Uvtu7GgFkRhDfdCBCtqIpz8oJ4vykRFDcg4yUdp3Cmkfxjs4CRUSp+2Qbkzx8E
    tQUVi3/C7jS8TWJbdChk7TUmmOAP4PoK4cKvrM5kp/G+4T33/AGdYpHyZgNMmvAhg4kvTz0qp7R9wVrhL6fjQnji8vRhZMcgKSDeVsrGXVm0CzK5acz77/4e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=Ns_SaZoR5cbUQq6wK4gA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeENDEg (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:04:36 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:37992
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752041AbeENDEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:04:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DGCgBP/Pha/+U/0XZcHAEBAQQBAQoBA?=
 =?us-ascii?q?YNDgVwog3KUcEUBAQEDBoEHNHyOQYZpHhgBhEACgwkhNxUBAgEBAQEBAQJsKIU?=
 =?us-ascii?q?pBiNWEBgBDAIYDgICRxAGE4UXDKl9ghwaAogggieBCYccgQyBB4E+hxiDN4I0I?=
 =?us-ascii?q?AKMeos8CY5RgSgOhjWFBIdIikAyIoFSTS4Kgn6QWzIwegEBjRuCRgEB?=
X-IPAS-Result: =?us-ascii?q?A2DGCgBP/Pha/+U/0XZcHAEBAQQBAQoBAYNDgVwog3KUcEU?=
 =?us-ascii?q?BAQEDBoEHNHyOQYZpHhgBhEACgwkhNxUBAgEBAQEBAQJsKIUpBiNWEBgBDAIYD?=
 =?us-ascii?q?gICRxAGE4UXDKl9ghwaAogggieBCYccgQyBB4E+hxiDN4I0IAKMeos8CY5RgSg?=
 =?us-ascii?q?OhjWFBIdIikAyIoFSTS4Kgn6QWzIwegEBjRuCRgEB?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179625"
Subject: [PATCH 06/10] autofs - update fs/autofs4/Makefile
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:04:28 +0800
Message-ID: <152626706824.28589.1915028175544560855.stgit@pluto.themaw.net>
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

Update Makefile to build from source in fs/autofs instead of
fs/autofs4.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/Makefile b/fs/autofs4/Makefile
index a811c1f7d9ab..417dd726d9ef 100644
--- a/fs/autofs4/Makefile
+++ b/fs/autofs4/Makefile
@@ -4,4 +4,6 @@
 
 obj-$(CONFIG_AUTOFS4_FS) += autofs4.o
 
-autofs4-objs := init.o inode.o root.o symlink.o waitq.o expire.o dev-ioctl.o
+autofs4-objs := ../autofs/init.o ../autofs/inode.o ../autofs/root.o \
+	../autofs/symlink.o ../autofs/waitq.o ../autofs/expire.o \
+	../autofs/dev-ioctl.o
