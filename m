Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95693C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBA02083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HO7dFisb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GImTlZuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBA02083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965185AbeFSFjp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:39:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964895AbeFSFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:39:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11E9A60B1A; Tue, 19 Jun 2018 05:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529386782;
        bh=OgY6vU1PLd02JA03RxHUuIPl099mDbw+QmDm/+cyvzc=;
        h=From:To:Cc:Subject:Date:From;
        b=HO7dFisblBBfyocpN8Q0H0UG+4y3zUQsR+OZAGCk6z+blcnSaSxMyjPDdnb/I877H
         95XtVd6nbf3BkkHOMBdVB0prKgvM7N2eblbLwj7jD8hcpBuWIKEHtz/FImlVTe0dyj
         ylu0UdjYcCv8+pf/4jEi3+xFZ0aa+4eXHF3EIchA=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B18F7604A6;
        Tue, 19 Jun 2018 05:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529386781;
        bh=OgY6vU1PLd02JA03RxHUuIPl099mDbw+QmDm/+cyvzc=;
        h=From:To:Cc:Subject:Date:From;
        b=GImTlZuUE/JDz8SVai+v0+wxQN9Iq38h5hz7pmGLjdS13mBpVD6e4Ds1jB9fCE9Q/
         lzMjD47qDlL6QcqMfGBIGQyjS11ww4Dembpy5wbbNDKDGadOnVE8f+JATToeFm+r1U
         QTWTVHvXZ+BM8FSmzc4gATvf7AraZ7nzASK5h97c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B18F7604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V3 0/4] Changes for SDCC5 version
Date:   Tue, 19 Jun 2018 11:09:17 +0530
Message-Id: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SDCC5, the MCI register space got removed and the offset/order of
several registers have changed. Based on SDCC version used and the register,
we need to pick the base address and offset.

Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm"

Changes since RFC:
	Dropped voltage regulator changes in sdhci-msm
	Split the "Register changes for sdcc V5" patch
	Instead of checking mci removal for deciding which base addr to use,
	new function pointers are defined for the 2 variants of sdcc: 
		1) MCI present
		2) V5 (mci removed)
	Instead of string comparing with the compatible string from DT file,
	the sdhci_msm_probe will now pick the data associated with the
	compatible entry and use it to load variant specific address offsets
	and msm variant specific read/write ops.

Changes since V1:
	Removed unused msm_reab & msm_writeb APIs
	Changed certain register addresses from uppercase to lowercase hex
	letters
	Removed extra lines and spaces
	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
	one for Documentation and other for the driver changes.

Changes since V2:
	Used lower case for macro function defenitions
	Removed unused function pointers for msm_readb & msm_writeb


Sayali Lokhande (3):
  mmc: sdhci-msm: Define new Register address map
  Documentation: sdhci-msm: Add new compatible string for SDCC v5
  mmc: host: Register changes for sdcc V5

Vijay Viswanath (1):
  mmc: sdhci-msm: Add msm version specific ops and data structures

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
 drivers/mmc/host/sdhci-msm.c                       | 511 ++++++++++++++++-----
 2 files changed, 391 insertions(+), 127 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

