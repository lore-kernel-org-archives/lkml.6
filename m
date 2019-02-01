Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454AF20811
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ye3p/+Nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfBAIuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:50:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34006 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBAIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:50:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so3998241wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vCX2vdQCQ3oeBCwnvrduM+Rmgr/c5zh9BwGBr+0dFTY=;
        b=ye3p/+NhuM4+CEurEK7jy3y1vNAbu0krx3G7+hiI8zv86qmAExxd/ezFl5WkcKMWEm
         xRNsqVvS3f+NURQv2HYmkjecpv2Bhy2ylwKfDZB3iwEEi/FYfqwzRbF9KMYqJxRDz7g6
         d0d+pD1OyryvJWJefqlCV7UwImUV+ZPLnClWpu2axf0QITxdFBH3/kuyr20G+3qxl2bk
         zdnWnMafIXd0kxTEYjs9ZjJ0Yhihw3rbTQTbNPaXlmvx0vLRWJF6YX8+VSO8NkRfQ1/r
         4dLmdLwwHO2U2N8l3caPX9Gqy1D0gQ7jgwHZR2FCGhbK4ns0ygFSNrtdH5bo90IkIo6T
         DlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vCX2vdQCQ3oeBCwnvrduM+Rmgr/c5zh9BwGBr+0dFTY=;
        b=BU0UsVDmsCjS/gPq2AyV1fg5XEvfwhsbMtEKMFl3xhNy52ojIPFu5JylFTcRQcIGzX
         3xUhCpokx3Jm+BPWDibJWfA81M0mLPQR225aF9Arm+lvkgROd+2D7oEdtTiiNQwaLkkL
         KUhiW2AuyrVZOlmAJLDda6CsdyKIhVRJpYsoCbuMuOpfP2FCwQ/MpFLGHM5iZ/jS0GOQ
         3ysXq48uf1KAS0H7tWZhV5v4JWotzMRjEaYM2M2RXL+ARnb0A7v1bgBVjQ6cdgSCbfxF
         LKTigGNui5uxhPoAl9AVx2UnFYWMjnnXzY3vGxdiMNJvzP1oVL9AV96y7uueruHrIFqq
         ONsw==
X-Gm-Message-State: AHQUAuYzZEIC9aHY81s9gvjkoQgXB07HLUyP0tJPHWsmS+FrJH2B5Ux/
        AZQf9Q4105cMeEHKoYVXdCWnh0cC3kg=
X-Google-Smtp-Source: AHgI3IYuJgYvWqt571r7kxJB9+p/8YlwnkbkLUKzSVLRTYsg3ZYl4ev/B3ki9dgX+55PSHb4Z6hD+g==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr1388846wma.90.1549011049092;
        Fri, 01 Feb 2019 00:50:49 -0800 (PST)
Received: from f2.Home (bzq-79-183-30-103.red.bezeqint.net. [79.183.30.103])
        by smtp.gmail.com with ESMTPSA id x12sm5527059wrt.20.2019.02.01.00.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 00:50:48 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH v2] virtio_net: Introduce extended RSC feature
Date:   Fri,  1 Feb 2019 10:50:35 +0200
Message-Id: <20190201085035.18481-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
is able to provide extended RSC information. When the feature
is active and 'gso_type' field in received packet is not GSO_NONE,
the device reports number of coalesced packets in 'csum_start'
field and number of duplicated acks in 'csum_offset' field
and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..23e73d666fc2 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,7 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
-
+#define VIRTIO_NET_F_RSC_EXT	  61	/* Provides extended RSC info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
 					 * with the same MAC.
 					 */
@@ -104,6 +104,7 @@ struct virtio_net_config {
 struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
+#define VIRTIO_NET_HDR_F_RSC_INFO	4   /* rsc_ext data in csum_ fields */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
@@ -118,6 +119,15 @@ struct virtio_net_hdr_v1 {
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
+/* if VIRTIO_NET_HDR_F_RSC_INFO is set, the csum_start
+ * field contains number of coalesced segments
+ */
+#define virtio_net_rsc_ext_num_packets csum_start
+/* if VIRTIO_NET_HDR_F_RSC_INFO is set, the csum_offset
+ * field contains number of duplicated acks
+ */
+#define virtio_net_rsc_ext_num_dupacks csum_offset
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.17.1

