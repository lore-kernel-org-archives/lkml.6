Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2EFECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FCF208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urtRXWaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FCF208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeGNIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:50:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40783 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeGNIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:50:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so5741915pgp.7;
        Sat, 14 Jul 2018 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Akf5sLt8347RHVY+scAnPDa1ovmW923VlqnFnICc500=;
        b=urtRXWaM4QG2OkH5hzq0uiTLDIL43VY6FuA6MHz191bAZLEF8HbzrtRkY0Gas3f9ck
         w/jWZ+GaX/B51oJO5hHpZLv4Pj0+kUv6yEVKaSOLy3HH20P3TMuHpr0Mm+/o7CYhWiGT
         CKPoxvD/wyDqZVOcWTRMk8DPwux9wuP62FY/L0ERhebYDM/RuQqNVVBleUFBdYjrb7tv
         ip/xzq2VEBHcjHjSq3kwYT7XXBRKGMdvtgOXyDk7oTyeciEvMvfWk7L4Vx4eBO+3OuAl
         zzmRM8vYTNQEYtyDVGnJo5Rne+5Lgz2bR+V+T+b3Xter3mZ69VkP9n8/kx99+gWnAqrk
         q/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Akf5sLt8347RHVY+scAnPDa1ovmW923VlqnFnICc500=;
        b=WYdxOVmED2cre/0Fu8QQAnWDCbRxXyBn+NJLgBepYg6poTUJAVAs9fJl7PGUWfyuAA
         c4VSOwWF28d22fUtvpPLLXTPnivtI+ptFTVe7z9nIjANl6Ru/B/2lbZPQsEMefTEqZl6
         epaWzvuNaI9VUDNCtQoEWRYzGPwgEIhrSGu9ZhpeKxB2rOhk5QWKQRpfvfVhqaQwUhBd
         h9mjJkZzHwDcc/aH7erMvhn/ydhs55+1LfCkUZngUSqkEF4vSGZJkU4Dnf5VB2xvgj0p
         BLS+kDm0yxumtYb2npUZAeEYXZbLaWlqEsMUt/PDjbJ1FxAHdWVDgo7cJ1UIHmjFZ0KZ
         jdzg==
X-Gm-Message-State: AOUpUlFvwzzGRLA+CugN4gcpJH/xr7r2V9i2b52TzGoAAyBwEMuFFB8b
        nNXRfOX0poqLIx3QQplMpAU=
X-Google-Smtp-Source: AAOMgpdAyim9LB1p4hOeqe25oh965zFusovkUP8fS/LiwLWWVpWvog8Zo7sgE0OnNspA7+UOJ9DY8g==
X-Received: by 2002:a63:8548:: with SMTP id u69-v6mr8838683pgd.346.1531557150620;
        Sat, 14 Jul 2018 01:32:30 -0700 (PDT)
Received: from bogon.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id w16-v6sm83219857pfi.101.2018.07.14.01.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 01:32:29 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
Date:   Sat, 14 Jul 2018 16:32:02 +0800
Message-Id: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_charge maybe executed in packet receive path, which is in interrupt
context.
In this situation, the 'current' is the interrupted task, which may has
no relation to the rx softirq, So it is nonsense to use 'current'.

Avoid bothering the interrupted if page_counter_try_charge failes.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 68ef266..13f95db 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2123,6 +2123,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 
+	if (in_softirq())
+		goto nomem;
+
 	/*
 	 * Unlike in global OOM situations, memcg is not in a physical
 	 * memory shortage.  Allow dying and OOM-killed tasks to
-- 
1.8.3.1

