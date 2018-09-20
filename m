Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E16ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E59214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E59214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeITWww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:52:52 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:55446
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbeITWwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:52:51 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 32QFgMau2M0DP32QFgaFga; Thu, 20 Sep 2018 10:07:24 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1g32QF-0002W1-NV; Thu, 20 Sep 2018 10:07:23 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,0/3] hv_netvsc: Support LRO/RSC in the vSwitch
Date:   Thu, 20 Sep 2018 17:06:58 +0000
Message-Id: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfGc7/lPH70RjjieotoAOkWxbDtfKvsMVW4F1J+7wtCeIRFM3mIvB0oY1UwKIGy19PBzCmP3ytTkB8MPfsThVxhIarUkHSgiSQ4VPDULu36RA/z0+iHOV
 xmJNjwF9D3hOB15YOXBbaHo1RbASr5664jqrJwjNtkucM5VhsLcWxDFHUFAEBQpGOy/NeqjNC4q0dP/rVa5uhIIp0A6hLN8Gzs7e9yfbXngb/GPJXtkW2ENh
 I/QEaRo56P0K0ye7o5lYQv/Yb65yijHjXpF0zf7ggyhb1a8isLZinr407XkwTa7kg2o6yu6wU7Crh72v71teoyxyir2wrGBCIEBzO7y9sKKDDe2E/NFncDNc
 vN1FL7/UPd0kql/MEoH4RFcA0dfh7Ez9Q6b7jdt9bixTkCHWxMRvg9OGGj1kl7XGVg8ykEDOu641k0lfJme/LICilm4HPPFCQLMKhsjCOP7nlRKWGaoVEQyE
 bAewYppx4aLJkp0sMKYBEw1e2uvw+hB6ZQS3bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The patch adds support for LRO/RSC in the vSwitch feature. It reduces
the per packet processing overhead by coalescing multiple TCP segments
when possible. The feature is enabled by default on VMs running on
Windows Server 2019 and later.

The patch set also adds ethtool command handler and documents.

Haiyang Zhang (3):
  hv_netvsc: Add support for LRO/RSC in the vSwitch
  hv_netvsc: Add handler for LRO setting change
  hv_netvsc: Update document for LRO/RSC support

 Documentation/networking/netvsc.txt |  9 +++
 drivers/net/hyperv/hyperv_net.h     | 51 ++++++++++++---
 drivers/net/hyperv/netvsc.c         | 18 ++++--
 drivers/net/hyperv/netvsc_drv.c     | 58 ++++++++++++-----
 drivers/net/hyperv/rndis_filter.c   | 97 +++++++++++++++++++++++++----
 5 files changed, 194 insertions(+), 39 deletions(-)

-- 
2.18.0

