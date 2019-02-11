Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE912C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CA1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896350;
	bh=e4wYGzGbZhk71+QW3/qZ4xb2ggvbkZgk4KPiQbpgH9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8AlFJAKggeC1Oq/ZD+RzwwmkXUSPVs+t0y3rFt5+PAeCn6O28lB6iuk6LF52+5fY
	 22PXR4X1bk7speU0VwV04ipYCX6akjhCqaMe6I1KN2VlNXMMyP5imS4w+sRNi3yyWL
	 qK6068KhI716K5UxbM1pBDEpaFsS1FxYRs2inp94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfBKOps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733103AbfBKOpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4145206BA;
        Mon, 11 Feb 2019 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896342;
        bh=e4wYGzGbZhk71+QW3/qZ4xb2ggvbkZgk4KPiQbpgH9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOWewgIzMV0Xl+tpxYqWD11FACIUM8B+8PJYnr0uJmh+jVqR/IHZ6C+iMqHo34Hql
         FDy3UUkYjqQmWNUIgq4HjnHK3rnmOzdIEdTbp1XKXOYYuqcmydCeH/ngy9pHyfit+n
         AgyOQgzbUhE4jXslYjx6W5AzI7yD/CK7jqz/Q75M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 151/313] usb: renesas_usbhs: add support for RZ/G2E
Date:   Mon, 11 Feb 2019 15:17:11 +0100
Message-Id: <20190211141903.645922416@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 4310df46639d..b0792585d5bc 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -457,6 +457,10 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
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



