Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2BBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2EE21734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2EE21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbeHGVNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbeHGVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D126BD54;
        Tue,  7 Aug 2018 18:57:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 28/85] ath: Add regulatory mapping for Bahamas
Date:   Tue,  7 Aug 2018 20:51:30 +0200
Message-Id: <20180807172358.386126193@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

[ Upstream commit 699e2302c286a14afe7b7394151ce6c4e1790cc1 ]

The country code is used by the ath to detect the ISO 3166-1 alpha-2 name
and to select the correct conformance test limits (CTL) for a country. If
the country isn't available and it is still programmed in the EEPROM then
it will cause an error and stop the initialization with:

  Invalid EEPROM contents

The current CTL mappings for this country are:

* 2.4GHz: ETSI
* 5GHz: FCC

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/regd.h        |    1 +
 drivers/net/wireless/ath/regd_common.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/wireless/ath/regd.h
+++ b/drivers/net/wireless/ath/regd.h
@@ -68,6 +68,7 @@ enum CountryCode {
 	CTRY_AUSTRALIA = 36,
 	CTRY_AUSTRIA = 40,
 	CTRY_AZERBAIJAN = 31,
+	CTRY_BAHAMAS = 44,
 	CTRY_BAHRAIN = 48,
 	CTRY_BANGLADESH = 50,
 	CTRY_BARBADOS = 52,
--- a/drivers/net/wireless/ath/regd_common.h
+++ b/drivers/net/wireless/ath/regd_common.h
@@ -306,6 +306,7 @@ static struct country_code_to_enum_rd al
 	{CTRY_AUSTRALIA2, FCC6_WORLD, "AU"},
 	{CTRY_AUSTRIA, ETSI1_WORLD, "AT"},
 	{CTRY_AZERBAIJAN, ETSI4_WORLD, "AZ"},
+	{CTRY_BAHAMAS, FCC3_WORLD, "BS"},
 	{CTRY_BAHRAIN, APL6_WORLD, "BH"},
 	{CTRY_BANGLADESH, NULL1_WORLD, "BD"},
 	{CTRY_BARBADOS, FCC2_WORLD, "BB"},


