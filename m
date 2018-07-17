Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69F420693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHfzVnPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69F420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeGQVjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46277 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbeGQVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so977542pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+oUpoCUo2DWLRpB7iXcfwH6+odVSYOgNZdA2MwlGoRg=;
        b=vHfzVnPTVaa5pAwGV3WZePEUeVvPDcOCWiMYXAo8Q3r/rEchfUwIrbjOwJLK/KvA1N
         D8gpE0Pl9oKl4C+VtnXmyIT31edGi21DfQrR2mwsRVntiZtFpsaFoO1/7t5F0p+tNL58
         LtGnjg9d/4+mJRn51jjxHxOi94kLViMCfp1/2AA4yZHfJ3vymboPUNdhuXVg9/WI2xv2
         Y5Frhlz7ph8hqLABbp6kn+jTeAXCNjgUATMEk/aQJeqHi0fMiN+EdcUjPBBEVqneQXyk
         morwspt0QDdY3reyIQdZOr1L2wjOIXYcIE4sKzLDiJ8/ZDD7bX2NcqWdqe13cRfKAcGK
         yOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+oUpoCUo2DWLRpB7iXcfwH6+odVSYOgNZdA2MwlGoRg=;
        b=VJxatuTtoV4y0CU4Kd1GWQIEM9raIE75hLWAbepOl+F/jITo5ArE3pjIdncNKgBiu+
         qapSLIjvrroyeARLLVQo3/XtaW9YQp0ow7R9worsaXqD1UQyma5wQWvuqhzpbHq4JXww
         iD6N6GGq8WfMVfT4oGUJwnFvFTU+Li6c25VBJ+4dhcAAr0ZcYMaOhl9IJ6M8LqaovCjP
         wSkaqEZA8f7qnTEIVXCVM/kCLqvtBxfqWg4Rt67BiY+gJDwARkTKuezKLN570K/KPDGx
         Uf7iCYtmUi1uI3b4gn0HvyszPo+crLHxz+JbdxeF+H68ACSoiXgMBg9Y7EeMkLgANyPf
         1e+g==
X-Gm-Message-State: AOUpUlF2/KUS9IFRttt9bWi/E4PsO7TZxdLe4sr6RJWDq3MKiMgOBc0B
        FBDcP4DgcBlSRvbPGstOrLQ=
X-Google-Smtp-Source: AAOMgpdA4yBMGqPXwBC9oPy8YofgktoktMmMpMi9kzMH3CrxF3iAypSaIY5GQY3Kd8t4BS8wZHV6HA==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11-v6mr3148574plq.228.1531861512799;
        Tue, 17 Jul 2018 14:05:12 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:11 -0700 (PDT)
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
Subject: [PATCH 21/32] staging: gasket: remove unnecessary code in coherent allocator
Date:   Tue, 17 Jul 2018 13:57:01 -0700
Message-Id: <20180717205712.29495-22-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
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
index ab2376c32c00b..0f6cb377cca47 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -419,10 +419,8 @@ static int gasket_config_coherent_allocator(
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

