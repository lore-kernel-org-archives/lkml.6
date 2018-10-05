Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE863C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9161C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awNqDUPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9161C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeJFE5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:57:06 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36180 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeJFE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:56:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id b3so5235689uak.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Rl24sJAi0Y2HiAPQyt9R0IT0oB0epHMd3uPDxXcutMo=;
        b=awNqDUPJj+9P9OXhQ2Q/oHmb1zPeVm85B33J+11ZBYgW49GVDkJa/l0GeWVoq/hncp
         Hw2POhbXPT4UiqnMqjJrKbYOTu87cPcLBbO00VwpHZCN/YArA+Mj2iaOCoX7TpQ96tIl
         A1LiCITjEAVnwAvXa5hJzTQ46UXSDVH0bJcjWhcKUkIJGtdwhgP4N+6oQuwM52hO9P91
         B8UK90Be/CAhFr0fZwgs1Q0eWegFrNYO0hoVVGBuSn1TcF1IKcL7kfE4ulPxkeYmeN9I
         qRHoiAb2gJW7zIvbbkYmyNLboGwwgtMSJJPiStNuwXPWCtCaspf9qJbQ6HYgSQi9aJa7
         J5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Rl24sJAi0Y2HiAPQyt9R0IT0oB0epHMd3uPDxXcutMo=;
        b=pz7CytrNt6NdZYHVoF8CKuUySlslXoaX75obAaozxizgIuMPktI4Ybsbvoca2+m5ie
         7372JcvdF9+P1V8P0g0K3PyT55bq3gcUi2CX+o6Povd4sH12mflCFPL/vuswQJ7dV1m8
         /e3yM4RrWXwaVGgOpEjcwgncO4Drs9VgbPBgSwdIVlwgmma//CgLS6+CEAgvq7mR3Z8Y
         hKG6B//beA2SL9WmADW7XhOsQ8I8wJTsW54U4WfmNfU3jvtZ32iXRZ4MRWBTr8AqI3Xu
         cCHMF6CBuBwJiRiWCwbsN52S+ICg2loxpBxqN/WgxYogjAzW9kxZKaRx7JV7Lq2q4klk
         Prjg==
X-Gm-Message-State: ABuFfohDPtoCSnHyS5qGMC50+s5J2iYoZx2PAeaZ5hhGYqbsiXsp44LF
        QDR9vpkV3TGY9i9a6S51utephQeIbQTssf6hpCzwVvhL
X-Google-Smtp-Source: ACcGV622d0Gr/wsyZXBe8fMrSQgWOwJuR0o/e5Eas/mFYMCpdr4HX3B3tcN5uy02Dc4xHbq/zNVKZv/y4TZwZnz8z/w=
X-Received: by 2002:ab0:6607:: with SMTP id r7mr4563049uam.6.1538776573350;
 Fri, 05 Oct 2018 14:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOTh5U3srTK_-OeESDL_-=M8petsorTDfzr6Ycte9f7p+5ZLCQ@mail.gmail.com>
In-Reply-To: <CAOTh5U3srTK_-OeESDL_-=M8petsorTDfzr6Ycte9f7p+5ZLCQ@mail.gmail.com>
From:   Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Date:   Fri, 5 Oct 2018 15:56:02 -0600
Message-ID: <CAOTh5U26Fwfarvs9e=Tj0rL5syfnB0KWwn+491co201RoDFOCA@mail.gmail.com>
Subject: Re: hung task in 4.14 (syzbot bug from 2018 April 17)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another instance of the same problem (also on 4.14.67), this time with
the hung task timeout restored to its 120 second default:

