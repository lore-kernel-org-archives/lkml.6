Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965279AbeEIPtB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:49:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935399AbeEIPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:48:27 -0400
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC 1/2] s390/cio: export hsch to modules
Date: Wed,  9 May 2018 17:48:21 +0200
Message-Id: <20180509154822.23510-2-cohuck@redhat.com>
In-Reply-To: <20180509154822.23510-1-cohuck@redhat.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio-ccw code will need this, and it matches treatment of ssch
and csch.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/ioasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
index 14d328338ce2..08eb10283b18 100644
--- a/drivers/s390/cio/ioasm.c
+++ b/drivers/s390/cio/ioasm.c
@@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
 
 	return ccode;
 }
+EXPORT_SYMBOL(hsch);
 
 static inline int __xsch(struct subchannel_id schid)
 {
-- 
2.14.3
