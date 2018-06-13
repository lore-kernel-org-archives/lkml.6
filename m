Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9EE6AC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468B0208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD9tOYfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468B0208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935500AbeFMSvv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:51:51 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36998 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935245AbeFMSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:51:49 -0400
Received: by mail-vk0-f66.google.com with SMTP id w8-v6so2163564vkh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZkEDp9mp6YoqH/Y44X4boSP2LJcB9L2tguOQynTlju4=;
        b=QD9tOYfmYKW+AZeME5F9JeQeqq3Wd2xNrwusLyvuR/GdLYp4skPClrUADbnXLoWSXB
         YCI7a0K9JGqFO7mblFtSJWba8Xl7g+1bRX9ycqrDGtzoNnxQORZCewo+e7Majoe1Awef
         LyxZh11W20Ta7mEJBUGlitkNSv2gI7zw8A/cO9+sQL+x7JWG7vAt/+ZAdovXTm7VicZc
         C92mL9u+81s7oruULpQLP3ehNPXM1hlxJtmI/OG6MpGdrklOFHIZzQksdrBFf0B7q/2+
         ebS1rhWVxxtwO2VMAY6aIHrwK3N8M2ZsO7LjgkPe/Sr+GAGoJeURiQdZ7G8dyH+BdwiO
         g17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZkEDp9mp6YoqH/Y44X4boSP2LJcB9L2tguOQynTlju4=;
        b=jjCo7AIN6dux0MgnN/a0qUyH5oUQ5sFaBd3LNgUTSmbMBTNBR6mxZ8sUDf6Us2O26z
         ogXB0i93n13S1HttY492X8seNqUv/BvYDxFPh4zyjij6ndwf+sR+ozcDR9RuOEOECak6
         MFQlzlsSLb9cqZttX/uVTebftcpVVDwBK1vhLf2TvGerIMedA3hbhqVEmszIfcRKiMyl
         RdDCgSGj6WORxWBsWJ9PYcJeWYBNJ8SB2NZuQG3A7lC+dRvx8uRrZUeya00EwE+k5F8+
         y+K7LkF4SMRThzon0WeV0GBPBR0TO6wWE8hLbXn12saQ0yOAoRnfZmPqRmRiqi/KS/Xj
         bKhw==
X-Gm-Message-State: APt69E1u9ugPJ7r5F2wexnW3oAgOMLaSfXInPvSxzb3yn0StovUS8udL
        3qSS0vsbUMQiErQw0zU3pbk=
X-Google-Smtp-Source: ADUXVKLiBwPA9wpEpEgITRWElr4G79PZ2MNWV1f20SyahpkJZUT8bIHO8e4VsVnHQPOOMuDj+hlHpA==
X-Received: by 2002:a1f:4c44:: with SMTP id z65-v6mr3752831vka.122.1528915909257;
        Wed, 13 Jun 2018 11:51:49 -0700 (PDT)
Received: from javier-Z97X ([2601:582:c500:a66c::21e8])
        by smtp.gmail.com with ESMTPSA id k31-v6sm1460462uaf.49.2018.06.13.11.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 11:51:48 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:51:38 -0400
From:   Javier Martinez <javiermlinux@gmail.com>
To:     abotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hoogmin@gmail.com
Subject: [PATCH] Staging: comedi: ssv_dnp: fixed style line length warning
Message-ID: <20180613185138.GA14362@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed style line length warning detected by checkpatch.pl in the file
ssv_dnp.c.

Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
---
 drivers/staging/comedi/drivers/ssv_dnp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/staging/comedi/drivers/ssv_dnp.c
index 0628060e42ca..87f46e0eb9ee 100644
--- a/drivers/staging/comedi/drivers/ssv_dnp.c
+++ b/drivers/staging/comedi/drivers/ssv_dnp.c
@@ -16,7 +16,7 @@
  * Status: unknown
  */
 
-/* include files ----------------------------------------------------------- */
+/* include files ------------------------------------------------------ */
 
 #include <linux/module.h>
 #include "../comedidev.h"
-- 
2.17.1

