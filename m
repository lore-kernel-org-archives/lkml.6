Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D00ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A480B208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnkihJCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A480B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGNGQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37071 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbeGNGQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id a26-v6so1670410pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6EM97rsFq+9hQv687+Lefl9itMDbgHYkCLKPBFfaRRE=;
        b=rnkihJCYzU6sGJWKYJyzJkvm+7gp/GTNFxo6c+5pfQGcZq0B+56NEjU7b1gywM5Psc
         5bt9you8oe3adeWfQ3/jjZHnHRi1N2Rwodl1HmksJ+G9TqMQjtGBcTq9DRvm1YoobzPH
         GfRqbXyTDAwdbHffzTshlIF0hAHPug/2WrrW99Thf4fJ0vaKlea9UfI9VKONXvPDZdyz
         8it9WZ/GwUrkR+5424naqyMs/WaFACdfNFMF5+GsBLA1PIkWmRFKiPsRxULIBMV6WSBd
         R6Oc/EYs66w6yE70146FhilZogFM+zzGSZiS2EoMMhis+sU/+/VjXHz/8ST5PqbtoeB1
         4dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6EM97rsFq+9hQv687+Lefl9itMDbgHYkCLKPBFfaRRE=;
        b=XMU6NdNzjizs9Gh9tbFCIAe/IqBbTVIZ3UdQy759eEbA/NzZOxmFYBOudUFG7Xg5UA
         P9AyKYjJqvTgBTBtjEdaOYVasBA1gx80ss10zO/CxTFw80Y33jrk81z5QPczIArBZk4d
         JX3oP1YU38jdDjuAHRCvUr+//jEnhP/2y1/gxJOvK72mBc8NU/sDSkso61/HY8fApBmc
         H6mDkZW/WrZCXMRYOcyvMy9RJ77Ggdds/hiLFsHqT/ZG0N8bhRMkDez5GqTNrgcm/4lX
         bWdCQe6S/2BJceNUvuSXcYwSqCsvkQyGZksvOnm70IuocQfxveRjYFYY+0i2pzS+onmb
         K69g==
X-Gm-Message-State: AOUpUlHC/3DzOT4++ygprmy3/d2xsqqXyIxko9KUzvfpRC+nRN1edEHo
        baYjGX3pIqXVWmWkuZM6OqU=
X-Google-Smtp-Source: AAOMgpeqd3tuSnFl1+Z2kB8aG//O4nIUhqhfKHyNMhTIzZwpn8gGVlPBLAOu0fO6h6x5n93CpbG3jw==
X-Received: by 2002:a62:f704:: with SMTP id h4-v6mr9991895pfi.169.1531547939054;
        Fri, 13 Jul 2018 22:58:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:58 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 15/18] staging: gasket: remove unnecessary code in coherent allocator
Date:   Fri, 13 Jul 2018 22:58:13 -0700
Message-Id: <20180714055816.223754-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove extraneous statement in gasket_config_coherent_allocator()

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 0c1e0723bef1..fcf58f44efed 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -427,10 +427,8 @@ static int gasket_config_coherent_allocator(
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES) {
-		ibuf.size = PAGE_SIZE * MAX_NUM_COHERENT_PAGES;
+	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES)
 		return -ENOMEM;
-	}
 
 	if (ibuf.enable == 0) {
 		ret = gasket_free_coherent_memory(
-- 
2.18.0.203.gfac676dfb9-goog

