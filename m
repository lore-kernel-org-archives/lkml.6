Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA8C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C443206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m4HPGWnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfAKXUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:20:47 -0500
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:41288 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbfAKXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547248845; bh=X1nO4TLV5q/lESpL7/3rYZUXfbHdKSUAERQNufEYU6c=; h=Subject:From:To:References:Cc:Date:In-Reply-To:From:Subject; b=m4HPGWnVx02McGlA7Up3Jn5frADtUxjW5/rBO/ElQQabqIYW8QFrADFshUw/MQLYoP3uaALFYYgJIqQWMfDu4282CqyWYyzTcRyBkJv1h+LeZjspr4QeyOeg7tK/qEQzzF2pzSRYPRnnasnZry56C/9MPqf/YBVNnbQSk0rpxtaHYGe28rwxjNqtrG1Bv6dJyp6La7U/nwBzKGC6lOG2hWFwAJGWJAuheZfk2mFA9BxTwsZU7GfTpUB0MHvw4yd8LvO0czC2Sx/C4GbmMfG/45dPbB5Sv+4BkwMyZ8rfffsiFrN73mgIWqYblB4donPJJ/KUNgARYK/mmwKMocWaVg==
X-YMail-OSG: 0_.OV7cVM1nGQ7KfBQuECFpGJOqoso3Fd.owSA9VxUpT9cVCBvEVA5K2H.04NwD
 YpBhGMC6_Q7PQGg570zR.CAasZl8ocZ_CseFEYJq1POreTJaFBW56dNliE8eZARv8kIe6amnqMOm
 2hsvtLszPKxpA4CcFcVvii2WS8ED_sKfR1broN8BjG7HHGEKVF5K2y8aeOvLIl7R9L_kIMvnXOwe
 4l5hXGrNmV3q4oCdEMR1.aWrHuLletLVNsy07gm5XzUKZf0rTfAlReJ5cBpVc_pDUMYBg5ACcc98
 1IG_RnnTSteEDJid9zVUds3ZZ525oQZ7EgipBbsMSdqrbMbqj3Tu_.2w6Ewfttwd_ryCOOpXPOTJ
 oCgjCeqQz4kX4m7OQUpRWIhiDYMcN3hxQe7i9Th4bKC4CNDGdd_dPga0oJYLiP0J0CkJ80oA1AZ1
 0G78jypcQtY9BmNK2.gBH0KE8ajzH1HNXKg74QbVeCUcn48_5x.Jt561noi3nANWZgILq0L775eN
 DEns1tCKBuJThAsBPlrZpPf8adxUPVgsWJkfPqYM_2X5H5hQfV2zBScd2OT6j1Wpr6pq4aK1hx_d
 il9Yjnz9IyJO7rdXLahbzGnX4nnUcGrfi850NfX6rcJYKNVL_09zW_HlaM.QiETQGJCWyHsee8og
 CYn6rMjzr04VWmtXKIk3ptj1JPi_3V2A1vIgCoWktxlqvVk_SITgfk5ByOJnDvlezIB_hBT6KB9H
 EdaxKZqLOLT6MPvRhWdwgNCnmUp1Zq5iCtbimqWtmzdyiMRYlNcUSjlcXgG6JhNhhx6vPU3pzZgV
 mWEEdwz03DzUXU7Iol3ox7XSGA3FJ_BZjz0wMdQ6zilwtxhx2IBLkS3dAy2emeayDK.NiyxlfVPS
 DtLWLLdjKy0Slz7kTkCFkhfQxeSUbhk6Ir9ycwc9acricRfyvgscFZP.0YCvpCLMYHE2xf7mOvOu
 sr6Ecj80bUrcDvXyjMgd6AeOzmKHhPRVQIDQ8Ns0ii17wBQHixREbcs1290FbEWhpFQX3feNzLP8
 wSLLKpgfJ2nhfsNSNsuyG75nOgDjjDcamnufxO1GzHUjKC1bhDaf0CX0Zc.S3sVOEGfy_KYrc0iS
 FxHm6bMaEM3wah8iSbCmalTR7dj2ahlMRN7RlOHBwHOlH8YdL0lrvMzLaBkzUY62oiOAXG6DNeQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Jan 2019 23:20:45 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c4dd1ea14352e6c3449e62b7a5be8a9a;
          Fri, 11 Jan 2019 23:20:45 +0000 (UTC)
