Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDC620673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcHUmRbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDC620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeG0EY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:24:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0EY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:24:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so2343154pgr.10;
        Thu, 26 Jul 2018 20:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I1w2fTWFH6D5/xRWuf1sz/hQSAip5UyfHVE49QGVzkg=;
        b=TcHUmRbDRv/cwZhQ3+JVthMbr7jPjcoHL+AsCW2jqLoLNJV15E8OqAr5oF1SO21TEf
         4OvfC/2ZgGxt5DN8i8SlYBkeKV8FPKUVvLbvluwYBAUPu7VrMttwGjqz6oOss9nYnAlh
         UORpYvHKktpQd41+XFMjIo/zDugr/lFJKNtR9Icqw9MatfEsSB7oNC9wwy5YcaEH7XaJ
         8MQ/BasZJ1j0hMdFyyZOHdys50Micz6PsRU2hgU9jN/1Tj2aPVqNTYZ6ORJmTe8s/9/+
         Gls4rTX9PC4zJbrfC608nOV6eJalrs63lmDZDPj7tjgt7mrYiAaVKqsRmfcB9oGmNhC0
         vlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I1w2fTWFH6D5/xRWuf1sz/hQSAip5UyfHVE49QGVzkg=;
        b=IZx6b7Hmabifz0mgL+SUAFuSrfoaK3EOT2Ni/Abg4tWQMQkteie1sGRGZlC5Pjvpcf
         0n1erNNW6QpwOErAR63yQCSSeIB4K9VsiEB+4ygejsJNn8JcQbZex9IsjhfYeBugq1KD
         uw1w4lUHX829fvgi7botwj8O6TyvKCkFyo149fLc918EbvoSL1nH+lSi2wDe7uBF0Ol5
         lmIfCSDSHbRLTDW5VpGmjw/ZXcjDLy/ZMNlyoFQ93NL2pyB6TgvyNUgXjh2Gj+dvpcBp
         M0nhnVkKYPEeB/rTesWS8ANm8stY0A4ttKPeWCTn9GnqYfmuBS6OLkSNUb/5SuP9evjt
         VoVg==
X-Gm-Message-State: AOUpUlGYGlbaaCIIukfrQoabn1OKb39XJtTRgz66ni/fDj6N74w2InHl
        3IYDndwd00VT/LHmeyWcAqE=
X-Google-Smtp-Source: AAOMgpdzPMo6Fm2Tk4tn7Mbt20Vg9vlmnysTOAywY1mN+V7xg+I+/nxRTE+YM+I+Sdsw0UDU7zL4hQ==
X-Received: by 2002:a62:4494:: with SMTP id m20-v6mr4696317pfi.205.1532660717388;
        Thu, 26 Jul 2018 20:05:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id n188-v6sm3864532pfn.49.2018.07.26.20.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:05:16 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     hans.verkuil@cisco.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: cobalt: Replace GFP_ATOMIC with GFP_KERNEL in cobalt_probe()
Date:   Fri, 27 Jul 2018 11:05:09 +0800
Message-Id: <20180727030509.2668-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cobalt_probe() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cobalt/cobalt-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index c8b1a6206c65..4885e833c052 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -670,7 +670,7 @@ static int cobalt_probe(struct pci_dev *pci_dev,
 	/* FIXME - module parameter arrays constrain max instances */
 	i = atomic_inc_return(&cobalt_instance) - 1;
 
-	cobalt = kzalloc(sizeof(struct cobalt), GFP_ATOMIC);
+	cobalt = kzalloc(sizeof(struct cobalt), GFP_KERNEL);
 	if (cobalt == NULL)
 		return -ENOMEM;
 	cobalt->pci_dev = pci_dev;
-- 
2.17.0

