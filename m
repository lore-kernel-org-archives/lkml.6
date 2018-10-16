Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53128C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA882098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="17c8ZO5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA882098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeJQBE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeJQBE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94E820866;
        Tue, 16 Oct 2018 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709985;
        bh=f2CQGBS8aJG7UGC2WOw/9vx/4UfUzbZAnU7k4muKMfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17c8ZO5zfCJhihrTjRC1ZKkJUow9vn/B2eIHn/MYSbp8qp43Fo7y/L3m9HAagOWGW
         Phg+iBHPzrnbOQtVHDdyvmRyfh2SQ+Zeb24BkUhDf8jVxFzSptVmjx3EzdbuPoMCwg
         lkxN/MkngtEjA0ooTw9fxGzL2RvlqAh8xmPMRo4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryan Lee <ryans.lee@maximintegrated.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 064/135] ASoC: max98373: Added speaker FS gain cotnrol register to volatile.
Date:   Tue, 16 Oct 2018 19:04:54 +0200
Message-Id: <20181016170518.926642318@linuxfoundation.org>
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

From: Ryan Lee <ryans.lee@maximintegrated.com>

[ Upstream commit 0d22825255f25adb6a609f130b42c752d3fd0f5d ]

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/max98373.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -519,6 +519,7 @@ static bool max98373_volatile_reg(struct
 {
 	switch (reg) {
 	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
+	case MAX98373_R203E_AMP_PATH_GAIN:
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:


