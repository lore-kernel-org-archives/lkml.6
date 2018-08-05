Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39618C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B9F21920
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha+kxwzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B9F21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeHEWOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so5214371pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YSPNlmBoQ0c2vXLlvgNngbfvkUzM+gMV6cPIhPtsYo=;
        b=ha+kxwznhRFIEB36cHnq7caV4yOhk4KtD5pH/dNU1ZPWfCC3lS/0TZk5vQUXeWzxi5
         E8G42H/ekZlVHyLF3I6sN1qH7QEpHtVLeAOKp9PRsUW2XAqgTJrqusZyrv2jePyqjqXj
         zPNpPtdeG9TGXurMdNsAMqacmGJ2oIvlCZu/3/SJyWNHettaTnrr9/+DQdKdpT8taVxf
         vlNEc/aX0AIuI6TkMkQHscmCR/6b3EitMMjDpJzDQyXr22vJ0mUKsX+sQePmTF/qho4X
         DWCWyFSYHUQ2rwmaUFuSmr62W+LcaBpbbxTD4OR+N4I+azNJCdWOSDpnwhaAj+dTZ71n
         MdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YSPNlmBoQ0c2vXLlvgNngbfvkUzM+gMV6cPIhPtsYo=;
        b=WPuNUOnVP9Vzeb73UInYk2sGmVpsUldIsv4eo+hfONtJQbPb+atS6NpFMyGlGrydUU
         dOzXhUQk/Vzcm1dOGPUudSPWA/MinuJ/j8eo0nxy+/P4+LHTegjdHltRgB7d9Y8DGewL
         yPM1LkdvYk/aey1saSpfBzrpUooN4t/9MRndGgwNHIpcMW68hirqQiaWGDgfaHFPjpW2
         yhuW8mYcsWvX3oEXS8ER/NOdqLsjbKMTIeM5wqhoxTQl+w/ZZehfEPIU2A2kCFH4t67+
         Rvy8o/cyZXT5a0doQjnh9UOUBBqMicqojGQAUy+l3RGcDCsSCqnjKlLBM0ZU4lFSYKIf
         41mg==
X-Gm-Message-State: AOUpUlGM6bCiL1lXAQJOgbK+6opuIVA425UB27b5wnoiFbNe3SEjKUfM
        NKolSVFvdRrQBG1rWFjnhUw=
X-Google-Smtp-Source: AAOMgpcsrkWdHEJMDy0bgYVR81Z4RCN979MTPokWyjCxN5/+23ltuV4N5SumfTQLqaqu4qZyt94fnw==
X-Received: by 2002:a62:778c:: with SMTP id s134-v6mr3888252pfc.189.1533499703549;
        Sun, 05 Aug 2018 13:08:23 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/15] staging: gasket: apex: remove device enable and disable callbacks
Date:   Sun,  5 Aug 2018 13:07:40 -0700
Message-Id: <20180805200749.116693-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

These are not implemented for apex, and are now being removed from the
gasket framework.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index b47661442009d..e2bc06b5244f7 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -688,9 +688,6 @@ static struct gasket_driver_desc apex_desc = {
 	.add_dev_cb = apex_add_dev_cb,
 	.remove_dev_cb = NULL,
 
-	.enable_dev_cb = NULL,
-	.disable_dev_cb = NULL,
-
 	.sysfs_setup_cb = apex_sysfs_setup_cb,
 	.sysfs_cleanup_cb = NULL,
 
-- 
2.18.0.597.ga71716f1ad-goog

