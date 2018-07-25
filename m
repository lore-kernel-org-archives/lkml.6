Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A504320833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="VgwH9ehG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A504320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeGZBNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42148 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbeGZBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so2196784pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hIvpKGKNqRxV3JggszEiPqiqS8x7Has4uKzatQ8KMas=;
        b=VgwH9ehGKsvLCpNCJBZ3LT/BPS3kwPfYyYKCdvQLTjgI2AWqFcsKmr1fkMCFT/BbGJ
         S85GvHFFcSzPQU1l4YKlJHpcQQ6zcChxOOFcnSLBdTSbPFOu+7ixg2949tYvLMmtAbT6
         2QGcFpKlnIoPWeoNKDmXnDDeV9cbZhwWm3nzfzTXZEf47Lg5/GueHAjRZMS8Mb0s6KjY
         +JZYhVbDDVeG9TLa7leCTOOcozVaPDpVoDi1yB+IgzN6vhJwflPRtnuL5BdgKpU2KzI3
         fgKdrprTyv4+bS0dD/o9uBqWURDlqMIN9XC4N2OwkVBsdoy7yKlnbK4z7xkf4crXj6qa
         NK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hIvpKGKNqRxV3JggszEiPqiqS8x7Has4uKzatQ8KMas=;
        b=tFrvsCqIWEXL+qff3sk5lSHFEsZzTSkps8+ajEBrqMroo0uNdpRfZcHk2DoINWh3qX
         oy5G6iZtOeThv6RkFYYbgKZ7R+QPADQfRCOPtq5BSYpS7kGZsbYZspRzqjkDjDHjlX6R
         bLS9IwOabNGOkWVXhbTibsVW0vXkJCmTIsH/rFGeokcJXnw2h3Qfdl7SJ1ALDRi2/hDx
         hMt6hERRqSssAtNyaf4XnkswQ/F/nW8GSkkcnv2dOJXNlpZEFEuA2uoHYTyQ5NmQACeb
         om2BAaBVKwKrPa/fV+yW7OjE084rnZ5XVyKqTOoHrpqENwRVpp0RcfDDrL2e4XxcgewU
         HA3Q==
X-Gm-Message-State: AOUpUlFBFUIcrCV83LwyF07odLCGtkb8OzAOn973TGjZ+xskqh9DqjM4
        26L+tUTLCiWdD74SV5VsAQyTA9lOBZY=
X-Google-Smtp-Source: AAOMgpdZj07WntgfPeGIVoOtHqMpHSMjPYh78SgKm6VEPVadyXrVGLL9NS5jXIHQ0H+CV4VWdQypBw==
X-Received: by 2002:a63:5055:: with SMTP id q21-v6mr21675081pgl.397.1532563176737;
        Wed, 25 Jul 2018 16:59:36 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:36 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 8/9] crash_core: use VMCOREINFO_SYMBOL_ARRAY() for swapper_pg_dir
Date:   Wed, 25 Jul 2018 16:59:19 -0700
Message-Id: <c05f9781ec204f40fc96f95086e7b6de6a3eb2c3.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is preparation for allowing CRASH_CORE to be enabled for any
architecture.

swapper_pg_dir is always either an array or a macro expanding to NULL.
In the latter case, VMCOREINFO_SYMBOL() won't work, as it tries to take
the address of the given symbol:

	#define VMCOREINFO_SYMBOL(name) \
		vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)

Instead, use VMCOREINFO_SYMBOL_ARRAY(), which uses the value:

	#define VMCOREINFO_SYMBOL_ARRAY(name) \
		vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)

This is the same thing for the array case but isn't an error for the
macro case.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b66aced5e8c2..e7b4025c7b24 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -401,7 +401,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(init_uts_ns);
 	VMCOREINFO_SYMBOL(node_online_map);
 #ifdef CONFIG_MMU
-	VMCOREINFO_SYMBOL(swapper_pg_dir);
+	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
 #endif
 	VMCOREINFO_SYMBOL(_stext);
 	VMCOREINFO_SYMBOL(vmap_area_list);
-- 
2.18.0

