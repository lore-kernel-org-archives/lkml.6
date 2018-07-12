Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D12C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA9E20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="rScu/uvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA9E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbeGLF5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:18 -0400
Received: from bosmailout02.eigbox.net ([66.96.184.2]:50007 "EHLO
        bosmailout02.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeGLF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:57:17 -0400
X-Greylist: delayed 1843 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 01:57:17 EDT
Received: from bosmailscan08.eigbox.net ([10.20.15.8])
        by bosmailout02.eigbox.net with esmtp (Exim)
        id 1fdU02-0004at-HI
        for linux-kernel@vger.kernel.org; Thu, 12 Jul 2018 01:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nP7t1MqDzKhUvZ5pmlbsgF001NHBUJaQXae6mknuC3o=; b=rScu/uvysWXphx3v7++aRNrM3J
        H0Qmbtr9/Zu/HKjEw/LNZ2t0zQM8YQ9g7j9JwIstCGzPobqefsq2/xiMTgUDZ7JVkzNnL/R/zbNvw
        1WScioGqp2MPxmTnvRZbfB8/boiy9IY8QJiSPL0BJsc3qyR6Z4h/16wi1lGPe5Rq8OGKJR2b2mYh1
        5T4ZAYfh6nBlqXTYUKMupGc0E8vghsmYsxbNU8AUqfhMjGYXCcVCM6OnIDOhQZJhCVnTbpMzTOG+X
        UbaIo14rvrN2BjO3uwoxIzEBK9rU/KNcu6fQ8i0xxciSsX1M8YeU+nKZpENzaCPTVFo4njUWq9vPA
        8W21LZug==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan08.eigbox.net with esmtp (Exim)
        id 1fdU02-000165-ED
        for linux-kernel@vger.kernel.org; Thu, 12 Jul 2018 01:18:42 -0400
Received: from bosauthsmtp17.yourhostingaccount.com ([10.20.18.17])
        by bosimpout13 with 
        id 9hJf1y0010N5uqq01hJi5i; Thu, 12 Jul 2018 01:18:42 -0400
X-Authority-Analysis: v=2.2 cv=MK0QoIRl c=1 sm=1 tr=0
 a=f4kFLigMKr8AH7rIJ//qJA==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8
 a=Ewg49PsxOhnORZRthZ0A:9 a=QEXdDO2ut3YA:10 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=11936 helo=localhost.localdomain)
        by bosauthsmtp17.eigbox.net with esmtpa (Exim)
        id 1fdTzy-0002eV-OY; Thu, 12 Jul 2018 01:18:39 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Constantine Shulyupin <const@MakeLinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] samples: fix compilation of mpssd
Date:   Thu, 12 Jul 2018 08:17:36 +0300
Message-Id: <20180712051739.24709-1-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 37.142.20.114
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors:

In file included from /usr/include/x86_64-linux-gnu/sys/types.h:194:0,
                 from /usr/include/stdlib.h:394,
                 from mpssd.c:23:
mpssd.c:93:10: error: initializer element is not constant
   .num = htole16(MIC_VRING_ENTRIES),

mpssd.c:610:10: warning: implicit declaration of function ‘readv’;

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 samples/mic/mpssd/mpssd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/mic/mpssd/mpssd.c b/samples/mic/mpssd/mpssd.c
index f42ce551bb48..9cddb9cfdc79 100644
--- a/samples/mic/mpssd/mpssd.c
+++ b/samples/mic/mpssd/mpssd.c
@@ -33,6 +33,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
+#include <sys/uio.h>
 #include <linux/virtio_ring.h>
 #include <linux/virtio_net.h>
 #include <linux/virtio_console.h>
@@ -77,6 +78,10 @@ static struct mic_info mic_list;
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
 #endif
 
+#define __uint16_identity(x) (x)
+#define __uint64_identity(x) (x)
+#define __uint32_identity(x) (x)
+
 static struct {
 	struct mic_device_desc dd;
 	struct mic_vqconfig vqconfig[2];
-- 
2.17.1

