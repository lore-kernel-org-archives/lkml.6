Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C7C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E0821A0B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYySlrD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E0821A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHLAXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 20:23:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41382 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeHLAXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 20:23:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so5882896pgu.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KKxaNydyGpmRa//Lja/l6lRO0TveX+lDLJnNrPc+i+Q=;
        b=jYySlrD6HjoIDSDnZZ0oblP+l74XmqBPySzvOnH2+FTWOWTfHwdOFjnTO2sok/2LLZ
         NikPNje/vcNCHaHTSq0GIqfbqxrK1Qxo6+wn+1ASmGqW0uMn3H2eB+yP+RGZvMgUS81e
         XlaC5Bsge0iOpAyphX2Q6JSfu3thaBeQt3gXQpW8fFwQJYVYRACgAUROST56jZ8X+MW+
         ARlx9WgdNFXJCeudJfIIMQ4qKXYwbXz1DXv+PIXQpjF3/RPX2JvwG9r6S1a0zbEpxWMr
         4e9HWQRYV8djdY8oE/hcCyNf6cJGrgRULtYBEyRDFKHGzsC3saQlJk3NLvY2zJmP6K3R
         l6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KKxaNydyGpmRa//Lja/l6lRO0TveX+lDLJnNrPc+i+Q=;
        b=sCd2YTDz+i9F7Dq4JtmUU6eJauaujkhfyKayCSOVNuqjZkSy7H/ZzgF35zEZONP5G3
         ecfF7IGOc74MjGKjGpsZKWwj6JXE9K3+qz3IDSFN6OeU1Z9v34EYe9iOdKmMkXg05HXs
         52ldqpbO/pfyr6zmYbimdNIvokNSl61yCDUevHzv0jvVU4/fKclbNoIWElFSVg1W2FNm
         lu3Wex/4l4jnAqSF99JWNFH5OqwvWoQPIosbNIEgdMv2N0uIaZnyelJOwhVVStNwzjay
         Dw+LZYmINWXt/Z0t+HTfvXDa+PgvijoimR93LssQYPSLo3/gowkVhw22NJALRQkbv+oA
         FhKg==
X-Gm-Message-State: AOUpUlH5wnigahDkuwdzWDh2409RCQTuwIMEFdx7xS6v9K7vbGJ5Gwk5
        RMJiTbc+i1pnEzClKvsqHogYYBAqWZw=
X-Google-Smtp-Source: AA+uWPxkKreIDmMFS8vSQf8XRxHqCpLIraaZewMZ04s+TVpa2236BpshR2vUc+DoSx9IXlFvJyFUNQ==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr11480397pgt.164.1534024078551;
        Sat, 11 Aug 2018 14:47:58 -0700 (PDT)
Received: from ubuntu ([119.82.107.14])
        by smtp.gmail.com with ESMTPSA id h130-v6sm52608986pgc.88.2018.08.11.14.47.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 14:47:58 -0700 (PDT)
From:   Sumit Kumar <sumit686215@gmail.com>
X-Google-Original-From: Sumit Kumar <sumit686215@example.com>
Date:   Sun, 12 Aug 2018 03:17:53 +0530
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: remove null ptr check before kfree
Message-ID: <20180811214753.GA14868@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove null ptr check before kfree because kfree is null ptr safe.
Issue found by checkpatch.

Signed-off-by: Sumit Kumar <sumit686215@example.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d4c5f8a..bd921dc 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1328,10 +1328,8 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				  num_pages * PAGE_SIZE, mem, handle);
 	}
 
-	if (gasket_dev->page_table[index]->coherent_pages) {
-		kfree(gasket_dev->page_table[index]->coherent_pages);
-		gasket_dev->page_table[index]->coherent_pages = NULL;
-	}
+	kfree(gasket_dev->page_table[index]->coherent_pages);
+	gasket_dev->page_table[index]->coherent_pages = NULL;
 	gasket_dev->page_table[index]->num_coherent_pages = 0;
 	return -ENOMEM;
 }
-- 
2.7.4

