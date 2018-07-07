Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49C5C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510F921530
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 20:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="ukK4uIQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510F921530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754404AbeGGUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 16:00:32 -0400
Received: from bosmailout07.eigbox.net ([66.96.190.7]:38227 "EHLO
        bosmailout07.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeGGUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 16:00:30 -0400
X-Greylist: delayed 1897 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2018 16:00:30 EDT
Received: from bosmailscan02.eigbox.net ([10.20.15.2])
        by bosmailout07.eigbox.net with esmtp (Exim)
        id 1fbst2-00025F-Hq
        for linux-kernel@vger.kernel.org; Sat, 07 Jul 2018 15:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nP7t1MqDzKhUvZ5pmlbsgF001NHBUJaQXae6mknuC3o=; b=ukK4uIQiijAQoH5E/ui3OO3bFA
        9C9Ly5JTwT097uX4UbvtjViUtjETr7cJxiN1OmetnNHbBI3zzxtWW0JfkuWsaJ04UZazZhM3Ur7fS
        XD3oXcVd+kYhBBI/mEfeTxF6YQQ/l2dSQjfTOLDtmAGdGcMQdH8HR5MW00wnCxkRG2MKaX0JOjHeB
        u09afF8SpeGuY1Y5TZjA53i2AquJugvKfLg6XS1rskjUK6TxtONkemeYW2tERonRUeVTyolT6/kLf
        1gbkNt0aCti0Vo8orhK9PzlngzXblXEyEEdOiuYjc2xBv3CJFPLj98pTJtoAvwS/h8vnhvYXtdCSO
        OKE8kT+g==;
Received: from [10.115.3.32] (helo=bosimpout12)
        by bosmailscan02.eigbox.net with esmtp (Exim)
        id 1fbst2-0003cw-Em
        for linux-kernel@vger.kernel.org; Sat, 07 Jul 2018 15:28:52 -0400
Received: from bosauthsmtp11.yourhostingaccount.com ([10.20.18.11])
        by bosimpout12 with 
        id 7vUo1y0040EKspE01vUriU; Sat, 07 Jul 2018 15:28:52 -0400
X-Authority-Analysis: v=2.2 cv=UN2tJGXy c=1 sm=1 tr=0
 a=anyYG9rjTBM1sAjEBQ8Cew==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8
 a=Ewg49PsxOhnORZRthZ0A:9 a=QEXdDO2ut3YA:10 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=11949 helo=localhost.localdomain)
        by bosauthsmtp11.eigbox.net with esmtpa (Exim)
        id 1fbssy-0007C0-L0; Sat, 07 Jul 2018 15:28:48 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Constantine Shulyupin <const@MakeLinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] samples: fix compilatin of mpssd
Date:   Sat,  7 Jul 2018 22:28:17 +0300
Message-Id: <20180707192819.7355-1-const@MakeLinux.com>
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

