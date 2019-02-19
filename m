Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E58C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7654321773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547671;
	bh=RBM5/xQRxiFOVruPqB03oLBGDT8e3c+3Mzx6GWoGcA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=OG8rCVLw/GWL2F2KoH6mgoG839alJhpHXp4P+bEaOPxfyXhLNpBtqa8SmAPTU2Dkg
	 zW9rumWaQD0hZIbbxdgbZp6+TgN9WHaBRWGu2Eef+khVf2gmaSKU1wey/uxrjD8uQ1
	 SYix9/gVSdDvdJSt/gdF9EJV7zRlePgOcYstgPQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfBSDlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:41:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38190 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfBSDkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so21644894qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=AE0sgzP6cJhHhsJWS+EYDFC7yviblKK4ktbj0HfAd0E=;
        b=inAViFSQwLbTEht7WklQYZTF526JNgh71kVcVszMF7A5Tp3u7v1k6ruHPY4mVW8aRE
         W4ViHKEk9TcCcP0WsuZgMqIKYOZQiyugPDckiwvAbxN7wzjpAb48EUguVJqi+agN26Ns
         K2pGDYJMP4LV/EW12k1G41KeeAJZ+eN/p4yLxlr+JHnQJTqn6bfzDNY358cIoqwkyxYP
         Vw/V1h2iIu8UPXPp04UNp+YlE79L3aHg/zLyBroX3JZ+wAitATIg1fOkz1Si5eTYILt8
         2KtTJ69yQnw+grxQ5ZIu3XDbmipqUge0ZYPJs3zqlv64a+mdn5qASvzyNQuHBr+Pisyi
         9KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=AE0sgzP6cJhHhsJWS+EYDFC7yviblKK4ktbj0HfAd0E=;
        b=m3+toui8KcBzTPInuVchnUu+nJi/Plp1ewY2ioLLjULxdUx5qiPsMbLmJkk7pGgiOB
         XHwo0t5GE7SB7NIqi5fOMwRkrjYEtmfN4lxk4MTbIXraLiRW+On5p8JGsjChJ6N9yRh9
         MqBwkkjWRrL0RxyGzTnSNVWGCByS3+hAFxVzThBmf304qH9QvR5C7vOnMzjYCn0WVlGt
         i3AJEbANxaUfxU8+NQK+VJ60Jlipp3WRuB2vaM9OllclY+LPSBn1jKamVGCKdcAaTC0v
         W2vtol6AX4OjBeksljVwOd8ZoWvbmhGfUPcYmtL0+mTabKQ+jHkbfGrOhZ8pTnJDyOFt
         MHsQ==
X-Gm-Message-State: AHQUAubm7CXO6TkYFO2rst8NxcrNX0f1n2HJ2S9/z9Txki/V3mmU4dj7
        zQV6mgx8uRnPTfF2FJBfM6rLcsIE
X-Google-Smtp-Source: AHgI3IYMBGx3VkJMym3GlhoPIoBCDVPs2pw6ehQAcGnNtcw4uwp6AuQ8XScvYBDQLIpgMtGuR8m6Wg==
X-Received: by 2002:aed:3bb3:: with SMTP id r48mr21541630qte.278.1550547630236;
        Mon, 18 Feb 2019 19:40:30 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:29 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 06/11] x86 topology: define topology_unique_die_id()
Date:   Mon, 18 Feb 2019 22:40:08 -0500
Message-Id: <270dd0e65f746e97669d9c3b89dfc56e5523e026.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The topology_unique_die_id() helper calculates a unique system-wide die-id,
for the benefit of multi-die per-package systems.

This simple system-wide unique number within known bounds is sufficient.
No need for the overhead of generating a global consecutive "logical" id.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index a52a572147ba..12444a1a30f3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,9 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_unique_die_id(cpu)	((cpu_data(cpu).logical_proc_id * \
+					 cpu_data(cpu).x86_max_dies) + \
+					 cpu_data(cpu).cpu_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
-- 
2.18.0-rc0

