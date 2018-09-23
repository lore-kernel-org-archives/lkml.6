Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2ACC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F4D21476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 08:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDUE1rfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F4D21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeIWOK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 10:10:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43082 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 10:10:58 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so15430860ioa.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y0IARn3KE7W2+I5lcBK0Qf/uWuLQeiNiibQnarU6CSo=;
        b=UDUE1rfDrwoTg9WEjccpglso8uiR5Ur1yQSizURMDbVk9PrY4AjE1BGJIO6neGXX0c
         L5mUMtx9+l04/f2caasqSRSYpFNPSol1sV1YbAAShm1IL7adFOCzAiGaQVVbdj4fF6kS
         2QEjxVUHP3zx2GHf78S9Sqf2cGBlOxvDhtUa4mnzgm+rPSev8HoKE2W3RqU8rfakYETr
         LBjG8R35Y9SNSphva+mq56QAJBBpu5Rft/4ksvYgjCTg/B3QSGMQSaKqCTugmtuR/ien
         czm6zC2oC9L8/avEOZ4NyJHaimhCtCxrMGAljzNzldlDOu/4tIcndLjrr6WQEAcSC5gb
         rFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y0IARn3KE7W2+I5lcBK0Qf/uWuLQeiNiibQnarU6CSo=;
        b=dQbhE2fyn/CSzeypuALmzuAqjTmc2qs/C6sNH+WmIrWUDpZ1vyByqjUFSshsnwV+FO
         F2xiEy1UEkGvvCFyTUUHiep1eFtf6O4F0EisdLf4Idccig8e1SbvBsAD7XZrTWBpRvGS
         giociNVpqQJkukzD/RjkLrRtU0l9nNCNkOr7YdqMTlo5WZBD1z9EEmgPVjn+3byy3wxW
         LoWofxsRhb7hgcKzS9r53nOThspFb7ZlgQsSzv7AZg4ASISUtKqaPvUgfuWlVJUzTEtZ
         83Qjeb1elky8gvgX+IHTm2rjh674gDBsNT+HPqHdNyqAQ4O0Xo1EEzpJPjEEI4zTb/Y8
         fP8g==
X-Gm-Message-State: ABuFfojAjIPTVtLyMenU9zliP71Yopt2sLqKZG/NOdy1CLEe/49HGJ0J
        3OVKyeFyiQhsFYGXXh8LrpDrp++CaHuLq1zjd4+2yw==
X-Google-Smtp-Source: ACcGV61kMrGwnULs3cTkgiES3Gx4u2GDUiZ9rnclbwJbDB9hZsn7d+i5oXYLNn1G8OWp64boXTcoyNoF83IjPfSDW3I=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr3828566ioh.271.1537690460456;
 Sun, 23 Sep 2018 01:14:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 01:14:00
 -0700 (PDT)
In-Reply-To: <0000000000002cdabf057685027b@google.com>
References: <0000000000002cdabf057685027b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Sep 2018 10:14:00 +0200
Message-ID: <CACT4Y+avdGM3bTCCHFxgH-4BpgA4KtGz6c=7R=Kwm5aGiq8zOg@mail.gmail.com>
Subject: Re: net build error
To:     syzbot <syzbot+a72ba31e3224309179d4@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 9:42 AM, syzbot
<syzbot+a72ba31e3224309179d4@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    474ff2600889 net-ethtool: ETHTOOL_GUFO did not and should ..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=164c4059400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=a72ba31e3224309179d4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a72ba31e3224309179d4@syzkaller.appspotmail.com

+netdev

The root cause:


net/rds/ib.o:(.data..percpu..shared_aligned+0x0): multiple definition
of `rds_ib_stats'
net/rds/rdma_transport.o:(.data..percpu..shared_aligned+0x0): first defined here
net/rds/ib_cm.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_recv.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_ring.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_send.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_stats.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_sysctl.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_rdma.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_fmr.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
net/rds/ib_frmr.o:(.data..percpu..shared_aligned+0x0): multiple
definition of `rds_ib_stats'
net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
first defined here
Makefile:1030: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1


> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
