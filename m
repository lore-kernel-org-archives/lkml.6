Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBFA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690784;
	bh=/HZnUz0tCckFGyo3E7EmbKmGf+MDVTCxax7qooVA/PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eVUWThfcrFX4bLwONOfohhxcA/hAJkluVDr6jYC1KHVpEJSVaLI4ec9de7ZU/mH1I
	 XdVI05H86O1gWwCcXJ2+patU0ICws8iKfqdkoBWIFhwdqCPsRtfuITtKwTjHuGq6sX
	 hLW41eVy4LLklCR4G+bMR9DagBzkg2Qou88qkebg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfA1PxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfA1PxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E3921741;
        Mon, 28 Jan 2019 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690781;
        bh=/HZnUz0tCckFGyo3E7EmbKmGf+MDVTCxax7qooVA/PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+fQdzMgKOcCVFc02ReTN3FSa0st/Mg3ux5j3gEA2zphrg0+s9PiBDqx11cehQNuw
         EqfuherYrryDedfhbFfWQ2PraztuA/DRlbRUnJHhkbbQrVp7sGEPndSpG2PxitgxvI
         Ab8DNiune7xw1/WDv5LlT4+A9j8OzRcA9WE1RxLA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 190/304] usb: renesas_usbhs: add support for RZ/G2E
Date:   Mon, 28 Jan 2019 10:41:47 -0500
Message-Id: <20190128154341.47195-190-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

[ Upstream commit 1d6e81a288e28d8d0e38e0501a324216f79bba35 ]

HS-USB found in RZ/G2E (a.k.a. r8a774c0) is very similar to the
one found in R-Car E3 (a.k.a. r8a77990), as it needs to release
the PLL reset by the UGCTRL register like R-Car E3, therefore add
r8a774c0 support in a similar fashion to what was done for the
r8a77990.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index a3e1290d682d..1de333be9353 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -539,6 +539,10 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
  *		platform functions
  */
 static const struct of_device_id usbhs_of_match[] = {
+	{
+		.compatible = "renesas,usbhs-r8a774c0",
+		.data = (void *)USBHS_TYPE_RCAR_GEN3_WITH_PLL,
+	},
 	{
 		.compatible = "renesas,usbhs-r8a7790",
 		.data = (void *)USBHS_TYPE_RCAR_GEN2,
-- 
2.19.1

