Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C577DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CAC2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ZcMcFokG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CAC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeKCF1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:27:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36462 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKCF1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:27:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so1495794plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bP2x2zVsvfjw0qkW5omW5BZjw64Liy5vlcdMEPN9GhQ=;
        b=ZcMcFokG9D8fUSa/kB1Sssspp5FAux5wKlt4l0FYeOfERK8ofDlGQYzRZpzdDwKfeh
         xnGEEoAVZ6uEzsJJrGeW8XSKG/qc3uq3MX22XdYvJWib8hzXKRWc60IOcYAL9SsYzXBi
         EsIvXnNt0/k9Ra/OjXZPhNIK88AA5imY0QwVS3M4P1Rg9a1+NpZW0wvWpHueUNufdtdo
         G85lI9grZUUjicOcy/fbL65zZ5AWKvuihhcEozoAos7RGhdeOwTAcaybCyBY78nDIEEk
         il2S5ljQU5rDLy5nzN31dpxmx9cky50HZwuiRpW5th1rbUhdrCOFno64pRwP5JXVdfCR
         /IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bP2x2zVsvfjw0qkW5omW5BZjw64Liy5vlcdMEPN9GhQ=;
        b=RznVUSo1Wn0pe3k9WBrsGiEK/mu3xGX3siAKEH6HQifn0yqESCHUyfH9YMe6mXG4kP
         0eq+XF7Vflp3Pjpn8uQt1yROQ5OZySlCapMthaDdbXyWxvfukxEKYfXvrS4ohb7VdZ0Q
         GNwcHxAcvgZyzGh291QuLz+DvDuX/n7j76f8sRDMo5kRzObQL42ug4TkNsso2B2gweEt
         vR+y2rK441DfmNux23jdKiOSUsGYOwUc59urY2kXptboT+O1uaPMHueOD29eTGmh2pdp
         x14uWcBgNjO78pI4UF1H+3u2q1vKhidPMgXjU39xbod8pg8sWUSx9mibUgFiE21aW+cS
         35Og==
X-Gm-Message-State: AGRZ1gIwExUnosO9fYqgrpEBA0eIHvMi0dIInlLteLYHGcm8303Jg9vP
        BkWAKZKUOzOAd30E1AhnpD6TKg==
X-Google-Smtp-Source: AJdET5cb+E7VJYr8eEb/iMCew4qqof3v3bRRshsAZnHPEs0MBt35UBkokDm93HYNCPc2KJUNAxTlXA==
X-Received: by 2002:a17:902:758f:: with SMTP id j15-v6mr13327240pll.160.1541189915882;
        Fri, 02 Nov 2018 13:18:35 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.162])
        by smtp.gmail.com with ESMTPSA id h62-v6sm26641676pfg.27.2018.11.02.13.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:18:34 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 2/3] dlm: don't allow zero length names
Date:   Fri,  2 Nov 2018 14:18:21 -0600
Message-Id: <20181102201822.12518-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102201822.12518-1-tycho@tycho.ws>
References: <20181102201822.12518-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject doesn't like zero length object names, so let's test for that.

