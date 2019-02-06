Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B14C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A0D2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ueBcUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfBFOwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:52:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41762 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbfBFOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:52:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so3172408pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hOLJ53QVgBzJNldTBlnzWhoN+IcJRB2IMFs2pXOodx0=;
        b=g6ueBcUXkTLX51tcF53RaWM44zhLjDxJSAgO+lU4Y1VFmIZFO33XjYESg6wlBHf9wy
         Ko+viBvjFiSLRuzwBvoNgGgtINqB8BMnrXS3p9s8XjQf8lGUQxiNjHzPgRPDpEeCFsbx
         VNaZB+zKsm/JqYAZfF7IyDOXLqC8B3std8c8Z9U/DJJPnRbuSWL1h8E+l7QxOjAL36J4
         SiaxByMSVWuRIa2t3pDZYk17OuJsIJBOkLfppkW8EX4huCrL4vPkvYQgrM2qtI3pR3/2
         i8eqm9hzguABCmPg7bGoVbbmx8iztKYYaTwTWp9TaGN5E1r8OggCn8CMg+Jd8scSpNwQ
         6w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hOLJ53QVgBzJNldTBlnzWhoN+IcJRB2IMFs2pXOodx0=;
        b=AlSDOOkhykYyBPDeL9nIYTLZ5rO5oWCJVgC0F5eia9Qdhn71fIAYwX80r1hHacaou+
         DEuz5nNajhX6KpnYt8KuSOUnDMKbTfhY2Su1022a0ailbJG2noQMmWhBBYRP17UBwg+7
         Rciv6epfP96lUNfixL3UqXQZkPlQ1Fb4bj1DYiUXOrg8atfl1Op8hHmSwBdfOsMGnFoe
         uEkGZxYmp6W1Ymj6CuafKFYJ4bNbuAD0nkhH4q6StDbAKwILnBfoasdmIh0q4XMK4sgt
         aHQ2gMwJklMri8yygaDiULKfQXaXfpVp5wwuGJjXtWYErO7CrMQpawNozL17kcV4qvLq
         Y/0Q==
X-Gm-Message-State: AHQUAubNdM5AmAyiF3AEP9w+lnn0ir3bedFLu/siacmXkQrYvFw2H9ET
        2BRpB/Lk0KIkRtXjjipuo6M=
X-Google-Smtp-Source: AHgI3IZnzC7oFZRCt2QRN23bNpVtkM5CYG1AGe+eTSp3bbxPKjaRrUaTCiG1i5u+a+LP+kEYCuy1Ow==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr11196844plr.128.1549464721522;
        Wed, 06 Feb 2019 06:52:01 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id y5sm31042649pge.49.2019.02.06.06.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:52:00 -0800 (PST)
Date:   Wed, 6 Feb 2019 20:21:53 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6656: Use the correct style for SPDX license
 Identifier
Message-ID: <20190206145148.GA19324@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the style for SPDX license Identifier in mac.h
by using "/* */" in place of "//" as per Linux kernel licensing rules.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
  - Use the "/* */" comment style specifically for the SPDX identifier
    as per licensing rules.
---
 drivers/staging/vt6656/mac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index 94e700fcd0b6..3fd87f95c524 100644
--- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
-- 
2.17.1

