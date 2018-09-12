Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470420882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXO9V3Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8470420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeILXV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:21:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46347 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeILXV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:21:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so1391834pfn.13;
        Wed, 12 Sep 2018 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=oM2v1G49rl71rQRQ2vZ6RJ9N3LGPn0V5rzjIW37RUII=;
        b=oXO9V3Dy1//mazKnHTbny/SfZOZ9gwQiVAJ80oGUWoGY57vTAxM/LEJT1m8RrhLZq7
         U1Ot7FWdEnV9GiLsatZKgVbzfv+XTKqZ2S3iy3vHA3zoGfSoqgUPrsChMzgH7lCO7oKh
         irDNQYBJQHxydWp5WJMdfkvsnfR6yxGnw9GMuDf6TVbCvzazpHuyGWFrQBWjKYl1y6oU
         OlfQLGlqtrRCtUoSLenv9L3iM6WjiLuYFGb+Bvg2OCZEdlHB/e02KxpGjI6V4CHYmCAu
         GFdk/h7nrvUvvOC/ofIGdPF2F5HhQAQrVVS64G5gSBOYn/ycNLNNV5pPhvdkmGm96UKN
         oKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=oM2v1G49rl71rQRQ2vZ6RJ9N3LGPn0V5rzjIW37RUII=;
        b=pL7s0nq5yOeqkcsmUnpZfr9IXvd8VYsU9X0KHnKpalfHyq4MBmACi9sK8GJaZ51zUR
         fFgHrovVHjUAa2R59+xhnKWqJlo+OrbXwJAmLqkP2474fDxVFPxFw0Znh2BJAaW6JA+2
         fdKLbWx4CrYPiZN9iNOtGZWzFzu7tKW92bTF2M80BZjrY2EkQui0vH2c53IhiGafM8rK
         A0jBccKCJHGEMiW9ip6svmrJLyg4O2iXYxu7uRh9MxJ8+KmEUSZQaQud1+hDXMoQcsnj
         5a0mOpoCeXfwNrFSvffFDUdy7hLYT3hhhs/teGMCnDhxhaLV+sqTHL5ZSLYSWx0yaMLs
         maLw==
X-Gm-Message-State: APzg51AIesFBE2fmn76I01KNv+3M3WzCjv/Ssol5ljgEfG7qebN2aCyA
        vDwLG8rENwV4C+iIG7L2TCjhF1U4nBc=
X-Google-Smtp-Source: ANB0Vdanp1m/7XGDDao3D3L+AFT//JJx4DLGu1RG0zBiA6fFkTzsc0VIVFWuopyrOy/uUL7KH3A+2g==
X-Received: by 2002:a62:2e02:: with SMTP id u2-v6mr3786499pfu.134.1536776173706;
        Wed, 12 Sep 2018 11:16:13 -0700 (PDT)
Received: from josh-ThinkPad-T460s (cpe-75-80-215-168.hawaii.res.rr.com. [75.80.215.168])
        by smtp.gmail.com with ESMTPSA id k26-v6sm3425890pfb.167.2018.09.12.11.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:16:13 -0700 (PDT)
From:   Josh Abraham <j.abraham1776@gmail.com>
X-Google-Original-From: Josh Abraham <sinisterpatrician@gmail.com>
Date:   Wed, 12 Sep 2018 08:16:10 -1000
To:     hminas@synopsys.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: remove set but unused variable
Message-ID: <20180912181610.GA31006@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a set but unused variable in hcd.c.

Fixes warning:
variable ‘data_fifo’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
---
 drivers/usb/dwc2/hcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2bd6e6bfc241..5f23b933cafc 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1328,14 +1328,11 @@ static void dwc2_hc_write_packet(struct dwc2_hsotg *hsotg,
 	u32 remaining_count;
 	u32 byte_count;
 	u32 dword_count;
-	u32 __iomem *data_fifo;
 	u32 *data_buf = (u32 *)chan->xfer_buf;
 
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
-	data_fifo = (u32 __iomem *)(hsotg->regs + HCFIFO(chan->hc_num));
-
 	remaining_count = chan->xfer_len - chan->xfer_count;
 	if (remaining_count > chan->max_packet)
 		byte_count = chan->max_packet;
-- 
2.17.1

