Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F73C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA39C2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dugeo-com.20150623.gappssmtp.com header.i=@dugeo-com.20150623.gappssmtp.com header.b="WCxVEwts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39C2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dugeo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeHYH3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 03:29:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41271 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeHYH3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 03:29:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so5112558pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dugeo-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1rk8UAbGwRvJuCPLPvx8UxsvdMYERWjtrCiIpJvLH5Y=;
        b=WCxVEwtsyvQOXefExHqZ/pw4+X/kdfN/v5006sDwhMWK8hLgpurW1HN1H+mRk//P0k
         zAXpHjRDq1KPGrXgLd3s1vdBzUFW4hMsbFdhuGQ8oRyruwz69rxQeCtJaqvLzND9wCAs
         PSpGdaw9BWpnajuhTRw6VpZPv/igqus+oZkakAqWw/7cWj4gyq8PBfaB4+ZtU70won6V
         Xx2Hx7SFHOHv1ZqRp7Pzf7Idg4QUP2A7R6Brj3/HIlVauR+Pc10jpXb/FcBzslgkKuwZ
         T0BQU1k9AGqiRHxDxANMZFepxq76g2u3SxlZUFAncvJ8XEw49WdeNiTN3jQINP3vr4GZ
         BjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1rk8UAbGwRvJuCPLPvx8UxsvdMYERWjtrCiIpJvLH5Y=;
        b=VB0BviKN2pE+e0nYR3hrLgInOrM37SXyUIB3iyW3joCQxaMNrYsz8/uBYr0YdmsEzB
         lGLTVhryvdb6JBwJnTlGkA5lu+NWwcwZhgp3fK0wwpJ5qw1pUJHUnPGy/ooPhfzYJEYJ
         F7w37Nee2lg1oIEKMi7aBe3La4kdWotImx0ru0cWXwf/En1KtJIabqOjtf/AdZAMCDPh
         DU2Tw3wmTneXSQ7qzNrj7scMGAs2BnYpai0H1ZTJ5/my/hRQZV9ovaI/Z/oDm/C6IwMV
         EsgH0gwfA4gVnI9Ihu3gF5WvkW5yJ+E2O8ChRQnusClqAkzXLxNh4UWL22ZnpvIuoYN3
         z1XQ==
X-Gm-Message-State: APzg51CNpSqWCFZNl5tWwX/rloPSKLDDqg1qKswW630Fzpso3mCVLN7k
        KMLzFNtnbL0v1OC1VEzQc4wp2pETm68=
X-Google-Smtp-Source: ANB0VdauvNd9tetjoXr5E52Lzi4mxz6Q9X46H90qWIQTRI3sNee64stUTzUiHuPvN763H+pfXnZs7g==
X-Received: by 2002:a62:6003:: with SMTP id u3-v6mr4595649pfb.114.1535169098623;
        Fri, 24 Aug 2018 20:51:38 -0700 (PDT)
Received: from bud178.dugeo.com ([116.212.202.58])
        by smtp.gmail.com with ESMTPSA id y86-v6sm14144682pfk.84.2018.08.24.20.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 20:51:37 -0700 (PDT)
From:   Jacek Tomaka <jacekt@dugeo.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Jacek Tomaka <jacekt@dugeo.com>,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: [PATCH] x86/microcode: allow non-root reading of microcode version and processor flags
Date:   Sat, 25 Aug 2018 11:50:39 +0800
Message-Id: <20180825035039.14409-1-jacekt@dugeo.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/devices/system/cpu/cpuX/microcode

Before:
-r-------- processor_flags
-r-------- version

After:
-r--r--r-- processor_flags
-r--r--r-- version

Microcode version has been already readable for non root users via
/proc/cpuinfo. However it is easier to access it from
/sys/devices/system/cpu/cpuX/microcode/version

Reported-by: Tim Burgess <timb@dug.com>
Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
---
 arch/x86/kernel/cpu/microcode/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b9bc8a1a58..2637ff09d6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -666,8 +666,8 @@ static ssize_t pf_show(struct device *dev,
 }
 
 static DEVICE_ATTR_WO(reload);
-static DEVICE_ATTR(version, 0400, version_show, NULL);
-static DEVICE_ATTR(processor_flags, 0400, pf_show, NULL);
+static DEVICE_ATTR(version, 0444, version_show, NULL);
+static DEVICE_ATTR(processor_flags, 0444, pf_show, NULL);
 
 static struct attribute *mc_default_attrs[] = {
 	&dev_attr_version.attr,
-- 
2.17.0

