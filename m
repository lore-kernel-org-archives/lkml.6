Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CCEECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A05208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXhT3MYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A05208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeGQCkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45223 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeGQCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so57296pgq.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kc7XIYYo/1h3dOvQbqfDhR0hGCJLAj1N2ACxHfQbJGk=;
        b=KXhT3MYRhyX9UBuCVXL5QZAHcL/ARnQ9ZdX1uN++X5/ckozQip3U2szx/+VKmTWnI9
         KxdsFHe3OLWty2hzRWskM1dRu0D0kn2ns+IWoplMGuan88fHnilghsU433+C9PI8BTnA
         58NNNixygvYEuD2/IhwKRW568ingVcQMgd2NhnLot6TQvXT3KutYlm86vWuhcv0s64hq
         6d8LfrHaP5stPqKwceJiacTFOUpU2cQVhWUqMKOWheDPCZSMpme4yvT5j1fbn1q4OBwj
         5PvInPrhPcfUhJ7lqfHLpWYJLIuclNsK0uZbkPeRzzxMm2ZYsQHOuv8gFpZs9RQQR6Go
         ULuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kc7XIYYo/1h3dOvQbqfDhR0hGCJLAj1N2ACxHfQbJGk=;
        b=mmfwC7Ouc65J6tsXnOa3vM/tOoJj0UVPy1QGCuQ1rBDA/gzjOpC860cg5DmMqtLO3V
         /xHCdMTW9uzKsJXLBdUV9sTbkmU44JUO7o3iLbjjFp5gtnW3+tkWAX8heNuGrzyk5IMr
         X81iBO8eDS8yQdZKtZ9B8PDnwzjppipj/igoQDTsETAOwPJ9UhzWT3O7MG0GSsl2xf+1
         kWTTOSIcJnNP1YYUsreCmcd1Wco/HGWSfgQtuVUtYintFKQ1wkwsbC8JskUD+DSh6L4p
         3I5JT62H8VsVQELoMWh87PenmzkENwFHKGuWwd75lQd9j0a6sco5TOJ0gIN0QO48wXtl
         y6Aw==
X-Gm-Message-State: AOUpUlGQMz2kY+OxO5JE4BWkAQQyLQE2UhIGv+Ag6fhjUainpgdhTMdK
        wPDMYgSkEp7KmwRH1Xx16Zo=
X-Google-Smtp-Source: AAOMgpejb/KfE312A7PIEAjhDuciJ+ZXth0Bkgkq8+W5Z3i9N2TW0p6Mzk0NfMJ7beQG236bnTor7A==
X-Received: by 2002:a65:4344:: with SMTP id k4-v6mr17513483pgq.409.1531793430781;
        Mon, 16 Jul 2018 19:10:30 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:30 -0700 (PDT)
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
Subject: [PATCH 31/32] staging: gasket: remove extra parens in gasket_write_mappable_regions
Date:   Mon, 16 Jul 2018 19:09:25 -0700
Message-Id: <20180717020926.176408-32-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unneeded parentheses around subexpressions.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 01740a8184594..fd024f2a282a8 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1893,7 +1893,7 @@ static ssize_t gasket_write_mappable_regions(
 	if (bar_desc.permissions == GASKET_NOMAP)
 		return 0;
 	for (i = 0;
-	     (i < bar_desc.num_mappable_regions) && (total_written < PAGE_SIZE);
+	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
 	     i++) {
 		min_addr = bar_desc.mappable_regions[i].start -
 			   driver_desc->legacy_mmap_address_offset;
-- 
2.18.0.203.gfac676dfb9-goog

