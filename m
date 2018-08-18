Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42CDC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C0205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8TW9OHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8C0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHRUAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:00:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:00:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so9550323wrs.9;
        Sat, 18 Aug 2018 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U/m7ucfMMFn/nJe5wUXDy5NIoCs7A8ILACF2RE9ly0M=;
        b=u8TW9OHGQuS68ELZQQHevh1piHPzmBmD1mnlGU2ZbRBk49HvPRir1F48LMpUUakBqi
         u+iNiPSmMUO4Lxha8EQO/Y1hZRvj0R6VTNq8SwQ9hkWgW4hE2vZwwPyGB7IPbKkIzT3m
         OJjO4jxRLmpXbm+fqfTNTgwXtBbI7d+PRTxyV3yPyc/Wt2NXXuklCYcE2I0yGZw5ibrv
         Dh/cAPxq/6upVqHMtyTt0dSBtMs22/VH4Fs2h2sPRPFYTCQEaQfMTL3RP2vCFsgf7vHC
         C57wV+NjZ4Ey2tjEI6bvZvt7HOukn7bBToHouIrDSP6cHFgNwlrsckMS9azhjA3GNh/1
         JXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U/m7ucfMMFn/nJe5wUXDy5NIoCs7A8ILACF2RE9ly0M=;
        b=nGP6/aGto4BJhM/aw1TUGojkgAnN/HMTlcTXgdxWYzHr1s/zpsGKSLeJRthyVDzmnv
         B9VuXOdw4xxK8L0znOaUewFE2UwtPoN2x/otOoY5gZNX5/Wb6nHzkESbqTQfcqTTOFDL
         ZH0sbOeTMcoQoiyPhe7N/XiDk9VvsV8a6mP+RY7g+Oj+RuIFTLfCyXCqp6DA7Gm8uQZw
         IlhjL92JyFwZEpIhvDhmdlTzF6F+PfOG62XwCx+JICNp5bWNP//AnjUBBmH3AYAYabrj
         kkI9wTZAFwC9VP/iaJA6eFNXrnZzaPUIxR5MKXTaUvtHe0j7iRcuOxse32rEWzV0Ysr1
         ExRQ==
X-Gm-Message-State: AOUpUlG50Fd2ssG6oQjJfsDtz7SIZPrc4vhqCjP8a4NN9A7pgcQwxCzr
        6rDw9Z8xdz3IZN4QsXYU0FvFuNy4NU1wug==
X-Google-Smtp-Source: AA+uWPxhWabHuOHa+XCGQip3q+h3mPl+HchPOgzoWKKHKw9m4oZVEGgT34vlfk4iWYQBqLDd52S6xw==
X-Received: by 2002:adf:f58f:: with SMTP id f15-v6mr6662696wro.59.1534611112357;
        Sat, 18 Aug 2018 09:51:52 -0700 (PDT)
Received: from Fulcrum ([39.40.115.2])
        by smtp.gmail.com with ESMTPSA id 66-v6sm12046091wmw.34.2018.08.18.09.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:51:52 -0700 (PDT)
Date:   Sat, 18 Aug 2018 21:49:54 +0500
From:   Faisal Mehmood <f.m3hm00d@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb/dwc3: Fix spelling of 'optimizations'
Message-ID: <20180818164954.GA5717@Fulcrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'optimizations' was misspelled as 'optmizations'. Fixed it. It is a
coding style change which should have no impact on runtime execution of code.

Signed-off-by: Faisal Mehmood <f.m3hm00d@gmail.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 103807587dc6..ab90f680deed 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -748,7 +748,7 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
-		dev_info(dwc->dev, "Running with FPGA optmizations\n");
+		dev_info(dwc->dev, "Running with FPGA optimizations\n");
 		dwc->is_fpga = true;
 	}
 
-- 
2.18.0

