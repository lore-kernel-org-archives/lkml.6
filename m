Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CC5C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300D22077C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLjV74Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300D22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeIAVI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:08:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35633 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeIAVI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:08:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so6889000pfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nY/CXas1c2fA3vc5upsuqnbL+eYlo/bv43dBH5aUo0Q=;
        b=gLjV74KpTln/yAmgNKMZzu8NA8led5B6wqH/YwlC+CO3Mtm8j3xNgcpJisGdKf3Ouk
         NAulbDW5SZV37e+LXLmXG6MStTIgM/emF6dkbj7oX70lLwIR2TpOPgTu9SRieltoXMEy
         67NajWsCIrtY7dne+N7LOWG1hxRH8OxK294QybYRgzyjLARJBMWMpWZabfNL1sWLjpk1
         u02g9MffdfxEegd/ObufFM796TJzzirCM/shOJ37QprlkjmzX5kvZlbWwKULzFmN96tD
         Eke/pJq/ZHhRMg+AWiiaHG1LEzYkxCHmb3NKRcxUiZK0E6aw/72YFGW3tvd6IWIMADjy
         TTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nY/CXas1c2fA3vc5upsuqnbL+eYlo/bv43dBH5aUo0Q=;
        b=WVlTYEEyfPjVTayXVgXkAXXL09hdD2Rid4uCN6a9J4Y99x4BDT1EUhp2J9I/wkUB/T
         n9a2MJfeSQd0FlNwwdhgp/6g5AVQB6XTAHKVsmTl7eiwO98hdOfPk2F2Hw7KnanY/bwg
         YRKp3HoGmwtH65jv3l9LTiIQOE6jn9f7SNCQOfJPpS2o4eLbI0FYCLD5r+f9KwDTbgdg
         eynmO2LDAaM+qhEzrG3KRMxiGjA40SL9jKg0RZgozVcIhTIMx18oTY9TsVHA9paXi9bB
         HAH8l1LDVxFLS/hsBSgf1fwsBO127X4SCbgj8Cr3nNusAYei4NCfzTKIMX1lCcqS8Fr1
         h+mw==
X-Gm-Message-State: APzg51B6ZZFAx3+vwoty8U+cyunFUswhDyHLjfMJ+7VoFIJ0zWcTpTSv
        6xxaLtyE1Ebyelz8Lu1HuM0=
X-Google-Smtp-Source: ANB0VdaroIHX37CrLZ+DGZRQAJLLjRQXxEfaHfYcmXqIdtCW/FEM7PyX4Z7EHBpinwqVrTfHLwEHfg==
X-Received: by 2002:a65:4384:: with SMTP id m4-v6mr4781763pgp.265.1535820949540;
        Sat, 01 Sep 2018 09:55:49 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.19.79])
        by smtp.gmail.com with ESMTPSA id u11-v6sm22073863pfd.117.2018.09.01.09.55.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Sep 2018 09:55:48 -0700 (PDT)
Date:   Sat, 1 Sep 2018 22:28:50 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] uio: convert to vm_fault_t
Message-ID: <20180901165850.GA28874@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of commit 9b85e95a3080 ("uio: Change return
type to vm_fault_t") in 4.19-rc1, this conversion
was missed. Now converted 'ret' to vm_fault_t type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 70a7981..8fae1a4 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -668,7 +668,7 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long offset;
 	void *addr;
-	int ret = 0;
+	vm_fault_t ret = 0;
 	int mi;
 
 	mutex_lock(&idev->info_lock);
-- 
1.9.1

