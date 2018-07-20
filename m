Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E790020856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soivex2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E790020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeGTEgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:10 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35752 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGTEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id w3-v6so4561474plq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGowTXP61m7tCJr+aTp4LKW5gj00RXiaKOvOriy1mCA=;
        b=soivex2+C3VWmuVioThgXgXfEMtKRdyg/EdV+4Sf2ApsUImGX7bvHM5x2XDFg9ZDcA
         UvArzdRlSckhpwVX+xbfe1Q5UW2W+6e7gTFukVoeljE/et5SO5kq+Vd0oxEz1zjr1i6E
         A4Vribp2ygvYtqk1q6mNXSKf5C1B5NrvKoLZ3uR+QXGtmCjYhl+b3TXaiutfm5WjBzu8
         8htrZ8S+47Pr3YXmJHW7lgtzu8vWIVCgHjS6bjtj9sHfOU5g+EFuItU1jc+yPI9jvCVi
         TW1l5D6wOLsGKwaWRVoTZLCJpOfsQ+EumoKKvFHdN0a5jKTG6i7+BlVJ85cg6k1e3147
         hMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGowTXP61m7tCJr+aTp4LKW5gj00RXiaKOvOriy1mCA=;
        b=BwPldscGlrfgeQMC+S2Y/o/mMGWCRhcGRdRT4NU2EAsnPT8D8LG5u5SsJAmX7bOP6t
         MX8WeGbRngWg7wM6tFD8ZYN86VOin1B9FzqwSv1REqfGpY6TehH5Eb3TykLDR+Ie+re9
         Jzi1UAWUy3A1Og0VufUtkC2UtQ5JVmG2RXl92SZjOntMRrjDr78AhAWc1meLB/FLoTby
         RSeDUWbvSSO01B/TIZS8sI7BVSdQxrQq423+XN5MHkS7nz0iDQeCHEtqsi6VUcmbAMmv
         qfZBWUEmC7LDoiFiY65y6KgxmPXdEfl7QTLmm2EGaF1UFi9TfbZokOlQ7rTSVHU1Tq8T
         NOZA==
X-Gm-Message-State: AOUpUlE2mzcg+94PbfarUeUJhxHg1IFPiyNCl4WRt0ze2rAHk5kOLQqt
        JtLmgjrPgtwwy+zCnb73xn4=
X-Google-Smtp-Source: AAOMgpfCn4EnvTJI/5RWvbsbrplz/2R8iVH410FG0L85JQri7yg7oetg07nrpyxsdq7Gkc3QJIGjqQ==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr477765pll.28.1532058599015;
        Thu, 19 Jul 2018 20:49:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:58 -0700 (PDT)
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
Subject: [PATCH 10/20] staging: gasket: remove else clause after return in if clause
Date:   Thu, 19 Jul 2018 20:49:10 -0700
Message-Id: <20180720034920.77320-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Else after return is unnecessary and may cause static code checkers to
complain.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 2a27db658a4e4..617d602b8b447 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -598,9 +598,7 @@ bool gasket_page_table_is_dev_addr_bad(
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
 		return gasket_is_simple_dev_addr_bad(
 			pg_tbl, dev_addr, num_pages);
-	else
-		return gasket_is_extended_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
+	return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
 }
 EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
-- 
2.18.0.233.g985f88cf7e-goog

