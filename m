Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1AF58C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB26D208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB26D208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965179AbeFOBaV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:30:21 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:45534
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965105AbeFOBaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:30:19 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id TdYEf8xBUdjTiTdYEfMD0U; Thu, 14 Jun 2018 18:29:18 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1fTdYE-0003VR-9a; Thu, 14 Jun 2018 18:29:18 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_netvsc: Fix the variable sizes in ipsecv2 and rsc offload
Date:   Thu, 14 Jun 2018 18:29:09 -0700
Message-Id: <20180615012909.13440-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfLSBLqervi28uzYJL/Bm35rYSBQU2fJzSEeYjqEO103d9wqbi0WjTPE5FfTa5MqBI7rBo0UsDHpT9cXUB1lfqS3YXFXQwAZ+rRckHZs3AZjwymP/pvDs
 nC6YysxVFm50wutKTAPzzrvXXhbxNC6LiOgqZoRH4oo/VezIhdj0YhmvqKqRCBf3c+l8wwPOn5IrlFXQpxNQHjPt+LkQKb4/menOejKH+6eoR2HDoEhyu1Hp
 5i/KgdWndElAU30/diGc2tx+4f0q8wiOtHHHgOEN9rrlPuVcHQk9n1CeVkATdR5pGEIV48z1oG1xe6Mw0d5WKQCGzJPyCfJswuhb7M7klQFkoQbeXVU+j4I9
 sm/F3+lROEGPsK4QQ5odiIjLgvkNwWvkmrtdUoQlUdKyvTDuP7wXxBio6F5P5dCVuTQGBeExKIkl+6UlEBhhGAUEE/uqk9K6CFG9RRRhcnIYhFS83TCaBU02
 oXRx3HRgUg2bPbXGPAzDZcvMlG1i0XeNxTFXWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

These fields in struct ndis_ipsecv2_offload and struct ndis_rsc_offload
are one byte according to the specs. This patch defines them with the
right size. These structs are not in use right now, but will be used soon.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index d31c0cd329a1..1a924b867b07 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1277,17 +1277,17 @@ struct ndis_lsov2_offload {
 
 struct ndis_ipsecv2_offload {
 	u32	encap;
-	u16	ip6;
-	u16	ip4opt;
-	u16	ip6ext;
-	u16	ah;
-	u16	esp;
-	u16	ah_esp;
-	u16	xport;
-	u16	tun;
-	u16	xport_tun;
-	u16	lso;
-	u16	extseq;
+	u8	ip6;
+	u8	ip4opt;
+	u8	ip6ext;
+	u8	ah;
+	u8	esp;
+	u8	ah_esp;
+	u8	xport;
+	u8	tun;
+	u8	xport_tun;
+	u8	lso;
+	u8	extseq;
 	u32	udp_esp;
 	u32	auth;
 	u32	crypto;
@@ -1295,8 +1295,8 @@ struct ndis_ipsecv2_offload {
 };
 
 struct ndis_rsc_offload {
-	u16	ip4;
-	u16	ip6;
+	u8	ip4;
+	u8	ip6;
 };
 
 struct ndis_encap_offload {
-- 
2.17.1

