Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936261-1525120330-2-2208247060641132659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES rosk.us-asciien,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525120329; b=VrFcCs9bMQDE7W/LpA4gWYKfUBuks9/FEjjT2Evj3o4L7tH2tM
    3OzDBvH1K3ITAHympkXNFGOWW5SU/JFJYHBfQEj5IXjKslggk4gxmvztWYy08CIv
    0skVzGk+pZYDScB73Lek2cSaVSsHxhP9IPV6X2NzfXDcPmPLVs+CFBWJj0qdfSDE
    c0AtP1rENz1IT1gH6tezYHRkmSmGcZB0fF6FeXZTET69ruEQk+0Fi5C8ENb1nlsa
    4AqOhbbLQcGjQwHFPPUYxXsObnpCVlW9Zyw6ZAv2XYmeUZOJqwT0acgo7EYajFJS
    bYsuRXINgZYf6eAkGaWH/eOVxmQbrCy3Vc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525120329; bh=yGVtmGeITtZGYBU53grf+pNBuqj+sZ
    Gg6Vzzg0u+Ky8=; b=SJp9Fr7WWnR+gEDpA45p6MeFrnpPrut7owIgPT306KvnM8
    oMaeH5vqJHbVXIbeuJM1xdH36z+VqWLAV18EM/B0qGYFRRFOMVnfR19aoOKDyRsQ
    fy0vGSuNbrtOt67ybSqWqMXieXZA//vvjwi+HhFUcfkspLyM/k2aIU3PVkOrvy3g
    t+NhM2/YLSmmnoWR48OOEVdeC9x08K4FwVVECIgVFhshbokho3nfE2tXtTKHwBlT
    jFIbIHIq7w0EvMBBQAJQ9FJCLKnNnv04hrSxt9gCc4fANW3ievPlO/YbPbwUcKcH
    9W8iDoVjiX8wMqcFT+EcLzLMzXdzu4RJWRrTcCMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3vTu+vnmtFuSovcqknlZ8mDhOK/xir5uQzO4oCGf/AY1hM6wvpkpR6PN/cBeEjE0etOZlOEO4ttkjT/D8MaJpAPwkDZUEyML8WW7onQh2VqoFS+bkP
    ajgUj9ywhncyPrFxVo7ut9g+5n6eDHhe6B8jtlLdtcyKa5SoJL5dIWAYeJ4+SgeU0j7GiMmWKWTue4ZGi9BDX/b8xqkpuM5JavWiQ7ClzUOpoRhQbQQ2sT10
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=EUspDBNiAAAA:8 a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8 a=R1ViX8kAiYiUaa0rIiMA:9
    a=QEXdDO2ut3YA:10 a=rMCfJy6NHDicN4J276Yl:22 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755590AbeD3Ubs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 16:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755510AbeD3T0I (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982C522DC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 4.4 44/44] ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode
Date: Mon, 30 Apr 2018 12:24:55 -0700
Message-Id: <20180430190948.085407552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>

commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.

Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
rx_hdr_status is not padded to align in 4-byte boundary. Define a
new hw_params field to handle different alignment behaviour between
different hw. This patch fixes improper retrieval of rfc1042 header
with QCA4019. This patch along with "ath10k: Properly remove padding
from the start of rx payload" will fix traffic failure in ethernet
decap mode for QCA4019.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/core.c |    8 ++++++++
 drivers/net/wireless/ath/ath10k/core.h |    4 ++++
 2 files changed, 12 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -67,6 +67,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA988X_BOARD_DATA_SZ,
 			.board_ext_size = QCA988X_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -85,6 +86,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -103,6 +105,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -121,6 +124,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -140,6 +144,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -159,6 +164,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA99X0_BOARD_DATA_SZ,
 			.board_ext_size = QCA99X0_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 1,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -177,6 +183,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA9377_BOARD_DATA_SZ,
 			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -195,6 +202,7 @@ static const struct ath10k_hw_params ath
 			.board_size = QCA9377_BOARD_DATA_SZ,
 			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
 		},
+		.decap_align_bytes = 4,
 	},
 };
 
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -670,6 +670,10 @@ struct ath10k {
 			size_t board_size;
 			size_t board_ext_size;
 		} fw;
+
+		/* Number of bytes used for alignment in rx_hdr_status */
+		int decap_align_bytes;
+
 	} hw_params;
 
 	const struct firmware *board;
