Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0719DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA244218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R/aMmNU2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R/aMmNU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbeLTRaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:30:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbeLTRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:30:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D47360734; Thu, 20 Dec 2018 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327034;
        bh=CvCsYojDdQXMogPh6qX5n/g51BKHlLm0u2l1ZVv3WZY=;
        h=From:To:Cc:Subject:Date:From;
        b=R/aMmNU2tAPMleXbBIrYao6cXwArMwRuOiB2hoorIhAjLyP6DucmGTo1KcdVZz/mi
         uQ/LaqifexiZC/yWQccAcuevv62c89fWI/k+PbrKnWtwI56blIXwUAehx1DgSkQX0d
         g3D1NVIuC9R4PfLdzU8njeWWjrYN5PMVCJufuw0A=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 594D460208;
        Thu, 20 Dec 2018 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327034;
        bh=CvCsYojDdQXMogPh6qX5n/g51BKHlLm0u2l1ZVv3WZY=;
        h=From:To:Cc:Subject:Date:From;
        b=R/aMmNU2tAPMleXbBIrYao6cXwArMwRuOiB2hoorIhAjLyP6DucmGTo1KcdVZz/mi
         uQ/LaqifexiZC/yWQccAcuevv62c89fWI/k+PbrKnWtwI56blIXwUAehx1DgSkQX0d
         g3D1NVIuC9R4PfLdzU8njeWWjrYN5PMVCJufuw0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 594D460208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        georgi.djakov@linaro.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-soc@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v3 0/3] arm64: dts: sdm845: Add sdm845 GPU interconnect
Date:   Thu, 20 Dec 2018 10:30:23 -0700
Message-Id: <20181220173026.3857-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect consumer definitions for the sdm845 GPU to device tree.

This patchset includes the a6xx gpu support for interconnect as previously
seen here:

https://patchwork.kernel.org/patch/10718587/

It was pulled into this patchset because the interconnect-name was removed from
the DT at the suggestion of Rob Herring and it was easier to combine all of
these together into one set.

Everything is based on the base GPU DT changes:
https://patchwork.freedesktop.org/series/39308/

As well as the DT nodes from Georgi:
https://patchwork.kernel.org/patch/10719483/

v3: Remove hardcoded interconnect name from driver and bindings

Jordan Crouse (3):
  drm/msm/a6xx: Add support for an interconnect path
  dt-bindings: drm/msm/a6xx: Document interconnect properties for GPU
  arm64: dts: sdm845: Add interconnect for GPU

 .../devicetree/bindings/display/msm/gpu.txt   |  4 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  2 ++
 drivers/gpu/drm/msm/Kconfig                   |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         | 20 +++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h                 |  3 +++
 6 files changed, 39 insertions(+)

-- 
2.18.0

