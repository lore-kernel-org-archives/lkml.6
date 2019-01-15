Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E804A20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfAOAxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:53:33 -0500
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:42166
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbfAOAxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:53:32 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id jCxygIvCoD44TjCxygDDRo; Mon, 14 Jan 2019 17:52:31 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gjCxy-0001BC-HO; Mon, 14 Jan 2019 17:52:30 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        netdev@vger.kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH hyperv-fixes,0/3] fixes for hash key setting issues
Date:   Tue, 15 Jan 2019 00:51:41 +0000
Message-Id: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: haiyangz@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMuJG+UhzuSpiFKPorvERfa5p9tDgkeoIuxo75o/iE6Y+Y96+6B5tENJWRHOXIHKfQy3Sc5iAj13BmbvX57jzWe/gocsZFKbO/3kr8YwZEfZNhSsuivc
 PDbLtLhTyzTLDzsAbU+uFocee6D+3Qrecn+pdk6TuUgHY5q4XOUttC6QJ8qG3CbccOpfoId1SjSaLfZi8ivp+Lpo4K8TbY0iuqnWfKRCJkjm1+bAea61/Oul
 RKCi7RUF8NBs5GoIqnED0hMt6oSeHqeGs+sMDSb5QSu5Ue7i5P2uEDWlCUNAo6p7a9f+Yj5BDq/HvraYYoQeFoBkMPCdBhmnQAtgT/F7+07QJ8uUE0/EN+r8
 E8zs57MKFtBoeO2tzuxNtbx9CW8g/TYygnluzwMd5TVLHXlXTTxaq2fpLTn+JRNOcLArpblFfzgM0Yxeu6a4ItAOeoJ+9SqNt9rfhpkechfuKKUFqf2p6JeG
 iNQ17v6ElHcf84vjyIgxKV/Dwi472kjt6hmUNac2JybIbvZbhKfFdZzJ/qA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Using ethtool to change Hash key failed on Linux VM runnig on
Hyper-V. This patch set fix them.
It targets Hyper-V tree, hyperv-fixes branch managed by 
Sasha Levin <sashal@kernel.org>.

Haiyang Zhang (3):
  Fix ethtool change hash key error
  Refactor assignments of struct netvsc_device_info
  Fix hash key value reset after other ops

 drivers/net/hyperv/hyperv_net.h   |  10 ++-
 drivers/net/hyperv/netvsc.c       |   2 +-
 drivers/net/hyperv/netvsc_drv.c   | 139 +++++++++++++++++++-----------
 drivers/net/hyperv/rndis_filter.c |  34 ++++++--
 4 files changed, 123 insertions(+), 62 deletions(-)

-- 
2.19.1

