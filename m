Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6923621A73
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrrZdrBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6923621A73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbeHGGTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:19:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:47033 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:19:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id d4-v6so16385151qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xRtoZ3kdO7qkh0Wdry/ua0BFUe7mihTU3AMzYPzIUrQ=;
        b=hrrZdrBS+cFxPG3HqA8Jm3Wk4q9YnK7W306G7rK24ZG9Gx5JaZC+D46YSLwiwSVXpH
         5WIJ6KaFPMUjhUwHxsvsMvy3y+L7Kt8cDGyY6soC+0JYPMy/v71f8iWgPPk5qkoH3Gm5
         d2PA7aWhCnJdeZkz3eViot7H6imnBUY0NwHMyjBOJokoNY0GsztPbeCt+q0YSI9v1gR5
         6bG2UhHK13y29GTdf2D+OE509t43AuV71DA+VlZuyeWqQIx4NEIOU/89juUA3MyxcsmR
         QhONSDvwncldL17sXYdY/hAYV4rwnpEqEexD/fYxt3j7jfRbdEjRr4baM0zG0FEZHEzd
         oFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xRtoZ3kdO7qkh0Wdry/ua0BFUe7mihTU3AMzYPzIUrQ=;
        b=jl0nDeR3GPAhq0q32iDE8K1PliZepTUMaM+g8RdsBSpQ+tLp5UDHqQhhDe12By8WmM
         jX7AS7OhWuWmHDWl1VX/zOmnCyAKi2qOTCk6LLKEL2XFiVkN83v8iVXbV95a6PDy5DSc
         i3Ul8RI4vWbiOkwg8ulJ7JpQi40awAcGOpMmFEYoz3BedVxKB9zd3PaB7vf3VKVZN8/k
         kZh3CZWmiUAe9gTeO1azw65ONhQiaaTfSG8ExyTSPWk2AQRT9FSl5q/nBhhg+YOLX5ro
         jVv0xSGM8Agik/ZpJ5QVxqgW/JLfHA1pS/soAAzzbWw8/xYRWLxzIvDyzDfUmwgIf8sL
         zPBA==
X-Gm-Message-State: AOUpUlHOMa6arQgX/p54EoenWsYu9VP1LQ2E5wYxkbHfbRvdZZ/tHW+J
        CRvuBrc+dJoTz8V7/po1fZs=
X-Google-Smtp-Source: AAOMgpe9uAp7B1N+tSx1uE3YHi+V5OC6C7/qHWl6BJKh7TYLm2CyU+Peu+xCa65uGPC/2ViFlPgsWw==
X-Received: by 2002:ac8:1b88:: with SMTP id z8-v6mr16957308qtj.321.1533614841594;
        Mon, 06 Aug 2018 21:07:21 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id u36-v6sm181398qtb.27.2018.08.06.21.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:07:21 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:07:16 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: fbtft: Corrects long index line  - Style
Message-ID: <a7d6ba97c773feda581f3877e906a85a0a347aad.1533614243.git.leobras.c@gmail.com>
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
 drivers/staging/fbtft/fbtft-sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 8327f8f26ab1..99c8c9a636b5 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -25,6 +25,7 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 	unsigned long val = 0;
 	int ret = 0;
 	int curve_counter, value_counter;
+	unsigned long idx;
 
 	fbtft_par_dbg(DEBUG_SYSFS, par, "%s() str=\n", __func__);
 
@@ -68,7 +69,10 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 			ret = get_next_ulong(&curve_p, &val, " ", 16);
 			if (ret)
 				goto out;
-			curves[curve_counter * par->gamma.num_values + value_counter] = val;
+			idx = curve_counter
+			      * par->gamma.num_values
+			      + value_counter;
+			curves[idx] = val;
 			value_counter++;
 		}
 		if (value_counter != par->gamma.num_values) {
-- 
2.18.0

