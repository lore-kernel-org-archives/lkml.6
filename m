Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PMELNZ/nHVueBAAAmS7hNA
	; Mon, 11 Jun 2018 03:08:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B31E060791; Mon, 11 Jun 2018 03:08:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0JQ7mYg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 30200604D4;
	Mon, 11 Jun 2018 03:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30200604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeFKDII (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:08:08 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38688 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeFKDIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:08:06 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so22245433ioj.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L6YMPn3dzEROBIVSmcjy7oTkC3KCMYhJRgTqLvBqsn8=;
        b=j0JQ7mYgzP/TknUpEO4+u1jI+CkaQxaMJ4HThDl7a1Lnmzl2rRzaUPVXsX0A4nXtN0
         qkEH/xt+cyhjZx2fIRzL/oN3e3uu9FJ0IDgOD9BIy23fU9IeQZbCW+oPgaRnR81E8gfv
         uKuZ7ytBdFnzc4hP9l4a8787OTcIYVwbNUAy5Pn51I55VcvEvp2Oe8XaTThT1dliwa9D
         6u9AOIKjtnSz2YmE7Fbnj8HZ4CT80RW02l4i3dfW+5ZWPJddQSgums1w6oipx05rH5Pw
         4ZcL5/LGOvLvaZLX6GLPAW2WkwunKmLSIOZKVqgQiUEosoPjHyno0+gK+LUuOC1JxOJ7
         qJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L6YMPn3dzEROBIVSmcjy7oTkC3KCMYhJRgTqLvBqsn8=;
        b=CtOLAfn+1SXQqkz5wY4OEbSHWOBuoTGznJfsn3luUd7kreOrKLBW5OCnyI/4fx/DNN
         GYij2gNQApp3F3DajrWjGz3pMqydApxwDbMzeuBVZr4Y6wFXjAGQDSLRDJ0QYeVuL+I4
         Pppim0P1dlVQqcKpwESnk8oPZRwi5SsU+EDpS+1jDwn6924JlEVwli01twH43IzM/sbq
         Cw/i5xqJNb0D/K1C3E83HU4Q6RL0LGMRSSq3AvcJN/qTOWZ+nAjgF+jy4JGN5eShv5Lx
         oI79O09dLOYwdjrkxvH0/DSztJUQlo561PWx5w/TjUMWAAJYLys1Qw2VlvPu0J5u5cwM
         K97g==
X-Gm-Message-State: APt69E3rFJKia7JhaIR2gc/1YjZld3ez7/hgCi1NelAXlFjfWCE9+d3h
        ztV6iU0cFbBYbn8+wlok8iLywdtv
X-Google-Smtp-Source: ADUXVKKpxnurmsvJ/aJKDJwCPcdAyLAHLFwirV66pvhDA0bRiunHN3UUPT2DFBFjq9fgJHYn65ZuTA==
X-Received: by 2002:a6b:3902:: with SMTP id g2-v6mr12153032ioa.265.1528686485761;
        Sun, 10 Jun 2018 20:08:05 -0700 (PDT)
Received: from pickle.eau.wi.charter.com ([24.178.40.44])
        by smtp.gmail.com with ESMTPSA id y13-v6sm4880268iob.53.2018.06.10.20.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 20:08:04 -0700 (PDT)
From: Kyle Buzby <kyle.buzby@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Kyle Buzby <kyle.buzby@gmail.com>
Subject: [PATCH] staging: clocking-wizard: prefer 'help' in Kconfig
Date: Sun, 10 Jun 2018 22:09:30 -0500
Message-Id: <20180611030930.2097-1-kyle.buzby@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the checkpatch warning:

WARNING: prefer 'help' over '---help---' for new help texts
+config COMMON_CLK_XLNX_CLKWZRD

Signed-off-by: Kyle Buzby <kyle.buzby@gmail.com>
---
 drivers/staging/clocking-wizard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
index 357af02c562c..aa57a5865556 100644
--- a/drivers/staging/clocking-wizard/Kconfig
+++ b/drivers/staging/clocking-wizard/Kconfig
@@ -5,5 +5,5 @@
 config COMMON_CLK_XLNX_CLKWZRD
 	tristate "Xilinx Clocking Wizard"
 	depends on COMMON_CLK && OF
-	---help---
+	help
 	  Support for the Xilinx Clocking Wizard IP core clock generator.
-- 
2.17.1
