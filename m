Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382A320693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqf8Cbq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382A320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbeGQVjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33428 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbeGQVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so1102157pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7qIvLWMxlxrTa8i7trHN10C2E+F4RxCHx4ZOKr/OQAY=;
        b=gqf8Cbq+1PEyAcSJKXGEM35DBPZfp5qSBQo771jU/IT/f+XsRUU5OTYEj9SJKzTHDk
         cjzHXGCV7A9Et+VLIfCvrU30XGcFbWMuw4uaYNTM/SbBz48fjLSSEybtm8gALBCrMYBK
         r6PS4hN1D1SG79saQz5hqlVOO3yRcJeGfM1/zx9pZNdJrDOfj80MvigIMhjGnFsY1NKE
         tXfQL4kvfJFZVEQare5ouv481zrhuy9Je6sg/xCNYngPh1Xkfp4JyMIkgDfKgAF8x29f
         L3xJlMvbqPRx75Te6R4b+Az/6rfxp6JRflpktqr8ceno6psy9cyXLeVrQZltXaBThSoJ
         SFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7qIvLWMxlxrTa8i7trHN10C2E+F4RxCHx4ZOKr/OQAY=;
        b=I/ZVl8Zp8NY2IYb3HtE4zwk41FpDX3xIhbr6l9xrweIAsNIHWPtsaNOfZOJmy4oZ92
         rvnUpRNDDcHW5FXayT0iS9IJLy5Mxmmj97MtcbqjgL8u2x/jygbNY8DJJuLHoIzlwZRb
         XJr6JcW0E90LvTHRp7HNILWym22G94ZVsNu+tyq1yBpeaGzwXIvS1qVuVuHEopFS2o3F
         7S0UbgHK1PBDyWNEkUF6A5o3pC+qV21HB2MUpZRzgX0evRSZc2+slW0QORhCuivz0LdP
         I8/kNAda1F0CLA93Jzg9oEogOsNpLNiIVtLqMBtTxKpoSZdypNqLND3aeTRCpOMTTsSN
         RGEQ==
X-Gm-Message-State: AOUpUlFPgHo99f/I7OtBPMmI0WR5ZOvv1QE+W9XzzgbH9eJuLK3X9qsG
        7S5AUrPntCTu6I1Sgo/SxcI=
X-Google-Smtp-Source: AAOMgpf8qpR7gGYFdHqeGcuvoOKxwtXUT26rQAmYtJMdNG7EGAg2UCzaAWAyJ5XxIfgdXKHF1CBAKg==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr3173920pgc.119.1531861527771;
        Tue, 17 Jul 2018 14:05:27 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:26 -0700 (PDT)
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
Subject: [PATCH 30/32] staging: gasket: gasket_mmap use PAGE_MASK
Date:   Tue, 17 Jul 2018 13:57:10 -0700
Message-Id: <20180717205712.29495-31-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_mmap use PAGE_MASK, instead of performing math on PAGE_SIZE, for
simplicity and clarity.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 9a821614b0334..98d5a200aaa5a 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1594,7 +1594,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
-	if (vma->vm_start & (PAGE_SIZE - 1)) {
+	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
 			gasket_dev, "Base address not page-aligned: 0x%p\n",
 			(void *)vma->vm_start);
-- 
2.18.0.203.gfac676dfb9-goog

