Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DB721523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DB721523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391151AbeIVALw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:11:52 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:41916
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390076AbeIVALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:11:52 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 3Q2pgfJiKM0DP3Q2pgpUIn; Fri, 21 Sep 2018 11:20:47 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1g3Q2p-0002dC-86; Fri, 21 Sep 2018 11:20:47 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2,0/3] hv_netvsc: Support LRO/RSC in the vSwitch
Date:   Fri, 21 Sep 2018 18:20:34 +0000
Message-Id: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfC+3JdNliwQv0Y3o5OZk4n4bzMcGaSwbWNnWqctROIV5JTkpTWmzwAk0/G1c+fYduppGJEBBLxoiapw25wZf6dhQU2qE78+OjG5XISkYHqZy/dYOXzPJ
 Tj0F47iMlAoW50Pf2639fWydE688wAOh6KysyfxmMeW47KapMta0ScBjGjSIM9Dj05hjvmH8E0E56rGYXiV7tYXtfazU53e7Q421y2TVFcAO7tTrtvJ+7dIc
 fUeDVIZ57MZnUiQCLVnmHFt8dHxxMZBT+qJrA5xW9YOWBdJYYn/+l2tXqH/C4IcHIdl/MEnjF5V55oS+LaS6CNJFrxKCR5AXB+9v9k9fDPnPOIbAspT3Ew+9
 h4UWABaohN0C9K8HWC63dqIG5O/49hEf+ZZx0eJt+u8td465ASz09FJxhNppHmRK++0YDF3wCkyI7Frc0VukbONxk1tnkgHTBziq2k3vRJ7gOj21F5EtCkMP
 R313WqNU6p7Awhs1MfF06L4APDkIEUWgMGTA2A==
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

