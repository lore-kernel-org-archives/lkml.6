Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47920C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F702098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z87iHFBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F702098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeJQFCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:02:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38213 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:02:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so27563379qtf.5;
        Tue, 16 Oct 2018 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MFuWILw+jKbAataXw+CzuEU/J1cMEJnPQwHcI5pgHm4=;
        b=Z87iHFBSgzBNfYZPN2K0xxagjVDfqi59tJdChi/SN/x5+FiK8V0VBUY1B0RyyhhXut
         AyIPxQQsG9yVVjjLHWrVdflqFaNDCUQlKCzDpbbiX7DtPFzxBJQkM2yxeEHkOVGvbOd/
         f2j2uPRPYof2cQwxthLoTqxjx1y/+08My0tBAIjYb9t9zH2Vb5xhi7HcjfHqQWtUdqel
         htW6qFsxQexkj/t8a6qPVIfv3aZ0Kq14FqsnYKetSobaQ0UPf+38Ql/bhsoruP8LkQd8
         a+ttm8UdnUqrmmJMva1KnxAlg4pkgT+RkbOcE7zQyiA2WRDfyU96grzO1oZBHc2heBm3
         0IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MFuWILw+jKbAataXw+CzuEU/J1cMEJnPQwHcI5pgHm4=;
        b=EKPUClrM554bRnZfKYZU0YpXRQ0E7Cms4BUr5uPvfYNF47Lvr4Im4oyHzvAzPQ8zsM
         p8bkJd2jGb2ERK7XGel9I+ShaVsfXJLXTHxGRb88fF/IK18OX1tYMnYH7TP5P+uv3vZp
         my5NDvJuL3LjlNvamr18nzQiZmmx/p+4CabvzlkKG8eDY/1Tt8Ps+7Lto0DT4+30xxNv
         6c9m47di26yXSrzINe3ExuUuZ2fWI53wucwDiHgPLb9xoNZK5WfhhH64yhUMsXYeefk1
         FvxoPhpYCn7wnAXqXXixxhWg3wwO3JtXfuJDKAkSrCyms2PL8XgIGWUyZSBbyH2blE4d
         33Ww==
X-Gm-Message-State: ABuFfojm547JQUNa4L+jQXxJJV22EO3mw2a0/DMb2igic4x6SayvYUaM
        G7oOHXzYnCRiZEO9p5VQvTE=
X-Google-Smtp-Source: ACcGV62yPCx+QZS+3jwLmn9pFSmk0KK8Rq6ggWyfZkd4AZM8pdKNLpuC/xS+2e8HoAC3zEWXNDBt3A==
X-Received: by 2002:ad4:51d2:: with SMTP id p18mr17285481qvq.64.1539724194823;
        Tue, 16 Oct 2018 14:09:54 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j57-v6sm11145108qtj.96.2018.10.16.14.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:09:54 -0700 (PDT)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Tue, 16 Oct 2018 18:09:50 -0300
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad7280a: Lines should not end with a '(' -
 style
Message-ID: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of macro calls cause a checkpatch issue:

    "Lines should not end with a '('"

This was fixed by moving the first '(' token to the line of the first
argument.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7280a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..f7df987412d7 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -725,8 +725,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		} else {
 			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
+					       IIO_UNMOD_EVENT_CODE
+							(IIO_TEMP,
 							0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING),
@@ -734,8 +734,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->aux_threshlow)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
+					       IIO_UNMOD_EVENT_CODE
+							(IIO_TEMP,
 							0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING),
-- 
2.19.1

