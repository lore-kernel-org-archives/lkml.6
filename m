Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A609C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561842075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6H0rS05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561842075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIGVuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:50:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38757 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeIGVuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:50:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so12870303ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nehbaC1Fe6VD9sOFSvtsd6Qic2sOj+f5imoKlToBLi8=;
        b=T6H0rS05/S0OeolO98wE6WfnbMYUbU7Go/0vOri9t7oXFsygRJiQ0P+/j1GjfpIURI
         BsPrByPfVUqh9n+lvSTZZs0oEC+qX25DPa7U/B4StpSJB+lG+1EhsfsOVhAHN4CqXs7p
         bCg7GgpOpDGf8q0laq3DvYzpVxMC25f6WIgR4Goa80yluUIiUYQpm7uMsaMIWIRGQs4C
         VwE8hjMw9ymxPqtdOh2DPTAaptM8/qaUddZXTZeZPlfAmnmWqkfMBdtWYhc9NeH4GsnQ
         1ka3UTYHDB5VcUKydtg0EIfIims4pE4dEKbTzL/5BjrEgT2yQdg3kkRkv63BTmxOIqks
         rd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nehbaC1Fe6VD9sOFSvtsd6Qic2sOj+f5imoKlToBLi8=;
        b=JkPZ/Um/L7a5sZnXD63tXF+3mEhxbLTA9yPuKtb1tobJ+LZXttLOr/6ELilPH7alq9
         kXgmfITD/lrLn3woP38k5KIzF0YKv3ZRc1w/52BMPGlVgHm+pqWENCebf3Or6SvfimLU
         OYPk8UrVfJZnPDX65b8po4jRKILdmaRxkWOwUuFnjVx1cHZBfHKS/KQ9R118rbRqdjw4
         vp4WeNINcKQ88rO2u1rSNoojT3UZEX1PEH2mK6F0fi6HUXjenVoHRNg/OuZK24W3xc3A
         yw1EUesmeTaEbnYYrDssckO5z2o/X/1tB1bKXsr8xgYmhNIRqoT3ZSbTqNZr22NGltgl
         AS8A==
X-Gm-Message-State: APzg51CHwlcVc1Gf5stWsZetezu3lHsbCjadDEfTDUSsWgpir5PpUm6w
        VwiW2lpJ0xF4/IHrpwCwlus=
X-Google-Smtp-Source: ANB0VdbWzrvz4OltkTd2G6QHOH5lgWaygVWsIO9liFgiPHqaY2008r0RE5oyJqOYs5Jr4P0491Aztw==
X-Received: by 2002:a2e:2c0d:: with SMTP id s13-v6mr5416368ljs.106.1536340108998;
        Fri, 07 Sep 2018 10:08:28 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id h15-v6sm1340355ljb.8.2018.09.07.10.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:08:28 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: octeon-hcd: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 20:08:20 +0300
Message-Id: <20180907170820.27328-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..1a6431879201 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2768,7 +2768,7 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 	    (pipe->transfer_dir == CVMX_USB_DIRECTION_OUT))
 		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
 
-	if (unlikely(WARN_ON_ONCE(bytes_this_transfer < 0))) {
+	if (WARN_ON_ONCE(bytes_this_transfer < 0)) {
 		/*
 		 * In some rare cases the DMA engine seems to get stuck and
 		 * keeps substracting same byte count over and over again. In
-- 
2.17.1

