Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16414C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C452121A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMQOCulM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C452121A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbeHGGTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:19:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42519 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:19:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so16405921qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4oAQf4eNJu6idlBQb/xK/WVwgE2/aByrXAUoZc6sPiA=;
        b=XMQOCulM7s9nyksdcLQLJEBLCEg430Iu6hcGaTzs9fPi/c1VwEU98AUzdGRficn967
         GKTUgDl1Uxh+9PgaXTqDX7tL0/smqE5zDOIg2M9/xW0qZ0naFVMLdHrVVrBRBSMxW695
         O9VKQ/odixz2dRT+Xecji6XFxqQG3FRYNLc37Kfx10okGgjyebkCCyI9IYkAT40sihWi
         JkxMA5cbHkCP1TTL4q1Fv201/nM+Song7Vbc23qmySDKN6bYpNPtdbPhxXXmc4U8lDtg
         qG9VOfwyLm3X0qx5FmMhx2NG8FBvBI9R6fnMqHttlsE+OF6jCscup+jkZK8w5ZfUpA3q
         rdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4oAQf4eNJu6idlBQb/xK/WVwgE2/aByrXAUoZc6sPiA=;
        b=AUVFH2YRvog80CFsMKa5hyyL8iIkEz29t31RXgHNL5xHA2M+DlchAJKYx175LXyDIR
         1Px71G8UrevThrUhGX7v4at6k+g6TaYpk6ybU6/amcpZawJDhhYVALJyNp2KxD8C4BcH
         9aOuHkFQ7Ju4FZWtoasq1wDAcOm6acyYvJUZMgiQ+UE/nU/C4u02tFMPAoed0CIAIMTB
         1n0V4shsYdQAEyJbChi6dPTno6SE0ugr8R9plqxzjPzBBDlgPpQeuMHkGxrO1lLN2i8N
         fyi+VnKx5jKQbK9yvG/2tfmZpgoA0R68nZlZRz6V5JVW9vGsSvfb1H9nFqxIarJ3n+Z1
         8ACQ==
X-Gm-Message-State: AOUpUlELsmLq4kzvcu78P0vJQx0qb1tP9AAIVpLrzswj6t86NHmGCQtM
        L+y1p4arqwbWh8BQOLShpG8nNzcp
X-Google-Smtp-Source: AAOMgpfl0KKZcOyJRhcUASoGLBrbeJg/rjDUgBGWGy0MbTWZUUAmyotZbBwZnfBYbXj3CSiD/hQAHA==
X-Received: by 2002:aed:3848:: with SMTP id j66-v6mr17232260qte.218.1533614830078;
        Mon, 06 Aug 2018 21:07:10 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id l44-v6sm188364qtb.58.2018.08.06.21.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:07:09 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:07:04 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: fbtft: Add spaces around /  - Style
Message-ID: <d115e3cf356e42d7f3a2f6c76463cfca93a9bd04.1533614243.git.leobras.c@gmail.com>
References: <cover.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533614243.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index a9ee586ee6ba..4c71106d3b71 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -775,7 +775,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbops->fb_setcolreg =      fbtft_fb_setcolreg;
 	fbops->fb_blank     =      fbtft_fb_blank;
 
-	fbdefio->delay =           HZ/fps;
+	fbdefio->delay =           HZ / fps;
 	fbdefio->deferred_io =     fbtft_deferred_io;
 	fb_deferred_io_init(info);
 
-- 
2.18.0

