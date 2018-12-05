Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC52BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E0C2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s822GVhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E0C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeLEM5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38388 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so9976306pfi.5;
        Wed, 05 Dec 2018 04:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uAJuZiZwKxXMhoL0sPJE/tx/l47j9wBuA1dXpeacqNA=;
        b=s822GVhj4pFbfaAOqUNQx2aQ7GmiMcDDnnL7eedMXOeMQpmDIrqogenC5aOKub10Tk
         zwIRjqTeYGHHI5Zjk3xJ8SfA/C8Z8Kml48u44+Lcu1Z/poCLM4ggCL+9icAksWuFomXj
         9WWEisj6x4F7a2Y41WTROYDrN+wEWU6eclrRfps54EUpP/qECbHBZR7zwzPBuaupbNRx
         HM9tc91kLF4TC0Dqodoqd7RRJOehm8ZEYaySwR9oIyYYgTel1JGTdO1PWY1Obde0PS7p
         rwO8JIka1HDAf4ZDlioGFODHk/yWAbr6Hu+ycEztbc2sZZWLPfHo9/WVLcw2bW4SoJ0S
         1N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uAJuZiZwKxXMhoL0sPJE/tx/l47j9wBuA1dXpeacqNA=;
        b=O5LNvyeRA+nsNWjXaQaK9Te+l+SJ2nJwmWTn/XfGrrJuyOisle28geous+ej+pmcCf
         YyH5Sv0Pg8vLaDF6boPg5/ooME75X1WplusikIxwmWS02M9iaDgWAYOwAr8lZvh9AC1r
         64mOKK1tqqts3abupqh6WBRpGWrTOJrpzwXqkQ/5OTmnySzsu1+RPKET9G1XruA4S5AB
         gnkmwDOOJbiQ4OEQEirzrELhqNmSkGHeX79jMcaupB2+qb0I3WCnS80Z/1fJjRLy4u6h
         4+6hYcBVrVTqwZSdsiWHmGCx2HbpLbslCDmvT0JPwPZAl045WCGoCMP4Syp8ufcDPboX
         vdYg==
X-Gm-Message-State: AA+aEWbEWRASFGav7NWu2Tp6YBjRVtOXXLP6JAY2dx+FddZy0PBFHuEa
        9nf9t/PtaFLT1Xl1CzUWAimvVKmIMUk=
X-Google-Smtp-Source: AFSGD/XpsKoau8YBua0Gu6Aa450/DuamG+X+WpZlO8QX9rJLtt3uCF9z48zRBxNYr9jS3X4kgZs6WA==
X-Received: by 2002:a63:f901:: with SMTP id h1mr20345958pgi.154.1544014639864;
        Wed, 05 Dec 2018 04:57:19 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q1sm26348898pfb.96.2018.12.05.04.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/5] netfilter: fix general protection fault when unregister sysctl table
Date:   Wed,  5 Dec 2018 20:56:26 +0800
Message-Id: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my server, I found a general protection fault in kernel message.
Bellow is the detailed information.

