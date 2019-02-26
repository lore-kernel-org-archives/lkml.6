Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5385C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DE42186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162039;
	bh=T3P/KbwFo9CBiubDajShCjn4XyI/14yoXrtREVd1WFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=tI2Z1gKO2294p8heziicrergaFmR5JIcDQNsFvvUXBtuiC8QgnF9/DCtAZRKdKgiz
	 InKMk8AXsW1yLAGVV629lTqJrFHyK0tKwulPNvmoL2CW0VifmQ520ytBXjvxCewH5A
	 dPqbXNgWRhlRzr6i/zIBIV6HdeSCwtXy+ktCDzXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBZGUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:37 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:32948 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBZGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:30 -0500
Received: by mail-it1-f196.google.com with SMTP id f186so1684820ita.0;
        Mon, 25 Feb 2019 22:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=Vv/7YZAxVP9GnQsOcnEiLXYpYJWDZw4VRmaikYyUm9s=;
        b=nql3JDxbAOIjR8jekTx0YwfOVdNl/o4D2Qw5QRMzfu9DwRBy3Rb3+DE9VSbSzGEFav
         PgcPOwjoVLceyw1/6r10tginnYxkge82VpIX0VCAwXrPoF+99R8FdpVTQuRZZX2F2GVr
         P4JNtVSAb6Y9gKRAHfJ1cmLMfyPRobcbomvYKpgJh4jDFd9WObWz6zrNWXr7CBwZ0feC
         mNZayQ/76F809syvFP1wRmrNEa3uLA1XWBRkohhKKAnBych8FeVzBRxfpEtoLJAmxnBS
         Vb9Wqt0M6kvFglBVAHvErrtbfLuADNXik9KPBN8B/rhWdr4hINVusWS/F/u6P/48hGZX
         HPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=Vv/7YZAxVP9GnQsOcnEiLXYpYJWDZw4VRmaikYyUm9s=;
        b=C/95Rjp9+P5t2tHj4oKwW6U+gthuXZZ0QcEAqIT3ZFqF+QVuucF2aacjH7N98iVa2q
         ojLinZGw41FIexFiZ50jXZYb7jiSeg0hSjltlZjqjdKStw1lQPp41hPtvzQPWePZVe+v
         GmM7B3gSiJZKsjq0bNiGsoYxwnXQ4Tu72mFPKZe/RgsaM9ezHNy2/1k9foKAXfGjBli1
         u5Jq5M3L9x21vrdy75WjDDs2whPwziKVNGOnWPKUsg765qhSu6AK1vJ97pUfUqjZoy5L
         RwI/b/h13TDS21G+humyYH2GNxuf+FdV1uhZxV9VdQ4ApiIjsg5FEnNV5i2ooImMSuFb
         gUeA==
X-Gm-Message-State: AHQUAub5Q4f8SEALCZDX6/8/eqs5IMLahKgbDAJYQ725gNo74PHsnTNx
        vEiTSimS2JiRkxa5OcWvRAM=
X-Google-Smtp-Source: APXvYqzsDGAK07YdLHitz/V+7AcmgFwa0l1DHNiybHJ9hhdqFbTL7cS62A7sPmXhl022nBpB+5ODEg==
X-Received: by 2002:a24:d4c1:: with SMTP id x184mr1439850itg.174.1551162028869;
        Mon, 25 Feb 2019 22:20:28 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:28 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 05/14] cpu topology: Export die_id
Date:   Tue, 26 Feb 2019 01:20:03 -0500
Message-Id: <43f15c3d7b5e0fd7e3f257d4c0736200f6198971.1551160674.git.len.brown@intel.com>
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

Export die_id in cpu topology, for the benefit of hardware that
has multiple-die/package.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/cputopology.txt   | 6 ++++++
 arch/x86/include/asm/topology.h | 1 +
 drivers/base/topology.c         | 4 ++++
 include/linux/topology.h        | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index cb61277e2308..4e6be7f68fd8 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -12,6 +12,12 @@ physical_package_id:
 	socket number, but the actual value is architecture and platform
 	dependent.
 
+die_id:
+
+	the CPU die ID of cpuX. Typically it is the hardware platform's
+	identifier (rather than the kernel's).  The actual value is
+	architecture and platform dependent.
+
 core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 453cf38a1c33..281be6bbc80d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 5fd9f167ecc1..50352cf96f85 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -43,6 +43,9 @@ static ssize_t name##_list_show(struct device *dev,			\
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
+define_id_show_func(die_id);
+static DEVICE_ATTR_RO(die_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
@@ -72,6 +75,7 @@ static DEVICE_ATTR_RO(drawer_siblings_list);
 
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
+	&dev_attr_die_id.attr,
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..5cc8595dd0e4 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -184,6 +184,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
+#ifndef topology_die_id
+#define topology_die_id(cpu)			((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
-- 
2.18.0-rc0

