Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08636ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6520856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlDpQYV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB6520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbeGUNwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:52:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39424 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeGUNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so9026746pgs.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ecNRodt9jmK1HhYIvfQR2YoSFB/LnxDWnDlZqBc19OE=;
        b=KlDpQYV3t8oumlziWoQ3o3UMlh2dM54eOvedgwOiBJeJ0VAL+mCx1CUt6CJDJ51WTa
         kG07FIGq+d0wYVFGrN8n60rPneJwc0+u8AbHcW8q7oO1qckvJx/4X7HAKN0yGGJZnpWk
         PLF3RNYvoBrEQgCUZAG1mMNkM3yjHTGRA+i1FcRXO5ASEl5L+b6fdBLtVbykg50J0fJ5
         bQzrhg9lmC53RKDBG3K1iaRdhMPY332k4SfPV3LxlWr2yIBXoXq10o7mWFxntRPGxQZg
         ZatjpCgB6bnmoaAwV3gjP+R+N2axZxD2DVW2PcH5F/YGgJWNA0UfJqMC2jwpt386Y/AB
         KHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ecNRodt9jmK1HhYIvfQR2YoSFB/LnxDWnDlZqBc19OE=;
        b=qku2NpRkFwHVQ+BnZBe1LNWtoAAMLaMJ4N7UflWrF6CE84gSHqFJhrK7+nUOUnFwgF
         WqjpnFppyXWKUPeKZNien64BoBwd9dN61ZYtf7wtKvNgqMJup2u7J2ef7oL9Fzh4+WNr
         +lLOgbblu+BcEujH6WynORQ5na7Ao0oQinLLtZV8Sew9coIRgbhpq7lf34n86xk3PMAb
         YU2BjUlMfBvDys6z/kR3R1+DUu0i9ZCO6SzKhustxYLFaGQwRGw8JhDW7VlhXb60EbjP
         ggYB2j9WalpxqmsL/lMtsiuFLwn7q17Usu1fe7wTGeRm1eGbAvIzkTj80UNcxu2qhfqX
         ktJQ==
X-Gm-Message-State: AOUpUlFWlX00ePERZW8eh9lQR7bF0moiT/C+3tofHWmnJQMtec/DK8b/
        0kO+ykmbJLgPuLqIlHJklns=
X-Google-Smtp-Source: AAOMgpd6Kh3MHYUYbTbWBYA7edTm6/gvHMfJZGnT7UvwyeKE6pYeKRjDLHenKChTwCksGNFIojzUSQ==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr5928395pfi.123.1532177865806;
        Sat, 21 Jul 2018 05:57:45 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:45 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 07/20] staging: gasket: gasket_mmap return error instead of valid BAR index
Date:   Sat, 21 Jul 2018 05:56:53 -0700
Message-Id: <20180721125713.88501-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

When offset to be mapped matches both a BAR region and a coherent mapped
region return an error as intended, not the BAR index.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index eb5ad161ccda2..3cf918f9d2604 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1627,7 +1627,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 			"0x%lx",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
-		return bar_index;
+		return -EINVAL;
 	}
 
 	vma->vm_private_data = gasket_dev;
-- 
2.18.0.233.g985f88cf7e-goog

