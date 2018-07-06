Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D32723FA5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE0bXSLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D32723FA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGFPao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:30:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46149 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbeGFPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:30:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so8729405pfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LDujMWZp7PHk69vGoFw7CDykH0eur5Nn251wZvxbjN0=;
        b=TE0bXSLT/8ErDyM+fcoHqD+IzYO1R7ZIXl21ieAYA4XEwMrr/j4FzQDbAoj2/0FMNB
         Gd6xZpYSKrWawhlrAWq8rAiSa5Qr3rWPzPSXvhsptGRvBczju+km3b3LoEXTh90h4Nxc
         DJCCDfsBovs4fPscMAjo1q61VHU9O/3ANc3dhOdf9FvwbCbnOyl/VcLch101yw9glfEC
         C3AaSeNO4WnEO7TE9OmYetBuToyAvUNQkFE4kWYG/sCjJ12GtBa+Z2Cm+U5FruSyYz5o
         fJ85x3jRy9yfYfVx8Qrtbz4jAYqM51x4kxx419ZuwNxebvozG2j+HrurswBiHOKu7FS3
         5glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LDujMWZp7PHk69vGoFw7CDykH0eur5Nn251wZvxbjN0=;
        b=IBwLOMemtHqqKNjloBzNpUIrVosoDpphK1szpXjyNWGjLKqR5B/d9XdYzi3PKd/k7b
         CiMbqBpbMnTHMPVah+VtwdYJ4WP5e6VAPU+f2A1QROzIc5gWuPgBMIkpQUtBc84eN2Og
         LuLwI0uaJhDwKrAIMRtdegZ1q2rEb4MpGZdBGmCdzDZo1aCzxKiTRcmARjJ4nY9Scee9
         VOw39FZ7vM3VtM/sKHPqHbLZTTc3/lWa1Gi4YZtbM0Uw29MxwSS4eeP+hlKOqgrcR+ur
         0AfUCPeSrm2ltS3EXHr6ZgnBGDst7uz6Xb6ScTM8oERh8jI6eC13BXF051pPnl4i5mcB
         +huA==
X-Gm-Message-State: APt69E0G2NMaRdMDLbcX1zasYNe8fIrX6Jnd0bqavgaN/7AFaF1hS/kO
        UqkOXcNf0fbCWeQfdqaSvlZUDMVIlCejwEVkRFP+120g1b4=
X-Google-Smtp-Source: AAOMgpdF/xODlQQqvK7vZMB43pZggRcyObWrLhdI9CYjn9Y+22o8ynlnZ/Nl0j1VnXpeT77TRCG1vRiCHb7pyVCStqY=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr11160727pfe.114.1530891041014;
 Fri, 06 Jul 2018 08:30:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Fri, 6 Jul 2018 08:30:20
 -0700 (PDT)
In-Reply-To: <CACT4Y+Yv8M93-N3J1U6r1X=Oy2SaKQpJU1S6iJeFC8bJMnjuKg@mail.gmail.com>
References: <1616306.R4SzcgHSdy@positron.chronox.de> <000000000000363e2e0570502d42@google.com>
 <CACT4Y+Yv8M93-N3J1U6r1X=Oy2SaKQpJU1S6iJeFC8bJMnjuKg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 Jul 2018 17:30:20 +0200
Message-ID: <CACT4Y+bMV5bU9tJodF50fu2VZ0AH3ZE0WZsinNs7whEumMRWRA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
To:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000b1572a05705658d8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b1572a05705658d8
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 6, 2018 at 10:19 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Jul 6, 2018 at 10:09 AM, syzbot
> <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot tried to test the proposed patch but build/boot failed:
>>
>> lost connection to test machine
>
> Looking into this.

Should be fixed now, let's try again:

#syz test: https://github.com/google/kmsan.git master


