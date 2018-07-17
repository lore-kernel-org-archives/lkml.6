Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C243ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E60206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDUGkcRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E60206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbeGQVjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36367 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeGQVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so989191plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tU3DJirmv81Mg4DIjt0X/vjvAvdMdTttnvcKxcm750M=;
        b=aDUGkcRrRBllHaC8qdOJtahuFEmefYNadHnAS4UZYqmT92Ov+fAbQizDVcRrm9rAAe
         n8ppx/TKCa8S0hBG+2xQKwD464yCRWZcLvw/GHJdTlPP4gkTqbYWwM8uU5BbxVFHpkdD
         xskJ2DXQO6OtH1fPUeO/tEr6vsVz7VM5nYgVP5eyYZptaRWnMbw2V+F2LVkakJH+Gp/5
         UGr+DxrqB5WcV2IHM0HM6mOM9wLxne1h3TDVFV+eucTa0DZI9Z3lAAYG7kz+yiqzmzp0
         Ci0H/qqBbaaYPrs5bJ6A6q34yB1MkClUyoNPUTiJSOyiHKfv7816LrqVLzwF38zUlw28
         K6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tU3DJirmv81Mg4DIjt0X/vjvAvdMdTttnvcKxcm750M=;
        b=frxAugbuP3tkreHVxty3Ss2BREh4Eze7bNu8Wsqjv2HG9ZgO2hb7XKzaiy/flnzzGm
         Zfic/t4abHTPmF8RakML1moMn5++Yf/0tEBdYrfWNL09p36IZfmjk1iHjv035iTRoUDz
         /qDHBaSG9PVhzN2VN5TGZ52wrXbaICz66JzNHh1vORNK/oEz23TERW6fd6dbr/PJ3KF2
         ZHQ6JPdlHmoyoQWyQVVQrjYRCMyks5Ww/ETct56NaQa7yqOEH6CFcGN/jRZhE2c4ujRr
         uMHVU1jkClzQ76MC3cSi1TteV1hqqPnDXET+c6DFR5OoSc6s5BRsF1Yr1LuvXo6+H0Ap
         C0VA==
X-Gm-Message-State: AOUpUlGeTmtjrncn7bNsxPz3fKilQ6F0Q/c2gTpxjlszWJI2UZNpzWNY
        S5XI0VqJ7Md5RvQSZK7Shns=
X-Google-Smtp-Source: AAOMgpdRLo8k77tn0Yy8sOgAOkFby+kPM7Cu7hmhh8rn5cQTpnAYHH80NGEo3vby89r7UeZUtYSd9w==
X-Received: by 2002:a17:902:a981:: with SMTP id bh1-v6mr3121845plb.2.1531861515923;
        Tue, 17 Jul 2018 14:05:15 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:14 -0700 (PDT)
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
Subject: [PATCH 23/32] staging: gasket: gasket_mmap return error instead of valid BAR index
Date:   Tue, 17 Jul 2018 13:57:03 -0700
Message-Id: <20180717205712.29495-24-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
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
index 09b3a3552ade0..9a821614b0334 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1630,7 +1630,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 			"0x%lx",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
-		return bar_index;
+		return -EINVAL;
 	}
 
 	vma->vm_private_data = gasket_dev;
-- 
2.18.0.203.gfac676dfb9-goog

