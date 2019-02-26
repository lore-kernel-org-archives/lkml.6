Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CC72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162028;
	bh=g3M/5b15eERHdZTOti1ql2/n1RS20eeqRM8IM0ukWMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Qsx+1R6RyvMn47PwOk028RrDhzH41ZsclTyfyKaSxEkAPB6WEyC1aSR2NrSZqoeeG
	 KaRpv+IrlVwDmu34PZwuw4pqLc6wlwspJC9CsF8blri+GKR5BJLe9EmnF93sULJIcI
	 wSLusGkxsLfR+HE9S3wW/nMAYZbrHgQptX6ZAxh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfBZGU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:27 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50892 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:25 -0500
Received: by mail-it1-f196.google.com with SMTP id m137so2340050ita.0;
        Mon, 25 Feb 2019 22:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=sffzOo8z7d81zUqxbJVCNYisYASVtWZPinAqN05wwmrfOei1tlZA9MwQsiLdvVLRwq
         Vq8wiVlrga9dJl9bHJNxrgh5WRonkhWnOma5tB7/Lpz5CglQQWg9MYi5/HuAopD35tvn
         nV5RnP/2L72NGh2WrKx0Po+M43xADuhRdl1E+zCVYgn8G81pjm74BM7KMgheQWA63f3O
         gqnMYP+XVoOgjKSPAnx+luPzVLH6SiLUXe2L3CxVptNA9I/JqvsyMV/beQddfRO6Tey3
         RtXLqjRjQfl6h01krLMmBaJ78aY3yKlD1PtknTJMAtMTZ6P9LBOUC2Op7RMZkWOlaNUl
         //Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Nk48nKxFrzVCbK/utRpRT/1210jzyM5INfoRqpnVTi0=;
        b=RCFJcphMI7XqE1+umFgdzwJICGtaxuj87NQE2Zt0pGQr/3qd72zR1LH+0aFdt12SZl
         kg+lGqlCP6ZegBcEZKdBE57RuapI6tgKqzw9YU+ztWF6i05oSR2XExkjeD8kX/09uFUS
         9XEvjc+7PmifcwjOqOTFJE0lbwka5VJfxP7lOqVK4XEZKAgjcdTs6+32/GFA+G/a2zTX
         ye3pou48rfda246/50pIIc4bWZrByhyjNzMX/8363+El0fp7ccgHj+37EIe8qWin7wxE
         nNonDlD6rXTKD7y+9tvxViOi+fhBjne3RN6xqgorbSw1jzn0Bv4Kapw9ZHKUKwXq3fMi
         jL/Q==
X-Gm-Message-State: AHQUAuZMJwbH7P5jblS1GH87T3KYOPZ22qtwXKLW8ttJdaium7g/2As8
        bUH3GEMNSMdGlXkrg389bco=
X-Google-Smtp-Source: AHgI3IZXi/9UawbR965Y4OZda0a3h9eY+QQzHMzMGF1LVJrGYdX6zBM3JqMbyASN/fFiQVbqTgr0uw==
X-Received: by 2002:a24:32c2:: with SMTP id j185mr1469004ita.33.1551162024270;
        Mon, 25 Feb 2019 22:20:24 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:23 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/14] x86 topology: Fix doc typo
Date:   Tue, 26 Feb 2019 01:19:59 -0500
Message-Id: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <20190226062012.23746-1-lenb@kernel.org>
References: <20190226062012.23746-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

reflect actual cpuinfo_x86 field name:

s/logical_id/logical_proc_id/

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/topology.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 2953e3ec9a02..06b3cdbc4048 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -51,7 +51,7 @@ The topology of a system is described in the units of:
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
 
-  - cpuinfo_x86.logical_id:
+  - cpuinfo_x86.logical_proc_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
     packages in a consistent way, we introduced the concept of logical package
-- 
2.18.0-rc0

