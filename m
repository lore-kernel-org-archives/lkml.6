Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEFAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FBA215EB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Fw4AB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FBA215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHHCq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:58 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35525 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so370985qku.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VkFeyBBR/Lf5OyIjN27X86REn3UJeBJ7d24lO2GwLFo=;
        b=b7Fw4AB1y3lX94FCjVTgm8UnF6Rw4DzFmS285uu9K1D/gue9zOrEKcBE4O5GABiyke
         ImHQed2kKS5tANTKCJWA3/0bGa8akW5YuGdySSPcPnND9/i8ZEdeirti7n2ufQ18NSay
         hxgnx8A8MJMGs+G2gRG27o5TB3RnylA4C8ZBsgiUXxwgP8cJh3vPH82g5rCHZH0uttdn
         jlydDhIfzlaBBUnku6LSD6OMYZr3ZELOJ075XIG9P9lc8G2pT/sh2TnT+njGBdcT7nAr
         5m9dAwwdi2/5owt7jYVRG3WBFJlSlhaC8IpBTjA98zoDxOkIW6IRXyN7s3qwsb6jr9Fu
         FBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VkFeyBBR/Lf5OyIjN27X86REn3UJeBJ7d24lO2GwLFo=;
        b=PYbaEoiutVYvQCD6H+98KVm38WbU01slvBTNvvyR3tBIqtZQ8vmal9cWw7K7at6ixD
         nKjDujVV7t2OKHe39Xqbw/cxRZfPURwYw7H2KEHGGyRy+XaJi8ZX/eiA8HUPgIRw5H9Q
         ddV/UyuHUEiFAVg/2cZg2abAIZUuz7ooXICnHXnDkmLIBBwRzGkKiGnuj81C7K3ArThh
         zRp58kRQtJm/uhtOAhQK8DEIADsasIFcSam7qpRJO1Gwa3h/LkG9MUZPbS4cTuM8Cr4c
         z3SUraNazEwD2DXEK2Ei5JtGwl5fvrI8B9yoyh7KMakHRR9jUQB/ETCgqGESO8e7fDJP
         dWmw==
X-Gm-Message-State: AOUpUlEfznIUE0L4GGZ82+JB6nLS8bloUpk+L+mUVjuvXy/0O/6RsHpm
        7RDzeMkVLxyLlegCHK5jrlWkwf75
X-Google-Smtp-Source: AA+uWPzRoeUu7d4p6p0XcqG50svLy9iI8pKTIRjXLlRy7NlGGQ0iD1gwUm7Vf1KDWctTMoZvBlka+Q==
X-Received: by 2002:a37:3695:: with SMTP id d143-v6mr566749qka.322.1533688200098;
        Tue, 07 Aug 2018 17:30:00 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id l5-v6sm1683999qte.20.2018.08.07.17.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:59 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:56 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] staging: fbtft: Corrects long index line  - Style
Message-ID: <d548fd16dcecbf02ce7b198c89ebf2bf24f5e9c2.1533686201.git.leobras.c@gmail.com>
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

Avoids a very long line of index, improving readability.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 2a5c630dab87..9caeb9ceb008 100644
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
+			idx = curve_counter * par->gamma.num_values +
+			      value_counter;
+			curves[idx] = val;
 			value_counter++;
 		}
 		if (value_counter != par->gamma.num_values) {
-- 
2.18.0

