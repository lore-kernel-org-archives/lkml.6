Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E564ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360F120857
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOzGtvIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360F120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeGTEgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46044 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeGTEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so5604369pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ecNRodt9jmK1HhYIvfQR2YoSFB/LnxDWnDlZqBc19OE=;
        b=rOzGtvIfCcBU+Zp35rH8ie/dWpGrUnqwPyWXZz/A7c8kvJd5SGcGHfhudwiihKFCAa
         lX4s1dCprF6QTrlX1qMjS/4t+KxtWBD4yJPsGQa7XiC2VIvdcqyzQxcibcWB2ZZ0i8xh
         GFOh8nDM3hoSXVbQus+PY/5BuTYggrHAa925pUNLnZ/w4x+3Ixtf5tMSdNHJlf8YMjgv
         8CmpRJFtnfYkJhrhX6rddA12IQ5YPs/FMSpUCokD9VxybKt+rBjUvEFKYBytP48Fvy9L
         7I/oUFBR4tpFoT1e+pdhFlEjgHmOjR/RtKW4DxGgVN9UJ0jIRJMHxqM9o/lYwdIEqFw4
         Bjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ecNRodt9jmK1HhYIvfQR2YoSFB/LnxDWnDlZqBc19OE=;
        b=A7tCd0anU2VrGfexVpXlWFclQU4A0L9hQIOOiNA1w+AuiLT7JifBywsmdEvGV5Ju8v
         YLzhJYe9oTNDEMAStgXTyP0MMOh3Tzm3OvTp9ZgVBOpf2fUY2Qdq/e9ckgtnNPa52Bmd
         VH9X8ZeFDD5sWR4sSEfbG/eHVxsN6Gl0t1LXKBy51RlGW/5maKApsKF3t8tGb5N1Bj81
         XC3+D1HgUjchwkAo3zCEg/CJ6MFGhP9YS+kJicYEHFbQf1CtyW3c3RBnPyE0vPcmDXLt
         WT97fadC5qLxrH4tWbvYtk1nGeKr0qc/ixd81s00uV+cyy46SSOH0w0FaLFJS9XmlvjE
         1ArA==
X-Gm-Message-State: AOUpUlHH2i+m6sUQQjiUExz4q2f73PP+G64EUp5u8+GKA/rdf8j1nU3l
        ca0MPJuPGgG5FE/WMfWWB17uRuNO9Pg=
X-Google-Smtp-Source: AAOMgpfmaDJP+T/Gm0uk0nrd6aJPyNt7RtHUW6BQ2c+cCEppLSfAZAvTVNBeulhHHV2HtcJuyzIRVQ==
X-Received: by 2002:a62:3b89:: with SMTP id w9-v6mr490162pfj.80.1532058596075;
        Thu, 19 Jul 2018 20:49:56 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:55 -0700 (PDT)
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
Subject: [PATCH 07/20] staging: gasket: gasket_mmap return error instead of valid BAR index
Date:   Thu, 19 Jul 2018 20:49:07 -0700
Message-Id: <20180720034920.77320-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
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

