Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A912C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9BD20843
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo1Iiy23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9BD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIADMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeIADMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so12512263wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HvJKc7o4Ct7KJLw/yiGgkXSsSFKhkyA4tx1LDCi3TY8=;
        b=Qo1Iiy23G7DEVa8Sk9DJi1CWT8COYzjMU/A32R4Vmw2KDHAaR1QC95kY8E+FDO3F9y
         fYHcP9of+cJ3CwsDaFjkRIE77gi4PV72Am0yRyblKo8DazFhOeQw3IJKEmy7vBqaIf+U
         yFYoQBws5JG8cgCOvSFFjBFYFyGYI2lZmuwHpHMdj7K1NeqoIbwhWGInj2j4emaKoHmd
         aOAiIb8XF4jw5SipWpuNPmPrfCMfW4IMH80efipnmEYxCHFopXdGV136DIBm8P5+P39F
         XG0Hzqlw96IZ8Oe9ydQddlmCDJPY1cwatsmxNtactbeuZYu542hGty4ZqTwmVXpw1vmt
         b7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HvJKc7o4Ct7KJLw/yiGgkXSsSFKhkyA4tx1LDCi3TY8=;
        b=b/mjHnM9bCCZf6TmgY08pUGqgmmq+aBxR6eZHzs1zJ7ZS8wySK2bc7AdOqf/kRNWXG
         e/3Y54DjVsJLuQGwzOn9B8W8BSv+V3CdHEEknIJce13fJkTKHrxUYkTpY/Fqv1Tq8BXU
         T1nJd5imD4kforpnbgwQF/PcFTnR87sTfdKN9YIj9lwNZJLwtmV2H8DHqgRuMCUvL3BM
         N9e5n/q7x1Ye+SBfXawcxrhZBIgZFKzBFS1OmPHM36YZ8ea5vDva9llouKx24y/HVgfJ
         7PdklG7anJnWjdxXF5H6KtuDG6UxQnf2U31MBPXmXvZMQP5r1bOb609Z/hIvu1U9tYhv
         bU8w==
X-Gm-Message-State: APzg51BWEP5bFIW+fX6jG/dZh7EALKPCompSKqkjmHW3/70Leu3ejVwU
        hw1P8ZkpQIFhP2AJAG304q7mjW4g0AM=
X-Google-Smtp-Source: ANB0VdbD+8ynIDqmw7Pgqnk9Amkobj3U4uwtdJSn52lDi7t5LaVBIicOr1HHsngjXi+9PeaDfacBLA==
X-Received: by 2002:adf:824f:: with SMTP id 73-v6mr12379155wrb.130.1535756581584;
        Fri, 31 Aug 2018 16:03:01 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/20] staging:rtl8192u: Add SPDX-License-Identifier - Style
Date:   Sat,  1 Sep 2018 00:02:34 +0100
Message-Id: <20180831230250.16810-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX-License-Identifier tag to the start of header file. This is
a coding style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index b3e6ce2acedb..4dcfcb4d3911 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This is part of rtl8187 OpenSource driver.
  * Copyright (C) Andrea Merello 2004-2005  <andrea.merello@gmail.com>
-- 
2.18.0

