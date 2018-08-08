Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B934B214E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/1vVC8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B934B214E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHHCpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:45:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46153 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeHHCpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:45:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so516095qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qOFTZpVY1Iu7gonudEQ8hi5TNpOiEjWu6UKEWYqHr64=;
        b=j/1vVC8CSJL7KbCsFzuLp4ineIml5rAz6MNfKVUs0nXVQ4Hrlik/oMU97NdnexeED7
         C5h5OFtYEnsUT9wWwt1DLGP3KCg0wGQVLxkbvQ1wCtaSRGoKS/DWBp9w6niX12D1JTyE
         y/WmT8YEFdY8XbyDCnWYWjHoIvgN4PxLwgiq4DJx3/CZ62CN1szboQ6IwuttQ3RSkoZI
         tYNqlKE9uHZUbCa2JBs69wx9bwFsgK+Od+A1cXpKCW9YL0AWkbscUMS4nkB/HMVUO5vX
         tlnUYzgZu4D8wSosbezUmHe9m5k47VIWla/wYFz/+6W682K5KeYu2pFSM6jxhNjKYrro
         bwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qOFTZpVY1Iu7gonudEQ8hi5TNpOiEjWu6UKEWYqHr64=;
        b=EWlh1U0ycngss9Hujdfg1JJ4n872EfY9UBN4dE+YQVTsQP5oga2Ivl5G5cufeouTDv
         VS6Otba6HfUUjHg0mKVNh5YvDPMliK083bYJnW0c0bRpcIrRCrQ0HiuvyF0PzuH342Is
         vKSJk0HsnMGJXNyDtdvrtzeGTIx6rhgPzUur9P3qiQ7babwFOlRMj78gYaWc6Fc5Kp+V
         ejUCjLLy4bCjJ8gTCq6AZXcbWkfVjoICIK8a5YCJzUX/qL2iVInmEG+cHVu3UTd3lKEB
         MMECDJmKa4+0wGqK50/owIbrje7rS/BUbDccuBxgUcfV4TJhaK4ygLgSwyBGVWdu8OXx
         FXqQ==
X-Gm-Message-State: AOUpUlGi8jQsM2v0T4nRXvr1qD9DmQkTfW2+n+B2IZ5lG7z+KUwR9W1g
        08OtPUewT2zKmWz18p7aLCho0USE
X-Google-Smtp-Source: AA+uWPzSK3oZe0KNxGrRiB2efDV9eb5CDBijETYXh+Gw7645DjZgkZdR211xt3+UrOj90lQiVUQf+w==
X-Received: by 2002:aed:3c34:: with SMTP id t49-v6mr610733qte.404.1533688133833;
        Tue, 07 Aug 2018 17:28:53 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id f184-v6sm1711091qkc.23.2018.08.07.17.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:28:53 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:28:50 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] staging: fbtft: A bit more information on dev_err.
Message-ID: <852f8edc391af5b44a262c0212fa4d367b40dcf5.1533686201.git.leobras.c@gmail.com>
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

Adds a bit more information on debug. 
The line break was to avoid obfuscating the parameters on the end of a large line.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1351.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index e077b3d58aef..ba78a7758fb7 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -126,14 +126,16 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 	for (i = 0; i < 63; i++) {
 		if (i > 0 && curves[i] < 2) {
 			dev_err(par->info->device,
-				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n", i);
+				"Illegal value in Grayscale Lookup Table at index %d : %d. Must be greater than 1\n",
+				i, curves[i]);
 			return -EINVAL;
 		}
 		acc += curves[i];
 		tmp[i] = acc;
 		if (acc > 180) {
 			dev_err(par->info->device,
-				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n", i);
+				"Illegal value(s) in Grayscale Lookup Table. At index=%d : %d, the accumulated value has exceeded 180\n",
+				i, acc);
 			return -EINVAL;
 		}
 	}
-- 
2.18.0

