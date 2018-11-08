Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED88C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049E020857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="CLH50q/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzMkU30J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049E020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeKHMWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:22:50 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48411 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728556AbeKHMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:22:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 32A0622075;
        Wed,  7 Nov 2018 21:49:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Nov 2018 21:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=HkXY12Kl1G4cG
        9Aj7QA8nyWXMCt8a8A+ympZCmhC0YU=; b=CLH50q/OYseuFVH0dywyM5D6fKsFY
        Y2ynmmULZEKg6cy5GSEOMG+4il+CvaLjBB+TjGLM4PWPxKgbB/hHYc8aG9lAGLdm
        ijzcNS9gt74jfnQ+77UlFAUCZoL3CYMfdJTR2ZqSw9wMEtRgxI1kMJr5ccP7HKOa
        BXnGHNwhjgzXn236lpctvSCtlWQkhG7zXqf39Atxhhyzhr3YtS59KsyWbvYX7wfE
        XtktKZwlKW9dHs5WA7wOJyJNLwuzE/H/c7J7o8YgIaKV5A0moBMwAmK0Dee0tXLR
        BJpUA1GJCUAitiWxrW4mDtlc9OMnH53CuPEa0NRplJBdM+hdiWZakVMMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HkXY12Kl1G4cG9Aj7
        QA8nyWXMCt8a8A+ympZCmhC0YU=; b=AzMkU30J0YHNJ96akEi57yekWRAJz8pbc
        av7tIbYUy32s0n4d5PpldWaWQvloLhz9JgknMHNvNLU5PWN1lU7bmNg2eF53c13X
        gFBBwCchebbQ1eQ2PmYvMQqDMDC7kgi4Y8lpzSmIf457BHR9L+sjMYCG9rLMam7j
        u0kjCUhrnIIhRSEsnYWvOO4xTMdMjJ3rqJqrY5cm4NQZaR9WlsO8/7+hZ4Y7J30s
        W1GaXBbW8dfjZUYMpiArfaTuia7zXWowkMx1BM+Rgkk6d18+McZdUXSOLtILKz3S
        OC20+qhzEaa8+utOpDO1XIUBF9tkEY+OyW2uFDXNQc14NeJgY7Ajw==
X-ME-Sender: <xms:PaTjW3i9Jf5gwEjNtBb4plm5-fdJpg0nhdzOLszq-kUcv6FsuHhPfA>
X-ME-Proxy: <xmx:PaTjWzbVT30e_kEKUBFhKmHbgtIfWL1RsGgNRn8Ca8qizik66Kis-A>
    <xmx:PaTjW4gv33OZSxI1T6zUW6q3yU-_QR2iqq9CzAxDEVS3jdwY7xkNUg>
    <xmx:PaTjW8ceTWYHSqRlQmEfoTj7SD8hxa1gzmsrHet7RFm5EWA2gZiJpg>
    <xmx:PaTjWzp6iZqMFA4h2qYgjmis1U3yGOPFv-7EdRFAlNjO4PDlOFPDbg>
    <xmx:PaTjWyRG2By10HAAU9MRd0H9_AYep5bMxLDzFJpIyKSTsNhCwI_5AQ>
    <xmx:PqTjW3xqeEdUdAcblTjVyhphjc5zOkJhKPxwNuQeOUToGoFeao90Qg>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47EF4102F2;
        Wed,  7 Nov 2018 21:49:31 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v3 0/6] net/ncsi: Allow enabling multiple packages & channels
Date:   Thu,  8 Nov 2018 13:49:03 +1100
Message-Id: <20181108024909.9897-1-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the NCSI driver to configure multiple packages
and/or channels simultaneously. Since the RFC series this includes a few
extra changes to fix areas in the driver that either made this harder or
were roadblocks due to deviations from the NCSI specification.

Patches 1 & 2 fix two issues where the driver made assumptions about the
capabilities of the NCSI topology.
Patches 3 & 4 change some internal semantics slightly to make multi-mode
easier.
Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
and keeping track of channel states.
Patch 6 implements the main multi-package/multi-channel configuration,
configured via the Netlink interface.

Readers who have an interesting NCSI setup - especially multi-package
with HWA - please test! I think I've covered all permutations but I
don't have infinite hardware to test on.

Changes in v2:
- Updated use of the channel lock in ncsi_reset_dev(), making the
channel invisible and leaving the monitor check to
ncsi_stop_channel_monitor().
- Fixed ncsi_channel_is_tx() to consider the state of channels in other
packages.
Changes in v3:
- Fixed bisectability bug in patch 1
- Consider channels on all packages in a few places when multi-package
is enabled.
- Avoid doubling up reset operations, and check the current driver state
before reset to let any running operations complete.
- Reorganise the LSC handler slightly to avoid enabling Tx twice.

Samuel Mendoza-Jonas (6):
  net/ncsi: Don't enable all channels when HWA available
  net/ncsi: Probe single packages to avoid conflict
  net/ncsi: Don't deselect package in suspend if active
  net/ncsi: Don't mark configured channels inactive
  net/ncsi: Reset channel state in ncsi_start_dev()
  net/ncsi: Configure multi-package, multi-channel modes with failover

 include/uapi/linux/ncsi.h |  15 ++
 net/ncsi/internal.h       |  19 +-
 net/ncsi/ncsi-aen.c       |  72 ++++--
 net/ncsi/ncsi-manage.c    | 511 ++++++++++++++++++++++++++------------
 net/ncsi/ncsi-netlink.c   | 233 ++++++++++++++---
 net/ncsi/ncsi-rsp.c       |   2 +-
 6 files changed, 646 insertions(+), 206 deletions(-)

-- 
2.19.1

