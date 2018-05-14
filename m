Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267113-2-18115781448468624700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267112; b=mZIJdHSmyJv7ITyYlyeMOCgabp1CnLBA8PLr7vHBvbEj65VgkU
    saRbDyA/3bHRjL4c587srAaiFkfqbkC/3w11JKNvOfSXceKA6xvZi8ucW6t+Bkxc
    bZbVPoD9kAhNLEjWcwaIqOhZWvhn1654LOY/vtflbAxkEXYwAdVJHxeHmAaIPaLG
    LnIAAXBoxTP5j9cB7aVYLlPkdFWPDPT3t0abWYNVZcmR9kQtbwTn31QRyGOmD1A5
    unfmeKsYBC3IazLC1gRsNMhq7bQpsEWbV1+aXbaQrAPN6b7VVFVMIHqkZDbMYNAP
    6w1Hc3UXml0X/rGqbR+Bz9954OkoF7DDNs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267112;
    bh=92b72iCi2t8aCdWVuYAT1PEwUXILR0GCr+4by0GnIPs=; b=Bg+s5LAxcNAO
    V97T/PZ14TpgCDKxS8tGjOIG9zW5fUaiDjS/IK9mTVJz5eUSc/RYPh3q4FjUITaL
    UF5peM53AAQhPStIr6CjHlKuCJcUIGmTc6wEeln2N4RXFDHClZXIkHeNQw4EIB8C
    PBqLUrL7KeUEL6xgNJJHWIIIjjcYRQmkx8d70ZXojEwfbh7RWRT93d8Ql/mHB4jq
    YohbuvoErwtP6xDI+/vtCQRVXD467+Wcl10nNAKUXdTqjPkx89wR6lJ3Bm3zdKeq
    mong4kd6YCh731IJqMk85p0JwHKSZPJrc0thqW70XLUk8t7XonpobZJQh9xixiXp
    Av5w7t8WsA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfNixYFtaXqEtHYHGGnxY/a9TLUi3iphNM/oKa8Fp3sVtew1tdRTvJKGQtjxDGCGk5wh8kXMJROy26a1AXU63EhqTetgz+GCAQHUIBSdUbV0m4buoVeVD
    fFQkWID5/AvD9JvgqDw3TtwL3qGEiNtzMcbm50o425Xcj7CNE0RAxeCrXwArhHdIvrk8zkiCKIpL3R/DnQynp0tJ5KEwKRphkY0iGY80nXQWVAi26KBIVy62
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=xq3W2uTSAAAA:8 a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8
    a=e0y2CrVoJfMakpu50XAA:9 a=QEXdDO2ut3YA:10 a=-tElvS_Zar9K8zhlwiSp:22
    a=P5L7wpMTXyg1GfFA3Gwx:22 a=AjGcO6oz07-iQ99wixmX:22 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeENDFH (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:05:07 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:38166
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752101AbeENDFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:05:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DVCgBP/Pha/+U/0XZcHQEBBQELAYNDY?=
 =?us-ascii?q?Xsog3KUcEUBAQEDBoE7fJUqHggQAYRAAoMJITcVAQIBAQEBAQECbBwMhSkGI1Y?=
 =?us-ascii?q?QGAEMAhgOAgJHEAYTgyWBcgypfYIcGgKIIIIiBYEJhxyBDIEHjA2CVAKMeos8C?=
 =?us-ascii?q?YVniGqBNoY1hQSHSIpAMiKBUk0uCoJ+ixCFSzIwegEBj2EBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DVCgBP/Pha/+U/0XZcHQEBBQELAYNDYXsog3KUcEUBAQE?=
 =?us-ascii?q?DBoE7fJUqHggQAYRAAoMJITcVAQIBAQEBAQECbBwMhSkGI1YQGAEMAhgOAgJHE?=
 =?us-ascii?q?AYTgyWBcgypfYIcGgKIIIIiBYEJhxyBDIEHjA2CVAKMeos8CYVniGqBNoY1hQS?=
 =?us-ascii?q?HSIpAMiKBUk0uCoJ+ixCFSzIwegEBj2EBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179754"
Subject: [PATCH 10/10] autofs - update MAINTAINERS entry for autofs
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:04:56 +0800
Message-ID: <152626709611.28589.456596640024354223.stgit@pluto.themaw.net>
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

Update the autofs entry in MAINTAINERS to reflect the rename of
autofs4 to autofs.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58b9861ccf99..6189ff91fda7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7652,11 +7652,11 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-keene*
 
-KERNEL AUTOMOUNTER v4 (AUTOFS4)
+KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
 S:	Maintained
-F:	fs/autofs4/
+F:	fs/autofs/
 
 KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
 M:	Masahiro Yamada <yamada.masahiro@socionext.com>
