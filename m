Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7580C222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392696AbfBOVrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:47:20 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:51126 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbfBOVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:47:19 -0500
Received: by mail-it1-f169.google.com with SMTP id z7so27763177iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=plCANN+xPqK74sU+IPcEmqBCKDodeksp3NUVAB60/OY=;
        b=SUQdCG9Zg3uF7NlvEqdTQzwArQdMf1gKMyLu8F9d1qh9z9lHA6jX5JO9p//kqZmtl4
         0vtZuPwtQMStUtEJ6YdW9TUWqJNIij3OyQ9CzDmKA5LD6we28RIAX2Ec8lYy4NoRYoF6
         wnMJjW6IgQC6FaN8BBwTHs534wKe+1wj+NNbYcCH14pSFsvQ1UwQ/i1fE0OkYOp352AS
         +Rc15kkPXjZ7RilBDtudUAOZIjESjsDOK1LV2kTZMMkgQ8UQcRceEaUmMR+jth/YOnG7
         gqBogvcFA2WrCcW+2uiyzRHvJhZzOVJSHutYnA3nSWOs5b5w2pkNqFxGiIm0YTZuBDNa
         sEaA==
X-Gm-Message-State: AHQUAuaVYTM4+CbQFMr+W+P8YXCrNZqxOXtIHmSKjDIBJnw2gVKzkAVO
        7vVmOzbYvBgEPJ1tWz51xDxMmM+C
X-Google-Smtp-Source: AHgI3IapFxvn3jOts56H0sax7okrkc4Sk8GJFbdwO9czdvzvBIQte4kXvGCEM9KozFfsDOzJCX6SgQ==
X-Received: by 2002:a24:3257:: with SMTP id j84mr6017472ita.173.1550267238767;
        Fri, 15 Feb 2019 13:47:18 -0800 (PST)
Received: from mail-it1-f171.google.com (mail-it1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id k4sm2711819ioj.33.2019.02.15.13.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 13:47:18 -0800 (PST)
Received: by mail-it1-f171.google.com with SMTP id x131so26461127itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:47:18 -0800 (PST)
X-Received: by 2002:a24:18f:: with SMTP id 137mr5329899itk.99.1550267238211;
 Fri, 15 Feb 2019 13:47:18 -0800 (PST)
MIME-Version: 1.0
From:   Sultan Alsawaf <sultan@kerneltoast.com>
Date:   Fri, 15 Feb 2019 13:47:07 -0800
X-Gmail-Original-Message-ID: <CAFArEyVmxmF1=uymN82m4j_2XGOdb+LoDqgU7773Edu09KLLpQ@mail.gmail.com>
Message-ID: <CAFArEyVmxmF1=uymN82m4j_2XGOdb+LoDqgU7773Edu09KLLpQ@mail.gmail.com>
Subject: random: remove no-op BUG_ON
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of simply does pointer arithmetic; it's not going to spit out NULL, so
this BUG_ON is unneeded.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1af6..5ea9cf3d3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1357,7 +1357,7 @@ static void push_to_pool(struct work_struct *work)
 {
  struct entropy_store *r = container_of(work, struct entropy_store,
        push_work);
- BUG_ON(!r);
+
  _xfer_secondary_pool(r, random_read_wakeup_bits/8);
  trace_push_to_pool(r->name, r->entropy_count >> ENTROPY_SHIFT,
     r->pull->entropy_count >> ENTROPY_SHIFT);
-- 
2.20.1