[   34.234846] general protection fault: 0000 [#1] SMP PTI
[   34.235498] CPU: 0 PID: 147 Comm: kworker/u2:3 Not tainted
4.20.0-rc3-next-20181120 #23
[   34.236461] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[   34.238216] Workqueue: netns cleanup_net
[   34.238623] RIP: 0010:unregister_sysctl_table+0x13/0x80
[   34.239202] Code: 6d ff ff ff 48 c7 c7 60 b1 07 83 bd f4 ff ff ff e8 22 1d a7
00 eb c5 0f 1f 44 00 00 41 55 48 85 ff 41 54 55 53 48 89 fb 74 30 <48> 8b 7f 20
e8 04 f1 ff ff 83 f8 01 7f 29 48 c7 c7 60 b1 07 83 e8
[   34.241920] RSP: 0018:ffffc9000022fda8 EFLAGS: 00010206
[   34.242496] RAX: 0000000000000000 RBX: 0000d2f000002328 RCX: 0000000000000000
[   34.243480] RDX: 000000000000001c RSI: ffffffff82999d00 RDI: 0000d2f000002328
[   34.244311] RBP: ffffc9000022fe30 R08: 000000000000000a R09: 0000000000002800
[   34.245274] R10: 000000000000024a R11: ffffea0000f64a40 R12: ffffffff8294a658
[   34.246191] R13: ffffffff8294a660 R14: ffffffff82941e00 R15: ffffc9000022fe30
[   34.247217] FS:  0000000000000000(0000) GS:ffff88803ea00000(0000)
knlGS:0000000000000000
[   34.248230] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.248984] CR2: 00007faa1819b2a8 CR3: 0000000002828005 CR4: 00000000003606f0
[   34.249845] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   34.250695] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   34.251535] Call Trace:
[   34.251848]  nf_ct_l4proto_pernet_unregister_one+0x45/0x60
[   34.252479]  proto_gre_net_exit+0x18/0x90
[   34.252888]  ops_exit_list.isra.8+0x33/0x60
[   34.253332]  cleanup_net+0x195/0x2a0
[   34.253698]  process_one_work+0x15f/0x360
[   34.254190]  worker_thread+0x49/0x3e0
[   34.254544]  kthread+0xf5/0x130
[   34.254966]  ? process_one_work+0x360/0x360
[   34.255401]  ? kthread_park+0x80/0x80
[   34.255916]  ret_from_fork+0x35/0x40
[   34.256269] Modules linked in:
[   34.256582] ---[ end trace be3904a1ee0bddf8 ]---
[   34.257080] RIP: 0010:unregister_sysctl_table+0x13/0x80
[   34.257697] Code: 6d ff ff ff 48 c7 c7 60 b1 07 83 bd f4 ff ff ff e8 22 1d a7
00 eb c5 0f 1f 44 00 00 41 55 48 85 ff 41 54 55 53 48 89 fb 74 30 <48> 8b 7f 20
e8 04 f1 ff ff 83 f8 01 7f 29 48 c7 c7 60 b1 07 83 e8
[   34.260268] RSP: 0018:ffffc9000022fda8 EFLAGS: 00010206
[   34.260864] RAX: 0000000000000000 RBX: 0000d2f000002328 RCX: 0000000000000000
[   34.261717] RDX: 000000000000001c RSI: ffffffff82999d00 RDI: 0000d2f000002328
[   34.262569] RBP: ffffc9000022fe30 R08: 000000000000000a R09: 0000000000002800
[   34.263592] R10: 000000000000024a R11: ffffea0000f64a40 R12: ffffffff8294a658
[   34.264449] R13: ffffffff8294a660 R14: ffffffff82941e00 R15: ffffc9000022fe30
[   34.265295] FS:  0000000000000000(0000) GS:ffff88803ea00000(0000)
knlGS:0000000000000000
[   34.266395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.267044] CR2: 00007faa1819b2a8 CR3: 0000000002828005 CR4: 00000000003606f0
[   34.267936] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   34.268881] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This general protection fault is in function unregister_sysctl_table(),
because 'header' is a pointer that isn't kmalloced.

If some modules(in this case, it is GRE) forget to kmemdup sysctl table,
'pn->ctl_table' will be NULL in function nf_ct_l4proto_register_sysctl(),
and then register_net_sysctl() can't be executed, so the 'header' in
__register_sysctl_table() will never be assigned,
	header = kzalloc(sizeof(struct ctl_table_header) +
			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);

But pn->users will be incremented as the return value of
nf_ct_l4proto_register_sysctl() is 0.

As a result of that behavior, when doing unregister,
unregister_net_sysctl_table() will be executed. Then we will access a
pointer that isn't assigned. That's why general protection fault occurs.

This patch is to fix this general protection fault issue.
After this patch, an error message will be printed to indicate some error
happens, for example, in this case bellow message will be printed,
	"nf_conntrack_gre4: pernet registration failed."

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/netfilter/nf_conntrack_proto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 40643af..154e8c0 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -192,8 +192,12 @@ int nf_ct_l4proto_register_sysctl(struct net *net,
 				pn->ctl_table = NULL;
 			}
 		}
+	} else {
+		/* in case any module doesn't kmemdup sysctl table */
+		err = -ENOENT;
 	}
 #endif /* CONFIG_SYSCTL */
+
 	return err;
 }
 
-- 
1.8.3.1

