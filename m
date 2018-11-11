Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C425AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFB721508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVvkWCIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFB721508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404723AbeKLIYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404705AbeKLIYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:12 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A7A223CB;
        Sun, 11 Nov 2018 22:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975654;
        bh=Ntl2kNLNzQzwEErc5ATb+0ddYePr/uiMSbvH52/droo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVvkWCIgIbdtMrhlHDgEe3LweZlwlIL1JEU4r0wS7we8ldk+2qs0ujYwvcisIV8FG
         F/0Fug35HEKd2QOjZY9t0J9keFxwgtVm+I/IbMuT17Katmf2gNeXaOTIJ9juDVCk3V
         rnAINI8GW43tjbsLVeHZp1vnrpfLMnP3aSujzQ68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.9 075/141] ARM: dts: exynos: Mark 1 GHz CPU OPP as suspend OPP on Exynos5250
Date:   Sun, 11 Nov 2018 14:25:34 -0800
Message-Id: <20181111221638.390179251@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 645b23da6f8b47f295fa87051335d41d139717a5 upstream.

1 GHz CPU OPP is the default boot value for the Exynos5250 SOC, so mark it
as suspend OPP. This fixes suspend/resume on Samsung Exynos5250 Snow
Chomebook, which was broken since switching to generic cpufreq-dt driver
in v4.3.

Cc: <stable@vger.kernel.org> # 4.3.x: cd6f55457eb4: ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
Cc: <stable@vger.kernel.org> # 4.3.x: 672f33198bee: arm: dts: exynos: Add missing cooling device properties for CPUs
Cc: <stable@vger.kernel.org> # 4.3.x
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5250.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -121,6 +121,7 @@
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1075000>;
 			clock-latency-ns = <140000>;
+			opp-suspend;
 		};
 		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;


