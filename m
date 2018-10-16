Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2432089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbQxmOA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2432089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeJQBGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1AE2089E;
        Tue, 16 Oct 2018 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710109;
        bh=uvpqrJvFuXnY94tvSqLCwh3Za9HH3QDYD/ZNAw+kJ7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbQxmOA5V1nrPONFZ9C/Qd/Me1ZdeWhf8NgNt1N5Aw9UFfeDKXLLcLvv0hWLJ9SfH
         2etGALcEKE+XgcdP390l+S0R4cqBwBlLa1bZ3gdL/Sw5nFRO6wnp3I//9VqYAxVVLL
         PWnUppRGBvVyOWS2C7qc6uVdgnrMSdPfUbe+OVW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Detheridge <s@sd.ai>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 104/135] pinctrl: cannonlake: Fix gpio base for GPP-E
Date:   Tue, 16 Oct 2018 19:05:34 +0200
Message-Id: <20181016170522.557405628@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Detheridge <s@sd.ai>

[ Upstream commit 8e2aac333785f91ff74e219a1e78e6bdc1ef2c41 ]

The gpio base for GPP-E was set incorrectly to 258 instead of 256,
preventing the touchpad working on my Tong Fang GK5CN5Z laptop.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=200787
Signed-off-by: Simon Detheridge <s@sd.ai>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-cannonlake.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/intel/pinctrl-cannonlake.c
+++ b/drivers/pinctrl/intel/pinctrl-cannonlake.c
@@ -382,7 +382,7 @@ static const struct intel_padgroup cnlh_
 static const struct intel_padgroup cnlh_community3_gpps[] = {
 	CNL_GPP(0, 155, 178, 192),		/* GPP_K */
 	CNL_GPP(1, 179, 202, 224),		/* GPP_H */
-	CNL_GPP(2, 203, 215, 258),		/* GPP_E */
+	CNL_GPP(2, 203, 215, 256),		/* GPP_E */
 	CNL_GPP(3, 216, 239, 288),		/* GPP_F */
 	CNL_GPP(4, 240, 248, CNL_NO_GPIO),	/* SPI */
 };


