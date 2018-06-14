Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C7A5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B54208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B54208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964889AbeFNVky (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:40:54 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:53184
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755410AbeFNVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:40:52 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id TZyBfOqIMN7esTZyBfCJKr; Thu, 14 Jun 2018 14:39:51 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1fTZyB-0000lG-GL; Thu, 14 Jun 2018 14:39:51 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Fix the variable sizes in ipsecv2 and rsc offload
Date:   Thu, 14 Jun 2018 14:39:12 -0700
Message-Id: <20180614213912.2889-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfMu9h1AX3f6OiDQcl8mEzz9KE3ptGwU1WATuV/gkjh1MvMyPB3fYG20uI6ZKTuv9DQbq+BNhwvbxP7+R0n/zYDs7wrek5Fa9cwaQWAWsVJCBqCtCBALf
 2nch93YR52xf2qmcU9Dz1VrzcG3Dkavc1/z9oPbnReQhy7/4GA8i/7aHUGetzkEget4tVOecAG3CoFU2L/0IEkv/2fdL1CtQaJ4FR9kmzyCNctIQBuxhJ4yV
 COaZOfdV64QrQRWmKiRQTP93npuHzNw3eO2D5YhyTrMSkgygekfckRWEpVJtxMyOKOsOO2gKcPy65Wd1b3MN0/vNohcX27IXXypx8SNqDWWlQmx8GcbPTXTQ
 6slT6ai9ImJr7RvwYHyiYOUp82aGCDSAy4KgzOELQTT4sGbU7BVcVN1hVHEbLTsn4vivE9Nv4CUi1zLTK6yq64xfxE8aWx3/Q2I4Jok9ugh0VZfKZnxhUWVD
 V8n2EeazAWlu4ppNAM0HS4IGUWmgPhtZ7Tv4Pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

These fields in struct ndis_ipsecv2_offload and struct ndis_rsc_offload
are one byte according to the specs. This patch defines them with the
right size.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 23304aca25f9..84eaaa6368a2 100644
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