Nov  2 19:48:14 dlm kernel: [   20.548713] ------------[ cut here ]------------
Nov  2 19:48:14 dlm kernel: [   20.548717] kobject: ((____ptrval____)): attempted to be registered with empty name!
Nov  2 19:48:14 dlm kernel: [   20.548747] WARNING: CPU: 2 PID: 1368 at lib/kobject.c:228 kobject_add_internal+0x689/0x800
Nov  2 19:48:14 dlm kernel: [   20.548750] Modules linked in: fuse
Nov  2 19:48:14 dlm kernel: [   20.548758] CPU: 2 PID: 1368 Comm: dlm Not tainted 4.19.0+ #36
Nov  2 19:48:14 dlm kernel: [   20.548762] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Nov  2 19:48:14 dlm kernel: [   20.548767] RIP: 0010:kobject_add_internal+0x689/0x800
Nov  2 19:48:14 dlm kernel: [   20.548771] Code: ff 48 89 df e8 d8 ec fd fe e9 fb f9 ff ff 48 89 df e8 fb ec fd fe e9 7b fa ff ff 4c 89 fe 48 c7 c7 00 e6 ed 82 e8 97 a8 b4 fe <0f> 0b bb ea ff ff ff e9 fb fb ff ff bb fe ff ff ff e9 f1 fb ff ff
Nov  2 19:48:14 dlm kernel: [   20.548775] RSP: 0018:ffff88011441f988 EFLAGS: 00010282
Nov  2 19:48:14 dlm kernel: [   20.548779] RAX: 0000000000000000 RBX: ffff880113d36600 RCX: ffffffff813c4a70
Nov  2 19:48:14 dlm kernel: [   20.548783] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88011612e770
Nov  2 19:48:14 dlm kernel: [   20.548786] RBP: ffff88011441faa8 R08: ffffed0022c25cef R09: ffffed0022c25cef
Nov  2 19:48:14 dlm kernel: [   20.548790] R10: 0000000000000001 R11: ffffed0022c25cee R12: 1ffff10022883f3d
Nov  2 19:48:14 dlm kernel: [   20.548793] R13: ffffffff82d005c0 R14: 0000000000000000 R15: ffff880112d78040
Nov  2 19:48:14 dlm kernel: [   20.548797] FS:  00007f441ba404c0(0000) GS:ffff880116100000(0000) knlGS:0000000000000000
Nov  2 19:48:14 dlm kernel: [   20.548801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov  2 19:48:14 dlm kernel: [   20.548804] CR2: 00007f441b53ebb0 CR3: 00000001103c0000 CR4: 00000000000006e0
Nov  2 19:48:14 dlm kernel: [   20.548810] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Nov  2 19:48:14 dlm kernel: [   20.548814] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Nov  2 19:48:14 dlm kernel: [   20.548817] Call Trace:
Nov  2 19:48:14 dlm kernel: [   20.548833]  kobject_init_and_add+0xe4/0x140
Nov  2 19:48:14 dlm kernel: [   20.548840]  ? kset_create_and_add+0x150/0x150
Nov  2 19:48:14 dlm kernel: [   20.548845]  ? printk+0x97/0xbe
Nov  2 19:48:14 dlm kernel: [   20.548859]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
Nov  2 19:48:14 dlm kernel: [   20.548874]  dlm_new_lockspace+0x1766/0x1df0
Nov  2 19:48:14 dlm kernel: [   20.548893]  ? dlm_put_lockspace+0x50/0x50
Nov  2 19:48:14 dlm kernel: [   20.548901]  ? wait_woken+0x260/0x260
Nov  2 19:48:14 dlm kernel: [   20.548913]  ? security_capable+0x4f/0x90
Nov  2 19:48:14 dlm kernel: [   20.548924]  device_write+0xb57/0x1bb0
Nov  2 19:48:14 dlm kernel: [   20.548935]  ? device_read+0xa60/0xa60
Nov  2 19:48:14 dlm kernel: [   20.548941]  ? __kasan_slab_free+0x12e/0x180
Nov  2 19:48:14 dlm kernel: [   20.548945]  ? kmem_cache_free+0xb9/0x2e0
Nov  2 19:48:14 dlm kernel: [   20.548949]  ? do_sys_open+0x182/0x340
Nov  2 19:48:14 dlm kernel: [   20.548954]  ? do_syscall_64+0x90/0x3e0
Nov  2 19:48:14 dlm kernel: [   20.548959]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
Nov  2 19:48:14 dlm kernel: [   20.548967]  ? debug_show_all_locks+0x2d0/0x2d0
Nov  2 19:48:14 dlm kernel: [   20.548979]  __vfs_write+0xd3/0x5c0
Nov  2 19:48:14 dlm kernel: [   20.548984]  ? kernel_read+0x130/0x130
Nov  2 19:48:14 dlm kernel: [   20.548987]  ? find_held_lock+0x32/0x1c0
Nov  2 19:48:14 dlm kernel: [   20.548993]  ? find_held_lock+0x32/0x1c0
Nov  2 19:48:14 dlm kernel: [   20.549001]  ? quarantine_put+0x8e/0x150
Nov  2 19:48:14 dlm kernel: [   20.549009]  ? do_sys_open+0x182/0x340
Nov  2 19:48:14 dlm kernel: [   20.549015]  vfs_write+0x157/0x4a0
Nov  2 19:48:14 dlm kernel: [   20.549021]  ksys_write+0xb3/0x180
Nov  2 19:48:14 dlm kernel: [   20.549026]  ? __ia32_sys_read+0xa0/0xa0
Nov  2 19:48:14 dlm kernel: [   20.549028]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
Nov  2 19:48:14 dlm kernel: [   20.549033]  ? trace_hardirqs_off_caller+0x5b/0x160
Nov  2 19:48:14 dlm kernel: [   20.549038]  ? do_syscall_64+0x13/0x3e0
Nov  2 19:48:14 dlm kernel: [   20.549044]  do_syscall_64+0x90/0x3e0
Nov  2 19:48:14 dlm kernel: [   20.549049]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
Nov  2 19:48:14 dlm kernel: [   20.549052] RIP: 0033:0x7f441b53f154
Nov  2 19:48:14 dlm kernel: [   20.549055] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 b1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
Nov  2 19:48:14 dlm kernel: [   20.549057] RSP: 002b:00007ffefadc1e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Nov  2 19:48:14 dlm kernel: [   20.549061] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f441b53f154
Nov  2 19:48:14 dlm kernel: [   20.549063] RDX: 000000000000007c RSI: 00007ffefadc1f30 RDI: 0000000000000003
Nov  2 19:48:14 dlm kernel: [   20.549065] RBP: 00007ffefadc1fc0 R08: 0000000000000004 R09: 0000000000000000
Nov  2 19:48:14 dlm kernel: [   20.549067] R10: 0000000000000000 R11: 0000000000000246 R12: 000055817bf3f760
Nov  2 19:48:14 dlm kernel: [   20.549069] R13: 00007ffefadc20a0 R14: 0000000000000000 R15: 0000000000000000
Nov  2 19:48:14 dlm kernel: [   20.549082] irq event stamp: 3866
Nov  2 19:48:14 dlm kernel: [   20.549086] hardirqs last  enabled at (3865): [<ffffffff8124d00d>] console_unlock+0x55d/0xa90
Nov  2 19:48:14 dlm kernel: [   20.549089] hardirqs last disabled at (3866): [<ffffffff8100364b>] trace_hardirqs_off_thunk+0x1a/0x1c
Nov  2 19:48:14 dlm kernel: [   20.549092] softirqs last  enabled at (3838): [<ffffffff82a004a9>] __do_softirq+0x4a9/0x8fb
Nov  2 19:48:14 dlm kernel: [   20.549095] softirqs last disabled at (3761): [<ffffffff8112c9c1>] irq_exit+0x1a1/0x1d0
Nov  2 19:48:14 dlm kernel: [   20.549097] ---[ end trace 56e315ac4368655c ]---

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 fs/dlm/lockspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 5ba94be006ee..7b9d47fe7a34 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -431,7 +431,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	int do_unreg = 0;
 	int namelen = strlen(name);
 
-	if (namelen > DLM_LOCKSPACE_LEN)
+	if (namelen > DLM_LOCKSPACE_LEN || namelen == 0)
 		return -EINVAL;
 
 	if (!lvblen || (lvblen % 8))
-- 
2.17.1

