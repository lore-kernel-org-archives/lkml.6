Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B1C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2D8214EE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiouPnns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2D8214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeHHCqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38276 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeHHCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id w26-v6so575882qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D/wyI6jwlf9eCnr8Q0q25yR4N4/Cqh3XCCvmG1In3x8=;
        b=eiouPnnsxpkFIGNo0MkCW7qdPET5onE1G+oKsnnArwjlb5N4qLi0KlQp7Mu6UPVJK8
         QYAbx3P3oKWYuQf9oOLGCeTJpHT7MChmVb26C/xRjNcsEkRKvFOpinud54PHLMscZFYD
         hvh9cUDoa/hxaWtw2VTfIrbInV5BybfZOj/MHX7XkYsTjDGfGDKKV82YY07JRCJyBbwN
         2wZ8YnDxuaqBKX6e9KYsUYtHAQHarXlvttFvFu2Mhq9BIGqw7g2nMKG3rpCm3v2cGZXf
         6FO1pHlrCEiF2vTv7BMMxjIOwWhV4fug6OU0zAntG1la7mC0z2eVeYyF2AgAd7DzF666
         nHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D/wyI6jwlf9eCnr8Q0q25yR4N4/Cqh3XCCvmG1In3x8=;
        b=tITwrgrUm6bdhQKYeoxQ9ur+LcgWXa9Gx4y/IDKeZUT1zo5OjagpFWlSb3HiF6cdol
         MppIvkHjVYHhT6PLZsgoMmSh1aDV7ynqmVrlkJ9WeGLnJL4WIwHhg+JopkjSqN69597n
         fs5bcw/ee50JlpWZCkANkeZor6OJ8OfgTJNaeXpZqPVV0V4NzPEXeQGu1PKZk35drmvf
         /Trpp9ZwUIj8+/mxwdZyiVtDw0aFPDrBIoKJ/1vh1/rZIdx16OM/JtRG7XOG2KCysCjq
         +Qaoz5KEiaGqM9OFCSP8UKxV03mE8qDhwPLZD23a+6uvhLygzylQNyR3cx7VOIgiHiQe
         F9qw==
X-Gm-Message-State: AOUpUlFaKdpC4y+Vv4MS4jdS5XQ3XjSp+vmnHaNpzMY5ygCN8R7PxkWc
        YdElqi9qUz3/Azq5GPncBvM=
X-Google-Smtp-Source: AA+uWPzGPyPR9QCjO8dL4vYb8PR2CUj53t+6jHc77MGq6LGgP9OF67ssvQI/qTrjbUqPZv0ocfn5vQ==
X-Received: by 2002:aed:3e50:: with SMTP id m16-v6mr665013qtf.214.1533688148068;
        Tue, 07 Aug 2018 17:29:08 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id g8-v6sm1274276qth.77.2018.08.07.17.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:07 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:04 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] staging: fbtft: Removes one nesting level to help
 readability - Style
Message-ID: <67d1e72cbeea7f9a0dd27696833072ef363608c8.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This nesting level was removed to improve readability. 

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/flexfb.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index af6c330cdf8d..812c03fb09f4 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -682,19 +682,22 @@ static int flexfb_probe_common(struct spi_device *sdev,
 			if (par->spi->master->bits_per_word_mask
 			    & SPI_BPW_MASK(9)) {
 				par->spi->bits_per_word = 9;
-			} else {
-				dev_warn(dev,
-					"9-bit SPI not available, emulating using 8-bit.\n");
-				/* allocate buffer with room for dc bits */
-				par->extra = devm_kzalloc(par->info->device,
-						par->txbuf.len + (par->txbuf.len / 8) + 8,
-						GFP_KERNEL);
-				if (!par->extra) {
-					ret = -ENOMEM;
-					goto out_release;
-				}
-				par->fbtftops.write = fbtft_write_spi_emulate_9;
+				break;
 			}
+
+			dev_warn(dev,
+				 "9-bit SPI not available, emulating using 8-bit.\n");
+			/* allocate buffer with room for dc bits */
+			par->extra = devm_kzalloc(par->info->device,
+						  par->txbuf.len
+						  + (par->txbuf.len / 8) + 8,
+						  GFP_KERNEL);
+			if (!par->extra) {
+				ret = -ENOMEM;
+				goto out_release;
+			}
+			par->fbtftops.write = fbtft_write_spi_emulate_9;
+
 			break;
 		default:
 			dev_err(dev,
-- 
2.18.0

