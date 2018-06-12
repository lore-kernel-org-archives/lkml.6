Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 24F6CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBDC208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8gxTSkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBDC208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeFLDUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:20:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44245 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeFLDUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:20:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so10743054pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gnoe12x/yFHH9LcL8GQtWAG2kUpGdM+wQ8tf0suy9vo=;
        b=t8gxTSkLsIKlXIusz3Q/nob8tPVDfw89trzwBGsqIJE74D4pdgyvwxWD3f4cb+tOWA
         vRJts1d0/uIwPLSqPHwr7eXnKWgI7N53fSnAVgwsQ57JhyGrP1NGsyWFR1Ahq8yblEUD
         /K9wIlIF+G4KEdc2vpp02en85GHDOJmHbPMtE0llfnsw9ZXMPMAwKv5LafX5WX3/eXy3
         P+FgtODk9UZllBVD908x3V7RPM0eAFB4YvCDo/dco60xGyzXW/ju2JF+HmR+1mF/ZJbJ
         Pn4hchH4IzjwX3p4vjn0ETOhgNifuWA09PTysvCD7Y2q1dOj8eRheOXZJH4nxKgEKnt6
         uy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gnoe12x/yFHH9LcL8GQtWAG2kUpGdM+wQ8tf0suy9vo=;
        b=A4TxwrwD6qspME0+N/wAodpl2fh2MPn3vRBRfLmir8ZXgEHm2ruGjpSLWscnYbJSBU
         7bhbIcYEm6OVsvzQ9LtDevSZd2oPD62ODTqBvr+WYxgty8i0BIzETP+FwygjsKRcrw0w
         BKLRh1fRJrROSLOMKqClCjxQZ+BXFaMoZ/Y8q1DejWr0zBXfnKtAhFjLqvrlg+gJobLE
         k+PmWgd7UOk7cUQvQ7z0piXzDDBa1eiscUxV2qh27bg5FRPCV9Jc1nQ0DOFNREpE/pvh
         HWM6Aw0TK4Lp/JU18jZNq/t1DRr14B7nrAQoq3WHZojDwU9XK5s6NzWTSLJWE0E4neVl
         n1Tw==
X-Gm-Message-State: APt69E2MtWZSO/bP3mZbDnxvIyxYDP9jPNy1jFEjZVTyodWcZgleDVrO
        C7VDcsPZJ7CWkd7OWY4eBVI=
X-Google-Smtp-Source: ADUXVKL7Ax5sVSCHdsE5Uhl0gQcdvRtQSmC2IERaSTdptqu5q03LDWXUy0XwnIDfUkPBg5UFlAWpVQ==
X-Received: by 2002:a62:3bd2:: with SMTP id w79-v6mr1875977pfj.129.1528773642355;
        Mon, 11 Jun 2018 20:20:42 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id z25-v6sm121690622pfi.171.2018.06.11.20.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:20:41 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alessandro Rubini <rubini@gnudd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fmc: add error handling for kmemdup
Date:   Tue, 12 Jun 2018 11:20:36 +0800
Message-Id: <1528773636-37730-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmemdup fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmemdup.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/fmc/fmc-fakedev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fmc/fmc-fakedev.c b/drivers/fmc/fmc-fakedev.c
index 941d093..62d9046 100644
--- a/drivers/fmc/fmc-fakedev.c
+++ b/drivers/fmc/fmc-fakedev.c
@@ -282,6 +282,9 @@ static struct ff_dev *ff_dev_create(void)
 	for (i = 0; i < ff_nr_dev; i++) {
 		fmc = kmemdup(&ff_template_fmc, sizeof(ff_template_fmc),
 			      GFP_KERNEL);
+		if (!fmc)
+			return ERR_PTR(-ENOMEM);
+
 		fmc->hwdev = &ff->dev;
 		fmc->carrier_data = ff;
 		fmc->nr_slots = ff_nr_dev;
-- 
2.7.4

