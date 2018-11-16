Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEF62086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="kBkspV3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AL2BJ1YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEF62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbeKPPD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:03:27 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58775 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbeKPPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:03:27 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 42F8721F05;
        Thu, 15 Nov 2018 23:52:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Nov 2018 23:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=mveNE3CjL8D4y
        OGGytaEu2P54t4pKyfCVAdEUX80/mA=; b=kBkspV3aJK5tXSjWB2Da1WmFuIbzt
        RQRLMf18SVWVXSVnLv9/OQiKJAn6NZ/QJWDq4Ad6v7amS75yC8n8sFApeefsMBQM
        cTdjH51uQk6rRNbAjR1LAFoqqNyr5+xVvDtYc9CCpz+3aM91t6iREe1l5JAZziJH
        5G67aVUS4fc3kRxBF4t4k1U1PpSh66dbr+ileC4vtFvd66SMYkc/RMHKOe6+sJgL
        NKZ6fGbOxRBzg5cCJe0PjSKDxmh4nu3nxVqsVq2t+Fza4s9ED/rgeVF0M7qMl+VP
        IucldwB++1HLr0DJ+wpbuYaE9g3Dwfxbqb/r8G/S9P4lSFbJE6Nkq2jpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mveNE3CjL8D4yOGGy
        taEu2P54t4pKyfCVAdEUX80/mA=; b=AL2BJ1YKEodzbRwPdy+iAxTeD+DYWt6ql
        Z8GpqfrVC5M5NTmvsJ5HDkhtpzzkD5BiKiAk2DSKx14e4Lg2qfwH8jUs9RgHmAPm
        nLUkX1PGK6jtKKoFEmAVh9DX+o3OxX54dzRH4YKuYTihyJNxOkwkE+ou60hbfKf7
        b0GkVwpnvroTOC5dbMApvNoSR08m56Il1uwD/EfAZUM96PqFDpFdDgYCAtcyQThO
        HJa8JICuElpUvgn1ACbF8Rt7oqZjLwuuJHW7vuY5jv4F+RUkpRk9/S1LHVUD7JXT
        dOFAiRcyisCj8Sh45D0ZAygl53/cyb+bNmofJqKXMGVjJLG9nS0WQ==
X-ME-Sender: <xms:FE3uW2EASKl85-V2KaWDUwPV0AjCnDJpcuKZtfUG2h5AOVQ5DLZxkA>
X-ME-Proxy: <xmx:FE3uW-513iIVDlYv1_IzC6K-ad0cXljgy11Utm2NuH0k_T9yExq6dQ>
    <xmx:FE3uW8P1q2-LGphxmznuG3guMVYibcxVoJDg2vrjuYCTJE_qbvptmA>
    <xmx:FE3uW8mIXZDSKcUFyzflAUeVKmDMJjeUe8RMFKd-H7_gmYH16cNlCQ>
    <xmx:FE3uWzTL1ZlOujqKCSSv2oxDt4rOetfUj73suHAftr1bx6_B7-wagw>
    <xmx:FE3uW4BFBjXntgEYVlJpwSvmPjlioiFT0migSNP787XAx2cWbFbpcw>
    <xmx:FU3uW4ZuEviF1Jz14E3JtleLwdXozXTt9vnIXmLf2RUmVm57Wy6-Og>
Received: from v4.ibm.com (unknown [1.144.189.168])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3BF21E405B;
        Thu, 15 Nov 2018 23:52:31 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v4 0/6] net/ncsi: Allow enabling multiple packages & channels
Date:   Fri, 16 Nov 2018 15:51:53 +1100
Message-Id: <20181116045159.4980-1-sam@mendozajonas.com>
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
Changes in v4:
- Fix failover in the single-channel case
- Better handle ncsi_reset_dev() entry during a current config/suspend
operation.

Samuel Mendoza-Jonas (6):
  net/ncsi: Don't enable all channels when HWA available
  net/ncsi: Probe single packages to avoid conflict
  net/ncsi: Don't deselect package in suspend if active
  net/ncsi: Don't mark configured channels inactive
  net/ncsi: Reset channel state in ncsi_start_dev()
  net/ncsi: Configure multi-package, multi-channel modes with failover

 include/uapi/linux/ncsi.h |  15 ++
 net/ncsi/internal.h       |  19 +-
 net/ncsi/ncsi-aen.c       |  75 ++++--
 net/ncsi/ncsi-manage.c    | 522 +++++++++++++++++++++++++++-----------
 net/ncsi/ncsi-netlink.c   | 233 ++++++++++++++---
 net/ncsi/ncsi-rsp.c       |   2 +-
 6 files changed, 660 insertions(+), 206 deletions(-)

-- 
2.19.1

