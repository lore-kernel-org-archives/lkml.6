Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039CC217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n25oafAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAWQbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:31:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfAWQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:31:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so1404369pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QM0WYe3U7IAOj7rprkn5WU3sgdnJny9GSGaYt8Q1O7U=;
        b=n25oafACOUYanlrnKebPd3iJ13BqM2BW6n4fwQL4nQBvaHHtANoyXXznsGMDDhTYQY
         ss/Wu5+iv0oXgbljpZJUX0JZWBBTMr042WuldfGPKX3STqAiwboOHAhvPvJbs7bNaII+
         pffTKj4waqcEyRbcR/RsbuiGxMzSLFZ+KU5QLHJzNkM4V6VVJUCqoKvjvzEdO3k+bxXM
         syqOwGFfxFMMh8wJL4jeVMzNp4WYZJiMdurYeaHG9Na0TkdfIBHn/94n9ySZVj3uN3OR
         LHkkR2+Y/O3s76VCp1JkGYbllK/LBbay526QIls2irX+6Z4mAjXInHFswggPB9hHZOAO
         rq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QM0WYe3U7IAOj7rprkn5WU3sgdnJny9GSGaYt8Q1O7U=;
        b=UC8UNI+rrdwrfbWRFCah25c1Am5zDcbTw9MOJOwK0Aca82yehv2jzIffd5wA1pyuvS
         cCocxmkS9Jkd+iYSKjlBDdCEolKxJA5bMkT/6nL9egNF8eWZBKl+LgvbaPCY1E08RsqS
         +0L2ycZpsy2jPKfR9llJYc7EGNL1AqaAuMvRO3Tdie0fczZhU17JbLv604hOHtHpT+Bi
         biKfL3O9yt+JTghK0F8UQ7s8RfyTuRCy1lmM4qxEPGYPLrwlz2T6wGa7cI5NWNLLvlFQ
         I/K7PjnbPntVwhaGu40+6fai7lb2hX7oRYyHTFrz+OLWxkoVy5SAeA3+oU2P+HhoY/PQ
         fLFQ==
X-Gm-Message-State: AJcUukeWEJLN1QXa/QzfeS4VwaZRLcDb0+x3s0fZRfb47rK45dB0nGgv
        iCySpwmsFr7GYul2uQmdtf0=
X-Google-Smtp-Source: ALg8bN5Vw4EAGT2vjtiHBEOpf4DQ3xc1PfY5ECeqXTlfEd3/qTqUw7x5cFKTdNidpv3KVEd+sp1SvQ==
X-Received: by 2002:a63:d949:: with SMTP id e9mr2594309pgj.24.1548261095381;
        Wed, 23 Jan 2019 08:31:35 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id w88sm44568938pfk.11.2019.01.23.08.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 08:31:34 -0800 (PST)
Date:   Wed, 23 Jan 2019 22:01:26 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neil@brown.name>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH] staging: mt7621-pinctrl: Remove space after cast
Message-ID: <20190123163122.GA4807@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes space after a cast as it
is not needed.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 80e7067cfb79..3e959fa73703 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -363,7 +363,7 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 		}
 
 		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
-		range->name = name = (char *) &range[1];
+		range->name = name = (char *)&range[1];
 		sprintf(name, "pio");
 		range->npins = __be32_to_cpu(*ngpio);
 		range->base = __be32_to_cpu(*gpiobase);
-- 
2.17.1