Subject: Re: WARNING in apparmor_cred_free
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
References: <0000000000007f604f057f2b8509@google.com>
 <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
 <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com>
 <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 15:20:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 2:43 PM, Casey Schaufler wrote:
> On 1/11/2019 2:30 PM, John Johansen wrote:
>> On 1/11/19 2:11 PM, Casey Schaufler wrote:
>>> On 1/11/2019 1:43 AM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    b808822a75a3 Add linux-next specific files for 20190111
>>>> git tree:       linux-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=179c22f7400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c052ead0aed5001b
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=69ca07954461f189e808
>>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d947f400000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139f6c37400000
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
>>>>
>>>> ------------[ cut here ]------------
>>>> AppArmor WARN cred_label: ((!blob)):
>>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 cred_label security/apparmor/include/cred.h:30 [inline]
>>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc1-next-20190111 #10
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>> Call Trace:
>>>>  <IRQ>
>>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>>>>  panic+0x2cb/0x65c kernel/panic.c:214
>>>>  __warn.cold+0x20/0x48 kernel/panic.c:571
>>>>  report_bug+0x263/0x2b0 lib/bug.c:186
>>>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>>>  fixup_bug arch/x86/kernel/traps.c:173 [inline]
>>>>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>>>>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>>>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
>>>> RIP: 0010:cred_label security/apparmor/include/cred.h:30 [inline]
>>>> RIP: 0010:apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>>>> Code: 7c 88 48 c7 c7 00 d0 7c 88 e8 fd 70 f2 fd 0f 0b eb a9 e8 54 3f 29 fe 48 c7 c6 c0 df 7c 88 48 c7 c7 00 d0 7c 88 e8 e1 70 f2 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 80 38 00 75 4a 4c 8b 2c 25 00
>>>> RSP: 0018:ffff8880ae6079f8 EFLAGS: 00010286
>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>> RDX: 0000000000000100 RSI: ffffffff81687fa6 RDI: 0000000000000006
>>>> RBP: ffff8880ae607a18 R08: ffffffff8987dec0 R09: 0000000000000000
>>>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a86b3100
>>>> R13: ffff8880a86b3100 R14: ffff8880a86b3188 R15: dffffc0000000000
>>>>  security_cred_free+0x4b/0xf0 security/security.c:1490
>>> The obvious thing to do is put a check in security_cred_free
>>> for a NULL cred->security, in which case the LSM hooks
>>> wouldn't get called.
>> Right, but the question is should we? To my thinking we shouldn't
>> ever have a cred without cred->security, unless the cred was
>> allocated but a later step in its construction, say allocating
>> ->security failed.
> If allocating ->security fails in security_cred_alloc_blank()
> or security_prepare_creds() you don't have to do anything but
> fail because the LSM hooks are not called before the allocation.
>
>> In which case I'd rather see the cred directly freed and not
>> call into security_cred_free() as I like being able to detect
>> corrupt creds.
> I think we need to look for some bit of code that's setting
> cred->security to NULL inappropriately.

If security_cred_alloc_blank() fails for lack of memory
in cred_alloc_blank() abort_creds() will be called. This
in turn calls put_cred() and put_cred_rcu(), which will
call security_cred_free() with ->security set to NULL.

put_cred_rcu() is the only caller of security_cred_free().
The ->security == NULL check can be in either put_cred_rcu()
or in security_cred_free(). I suggest the latter as the
cleanest option.