[  980.954129] INFO: task systemd:1 blocked for more than 120 seconds.
[  980.954132]       Tainted: G           OE   4.14.67-solidfire1 #1
[  980.954133] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  980.954135] systemd         D    0     1      0 0x00000000
[  980.954137] Call Trace:
[  980.954150]  ? __schedule+0x27f/0x870
[  980.954154]  ? check_preempt_wakeup+0x102/0x230
[  980.954156]  schedule+0x28/0x80
[  980.954159]  schedule_timeout+0x1e7/0x340
[  980.954163]  ? radix_tree_node_ctor+0x20/0x20
[  980.954165]  ? delete_node+0x1b8/0x1f0
[  980.954167]  ? wait_for_completion+0xb0/0x120
[  980.954169]  wait_for_completion+0xb0/0x120
[  980.954172]  ? wake_up_q+0x70/0x70
[  980.954176]  flush_work+0x10d/0x1c0
[  980.954179]  ? worker_detach_from_pool+0xa0/0xa0
[  980.954183]  fsnotify_destroy_group+0x34/0xa0
[  980.954185]  inotify_release+0x1a/0x50
[  980.954189]  __fput+0xd8/0x220
[  980.954194]  task_work_run+0x8a/0xb0
[  980.954198]  exit_to_usermode_loop+0xb9/0xc0
[  980.954200]  do_syscall_64+0x10b/0x120
[  980.954203]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  980.954206] RIP: 0033:0x7f031a552900
[  980.954208] RSP: 002b:00007fff93fd18b0 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[  980.954210] RAX: 0000000000000000 RBX: 0000000000000010 RCX: 00007f031a552900
[  980.954211] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000010
[  980.954212] RBP: 00007f031beba088 R08: 0000000000000020 R09: 000055ac5a21e2ad
[  980.954213] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  980.954214] R13: 000055ac5a488b20 R14: 000055ac5c0907f0 R15: 0000000000000000
[  980.954724] INFO: task kworker/u114:4:41909 blocked for more than
120 seconds.
[  980.954725]       Tainted: G           OE   4.14.67-solidfire1 #1
[  980.954726] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  980.954727] kworker/u114:4  D    0 41909      2 0x80000000
[  980.954733] Workqueue: events_unbound fsnotify_mark_destroy_workfn
[  980.954734] Call Trace:
[  980.954739]  ? __schedule+0x27f/0x870
[  980.954741]  schedule+0x28/0x80
[  980.954743]  schedule_timeout+0x1e7/0x340
[  980.954746]  ? __switch_to_asm+0x40/0x70
[  980.954747]  ? update_curr+0xe1/0x1a0
[  980.954750]  ? wait_for_completion+0xb0/0x120
[  980.954751]  wait_for_completion+0xb0/0x120
[  980.954753]  ? wake_up_q+0x70/0x70
[  980.954758]  __synchronize_srcu.part.13+0x76/0x90
[  980.954761]  ? trace_raw_output_rcu_utilization+0x40/0x40
[  980.954762]  ? try_to_wake_up+0x44/0x460
[  980.954765]  ? fsnotify_mark_destroy_workfn+0x67/0xb0
[  980.954767]  fsnotify_mark_destroy_workfn+0x67/0xb0
[  980.954769]  process_one_work+0x1da/0x3d0
[  980.954772]  worker_thread+0x21f/0x3f0
[  980.954775]  ? process_one_work+0x3d0/0x3d0
[  980.954777]  kthread+0x119/0x130
[  980.954779]  ? kthread_create_on_node+0x40/0x40
[  980.954781]  ret_from_fork+0x35/0x40

crash> print reaper_work
$3 = {
  work = {
    data = {
      counter = -117148584927483
    },
    entry = {
      next = 0xffff95743772b770,
      prev = 0xffffa2aa800a3df8
    },
    func = 0xffffffffa8249df0
  },
  timer = {
    entry = {
      next = 0xdead000000000200,
      pprev = 0x0
    },
    expires = 4295020559,
    function = 0xffffffffa80778c0,
    data = 18446744072250514272,
    flags = 69206020
  },
  wq = 0xffff95443f011400,
  cpu = 128
}

Any input is welcome.

-- 
Sebastian Kuzminsky