>> [....] Starting enhanced syslogd: rsyslogd [?25l [?1c 7 [1G[ [32m ok [39;49m
>> 8 [?25h [?0c.
>> [....] Starting periodic command scheduler: cron [?25l [?1c 7 [1G[ [32m ok
>> [39;49m 8 [?25h [?0c.
>> [....] Starting OpenBSD Secure Shell server: sshd[   21.709280] random:
>> sshd: uninitialized urandom read (32 bytes read)
>> [?25l [?1c 7 [1G[ [32m ok  [39;49m 8 [?25h [?0c.
>>
>> Debian GNU/Linux 7 syzkaller ttyS0
>>
>> syzkaller login: [   26.229113] random: sshd: uninitialized urandom read (32
>> bytes read)
>> [   26.532843] random: sshd: uninitialized urandom read (32 bytes read)
>> [   27.787277] random: sshd: uninitialized urandom read (32 bytes read)
>> Warning: Permanently added '10.128.0.2' (ECDSA) to the list of known hosts.
>> [   33.299368] random: sshd: uninitialized urandom read (32 bytes read)
>> flag provided but not defined: -os
>> Usage of ./syz-fuzzer:
>>   -abort_signal int
>>         initial signal to send to executor in error conditions; upgrades to
>> SIGKILL if executor does not exit
>>   -arch string
>>         target arch (default "amd64")
>>   -buffer_size uint
>>         internal buffer size (in bytes) for executor output
>>   -collide
>>         collide syscalls to provoke data races (default true)
>>   -cover
>>         collect feedback signals (coverage)
>>   -debug
>>         debug output from executor
>>   -executor string
>>         path to executor binary (default "./syz-executor")
>>   -ipc string
>>         ipc scheme (pipe/shmem)
>>   -leak
>>         detect memory leaks
>>   -manager string
>>         manager rpc address
>>   -name string
>>         unique name for manager (default "test")
>>   -output string
>>         write programs to none/stdout/dmesg/file (default "stdout")
>>   -pprof string
>>         address to serve pprof profiles
>>   -procs int
>>         number of parallel test processes (default 1)
>>   -sandbox string
>>         sandbox for fuzzing (none/setuid/namespace) (default "none")
>>   -test
>>         enable image testing mode
>>   -threaded
>>         use threaded mode in executor (default true)
>>   -timeout duration
>>         execution timeout
>>   -v int
>>         verbosity
>>
>>
>>
>> Tested on:
>>
>> commit:         9c9df9f275f0 kmsan: remove kmsan_threads_ready
>> git tree:       https://github.com/google/kmsan.git/master
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b11f4cfb262ee607
>> compiler:       clang version 7.0.0 (trunk 334104)
>> patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a5af84400000
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000363e2e0570502d42%40google.com.
>>
>> For more options, visit https://groups.google.com/d/optout.

--000000000000b1572a05705658d8
Content-Type: text/x-patch; charset="US-ASCII"; name="alg.patch"
Content-Disposition: attachment; filename="alg.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jja4z8ay0

LS0tIGEvY3J5cHRvL2FmX2FsZy5jCisrKyBiL2NyeXB0by9hZl9hbGcuYwpAQCAtMTE0OCw4ICsx
MTQ4LDEwIEBAIGludCBhZl9hbGdfZ2V0X3JzZ2woc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgbXNn
aGRyICptc2csIGludCBmbGFncywKIAogCQkvKiBtYWtlIG9uZSBpb3ZlYyBhdmFpbGFibGUgYXMg
c2NhdHRlcmxpc3QgKi8KIAkJZXJyID0gYWZfYWxnX21ha2Vfc2coJnJzZ2wtPnNnbCwgJm1zZy0+
bXNnX2l0ZXIsIHNlZ2xlbik7Ci0JCWlmIChlcnIgPCAwKQorCQlpZiAoZXJyIDwgMCkgeworCQkJ
cnNnbC0+c2dfbnVtX2J5dGVzID0gMDsKIAkJCXJldHVybiBlcnI7CisJCX0KIAogCQkvKiBjaGFp
biB0aGUgbmV3IHNjYXR0ZXJsaXN0IHdpdGggcHJldmlvdXMgb25lICovCiAJCWlmIChhcmVxLT5s
YXN0X3JzZ2wpCg==
--000000000000b1572a05705658d8--
