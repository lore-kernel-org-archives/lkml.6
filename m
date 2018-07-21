Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B6720856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEmqRO78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B6720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeGUO2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37592 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeGUO2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so6370142plc.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BS7jONlcC15l+eBl52Jh0dWrkwF8GT1KK+12jUOAAcY=;
        b=iEmqRO78nkQ95C8DCLTo3gPnPtACjOl3Tf6y1UMJZa0rgVxKWvTNgmLgH21J+uitW1
         y+YbU2jVNOp+H/xLatWyVjfCZjLb6Ybj9KnhvbL+YhIzAepZXp4qGpXCYtgHR+QlvjBK
         QJGrtdHR/5SrGe3g3oQyJLBgixgSkt8M5g759niYfU3IKHCjlqS3G0PKIN1KZKtMr196
         cr7uV3XErWZA1buy5HPmHi5LmhWGFCOIauh2z8kNDOk2vHDO/Q+SwCdA1/Y/tOZCtTyg
         emdaUj9hZOPfz1FtOuJ7ucdm5zgKxWB5mSzmpQ+IikNiwF/9XLOMIefKF2uAhPSl7pWs
         d3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BS7jONlcC15l+eBl52Jh0dWrkwF8GT1KK+12jUOAAcY=;
        b=OAYAG68B83zj6s/EXpkQedie1IR5rnvvm6GMe4bY4r5BGUHBe6Ka00ijA5Xagz3E4B
         LNDjB9mdaSWVfYeW/9Uj8EDCz/+NJD61bgQW/sWR3whZ9V6JjdP21wALRUZuqQFA8DIe
         Nxu5KMVNDMayXBlsm6b61x6+qY+1X+hHmJDOEwLRt56yr9KrYm58iNrMBm8wZWLrJ6jT
         lSCzn2Rk5Tg1VrwV96wLY4a1ratVfjeBDo7H5P/6TQZ6g0OD198MX4/TX/q1p4x86c7N
         THLMEPJnvBbCgX53uHHscLFrjtHlakhF+E1rwYjn13FKjOHP4t6AR5vbLGDVb9cVahfp
         Etxw==
X-Gm-Message-State: AOUpUlFVgKroPzRdcwp9q735LLcMTWDw6kCC+YUGqF+lf3j0RS4sxenU
        4kdzhqDpbi2sEA4mbLqqxXU=
X-Google-Smtp-Source: AAOMgpff00kLrUM79eC6NySBUM2/Gvag40zGoih5SfLtFsI1mCb8btAdi/XobVkcBwIeNpY+NVzEQw==
X-Received: by 2002:a17:902:6e09:: with SMTP id u9-v6mr5753050plk.13.1532180126626;
        Sat, 21 Jul 2018 06:35:26 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:26 -0700 (PDT)
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
Subject: [PATCH 07/14] staging: gasket: gasket_get_device drop check for NULL pci_dev
Date:   Sat, 21 Jul 2018 06:35:00 -0700
Message-Id: <20180721133507.95599-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The pci_dev field of a struct gasket_dev can never be NULL, there's no
need to check for this in gasket_get_device().

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index e82f8ce39c9fd..8265d543623d7 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2026,9 +2026,7 @@ const struct gasket_driver_desc *gasket_get_driver_desc(struct gasket_dev *dev)
  */
 struct device *gasket_get_device(struct gasket_dev *dev)
 {
-	if (dev->pci_dev)
-		return &dev->pci_dev->dev;
-	return NULL;
+	return &dev->pci_dev->dev;
 }
 
 /**
-- 
2.18.0.233.g985f88cf7e-goog

