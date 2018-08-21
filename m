Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B141C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0087216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmZtHcMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0087216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeHURAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:00:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:00:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so1463763wro.11;
        Tue, 21 Aug 2018 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7PiNML7maVowlUH2fnbuxecTby3TNLFvD0QPEu/CL+Q=;
        b=CmZtHcMx/0U+NbHa1mkNfIgbvGjUeT1O+0lUsNwdXhwtnPSAg+g1mGdoYU1IdwCaMX
         nHFdMoFGIUVe1E/3w0dflMEw/cQ7iKuTB7w7C8c53HENjSHFcISTzjRhVjAYpGZ4t3r9
         Wc+/xE3fNf1akXN83nRqpHiqCEZQDYQONIfNdgmriVVBAqPVf0h8usFvRtf2BTk7/HwJ
         q4R/9mSXByb+VNbIGV0b8hsyDjQr3Ro+yinHR+HCx/KlJtN+Ano69mlJ83/+ivYYkYdY
         ImCA/nU7up9xeqO4x3YiBH4t9FOCcLU4ckV0nCsycb2Y/j16Q7/XDsVooFfeE1aTQ3Du
         ibBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7PiNML7maVowlUH2fnbuxecTby3TNLFvD0QPEu/CL+Q=;
        b=ZFa9jVuHqJ0tIKfgWGYdt18MnZs9ZLv7oU8CZZnHr8WC06+9jQrcGcT8mAv091wuk4
         fZy1NbhHroLnBR6VdThomIyl9xzt404hlD+wdLPoaYQixtwC33G5RECc6DiAvOBQhtXN
         jTuSdrPODm+fM0f6XiOUienVHP5B72/KIdyrsfsUVFXi1cV8h4QOdCEUgUxvU9p5QQer
         2wuHhWJSpGQGLcLT39vPjboIvd3qVEQ37/wVXupIuREHXlfGV0XgTStO7zGhNYI181I+
         6H3N1yKczbBOF6aGrfVeEYgRF8gp3mciysr4AxhZJX0tYMrlbXZ4uFZ/Emm9aTa570Xa
         BjXA==
X-Gm-Message-State: AOUpUlFaoQ86dJVR0el0hMNWximNV2YfySjII6w8tYYUyuAqg2aDeXik
        pC1+eek/S2gR6YyoqxC+XCw=
X-Google-Smtp-Source: AA+uWPytFIvq/y8lXRTv5QmIPzVbhUVe7NfEpU4wl1QCI0ecgMM9qhX9xze3tNUO4rSGmxVpSlO8Sg==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr32254558wrv.102.1534858834198;
        Tue, 21 Aug 2018 06:40:34 -0700 (PDT)
Received: from K55DR ([86.57.255.94])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5525704wmf.47.2018.08.21.06.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 06:40:33 -0700 (PDT)
Date:   Tue, 21 Aug 2018 16:40:30 +0300
From:   Alexander Pateenok <pateenoc@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] percpu: cleanup PER_CPU_DEF_ATTRIBUTES macro
Message-ID: <20180821134030.lycgq7l7czetdngs@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro is not used:

  $ grep -r PER_CPU_DEF_ATTRIBUTES
  include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak		\
  include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES		\
  include/asm-generic/percpu.h:#ifndef PER_CPU_DEF_ATTRIBUTES
  include/asm-generic/percpu.h:#define PER_CPU_DEF_ATTRIBUTES

It was added with b01e8dc34379 ("alpha: fix percpu build breakage") and
removed in 2009 with b01e8dc34379..6088464cf1ae.

Signed-off-by: Alexander Pateenok <pateenoc@gmail.com>
---
 include/asm-generic/percpu.h | 4 ----
 include/linux/percpu-defs.h  | 6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 1817a8415a5e..c2de013b2cf4 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -62,10 +62,6 @@ extern void setup_per_cpu_areas(void);
 #define PER_CPU_ATTRIBUTES
 #endif
 
-#ifndef PER_CPU_DEF_ATTRIBUTES
-#define PER_CPU_DEF_ATTRIBUTES
-#endif
-
 #define raw_cpu_generic_read(pcp)					\
 ({									\
 	*raw_cpu_ptr(&(pcp));						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 2d2096ba1cfe..1ce8e264a269 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -91,8 +91,7 @@
 	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
 	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
 	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
-	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
-	__typeof__(type) name
+	__PCPU_ATTRS(sec) __weak __typeof__(type) name
 #else
 /*
  * Normal declaration and definition macros.
@@ -101,8 +100,7 @@
 	extern __PCPU_ATTRS(sec) __typeof__(type) name
 
 #define DEFINE_PER_CPU_SECTION(type, name, sec)				\
-	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES			\
-	__typeof__(type) name
+	__PCPU_ATTRS(sec) __typeof__(type) name
 #endif
 
 /*
-- 
2.17.1

