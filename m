Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2015E2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2015E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbeHAUMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:12:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404196AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 88DB8FE0;
        Wed,  1 Aug 2018 16:59:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 118/336] ath: Add regulatory mapping for ETSI8_WORLD
Date:   Wed,  1 Aug 2018 18:47:33 +0200
Message-Id: <20180801165033.665140622@linuxfoundation.org>
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

[ Upstream commit 45faf6e096da8bb80e1ddf8c08a26a9601d9469e ]

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
@@ -45,6 +45,7 @@ enum EnumRd {
 	ETSI4_ETSIC = 0x38,
 	ETSI5_WORLD = 0x39,
 	ETSI6_WORLD = 0x34,
+	ETSI8_WORLD = 0x3D,
 	ETSI_RESERVED = 0x33,
 
 	MKK1_MKKA = 0x40,
@@ -181,6 +182,7 @@ static struct reg_dmn_pair_mapping regDo
 	{ETSI4_WORLD, CTL_ETSI, CTL_ETSI},
 	{ETSI5_WORLD, CTL_ETSI, CTL_ETSI},
 	{ETSI6_WORLD, CTL_ETSI, CTL_ETSI},
+	{ETSI8_WORLD, CTL_ETSI, CTL_ETSI},
 
 	/* XXX: For ETSI3_ETSIA, Was NO_CTL meant for the 2 GHz band ? */
 	{ETSI3_ETSIA, CTL_ETSI, CTL_ETSI},


