Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD369C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858FF214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XYc9+2MO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfAIJof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:44:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfAIJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:44:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so6942843wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=HSko8mnroTFfccmcMk0+UXnHoaWJwMRrpxgEOnKE3EE=;
        b=XYc9+2MOCfMjxmyfMP6f8TihFOUmV4bGbkNDCEozCgZhC+wVeII6RdGXgNy2Jyr3uF
         bLhn9HuToD9PDchT+C9avozUM1z4YKKxWIEHBv6Tee7WZzJytuR3CSFmEsl/XstOoCYf
         NCodd1lOKtLY8R+PrF00EdSIgYR38AuMTiyypmi1KVMqclChtgGTAV63ilhAh1M7ei/x
         YlQnOkZ+TBWdu46g4yOh1l17byACdasfn/y4uCXPS1+DzeyEyL+e0HepJbHj7iSyg1lG
         G0aQxibk0JwZume/U3MJUiEJ36Y0aO3A4GT7tJnoJ6bs3Z3ZfM//WzBRE8zSLwlUkspa
         Mhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=HSko8mnroTFfccmcMk0+UXnHoaWJwMRrpxgEOnKE3EE=;
        b=OY1AoMLxfrzNBh8r2pQ6X6SLs+E8s8mUTgtU/XXSDbTujrPMok2Ay9tvLmKz3wSBYN
         76OBg9u8AdTCPza5iFNrVq74TIlgeJLJItTtqR2F+GZJiJc6VR2pFPtpzchc5d7DHeFy
         3Piwzn3gOlbOtR2AK7WYGAGsOEPJpjE3e5aGdvv1wxZ8yxyPHq08O1hco7RpbitCSrI2
         FD5dzujA3LGuU4oMoP+C+MiRI4B3ced5oh8NGKt+9O79uaCpHVt7gim/jGJ67HNd8p/3
         diqAMzupfSXNdkJSIxvrU+TcFHj7OJCGNmv0T2VclP+ZKRQKM4nFIuoYqT1Q0ibpTOHv
         1bwQ==
X-Gm-Message-State: AJcUukePK41o2eq+9wCnW+cNytS4U3Uku3KvAX7lSFv+UBt0Yjs/W4ei
        zSu4Jacf/CAZeVjGp1ubWaX+YQ==
X-Google-Smtp-Source: ALg8bN5znC+pFBVJa3PaWxgE2E/+C0NgACTSWC71dA17fcoq7WzST3desMAZW7lVLlufvA9Ep822+Q==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr4278680wrw.311.1547027072787;
        Wed, 09 Jan 2019 01:44:32 -0800 (PST)
Received: from ?IPv6:2a02:8109:b6c0:d6c:2472:eca3:e8e0:b8e2? ([2a02:8109:b6c0:d6c:2472:eca3:e8e0:b8e2])
        by smtp.gmail.com with ESMTPSA id w12sm52074514wrr.23.2019.01.09.01.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:44:32 -0800 (PST)
Date:   Wed, 09 Jan 2019 10:44:27 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190109085041.GK17624@shao2-debian>
References: <20190109085041.GK17624@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [LKP] [binder] 3ad20fe393: BUG:unable_to_handle_kernel
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Todd Kjos <tkjos@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <2287973C-F706-4B3A-A854-6968A825089F@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2019 9:50:41 AM GMT+01:00, kernel test robot <rong=2Ea=2Echen=
@intel=2Ecom> wrote:
>FYI, we noticed the following commit (built with gcc-7):
>
>commit: 3ad20fe393b31025bebfc2d76964561f65df48aa ("binder: implement
>binderfs")
>https://git=2Ekernel=2Eorg/cgit/linux/kernel/git/torvalds/linux=2Egit mas=
ter
>
>in testcase: trinity
>with following parameters:
>
>	runtime: 300s
>
>test-description: Trinity is a linux system call fuzz tester=2E
>test-url: http://codemonkey=2Eorg=2Euk/projects/trinity/
>
>
>on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2
>-m 768M
>
>caused below changes (please refer to attached dmesg/kmsg for entire
>log/backtrace):
>
>
>+------------------------------------------+------------+------------+
>|                                          | 80cd795630 | 3ad20fe393 |
>+------------------------------------------+------------+------------+
>| boot_successes                           | 17         | 1          |
>| boot_failures                            | 8          | 31         |
>| invoked_oom-killer:gfp_mask=3D0x           | 6          |            |
>| Mem-Info                                 | 6          |            |
>| BUG:kernel_in_stage                      | 2          | 4          |
>| RIP:__put_user_8                         | 1          |            |
>| BUG:unable_to_handle_kernel              | 0          | 27         |
>| Oops:#[##]                               | 0          | 27         |
>| RIP:binderfs_mount                       | 0          | 27         |
>| Kernel_panic-not_syncing:Fatal_exception | 0          | 27         |
>+------------------------------------------+------------+------------+
>
>
>
>[    8=2E360965] BUG: unable to handle kernel NULL pointer dereference at
>00000000000006a0
>[    8=2E362067] PGD 0 P4D 0=20
>[    8=2E362437] Oops: 0000 [#1] PREEMPT DEBUG_PAGEALLOC
>[    8=2E363131] CPU: 0 PID: 1 Comm: swapper Not tainted
>4=2E20=2E0-rc6-00107-g3ad20fe #2
>[    8=2E364177] RIP: 0010:binderfs_mount+0x42/0x480
>[    8=2E364820] Code: 89 fc 49 c7 c7 ff ff ff ff 48 83 ec 20 e8 86 5d 86
>ff 48 8b 04 25 40 10 e3 ab 48 8b 80 28 06 00 00 be 15 00 00 00 48 8b 58
>10 <48> 8b bb a0 06 00 00 e8 e2 3c 7d ff 84 c0 75 19 e8 59 5d 86 ff 48
>[    8=2E367104] RSP: 0000:ffffb6a78000bd98 EFLAGS: 00010293
>[    8=2E367104] RAX: ffffffffabe48e40 RBX: 0000000000000000 RCX:
>ffffffffab2bfd6a
>[    8=2E367104] RDX: 0000000000000000 RSI: 0000000000000015 RDI:
>ffffffffabf38d60
>[    8=2E367104] RBP: ffffb6a78000bde8 R08: 0000000000000000 R09:
>0000000000000000
>[    8=2E367104] R10: 0000000000000000 R11: ffff90c7ec4f2980 R12:
>ffffffffabf38d60
>[    8=2E367104] R13: 0000000000400000 R14: ffffffffabf38d60 R15:
>ffffffffffffffff
>[    8=2E367104] FS:  0000000000000000(0000) GS:ffffffffabe2d000(0000)
>knlGS:0000000000000000
>[    8=2E367104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    8=2E367104] CR2: 00000000000006a0 CR3: 0000000027e19000 CR4:
>00000000000406b0
>[    8=2E367104] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>0000000000000000
>[    8=2E367104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>0000000000000400
>[    8=2E367104] Call Trace:
>[    8=2E367104]  ? __lockdep_init_map+0x4d/0x1b0
>[    8=2E367104]  mount_fs+0x30/0xe0
>[    8=2E367104]  vfs_kern_mount+0x63/0x160

Thanks=2E A fix for this is already in Greg's char-misc tree queued up for=
 -rc2=2E
The wrong kern_mount() call is gone then=2E

Christian
