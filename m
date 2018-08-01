Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F13220840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F13220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbeHAUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:22:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404099AbeHATDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3678FE2;
        Wed,  1 Aug 2018 16:59:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 119/336] ath: Add regulatory mapping for APL13_WORLD
Date:   Wed,  1 Aug 2018 18:47:34 +0200
Message-Id: <20180801165033.703455708@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

[ Upstream commit 9ba8df0c52b3e6baa436374b429d3d73bd09a320 ]

The regdomain code is used to select the correct the correct conformance
test limits (CTL) for a country. If the regdomain code isn't available and
it is still programmed in the EEPROM then it will cause an error and stop
the initialization with:

  Invalid EEPROM contents

The current CTL mappings for this regdomain code are:

* 2.4GHz: ETSI
* 5GHz: ETSI

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/regd_common.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/ath/regd_common.h
+++ b/drivers/net/wireless/ath/regd_common.h
@@ -69,6 +69,7 @@ enum EnumRd {
 	APL1_ETSIC = 0x55,
 	APL2_ETSIC = 0x56,
 	APL5_WORLD = 0x58,
+	APL13_WORLD = 0x5A,
 	APL6_WORLD = 0x5B,
 	APL7_FCCA = 0x5C,
 	APL8_WORLD = 0x5D,
@@ -195,6 +196,7 @@ static struct reg_dmn_pair_mapping regDo
 	{APL3_WORLD, CTL_FCC, CTL_ETSI},
 	{APL4_WORLD, CTL_FCC, CTL_ETSI},
 	{APL5_WORLD, CTL_FCC, CTL_ETSI},
+	{APL13_WORLD, CTL_ETSI, CTL_ETSI},
 	{APL6_WORLD, CTL_ETSI, CTL_ETSI},
 	{APL8_WORLD, CTL_ETSI, CTL_ETSI},
 	{APL9_WORLD, CTL_ETSI, CTL_ETSI},


