Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040FFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34124098
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hJfDMI0d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J4IWWs9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34124098
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeGFHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:52:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbeGFHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:52:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7EE97601D9; Fri,  6 Jul 2018 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863532;
        bh=smBPeasuC1/01H/NVcCMDGBdLokiGkofLvtuG5ialSA=;
        h=From:To:Cc:Subject:Date:From;
        b=hJfDMI0dvaiJHok63YfKzr5LVdDIbk1E880OZpD1WAHrQkUyNdVbiFRq4iwjLCwWM
         SFWnIW2jSvPM0zTg57pS7LhLIMRthlKG1wjhrF1ZlfP1iCFZI9dc71NtyKEtciwp7a
         WGE+8xk0j5wrbLAHV2FlExoOJhe2YQaFaQE+sXkQ=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB734601D9;
        Fri,  6 Jul 2018 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863527;
        bh=smBPeasuC1/01H/NVcCMDGBdLokiGkofLvtuG5ialSA=;
        h=From:To:Cc:Subject:Date:From;
        b=J4IWWs9zjP5HrMQUGaSv08wi8f0CUN0wXEkINj39msgeYNPQsZRJYo+pC3ZqoYPZK
         N3hy5UKW8j0bOV1L46ZzwYK7qskgIuPN0ceheBO67ud/EhWVmkN3OorVb8Uypql5yQ
         95x6j4Of3EL8qxhFWCSTRf0uDMLMrcZ7vRHISgvQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB734601D9
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
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 0/5] Update for removing driver specific BBM functions
Date:   Fri,  6 Jul 2018 13:21:54 +0530
Message-Id: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series deals mainly with removing driver specific bad block
functions and some minor fixing/cleanup.

1. When initial support for this driver was added [1], then the
   plan was to remove these driver specific functions when NAND base
   layer has support for doing raw read/write for bad block related
   things. Moving to raw read/write seems to take more time so this patch
   series implemented alternate logic for reading/writing bad block with
   normal read/write itself. This alternate logic relies on some
   assumption which seems to be better than driver specific functions and
   provide more functionality. Some discussion regarding it has already
   happened in [2].

2. Some part of code is duplicated in every read/write function
   so clean up the code by making helper function.

3. Bootloaders does access protection for some of the NAND
   registers which generates few write errors if it is enabled.

4. Create RAM based BBT table. Flash based BBT table can’t be
   used since our bootloader does not have support for the same.

**This patch series is rebased over linux-next with PATCH [3]

[1]: http://patchwork.ozlabs.org/patch/508565/
[2]: https://patchwork.ozlabs.org/patch/920563/
[3]: https://patchwork.ozlabs.org/patch/938631/

Abhishek Sahu (5):
  mtd: rawnand: qcom: remove driver specific bad block check function
  mtd: rawnand: qcom: remove driver specific block_markbad function
  mtd: rawnand: qcom: fix NAND register write errors
  mtd: rawnand: qcom: update BBT related flags
  mtd: rawnand: qcom: reorganization by removing read/write helpers

 drivers/mtd/nand/raw/qcom_nandc.c | 439 ++++++++++++++------------------------
 1 file changed, 162 insertions(+), 277 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

