Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F4D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oa3AQz9p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q/pDh5/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfANQhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:37:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfANQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:37:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C53360928; Mon, 14 Jan 2019 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483849;
        bh=Gd+QtjCybC5WjWQoVGUj9Esn6Z1wlVmCqXn+WxECaKY=;
        h=From:To:Cc:Subject:Date:From;
        b=oa3AQz9p8kWWCBqv1jmMRVbURpxouVe/G4ULCOs2HoU0lf7z/6t5wbZfGg+2I3cdD
         MKeBJAO4HTEAuFbCFUJXaH9DAtiELJ9QrPnq7AAi1+4R7z23X0H89QpSv/N/kzMRtI
         GnfOMNdZ3Q+HmWjNyhyiFuj7Y/N7b784G+bekxpo=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FB716092B;
        Mon, 14 Jan 2019 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483846;
        bh=Gd+QtjCybC5WjWQoVGUj9Esn6Z1wlVmCqXn+WxECaKY=;
        h=From:To:Cc:Subject:Date:From;
        b=Q/pDh5/tCMXj6mYozrEqzxd1xZ9CsbymKtMDdM1ML1Xg1dY4Rybu2VZrWesh3xx23
         VUJirXRFsRYkoj8wI1xxGDT93k9XdHOAPW9rZ+RLS/zAF2z9rUPOt5QGs2cCC28lVw
         w7Bm0nNQ2Ga83Ui/olXa6Ju8wbBOkLTnVsOCv7Es=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FB716092B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     balbi@kernel.org
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 5/6] usb: dwc3: qcom: Add support for MSM8998
Date:   Mon, 14 Jan 2019 09:37:18 -0700
Message-Id: <1547483838-5482-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MSM8998 specific DT compatible so that we can properly bind to the
device and enable the USB controller.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index a6d0203..184df4d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -595,6 +595,7 @@ static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
 static const struct of_device_id dwc3_qcom_of_match[] = {
 	{ .compatible = "qcom,dwc3" },
 	{ .compatible = "qcom,msm8996-dwc3" },
+	{ .compatible = "qcom,msm8998-dwc3" },
 	{ .compatible = "qcom,sdm845-dwc3" },
 	{ }
 };
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

