Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF89C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0348F217C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0348F217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbeHDLIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:08:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbeHDLIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:08:06 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36776BB3;
        Sat,  4 Aug 2018 09:08:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 037/124] ath: Add regulatory mapping for FCC3_ETSIC
Date:   Sat,  4 Aug 2018 11:00:26 +0200
Message-Id: <20180804082703.821685721@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

[ Upstream commit 01fb2994a98dc72c8818c274f7b5983d5dd885c7 ]

The regdomain code is used to select the correct the correct conformance
test limits (CTL) for a country. If the regdomain code isn't available and
it is still programmed in the EEPROM then it will cause an error and stop
the initialization with:

  Invalid EEPROM contents

The current CTL mappings for this regdomain code are:

* 2.4GHz: ETSI
* 5GHz: FCC

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/regd_common.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/ath/regd_common.h
+++ b/drivers/net/wireless/ath/regd_common.h
@@ -35,6 +35,7 @@ enum EnumRd {
 	FRANCE_RES = 0x31,
 	FCC3_FCCA = 0x3A,
 	FCC3_WORLD = 0x3B,
+	FCC3_ETSIC = 0x3F,
 
 	ETSI1_WORLD = 0x37,
 	ETSI3_ETSIA = 0x32,
@@ -168,6 +169,7 @@ static struct reg_dmn_pair_mapping regDo
 	{FCC2_ETSIC, CTL_FCC, CTL_ETSI},
 	{FCC3_FCCA, CTL_FCC, CTL_FCC},
 	{FCC3_WORLD, CTL_FCC, CTL_ETSI},
+	{FCC3_ETSIC, CTL_FCC, CTL_ETSI},
 	{FCC4_FCCA, CTL_FCC, CTL_FCC},
 	{FCC5_FCCA, CTL_FCC, CTL_FCC},
 	{FCC6_FCCA, CTL_FCC, CTL_FCC},


