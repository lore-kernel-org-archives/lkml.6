Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A852DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6074520C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJOr+xah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6074520C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeHVOVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40305 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbeHVOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id y200-v6so1066058lfd.7;
        Wed, 22 Aug 2018 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cs0oGoUO045kYss0NRP85VwvOntfsfVLI3TSx4yAoPw=;
        b=eJOr+xahIlY/uMksffRa4ztQwgp8wO/Ccmh//zSweBtwrPIcn9KuNWngElSgBxmUh2
         BzyAFspNo4LDWQig3q22V9dLTka7xy1c+ERKeH22iVJ6+U4hZvqn0LyJPT8Vy4Pg+k5T
         5loIbNT84CVeN9NbqK5HmFyaDJUyqPfTED91tpOBRUlxJh7BJ2WP+IZ+7+S/ViezEh+B
         39Eo9cV6877ArXuT+JJ2ai5Q/fr6q9ExYlpyABEiz875oF3Xn8xfPt7O+FCoFJihnh6U
         JTLrTjWUK7A/LoVirTPkmbz/eSdTunb1HENOqJU/BiCfWkMGhtSRUoPLtcDl68LbY2LD
         hAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Cs0oGoUO045kYss0NRP85VwvOntfsfVLI3TSx4yAoPw=;
        b=N3ZvlG/bgNFH+8cLLipQZ45STbO5cK94UO3Nvz5PL0NjqTbYDobo31P+qZQ95GxZIv
         D1ox5x9D6Khkk7lPmw08bpOBlfdPZUuBZubTPr7gJZ5AHOxC2JkOhokML2D9uhMEzfNN
         0tv3+sADFCuIczeiiccI9KHfPe0gZZIDi5LZANE0abtd3aP0xKgNSDF8KJ0/hdSx/wcm
         YsaqtspsKU/i0KyLqkPbSx5L9s3si0atAuJ78G92BKJJg9kHB2ERtG6TBsHTknpNvUvE
         XkKXsSXfI8E80SdCePM/ZTtDlo4zDTsoZn8kS85gkJO/ut6k+TCaImLX9P80+KYH1X+W
         Cc6Q==
X-Gm-Message-State: AOUpUlGgICa+BIPVKLuAGVCWdfNoZrDMpID3EAtYMiJxrSdZQp/HqFjq
        M1vJ8gOubUbqG6gixxVMN88=
X-Google-Smtp-Source: AA+uWPw1NqU57rW72yLXuxaMyU35nGyNAQtmAgF06HzTJmjUbTmxxwYxqvV+FYWyuM30Ucrobp8Fnw==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr21176282lfl.136.1534935440032;
        Wed, 22 Aug 2018 03:57:20 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u84-v6sm258900lff.35.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpC-0002XS-S0; Wed, 22 Aug 2018 12:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 12:55:42 +0200
Message-Id: <20180822105547.9634-5-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the slot child
node instead of using of_find_compatible_node(), which searches the
entire tree and thus can return an unrelated (i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

While at it, also fix up the related slot-node reference leak.

Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Cc: stable <stable@vger.kernel.org>     # 4.15
Cc: Carlo Caione <carlo@endlessm.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/meson-mx-sdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 09cb89645d06..2cfec33178c1 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -517,19 +517,23 @@ static struct mmc_host_ops meson_mx_mmc_ops = {
 static struct platform_device *meson_mx_mmc_slot_pdev(struct device *parent)
 {
 	struct device_node *slot_node;
+	struct platform_device *pdev;
 
 	/*
 	 * TODO: the MMC core framework currently does not support
 	 * controllers with multiple slots properly. So we only register
 	 * the first slot for now
 	 */
-	slot_node = of_find_compatible_node(parent->of_node, NULL, "mmc-slot");
+	slot_node = of_get_compatible_child(parent->of_node, "mmc-slot");
 	if (!slot_node) {
 		dev_warn(parent, "no 'mmc-slot' sub-node found\n");
 		return ERR_PTR(-ENOENT);
 	}
 
-	return of_platform_device_create(slot_node, NULL, parent);
+	pdev = of_platform_device_create(slot_node, NULL, parent);
+	of_node_put(slot_node);
+
+	return pdev;
 }
 
 static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
-- 
2.18.0

