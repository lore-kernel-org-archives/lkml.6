Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E03206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392449AbfAPMKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:10:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbfAPMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:10:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GC9sAh257345
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 04:09:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GC9rur257342;
        Wed, 16 Jan 2019 04:09:53 -0800
Date:   Wed, 16 Jan 2019 04:09:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-2bc217c61685487987c5befd807e10936371643c@git.kernel.org>
Cc:     nstange@suse.de, mingo@kernel.org, gustavo@embeddedor.com,
        mingo@redhat.com, peterz@infradead.org, colin.king@canonical.com,
        rvarsha016@gmail.com, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de,
        keescook@chromium.org, hpa@zytor.com, abanman@hpe.com
Reply-To: colin.king@canonical.com, peterz@infradead.org, mingo@redhat.com,
          nstange@suse.de, gustavo@embeddedor.com, mingo@kernel.org,
          tglx@linutronix.de, bp@suse.de, hpa@zytor.com, abanman@hpe.com,
          keescook@chromium.org, x86@kernel.org, luto@kernel.org,
          rvarsha016@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190115173713.GA31031@embeddedor>
References: <20190115173713.GA31031@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/platform/UV: Replace kmalloc() and memset()
 with k[cz]alloc() calls
Git-Commit-ID: 2bc217c61685487987c5befd807e10936371643c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2bc217c61685487987c5befd807e10936371643c
Gitweb:     https://git.kernel.org/tip/2bc217c61685487987c5befd807e10936371643c
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Tue, 15 Jan 2019 11:37:13 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 13:01:26 +0100

x86/platform/UV: Replace kmalloc() and memset() with k[cz]alloc() calls

Replace kmalloc_node() and memset() with kzalloc_node(), and
kmalloc_array() and memset() with kcalloc().

This code was detected with the help of Coccinelle.

No functional changes.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Andrew Banman <abanman@hpe.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Varsha Rao <rvarsha016@gmail.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190115173713.GA31031@embeddedor
---
 arch/x86/platform/uv/tlb_uv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index a4130b84d1ff..2c53b0f19329 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2010,8 +2010,7 @@ static void make_per_cpu_thp(struct bau_control *smaster)
 	int cpu;
 	size_t hpsz = sizeof(struct hub_and_pnode) * num_possible_cpus();
 
-	smaster->thp = kmalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
-	memset(smaster->thp, 0, hpsz);
+	smaster->thp = kzalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
 	for_each_present_cpu(cpu) {
 		smaster->thp[cpu].pnode = uv_cpu_hub_info(cpu)->pnode;
 		smaster->thp[cpu].uvhub = uv_cpu_hub_info(cpu)->numa_blade_id;
@@ -2135,15 +2134,12 @@ static int __init summarize_uvhub_sockets(int nuvhubs,
 static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 {
 	unsigned char *uvhub_mask;
-	void *vp;
 	struct uvhub_desc *uvhub_descs;
 
 	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
 		timeout_us = calculate_destination_timeout();
 
-	vp = kmalloc_array(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
-	uvhub_descs = (struct uvhub_desc *)vp;
-	memset(uvhub_descs, 0, nuvhubs * sizeof(struct uvhub_desc));
+	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
 	uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
 
 	if (get_cpu_topology(base_part_pnode, uvhub_descs, uvhub_mask))
