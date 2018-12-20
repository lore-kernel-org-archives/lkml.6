Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B13DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EA1218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VAJ7acFz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VAJ7acFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbeLTNjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:39:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:39:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78D2B6074E; Thu, 20 Dec 2018 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545313186;
        bh=7n32wkDdH5ws7m8dwm/BdVKV6qrqrQKAbcapKtvj6H8=;
        h=From:To:Cc:Subject:Date:From;
        b=VAJ7acFzSQeHHYyqV3poomV4OwqxFMYrM3NtUDfxsh0nBOBEjh/drQVT9rTd/iYXQ
         uDR+H7TfWH60jywS8y1aiSXyXc7qg+HISl6WpTRXzkpbwI+9qenlpvI11yHo9AkDyG
         uT87jmm9BY8qvdPmKG0BSo2W/w+wcuPwXtlUXfMA=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D98616034E;
        Thu, 20 Dec 2018 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545313186;
        bh=7n32wkDdH5ws7m8dwm/BdVKV6qrqrQKAbcapKtvj6H8=;
        h=From:To:Cc:Subject:Date:From;
        b=VAJ7acFzSQeHHYyqV3poomV4OwqxFMYrM3NtUDfxsh0nBOBEjh/drQVT9rTd/iYXQ
         uDR+H7TfWH60jywS8y1aiSXyXc7qg+HISl6WpTRXzkpbwI+9qenlpvI11yHo9AkDyG
         uT87jmm9BY8qvdPmKG0BSo2W/w+wcuPwXtlUXfMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D98616034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/2]  arm64: dts: qcom: sdm845: add support for ADSP PIL
Date:   Thu, 20 Dec 2018 19:09:32 +0530
Message-Id: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add remoteproc and child device nodes for adsp pil for sdm845.

This depends on below upstream patches:
1) lpasscc dt node : https://lore.kernel.org/patchwork/patch/1021267/
2) pdc sync reset dt node : https://lore.kernel.org/patchwork/patch/1003795/
3) dt-binding: Remove lpass_aon clock from adsp clk list:  https://lore.kernel.org/patchwork/patch/1019609/

Rohit kumar (2):
  arm64: dts: qcom: sdm845: Add ADSP reserve-memory nodes
  arm64: dts: qcom: sdm845: Add Q6V5 ADSP node

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 101 ++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

