Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F51FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB5020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iRt5Dkpy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LGUWYvsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB5020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeG3TAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:00:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeG3TAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:00:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB2DB62231; Mon, 30 Jul 2018 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532971449;
        bh=5u7usaUDVMGR5zkYi59QJqDlDxgM+lZ6ShJS3dJun6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRt5DkpyH4iobSMbxSnIVT+j4QiOUGR+P6Awy/hUNLdWJowzgmRmUwYvpI40MVDcq
         ccpPttj+ekj1I3XWaoLI40utt0WH2e3xDYf9RVIx7eENvh8MZLKOlUTz6OQ+LdlsSn
         3NwQwWV8kkQbYwYG6XNgXk0Am/oAMTLetUeH+irE=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E90062227;
        Mon, 30 Jul 2018 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532971447;
        bh=5u7usaUDVMGR5zkYi59QJqDlDxgM+lZ6ShJS3dJun6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGUWYvsQtmwvkqGWNAbIIt6rglTRGdSauu2N3vAJsp/2jp9nCNhTHq3xm/t+Abyej
         T7s+nJd0UJ+RXky7/VydhDKr7Gu2YzH423kXMhNRTzaBxSf9QX5Ke1eL8AKEYBfHzh
         RWhHahBaCvLdzMzTN6kIL58KgFT/DsHDCaif8JC4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E90062227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
From:   Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
To:     wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org
Subject: [PATCH v8 2/2] MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer
Date:   Mon, 30 Jul 2018 11:23:52 -0600
Message-Id: <1532971432-16784-3-git-send-email-kramasub@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
References: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alok Chauhan and myself as maintainers for Qualcomm GENI I2C master
controller driver.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32fbc6f..6e33b29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11830,6 +11830,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/qualcomm/emac/
 
+QUALCOMM GENERIC INTERFACE I2C DRIVER
+M:	Alok Chauhan <alokc@codeaurora.org>
+M:	Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	drivers/i2c/busses/i2c-qcom-geni.c
+
 QUALCOMM HEXAGON ARCHITECTURE
 M:	Richard Kuo <rkuo@codeaurora.org>
 L:	linux-hexagon@vger.kernel.org
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

