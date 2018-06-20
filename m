Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D16C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398FF20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jog8sov1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C0zAlQ9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398FF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754797AbeFTJCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:02:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932602AbeFTIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D0FA60714; Wed, 20 Jun 2018 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479673;
        bh=H5j6Hm2fEfVor/UOBsGNN62LwiD17JBFcwYZdSCnTOI=;
        h=From:To:Cc:Subject:Date:From;
        b=jog8sov1wUVSGAM1slf2OR7/SisQmfXTPaO/bT11QRc1/3PEszAoxAB/NbF/DV5Qw
         D6APlF4z50B4pFmQC9707QNXVs5Cx/yaA1zJVQJlWVw//+ZZWmIFTl7PBETaFM41ye
         4VchjPI1pEwpBdCPu3Z+rZ5fKMMUQWTP/k2nI0So=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 511D1605FF;
        Wed, 20 Jun 2018 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479672;
        bh=H5j6Hm2fEfVor/UOBsGNN62LwiD17JBFcwYZdSCnTOI=;
        h=From:To:Cc:Subject:Date:From;
        b=C0zAlQ9InBVc+29A7mufOavUJ5NM2MbizpeS45JnB8199LPZWwLUbfouzgvBcKINA
         e0WxNsn0brVF8tNNA4IO2GlOGBj4o60frlb0aRGmY1mwrmh4MSXeC/l0IQAHecfqhU
         CE9AWZEAYF12dTletPGo31O9InVgQfedlCxOQZC4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 511D1605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v4 00/15] Update for QCOM NAND driver
Date:   Wed, 20 Jun 2018 12:57:27 +0530
Message-Id: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* v4:

1. Added patch to make other ECC configurations function static.
2. Clubbed the DT update patches.
3. Removed the bad block related patch. Discussion is going on
   related with for proper solution so planning to submit separate
   patch series for all bad block related changes.
4. Made the single codeword raw read function and used the same
   for raw page read.
5. Changes in erased codeword detection to raw read function.

* v3:

1. Addressed all review comments in v2.
2. Added patch for removing redundant nand-ecc-step-size DT property.
3. Renamed ECC configuration setup function with minor code changes.
4. Modified comments and commit message for few patches.

* v2:

1. Addressed all review comments in v1.
1. Make the generic helper function for NAND ECC parameters setup
   and used this helper function for QCOM and Denali nand driver
   for ECC setup.
2. Modified commit message for some of the patches and added more
   comments.
3. Added new patch for fixing ‘return 0’ for raw read.
4. Removed the read last codeword part for nand oob write.
5. Reorganized bad block check function and removed the
   read_last_cw function completely.

* v1:

This patch series mainly deals with error handling and erased page
bitflip detection for QCOM NAND driver.

1. The error handling was missing for some of the cases so fixed
   the same.

2. Add the support for taking ECC strength from ONFI parameter.
   The earlier QCOM boards were coming with 4-bit ECC chip but
   now the same boards are coming with 8-bit ECC chip since the
   earlier 4-bit parts are obsolete from some vendors.

3. We got few issues related with NAND erased page bitflips. The
   QCOM NAND controller can’t detect the bitflip in completely erased
   page so added the support to detect the same. It implemented the
   logic mentioned in patch [1] which didn’t go in mainline and later
   the generic functions were provided [2] to count the number of
   bitflips and make all 0xff. This patch series did some optimization
   logic to prevent the unnecessary full page raw read and data copy
   from QCOM NAND controller to DMA.

4. Following are the testing done for these patches in QCOM IPQ8074
   HK01 (4-bit and 8-bit ECC chip) and IPQ806x AP148 boards.
    a. Run all mtd test and check if it passes
    b. Introduce custom bitflips in erased page and check if it
       returns no error/EUCLEAN/EBADMSG depending upon number of
       bitflips and position.
    c. Introduce failure condition for operational failure and
       check if it detects the same.

[1]: https://patchwork.ozlabs.org/patch/328994/
[2]: https://patchwork.ozlabs.org/patch/509970/

Abhishek Sahu (15):
  mtd: rawnand: helper function for setting up ECC configuration
  mtd: rawnand: denali: use helper function for ecc setup
  dt-bindings: qcom_nandc: update for ECC strength and step size
  mtd: rawnand: qcom: remove dt property nand-ecc-step-size
  mtd: rawnand: qcom: use the ecc strength from device parameter
  mtd: rawnand: qcom: wait for desc completion in all BAM channels
  mtd: rawnand: qcom: erased page detection for uncorrectable errors
    only
  mtd: rawnand: qcom: fix null pointer access for erased page detection
  mtd: rawnand: qcom: parse read errors for read oob also
  mtd: rawnand: qcom: modify write_oob to remove read codeword part
  mtd: rawnand: qcom: fix return value for raw page read
  mtd: rawnand: qcom: check for operation errors in case of raw read
  mtd: rawnand: qcom: code reorganization for raw read
  mtd: rawnand: qcom: erased page bitflips detection
  mtd: rawnand: provide only single helper function for ECC conf

 .../devicetree/bindings/mtd/qcom_nandc.txt         |   7 +-
 drivers/mtd/nand/raw/denali.c                      |  30 +-
 drivers/mtd/nand/raw/nand_base.c                   |  72 ++-
 drivers/mtd/nand/raw/qcom_nandc.c                  | 491 ++++++++++++++-------
 include/linux/mtd/rawnand.h                        |  10 +-
 5 files changed, 380 insertions(+), 230 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

