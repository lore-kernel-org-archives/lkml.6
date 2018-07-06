Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C64323FDB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+nMtLdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C64323FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeGFITc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:19:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:44477 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeGFIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:19:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id j3-v6so7787985pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/rdcFyloq0FCd5716AHuS1Gkoc1Opj41ZzvuH81b2/4=;
        b=I+nMtLdd1YxCgSy3g94fW8r5Wt8vYsaF55YhaVtw3dQ0AHqzwE2hflVUlT3rfJlCEh
         AvJ6JfdIWKBpVxTSSRfR+RSqideMvRghnsGt2wA4MZeoYIEhKL95REi4ewulk6bCu8lY
         i8meMPdWnOR6rwznLQqpyA390MlaXQUUPczW5IaJROjbkRaa0SL88j5uftaHWzIbrmgD
         PeisOZQxaOOJfrY8uqP9bmG3OCDO8DS127VEv0agZXTDa4kU7s1IQtibizh4Plqqvkin
         gyQD5UZFnLKutpyediqO+5pqqY44I278XhV0H6rnKKfIS+ncfcXRXryxWbpOBfteek9+
         2BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/rdcFyloq0FCd5716AHuS1Gkoc1Opj41ZzvuH81b2/4=;
        b=DlVeE5V4uy0nz2nUhQX7OCvgLvf0V2hXCcUkG1YHuzR6o25mkTjrJm0D3bjxU7wQKY
         Jm2fWaWx28KU+/w3HUY37xIX3CB+8XIpXbhoAArjAR/0msnnxrVmb9hvCPjBnCc23d6K
         m/Dz4sH+GZZ4WyuaprvoQo2y65Gx1798FO/SMPLND4MRSEmKHe4Z4R2CZswlx7HubPQ3
         qDrNb6pdWiECJrDLTu6aMPx0eHEWJiHUZjIvYgQyo8ZeaKyxEbONdBoXUu6Sx6pBJchw
         sMRLVFASLevDKiqm+saMiI+nVo/KAP6JA0/XnlkRIn+zqqa8CS0ZXXRho7OGcmj5vuFw
         BMGg==
X-Gm-Message-State: APt69E14v7LknSOqE24QUrHLxhMgnTNm8gJAygS8uIdics1dHcwPA4+W
        5OJbu+S1qWbc5mAjEk6MQPUxQzVhh3XnUoVxxaay/w==
X-Google-Smtp-Source: AAOMgpfiafFWLbMZnHx4rEpo+6APgaCao0ilX2SVvKlH8CzZ2kBybj/mzhXWUzlzKWYnrrxcTxXIBJGdQ+Cwn6hr6Ks=
X-Received: by 2002:a63:501c:: with SMTP id e28-v6mr8588511pgb.114.1530865167609;
 Fri, 06 Jul 2018 01:19:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:19:07
 -0700 (PDT)
In-Reply-To: <000000000000363e2e0570502d42@google.com>
References: <1616306.R4SzcgHSdy@positron.chronox.de> <000000000000363e2e0570502d42@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 Jul 2018 10:19:07 +0200
Message-ID: <CACT4Y+Yv8M93-N3J1U6r1X=Oy2SaKQpJU1S6iJeFC8bJMnjuKg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
To:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 10:09 AM, syzbot
<syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot tried to test the proposed patch but build/boot failed:
>
> lost connection to test machine

Looking into this.

> [....] Starting enhanced syslogd: rsyslogd [?25l [?1c 7 [1G[ [32m ok [39;49m
> 8 [?25h [?0c.
> [....] Starting periodic command scheduler: cron [?25l [?1c 7 [1G[ [32m ok
> [39;49m 8 [?25h [?0c.
> [....] Starting OpenBSD Secure Shell server: sshd[   21.709280] random:
> sshd: uninitialized urandom read (32 bytes read)
> [?25l [?1c 7 [1G[ [32m ok  [39;49m 8 [?25h [?0c.
>
> Debian GNU/Linux 7 syzkaller ttyS0
>
> syzkaller login: [   26.229113] random: sshd: uninitialized urandom read (32
> bytes read)
> [   26.532843] random: sshd: uninitialized urandom read (32 bytes read)
> [   27.787277] random: sshd: uninitialized urandom read (32 bytes read)
> Warning: Permanently added '10.128.0.2' (ECDSA) to the list of known hosts.
> [   33.299368] random: sshd: uninitialized urandom read (32 bytes read)
> flag provided but not defined: -os
> Usage of ./syz-fuzzer:
>   -abort_signal int
>         initial signal to send to executor in error conditions; upgrades to
> SIGKILL if executor does not exit
>   -arch string
>         target arch (default "amd64")
>   -buffer_size uint
>         internal buffer size (in bytes) for executor output
>   -collide
>         collide syscalls to provoke data races (default true)
>   -cover
>         collect feedback signals (coverage)
>   -debug
>         debug output from executor
>   -executor string
>         path to executor binary (default "./syz-executor")
>   -ipc string
>         ipc scheme (pipe/shmem)
>   -leak
>         detect memory leaks
>   -manager string
>         manager rpc address
>   -name string
>         unique name for manager (default "test")
>   -output string
>         write programs to none/stdout/dmesg/file (default "stdout")
>   -pprof string
>         address to serve pprof profiles
>   -procs int
>         number of parallel test processes (default 1)
>   -sandbox string
>         sandbox for fuzzing (none/setuid/namespace) (default "none")
>   -test
>         enable image testing mode
>   -threaded
>         use threaded mode in executor (default true)
>   -timeout duration
>         execution timeout
>   -v int
>         verbosity
>
>
>
> Tested on:
>
> commit:         9c9df9f275f0 kmsan: remove kmsan_threads_ready
> git tree:       https://github.com/google/kmsan.git/master
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b11f4cfb262ee607
> compiler:       clang version 7.0.0 (trunk 334104)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a5af84400000
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000363e2e0570502d42%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
