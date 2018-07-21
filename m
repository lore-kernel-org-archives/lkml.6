Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ACFECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1020720856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+dDMZME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1020720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeGUNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42674 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeGUNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:22 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so4553488plo.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CEnOMmXj1PSytsHYEuA+E29Sq6QGkC9YGpuPwIBA0TI=;
        b=W+dDMZMEnPTTDd6I6GUyFg2rbB+htqBpg1Ut3JZwIh4kn/ULh6J6s7cLMpp5NCEmU2
         X61gmlwSJBU/zgRdMfFnUwKzSkMkmcZx2Q1WeMcNbNRG5Lrk7zSjk3hwWP2li2Ne6AlI
         //cCDgBCjVsWqsdHxT1N4klD9joCi6ucnWg4kFHDsKdFZbhw/+Krj28WR+iHVYD1SQhw
         HRJvymIygaLwGGHFm54QhEzid72ZhJtQjMzgSx6VbP4w3v2fcpUMKZ0k2MmCSiJ/xIQP
         eFsln586uUTdD+cEGesPf5XS0kT9lkZasHyp8vtw4WLeGhefhB4Ni7qEh6ioFMUUeJqk
         S8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CEnOMmXj1PSytsHYEuA+E29Sq6QGkC9YGpuPwIBA0TI=;
        b=L3+HDQOe0ktFblA6RIeXCeJ9aDQ8N+YaWnAMOC6xRsQUlsyANkdlSk/MJD2Wvb4/29
         sRn/qDAg2glI9BwAUwgYg3eKjXBuXrVCoB4RM96nKwUWoQwUNJStfL8qdx+i5AARhiqq
         gJ6GbgW6deU+qShodBpGDywKCncr4mxsY3I+SwTiO8vMGhoD9dFoPugqo7V4lAmNYFT0
         iXkppYxa0ZeEJjvVWmR4aotlw2w4x9uQ1GJBOtas3cHS8iD9OwECdT4nDnUKqiYhPxwF
         101ZOOs8TBaKNgCtPOuUlFsZOWaYHhj64aTiTnNPKrVbY0GYh6bzUalgYSoLLLS5EhP3
         yVWw==
X-Gm-Message-State: AOUpUlGCKRGqYP3a8arSPwEUzK2mtkLZnc8wL0UBUvmLbEJDYV1kSTh7
        CPSL8VxRuVw3FNtDWDQLPpA=
X-Google-Smtp-Source: AAOMgpf/8szHGm8oPneNXfpbHmwY4S35SI/g8ykZzW8Nz8BW+4GAIZuV+YyiCh+RTNVEtz1yrGW02g==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14-v6mr5739325plo.213.1532177862407;
        Sat, 21 Jul 2018 05:57:42 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:41 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/20] staging: gasket: remove unnecessary code in coherent allocator
Date:   Sat, 21 Jul 2018 05:56:49 -0700
Message-Id: <20180721125713.88501-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
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
index 0c2f85cf54480..d0142ed048a65 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -420,10 +420,8 @@ static int gasket_config_coherent_allocator(
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
2.18.0.233.g985f88cf7e-goog

