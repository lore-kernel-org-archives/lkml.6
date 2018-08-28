Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1288C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641BC2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvbKxSCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641BC2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH1VEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:04:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33554 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1VEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:04:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id 60-v6so1015579ple.0;
        Tue, 28 Aug 2018 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nqb8Ad1UcN0nTASVDtMJIajbg2bbCwjXAK3GF8SilY0=;
        b=HvbKxSCBkMUJu9eVcORXfPJ21eFDL3OyrajAIjSCuSuQ/jsJuroRLjr7Qg6kClgU80
         d8B3ZRApr8JB0JIHYtbDw1FtGrB33af49VfcxRfZDTpLMEUOU2349zV3eHkE4wzzOwk7
         g246eZruAnuHh+qLUplSJYRKM6OLZX714WKRjbeZRePo4eRcYrSB1pJvfvSjjPlIuDsA
         wxnm0bVdDQE9Y3tzrTyau3oiWqs2ssINzIQyqeI1T7EYpef/E8JPUYBRKliimsSrw3Jb
         UZOfOFB82TovlcMDDAenvim9mEK7FZ1fXHzXrTn4AoT5o/C3ZgSL2UuzE2n8M36+z9yc
         xuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nqb8Ad1UcN0nTASVDtMJIajbg2bbCwjXAK3GF8SilY0=;
        b=IPlXk4AEZLwakwD+BfbPV7fA7WyiLb6kPZ96kvAk1GrYg7Na6WCh26LzVzmMbLF6+3
         DoNc8F4ocg+OkgwxIb8CBb4V7tKOQIceRMSfaWwZKLCYODy7My+4rJ2iVN6wKhnxIqSS
         KvRxuj15M5NGZpeTGM4eyJkRNVgC0tSjS7iUM8FVcmOlM7lwaR0zuBE/czJquL/zX65s
         LiA4SnaT/Y19gd5jiE+9OHkwQw0P3B1VXNOvT9J1/B1IgpFGtpda4M5gqVoPsrRjJsm4
         qs/SwujrFepdRebsGWU/DgYtvwdLuGaArt0VPTAlPblGdFhInuPDS8ZbYvPJ18yYPJnN
         /cxw==
X-Gm-Message-State: APzg51AY3ooH0dEyhlxhkhNeNFjUC5nY/DIxCs3oRNkGSZXmenYchprr
        IQHkH7ju1RD5ct3wJe1Y2Tw=
X-Google-Smtp-Source: ANB0VdZSSYs2AQLILFLS21m/wfBYgx+m9D3JMEuF6Aa3+AfjfBimvyDyuJCsR45tdKEK13ihCG5uUA==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr2391924plr.242.1535476303952;
        Tue, 28 Aug 2018 10:11:43 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([2405:204:560d:9e3:45f6:9848:6cd1:b9a4])
        by smtp.gmail.com with ESMTPSA id u11-v6sm3299852pgj.71.2018.08.28.10.11.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 10:11:42 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:44:43 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, corbet@lwn.net,
        akpm@linux-foundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] Document/gpu: Use new vm_fault_t type
Message-ID: <20180828171443.GA3854@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have introduce a new return type vm_fault_t for
fault handler. Update the document for the same.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 Documentation/gpu/drm-mm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index 21b6b72..23ae261 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -295,9 +295,9 @@ made up of several fields, the more interesting ones being:
 .. code-block:: c
 
 	struct vm_operations_struct {
-		void (*open)(struct vm_area_struct * area);
-		void (*close)(struct vm_area_struct * area);
-		int (*fault)(struct vm_fault *vmf);
+		void       (*open)(struct vm_area_struct * area);
+		void       (*close)(struct vm_area_struct * area);
+		vm_fault_t (*fault)(struct vm_fault *vmf);
 	};
 
 
-- 
1.9.1

