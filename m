Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C9FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154E02088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154E02088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeIREWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:22:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeIREWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:22:47 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38FD6CAD;
        Mon, 17 Sep 2018 22:53:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 20/70] ethtool: Remove trailing semicolon for static inline
Date:   Tue, 18 Sep 2018 00:41:53 +0200
Message-Id: <20180917211650.928887119@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit d89d41556141a527030a15233135ba622ba3350d ]

Android's header sanitization tool chokes on static inline functions having a
trailing semicolon, leading to an incorrectly parsed header file. While the
tool should obviously be fixed, also fix the header files for the two affected
functions: ethtool_get_flow_spec_ring() and ethtool_get_flow_spec_ring_vf().

Fixes: 8cf6f497de40 ("ethtool: Add helper routines to pass vf to rx_flow_spec")
Reporetd-by: Blair Prescott <blair.prescott@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/ethtool.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -882,13 +882,13 @@ struct ethtool_rx_flow_spec {
 static inline __u64 ethtool_get_flow_spec_ring(__u64 ring_cookie)
 {
 	return ETHTOOL_RX_FLOW_SPEC_RING & ring_cookie;
-};
+}
 
 static inline __u64 ethtool_get_flow_spec_ring_vf(__u64 ring_cookie)
 {
 	return (ETHTOOL_RX_FLOW_SPEC_RING_VF & ring_cookie) >>
 				ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
-};
+}
 
 /**
  * struct ethtool_rxnfc - command to get or set RX flow classification rules


