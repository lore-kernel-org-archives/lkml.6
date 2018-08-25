Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CAAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406D121581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406D121581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freedesktop.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHYFKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:10:06 -0400
Received: from mail.bsd-unix.net ([65.175.82.195]:41628 "EHLO
        mail.bsd-unix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeHYFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:10:06 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2018 01:10:06 EDT
Received: from vlee-ubuntu.corp.dropbox.com (unknown [4.16.47.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mailrelay)
        by mail.bsd-unix.net (Postfix) with ESMTPSA id 5FA801C00D7;
        Fri, 24 Aug 2018 21:26:36 -0400 (EDT)
From:   Vinson Lee <vlee@freedesktop.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: Fix linux/rds.h userspace compilation errors.
Date:   Fri, 24 Aug 2018 18:26:56 -0700
Message-Id: <20180825012656.12443-1-vlee@freedesktop.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/in6.h for struct in6_addr.

/usr/include/linux/rds.h:156:18: error: field ‘laddr’ has incomplete type
  struct in6_addr laddr;
                  ^~~~~
/usr/include/linux/rds.h:157:18: error: field ‘faddr’ has incomplete type
  struct in6_addr faddr;
                  ^~~~~
/usr/include/linux/rds.h:178:18: error: field ‘laddr’ has incomplete type
  struct in6_addr laddr;
                  ^~~~~
/usr/include/linux/rds.h:179:18: error: field ‘faddr’ has incomplete type
  struct in6_addr faddr;
                  ^~~~~
/usr/include/linux/rds.h:198:18: error: field ‘bound_addr’ has incomplete type
  struct in6_addr bound_addr;
                  ^~~~~~~~~~
/usr/include/linux/rds.h:199:18: error: field ‘connected_addr’ has incomplete type
  struct in6_addr connected_addr;
                  ^~~~~~~~~~~~~~
/usr/include/linux/rds.h:219:18: error: field ‘local_addr’ has incomplete type
  struct in6_addr local_addr;
                  ^~~~~~~~~~
/usr/include/linux/rds.h:221:18: error: field ‘peer_addr’ has incomplete type
  struct in6_addr peer_addr;
                  ^~~~~~~~~
/usr/include/linux/rds.h:245:18: error: field ‘src_addr’ has incomplete type
  struct in6_addr src_addr;
                  ^~~~~~~~
/usr/include/linux/rds.h:246:18: error: field ‘dst_addr’ has incomplete type
  struct in6_addr dst_addr;
                  ^~~~~~~~

Fixes: b7ff8b1036f0 ("rds: Extend RDS API for IPv6 support")
Signed-off-by: Vinson Lee <vlee@freedesktop.org>
---
 include/uapi/linux/rds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/rds.h b/include/uapi/linux/rds.h
index dc520e1a4123..8b73cb603c5f 100644
--- a/include/uapi/linux/rds.h
+++ b/include/uapi/linux/rds.h
@@ -37,6 +37,7 @@
 
 #include <linux/types.h>
 #include <linux/socket.h>		/* For __kernel_sockaddr_storage. */
+#include <linux/in6.h>			/* For struct in6_addr. */
 
 #define RDS_IB_ABI_VERSION		0x301
 
-- 
2.17.1

