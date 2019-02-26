Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8135C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958C02173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162030;
	bh=ZnQmzZd6wvP/IK0HwOy+zcnUZULAlffdR5ZJQrx9ugQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Qqi/b2oHJAJBzHDjvDaFDu1h0iKSHu4t0yL5TRiF84YsiCcJqd6MfJB5tU7N+LnM9
	 xkKJMsXOm3hIyQIKOXYADN+a0OpL6CgZ2+7Nj37nZks+hrXA7Dwu+tKVHrFs68bjoy
	 RZ5brCGRKxpBUIBbG/HKZf+mzLC7ywLwy26oobdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfBZGU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45838 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBZGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:27 -0500
Received: by mail-io1-f65.google.com with SMTP id x9so9590522iog.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=HbIvXXxkoOYvDJka1De1DE8EvRWM+I3icfIF/qPG/Mo=;
        b=cZlaF38NkDP8gE4OCIxZHEr0Q2yxDkFQmAlOpqM4F6iGfjpKXYqQT/pe+DI90uYb9y
         /1HglBphsm8ViZMKC17dFaqe3fk4D+irlpVXVvSDogKc4bntA4lYOKWsOXZwnLNgBPKt
         S0KRV5XLYgCEBvCtpKJGckxM5EDoopMWDi0dohVgGrP58LCIlt/y87n2U7SswJdiYK+J
         B2Z4AobbKrARn0d2b4tevxuwdiYoHKq74QcVRRKc6Ecy7f3v3yxzreQ57is6jibJ7GlA
         zgNgOOfs7KLBkyH/L+TLLKMYFETM1Oqnt3bv/Uppz/v+PUhiaZhOnhRjh90OJYvlnRiK
         9xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=HbIvXXxkoOYvDJka1De1DE8EvRWM+I3icfIF/qPG/Mo=;
        b=S+8m0fG5uxHS7CvGrJOin5VgF8cTn0ZHKWWbUw57re2heMnqxoJkFpsTd2FjAgTSBZ
         AQMbe7ylCRBOLsafFwmqhlh8TCQU2hcgKpkb9f3xxoXgJsEQajpgjRj0+36O9rQhJINg
         m+hqcRGxTeFrYtuTw24f/SaxF7DPz6J4COeHjdZhvRVa4+76y5yPw/yhj2wMvJ8Y/z6+
         +jwjj9evb/gStoKPC9An9ljBMtqn5Okfjsov92FC9RkxOwkyybnMAeCmKlYVMALyWW/y
         zVGxE9kqXt8n4sTrZLA3L2P7JpqiRAiAl4rhaQqQ59dsEJ/yYJjEvlC5Zt9eW1HXjJru
         jJPA==
X-Gm-Message-State: AHQUAubdkh4WfP9NHJW4Lx4VbkT8AO0l/wxmpfGErhmMhnuBFe/VKZFb
        m5uVs4bmI+/hQgACLcqoevnGVZhj
X-Google-Smtp-Source: AHgI3IbObQlQCLSUwnOQ/hiQSn8ubA0LRXvlbfPyrNSASPbo4mcSoV/ZDsGPzF05CA6tUGl+4+AL0Q==
X-Received: by 2002:a6b:7b02:: with SMTP id l2mr10918746iop.60.1551162026600;
        Mon, 25 Feb 2019 22:20:26 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:26 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/14] x86 smpboot: Rename match_die() to match_pkg()
Date:   Tue, 26 Feb 2019 01:20:01 -0500
Message-Id: <7ca18c4ae7816a1f9eda37414725df676e63589d.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax only, no functional or semantic change.

This routine matches packages, not die, so name it thus.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ccd1f2a8e557..19a963890bbe 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -459,7 +459,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  * multicore group inside a NUMA node.  If this happens, we will
  * discard the MC level of the topology later.
  */
-static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->phys_proc_id == o->phys_proc_id)
 		return true;
@@ -550,7 +550,7 @@ void set_cpu_sibling_map(int cpu)
 	for_each_cpu(i, cpu_sibling_setup_mask) {
 		o = &cpu_data(i);
 
-		if ((i == cpu) || (has_mp && match_die(c, o))) {
+		if ((i == cpu) || (has_mp && match_pkg(c, o))) {
 			link_mask(topology_core_cpumask, cpu, i);
 
 			/*
@@ -574,7 +574,7 @@ void set_cpu_sibling_map(int cpu)
 			} else if (i != cpu && !c->booted_cores)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
-		if (match_die(c, o) && !topology_same_node(c, o))
+		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
 	}
 
-- 
2.18.0-rc0

