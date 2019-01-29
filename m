Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1404C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCD42087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="pN0tUh2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfA2Mwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:52:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfA2Mwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:52:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so17619168wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JSPp80mPpjMLHxiYwgVFlyS+M+a8c9VP14HDP0AdVTs=;
        b=pN0tUh2FSYj/VRZ+2jGRxoBSRHccfZ6jkiD5hzN/uq+lxTXXDqbFIKBCZ/PoA09HjP
         eBv7RYaQC2G4L2s1sOlWuE1bA9N411XSG2bOIFk9E/MOXFvSIgDrNkekziOG792zrlJr
         TQ6uh6HeZO8n6Tp4QAsTLB+imAtdhFI8Pxs5Hz1fye2a0zkmr+0PszO0kla9LXYyGBjk
         8Y9IAE1uWFhokjIiuhfnmp9i09yiyci6BbHnau1XJwKbr5IM/Os0iFoG7/GcETJjeriA
         CpzCB4rDZ+Z9DCED6zs60DqTdgnvEhetUy+/8n9ig3dRCa2+1WMH20apdbWeskug7p0F
         YvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JSPp80mPpjMLHxiYwgVFlyS+M+a8c9VP14HDP0AdVTs=;
        b=aK/vynzPJ+/iz5Vqpoq1dVETanmpWJDOS0MsWvU/v71pSmuESwNLHB5vanN6NB8+W+
         ybPJiANebZh3OnYG17mQQh0jn901Mg+lxwNDMAtWfNmWN6AIM2X3jj8qQOB/IAtiBZ2V
         J3jDJW4HdtO0nWJzBzXQvSENTTad0ZyBPP1m352jyGGw0NhjJJt3DPwXUVPdmg8i01b4
         iDh9G4MjRy6I/kGuXobTl+WQWDddkVM3sq7MsEVBdkonYAumaLKA/XDBQwp7V/Wcig6v
         8x+IaiM70RpWiMqwWp9YZIah+tbYeemUBBkh7UenHtupzbY0rnTa9Jm2mkqUWkjxrpM9
         egXQ==
X-Gm-Message-State: AJcUukd/wI8NwX/B8OlrjFOKkv6/Ie1hb9Fsin8NqIohIg4se9/OL2j7
        Q5uWqlS3qfnk6mRlhrcoE+vVDw==
X-Google-Smtp-Source: ALg8bN58VCwosDhmCkNtXtouFzj89sKW38eHL40q8pfooTyX8TEnGusolWiT74slvUmEcLf9F2p41Q==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr21653090wme.73.1548766364560;
        Tue, 29 Jan 2019 04:52:44 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-8-90.red.bezeqint.net. [79.183.8.90])
        by smtp.gmail.com with ESMTPSA id m21sm2872724wmi.43.2019.01.29.04.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 04:52:43 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     yan@daynix.com
Subject: [PATCH] virtio_net: Introduce extended RSC feature
Date:   Tue, 29 Jan 2019 14:52:36 +0200
Message-Id: <20190129125236.12165-1-yuri.benditovich@daynix.com>
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
 include/uapi/linux/virtio_net.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..93c71d714475 100644
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
@@ -140,6 +141,18 @@ struct virtio_net_hdr_mrg_rxbuf {
 	struct virtio_net_hdr hdr;
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
+
+static inline __virtio16 *virtio_net_rsc_ext_num_packets(
+	struct virtio_net_hdr *hdr)
+{
+	return &hdr->csum_start;
+}
+
+static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
+	struct virtio_net_hdr *hdr)
+{
+	return &hdr->csum_offset;
+}
 #endif /* ...VIRTIO_NET_NO_LEGACY */
 
 /*
-- 
2.17.1

