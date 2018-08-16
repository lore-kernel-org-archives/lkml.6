Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD076C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AD5214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEIO8UjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AD5214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbeHPMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:21:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44140 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeHPMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:21:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id g6-v6so2888134lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MlEs7Lrjj+jD7q/cIKJizBRpruSZ1cojNxLU/jWmUJs=;
        b=VEIO8UjWnuKafq+bokF8XJ0SnaAmTUzRqR4n4EmKG1Isf1gGdbsTjv1UWGiPuLAFjK
         hqzPqKxdVvCnG3PFo2ykRLB2Q7J9SzAf1s3fcU90b/ZtH8vuv/r5ViUWDNdVQYfBFRts
         4rJh7MkBN78lagt9olP+FaO+7oqwAiyOI/24fde0ag6nSf8nBB2tQOA+uuwIxJxiz5iK
         HOFvHjplfdLtVBQJ1PP2XlsRzlITf/seo18XW83SOBj8Icj02VdzY0/1HpH6k9k+Yr4S
         fRrs890BsXFFffdQmcqPSo/5LWSrxZNs1J/m6z8nD96b0GvsvnDnklciT2E6KsjrzeP3
         0f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MlEs7Lrjj+jD7q/cIKJizBRpruSZ1cojNxLU/jWmUJs=;
        b=ZDFWtQhbft0hzVUIuN2FE8BoDvq1TJRVdwdxQaaZ22YVXp1HNGUjUHa1FlI7itqIoE
         yxoX766S+bEI9Uaj+i4Kv97J8KhJGx70nkQ5of2zhsZA780Miy8RdGOmU24UXXPFGUEt
         kLk6iK9+BqTOe9xJZC9aA7PHFjQHold/IdZai6LkZX2j+ACYBWeaYGU6jG4XKuENFl13
         OHqcKKJl1S3VTPVHgVflAPR8Na/061omm5yNo61b7rtNSlVSmxxQuQZrpbd0mH7IKYT7
         zxPevV7PMDKrNPWL5P0azQGlLao355gkdaAcY6VcnDvRagABVUCOpEprR2ex4kBANTAz
         m0Ig==
X-Gm-Message-State: AOUpUlGg7xUyILGZgZ7WBckFouqIlKFDXNcb5RppKf/0a2MtLBS/5nWg
        EQTiQBuSVx4fRVfDYUazTAcZ/LXl8Lw=
X-Google-Smtp-Source: AA+uWPz4imXfnbXtuVnZLx7DWRoW8l7f0SZmVwSF5idV5fFWxnnPL7QmuHXuyedXXSiSTZffW2dLPQ==
X-Received: by 2002:a19:6801:: with SMTP id d1-v6mr18559286lfc.8.1534411470875;
        Thu, 16 Aug 2018 02:24:30 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z10-v6sm4276323ljh.57.2018.08.16.02.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:24:29 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 811B1460B3D; Thu, 16 Aug 2018 12:24:29 +0300 (MSK)
Date:   Thu, 16 Aug 2018 12:24:29 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Vagin <avagin@virtuozzo.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [linux-next] Kernel panic while tetsing criu
Message-ID: <20180816092429.GV10406@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric! We're regularly running criu on linux-next and today
kernel get panicing.
---
[  753.478579] BUG: unable to handle kernel NULL pointer dereference at 00000000000006a8
[  753.479674] PGD 800000011215f067 P4D 800000011215f067 PUD 1134a8067 PMD 0
[  753.480590] Oops: 0000 [#1] SMP PTI
[  753.481054] CPU: 0 PID: 32493 Comm: file_fown Not tainted 4.18.0-next-20180815-00001-g1532db2f419f-dirty #2
[  753.482329] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[  753.484096] RIP: 0010:send_sigio_to_task+0x81/0x2c0
[  753.484792] Code: b9 02 00 00 00 31 f6 48 c7 c7 60 35 46 b2 e8 46 9c e3 ff e8 71 94 e5 ff 5a 85 c0 74 0d 80 3d 1e 26 2b 01 00 0f 84 cc 01 00 00 <4d> 8b b4 24 a8 06 00 00 e8 52 94 e5 ff 85 c0 74 0d 80 3d fe 25 2b
[  753.487383] RSP: 0018:ffffbd8440f5bcc0 EFLAGS: 00010202
[  753.488128] RAX: 0000000000000001 RBX: ffff99a75224f7c8 RCX: 00000000133c1702
[  753.489166] RDX: ffffffffb12bd995 RSI: 00000000d1f2807e RDI: 0000000000000246
[  753.490184] RBP: ffffbd8440f5bd78 R08: 0000000000000001 R09: 0000000000000000
[  753.491204] R10: ffffffffb2463560 R11: 0000000000000000 R12: 0000000000000000
[  753.492249] R13: 0000000000000002 R14: 0000000000000005 R15: 0000000000000001
[  753.493273] FS:  00007f01488d04c0(0000) GS:ffff99a77ba00000(0000) knlGS:0000000000000000
[  753.494423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  753.495244] CR2: 00000000000006a8 CR3: 00000001327b8004 CR4: 00000000003606f0
[  753.496251] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  753.497269] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  753.498276] Call Trace:
[  753.498653]  ? __lock_is_held+0x4f/0x90
[  753.499198]  send_sigio+0x137/0x1c0
[  753.499701]  kill_fasync+0xdd/0x210
[  753.500208]  pipe_read+0x165/0x310
[  753.500703]  __vfs_read+0x133/0x190
[  753.501201]  vfs_read+0x9c/0x150
[  753.501764]  ksys_read+0x52/0xc0
[  753.502229]  do_syscall_64+0x60/0x210
[  753.502756]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  753.503474] RIP: 0033:0x7f01483f5701
[  753.504012] Code: fe ff ff 48 8d 3d af 8f 09 00 48 83 ec 08 e8 96 fe 01 00 66 0f 1f 44 00 00 8b 05 4a f1 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
[  753.506667] RSP: 002b:00007ffdbb2d2878 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  753.507737] RAX: ffffffffffffffda RBX: 0000000000000025 RCX: 00007f01483f5701
[  753.508733] RDX: 000000000000001c RSI: 00007ffdbb2d28a0 RDI: 0000000000000004
[  753.509714] RBP: 00000000004043f0 R08: 0000000000000000 R09: 0000000000000000
[  753.510696] R10: 000000000000038b R11: 0000000000000246 R12: 0000000000000000
[  753.511677] R13: 00007ffdbb2d2a70 R14: 0000000000000000 R15: 0000000000000000
[  753.512662] Modules linked in:
[  753.513095] CR2: 00000000000006a8
[  753.513579] ---[ end trace 2d68e222d9dac4c3 ]---

we suspect it might be due to commit 9c2db007787ef1aac6728c5e03d37b0ae935d122
because oneliner

diff --git a/fs/fcntl.c b/fs/fcntl.c
index a04accf6847f..20e4daf83aab 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -791,6 +791,8 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
       if (type <= PIDTYPE_TGID) {
               rcu_read_lock();
               p = pid_task(pid, PIDTYPE_PID);
+               if (!p)
+                       goto out_unlock_fown;
               send_sigio_to_task(p, fown, fd, band, type);
               rcu_read_unlock();
       } else {

has helped.

Could you please take a look once time permit?

p.s. Andrew noticed the problem and asked me to notify,
also he has been testing this oneliner patch. I'm out
of sources at the moment but I think Andrew will help
to test if needed.

	Cyrill
