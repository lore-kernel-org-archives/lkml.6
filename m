Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27732ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D862086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0GdzqyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D862086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeIXWMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:12:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40089 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeIXWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:12:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so16756981edd.7;
        Mon, 24 Sep 2018 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vS8Vu8sOTmIua5LCI+HM1fjrU4yKkBX7F1AoklvK5bw=;
        b=a0GdzqyEsYmTaf/IWkoswvjgCIm41FwC7EnOtLacoCMsU1r/qgCf74zbW6ReYmiFmV
         gsTkAtPc6vku761MZuWHXBY3uxGWvERTwFvwt8Ej1nItYUhU3tppdtlBwYtVJgMYn43m
         /AodPh4kxJNMcVPwOJRagPiM2qrwQUJ6CCL558IHmXXvkhJdjnsQmnHCvwc7og7ZudlT
         2nO57hK3TbhaCtckvmy4+h1gwhk0CxwVon06vaF6RioloqO4nlcuJKncKm1WBdsRjhpu
         mOw2WqhJPN8T3Odt2bEA9K68f7ILa0c2i5iHaFRXjv29HX+LoxQsxfPpcIQb5fBtBijS
         Mz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vS8Vu8sOTmIua5LCI+HM1fjrU4yKkBX7F1AoklvK5bw=;
        b=g48VUXpzxASIjWhru2LzJbjfxBgFx8+QBdEgVPDi8HduEsRNLn4jQfWpST4l79KwGC
         TeRnknLmv8MloEE9KmyESkxTxu4JBSCptscRywnz5XafGBEj2fsORZyBiAEdDubpyuec
         X51/H144Ydy7eWUn1ckZo2trclKO6hcJObWgVFTEIva4uqUn06FLT4vTebDjQYobFI6S
         tE14E+RbgQf6L2nj1Y5F8nzOOhKuXRfQZwcrVoUxFfjmx3u7EZZ/lrIlEWuXgGHqeZLH
         AwypKuWiUgjM5WnEpgMZcA5rJuk9OZPPOn2G1PQF4PFBArLDVo5eIq3jxfxoqHDEg+43
         HNTA==
X-Gm-Message-State: ABuFfog2m+zNKbdZakFP3fRTMXrLlqUsylhUieM1ZTwJdrOcqUgfVkAm
        E41CGoWWWVKljcHJvJysCq4=
X-Google-Smtp-Source: ACcGV612tu0mvUzk7pZ5fejf0u1n1kU8XTQEdUGq6EBLOMjp2psgWi9yA0mbRaFUHF6GOzuwLw73BQ==
X-Received: by 2002:a50:b206:: with SMTP id o6-v6mr17926954edd.160.1537805376853;
        Mon, 24 Sep 2018 09:09:36 -0700 (PDT)
Received: from [10.8.0.2] (ec2-52-213-96-211.eu-west-1.compute.amazonaws.com. [52.213.96.211])
        by smtp.gmail.com with ESMTPSA id z30-v6sm6559438edb.4.2018.09.24.09.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 09:09:36 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000014285d05765bf72a@google.com>
From:   Sabin Rapan <sabin.rapan@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sabin.rapan@gmail.com; keydata=
 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
Message-ID: <93e2ac09-1a8b-4efe-d707-1932278592f9@gmail.com>
Date:   Mon, 24 Sep 2018 19:09:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00000000000014285d05765bf72a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is fixed by patch vfs: namespace: error pointer dereference in do_remount()

#syz fix: vfs: namespace: error pointer dereference in do_remount()

On 21.09.2018 09:44, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a0cb0cabe4bb Add linux-next specific files for 20180920
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=164d6511400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=786006c5dafbadf6
> dashboard link: https://syzkaller.appspot.com/bug?extid=73c7fe4f77776505299b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13650fae400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118cbf21400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com
> 
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440329
> RDX: 0000000020000380 RSI: 00000000200002c0 RDI: 0000000000000000
> RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000034
> R10: 00000000001800a0 R11: 0000000000000246 R12: 0000000000000003
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> BUG: unable to handle kernel paging request at fffffffffffffff4
> PGD 966d067 P4D 966d067 PUD 966f067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5551 Comm: syz-executor016 Not tainted 4.19.0-rc4-next-20180920+ #76
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:parse_monolithic_mount_data fs/namespace.c:2354 [inline]
> RIP: 0010:do_remount fs/namespace.c:2387 [inline]
> RIP: 0010:do_mount+0xb3b/0x1db0 fs/namespace.c:2950
> Code: 06 00 48 89 c2 48 89 c3 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 24 11 00 00 48 b8 00 00 00 00 00 fc ff df <4c> 8b 33 49 8d 7e 18 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 10
> RSP: 0018:ffff8801bb99fc28 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 0000000000000000
> RDX: 1ffffffffffffffe RSI: ffffffff81ddffac RDI: 0000000000000282
> RBP: ffff8801bb99fdb0 R08: ffff8801d8b0e600 R09: ffffed003b5a5b57
> R10: ffffed003b5a5b57 R11: ffff8801dad2dabb R12: ffff8801d3666830
> R13: ffff8801c942cb80 R14: ffff8801c942cb80 R15: 0000000000000000
> FS:  00000000010de880(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff4 CR3: 00000001d84b5000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ksys_mount+0x12d/0x140 fs/namespace.c:3175
>  __do_sys_mount fs/namespace.c:3189 [inline]
>  __se_sys_mount fs/namespace.c:3186 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3186
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440329
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc6e4c9ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440329
> RDX: 0000000020000380 RSI: 00000000200002c0 RDI: 0000000000000000
> RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000034
> R10: 00000000001800a0 R11: 0000000000000246 R12: 0000000000000003
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> CR2: fffffffffffffff4
> ---[ end trace 8aa3e592ff591401 ]---
> RIP: 0010:parse_monolithic_mount_data fs/namespace.c:2354 [inline]
> RIP: 0010:do_remount fs/namespace.c:2387 [inline]
> RIP: 0010:do_mount+0xb3b/0x1db0 fs/namespace.c:2950
> Code: 06 00 48 89 c2 48 89 c3 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 24 11 00 00 48 b8 00 00 00 00 00 fc ff df <4c> 8b 33 49 8d 7e 18 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 10
> RSP: 0018:ffff8801bb99fc28 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 0000000000000000
> RDX: 1ffffffffffffffe RSI: ffffffff81ddffac RDI: 0000000000000282
> RBP: ffff8801bb99fdb0 R08: ffff8801d8b0e600 R09: ffffed003b5a5b57
> R10: ffffed003b5a5b57 R11: ffff8801dad2dabb R12: ffff8801d3666830
> R13: ffff8801c942cb80 R14: ffff8801c942cb80 R15: 0000000000000000
> FS:  00000000010de880(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff4 CR3: 00000001d84b5000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
