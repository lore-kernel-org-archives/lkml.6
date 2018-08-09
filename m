Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EBC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1324E2239C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJGvMaK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1324E2239C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHJBB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:28 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39248 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeHJBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:01:27 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so8395034qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E6Sx1f0+jHXAyk4T29H/ecTgNXh8lga/ZGsPL6FxikI=;
        b=IJGvMaK/t8yRyEAhkknRajlmrw2b7Kv2TNIHnSSezkcBhaUdFr527TQP9hz9czzykZ
         Et/1MRbvBmrznAct3k665/Fr5LEFGimRnuh1xf8Dhw1Uivsowyu83hGLoNEFwYzad8mX
         6zzgUh5whkKkAItHJ6UBzr0H3tW3cUE3KsQPzAgTWbyXleIej78zQzx7tehcLWlwWVl2
         YJBh6tQIyKi96c6g1kB3NK+ycqi1rYEpGqL4aaMvTqzaHncs/U/wdlYbAlVL4PNaQuM+
         E+BfOhRPbnBOC16GwZwVVPWcAM3BFdguXvDTu636yS2dczq4yi0fMejOwKgN+okodZIR
         VgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E6Sx1f0+jHXAyk4T29H/ecTgNXh8lga/ZGsPL6FxikI=;
        b=mSiAcAP/VIeokHhqjPzSA9LC+xt2ad9Ft6fCofhNM2sSa1IanQEzJfTLUm8Z3ChY0P
         PsUy6SlF/OeIJwDsjQYUyv1Rwo/5YMGB8BMQ6V3ICU0VhMu29u0qZCPN3+1/l/1yO8Zg
         spCNwkK+B6jkU1NNGVOWa+TgTeK5wAMze8b0/yHlbwyioe8+kTP6E6fAp8S+ByCYGLlG
         t+TbL/OI0JonhN9hMe1Yjk/Msqs7/DGPrZbqStaXouxfNEK9+XLr/x+rrni7kXRzC8eE
         ZIL+NaCsWVSCIwEk/Td3DqANetrBMxR0kxdacxDGtTJe/q45V4w+act7XZ/RIuj5DDSC
         mIVA==
X-Gm-Message-State: AOUpUlH+T0qux5Vrtku426NK5uboL/HcfGdfn7yNG32ZgFj89r/vdy3Z
        V4Bp8PTNrpjbeV7Vjdu2PkECDtsi
X-Google-Smtp-Source: AA+uWPw/t89YaIUqVWNSP42ck70KTvmiPYwAqgGmsfNzmkhdyTPMi6/fX/0TeND23zipnHyhWS6XkA==
X-Received: by 2002:ac8:2463:: with SMTP id d32-v6mr4094964qtd.41.1533854070273;
        Thu, 09 Aug 2018 15:34:30 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id u36-v6sm5391994qtb.27.2018.08.09.15.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:34:29 -0700 (PDT)
Date:   Thu, 9 Aug 2018 19:34:24 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] staging: fbtft: Corrects long index line  - Style
Message-ID: <7cd8c34234ae8603c71f172381cb613dda6797c5.1533853354.git.leobras.c@gmail.com>
References: <cover.1533853354.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533853354.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduces the index size to keep the code more readable. 

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 2a5c630dab87..404046d3999a 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -25,6 +25,7 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 	unsigned long val = 0;
 	int ret = 0;
 	int curve_counter, value_counter;
+	unsigned long idx;
 
 	fbtft_par_dbg(DEBUG_SYSFS, par, "%s() str=\n", __func__);
 
@@ -68,7 +69,9 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 			ret = get_next_ulong(&curve_p, &val, " ", 16);
 			if (ret)
 				goto out;
-			curves[curve_counter * par->gamma.num_values + value_counter] = val;
+			idx = curve_counter * par->gamma.num_values +
+			      value_counter;
+			curves[idx] = val;
 			value_counter++;
 		}
 		if (value_counter != par->gamma.num_values) {
-- 
2.18.0

