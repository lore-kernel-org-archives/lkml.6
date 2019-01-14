Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63188C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322EF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bG6TAyGD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hX3V30Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfANQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:36:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfANQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:36:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E832D60807; Mon, 14 Jan 2019 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483802;
        bh=dc4vKVqWNzc/oa/ED2gTqTSifCcyV+RQUFi7//voFtk=;
        h=From:To:Cc:Subject:Date:From;
        b=bG6TAyGD0LDqvYLTErGzDNvu5OjIOkjY8T6IgTqnj+TjCLy/1+rCF6YwkDw5l1ZHf
         iHn3FB3MLVhu1kK8tGet58ElkDFRSbwAMjmar8GPG7Uxn4bdYSXZUZBPhkS76c0sEF
         t1PWQOMPfnidkSjQLrJYsHdjzy01OK3uH4xgAT8o=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 298C86098C;
        Mon, 14 Jan 2019 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483798;
        bh=dc4vKVqWNzc/oa/ED2gTqTSifCcyV+RQUFi7//voFtk=;
        h=From:To:Cc:Subject:Date:From;
        b=hX3V30Iqyi9NJa5ZII7mJCh8dEd0vBcmBXaAEGjtjm4vYAJngharx4L30X8TX+klk
         L8FHvuFlQx5dDTanyRrQz3LYd2CSC24WzBQL8A7SR0fsSrS6z2Jn0budkW06FdsOz6
         xgPdmmUCaB/Kq2a9xw/eA2Luc5bm4ASpr03t8kFc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 298C86098C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 2/6] dt-bindings: usb: Add support for msm8998
Date:   Mon, 14 Jan 2019 09:36:27 -0700
Message-Id: <1547483787-5371-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8998 USB has a dwc3 controller just like the existing sdm845 support

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
index 95afdcf..cb695aa 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:		Compatible list, contains
 			"qcom,dwc3"
 			"qcom,msm8996-dwc3" for msm8996 SOC.
+			"qcom,msm8998-dwc3" for msm8998 SOC.
 			"qcom,sdm845-dwc3" for sdm845 SOC.
 - reg:			Offset and length of register set for QSCRATCH wrapper
 - power-domains:	specifies a phandle to PM domain provider node
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

