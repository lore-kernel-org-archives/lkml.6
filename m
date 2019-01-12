Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856E7C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF320870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CR9x/akc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfALBrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:47:01 -0500
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:45348 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfALBrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547257619; bh=7DM4fJg+MZ62w010ce4LddWQv/r3bYjhPrv2NITcdcY=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=CR9x/akckKbWRjRJvt1rtro+D3c+9HSQrnb8qYw/JaAHwnlgKFQCBcxLQo/Lc/y/PBx8XgyLuhuOQ7OWHJPKp/Ed2iwURDyWeJ3Uayyh2dXCyEdVIPY3dGqfBMuL+2L+C7iiPmX+Lhe7IFvQ84D6SGEbqT/soxpMIaQy0GU3/8tKveeQ5jqA+ThA1IQLh9Q2BCxK1oafBstgCEoPNV+SS2SiU/MfG3/TtY4tsvZIjldK4xh2bk0iHLQ4vPMsP2DQPOb5aukPhnrujTbN0/rYcCXEhnxrY4vcmXwd8DNHu1rBNeuBs2W7cfPozlESI2bQEVStFNrbqxAvrxpNW6phgQ==
X-YMail-OSG: EjCKd7UVM1mFovZ5KkxUjfatDj6E0jY6W9U7klBNRDw38o9QCSnSq3y76QcFJxM
 Ntie5N74AuB.UhRKjqyozc8b9UGIpvpOkGFWh2hmhNkHBB5lbkWAS73izQFRkM9SyF46DGutH1vq
 licKR8w9l2g3PdjFJAAObi4zmngglNH7ZWQxWw_kIOI27kPwfiWklgQ9PjcsUcfiihVgz8l8ROts
 h2vR2eR2CQ49wLXcEXekjhPKEvx4i4ESUbOck_Ep59S9YWu.fAnDMzzZuQllTjXCWcT.rEVjRp7P
 WPAxAfxqPVWpt1psbgNkoMheJpyldZuRPIKqn_d3C37DLXexnuul6XAy5v2Zu8MKKm9Y5iISSBgl
 hK61d8HPb6_2TdlxNN2VlYeixjkw6FoDpb65.fHsVFT7.MXJs8CPQaRDR5WSuFMyKo0qvBI0Yao0
 1924hLpyT3cHZWkhkxjUghXsu8LsrykdhMA58TrvZ6QCO7fyDtf_AG3vp4sIyp_yS89uS2HRuXWT
 dkY.pWGOr_5hOLxWVVoXTbi1J35l2iF_iCzYkVpMWMsYLOpRBGHHBcsOZtvJ7STicGZIRkfgkL7S
 xUL_HP86hq.YY_QeTRZDQDR4dpbFSCKLNK9BbYY5kVGAbLEuAEaZfM2AQCPfQSo8xa9WroLKp41M
 3f0Zef7eihc1ZU2b8aXeJ19mBAN0cvjbuLfG_DvQTuf1hDDTGpW.udph37.FplXGozWuYyXcl8vw
 K6v5kQR_F9OYfL8VUeCRk1HPVE8ygovhjdPV9N9nFid2tzKSZmb7xuSVsiTaZrrFbVsJJXL11IV.
 YM5RuG0g7kMMKR13sH1JyJYNVSGQynwPsmI2Hubb8YRbPNSCNoDr9x8IR7BWDXYt0cGqqryRpyRw
 uLk6NhTWwojOn1qsClp6EhzzFm3QKfrBw1Kp2OHUa3TOE.0DkN7s.LCDhJcqHhgtqi4INWRzBihv
 TDqSCdS_ueIWuVwscnmF6qUevBacUosABPOq7._z1yYz1NhdwRM1Pl.BiNWMD7KCV2PQsO78QfwQ
 MaL7tVeZz1gbx0LZtc8NpEn_kXoSXPIVU76hoPwMQHg0Pn8ZW4p1bpXAnmkWTOVn6xFEdr2IRX1l
 k75Z3caoPBXoz34LNH8Lft48r_CJ5ycKdO7Kc.2FExthm7zAQGwIyQxIfNljPTUaY
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sat, 12 Jan 2019 01:46:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 732e316b53bafa20d53224a08c1133bc;
          Sat, 12 Jan 2019 01:46:58 +0000 (UTC)
Subject: Re: WARNING in apparmor_cred_free
To:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
References: <0000000000007f604f057f2b8509@google.com>
 <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
 <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com>
 <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com>
 <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <99cd1f6b-682e-7d1f-35ad-b9092d46323f@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 17:46:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 3:20 PM, Casey Schaufler wrote:
> On 1/11/2019 2:43 PM, Casey Schaufler wrote:
>> On 1/11/2019 2:30 PM, John Johansen wrote:
>>> On 1/11/19 2:11 PM, Casey Schaufler wrote:
>>>> On 1/11/2019 1:43 AM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    b808822a75a3 Add linux-next specific files for 20190111
>>>>> git tree:       linux-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=179c22f7400000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c052ead0aed5001b
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=69ca07954461f189e808
>>>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d947f400000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139f6c37400000
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>> Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
>>>>>
>>>>> ------------[ cut here ]------------
>>>>> AppArmor WARN cred_label: ((!blob)):
>>>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 cred_label security/apparmor/include/cred.h:30 [inline]
>>>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc1-next-20190111 #10
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>>> Call Trace:
>>>>>  <IRQ>
>>>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>>>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>>>>>  panic+0x2cb/0x65c kernel/panic.c:214
>>>>>  __warn.cold+0x20/0x48 kernel/panic.c:571
>>>>>  report_bug+0x263/0x2b0 lib/bug.c:186
>>>>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>>>>  fixup_bug arch/x86/kernel/traps.c:173 [inline]
>>>>>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>>>>>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>>>>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
>>>>> RIP: 0010:cred_label security/apparmor/include/cred.h:30 [inline]
>>>>> RIP: 0010:apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>>>>> Code: 7c 88 48 c7 c7 00 d0 7c 88 e8 fd 70 f2 fd 0f 0b eb a9 e8 54 3f 29 fe 48 c7 c6 c0 df 7c 88 48 c7 c7 00 d0 7c 88 e8 e1 70 f2 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 80 38 00 75 4a 4c 8b 2c 25 00
>>>>> RSP: 0018:ffff8880ae6079f8 EFLAGS: 00010286
>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>> RDX: 0000000000000100 RSI: ffffffff81687fa6 RDI: 0000000000000006
>>>>> RBP: ffff8880ae607a18 R08: ffffffff8987dec0 R09: 0000000000000000
>>>>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a86b3100
>>>>> R13: ffff8880a86b3100 R14: ffff8880a86b3188 R15: dffffc0000000000
>>>>>  security_cred_free+0x4b/0xf0 security/security.c:1490
>>>> The obvious thing to do is put a check in security_cred_free
>>>> for a NULL cred->security, in which case the LSM hooks
>>>> wouldn't get called.
>>> Right, but the question is should we? To my thinking we shouldn't
>>> ever have a cred without cred->security, unless the cred was
>>> allocated but a later step in its construction, say allocating
>>> ->security failed.
>> If allocating ->security fails in security_cred_alloc_blank()
>> or security_prepare_creds() you don't have to do anything but
>> fail because the LSM hooks are not called before the allocation.
>>
>>> In which case I'd rather see the cred directly freed and not
>>> call into security_cred_free() as I like being able to detect
>>> corrupt creds.
>> I think we need to look for some bit of code that's setting
>> cred->security to NULL inappropriately.
> If security_cred_alloc_blank() fails for lack of memory
> in cred_alloc_blank() abort_creds() will be called. This
> in turn calls put_cred() and put_cred_rcu(), which will
> call security_cred_free() with ->security set to NULL.
>
> put_cred_rcu() is the only caller of security_cred_free().
> The ->security == NULL check can be in either put_cred_rcu()
> or in security_cred_free(). I suggest the latter as the
> cleanest option.

From 47134986133c822e1d88860fa2b108f92c97a7ff Mon Sep 17 00:00:00 2001
From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 11 Jan 2019 17:31:50 -0800
Subject: [PATCH 1/2] LSM: Check for NULL cred-security on free

Check that the cred security blob has been set before trying
to clean it up. There is a case during credential initialization
that could result in this.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/security.c b/security/security.c
index a618e22df5c6..7bffc86d4e87 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1477,6 +1477,13 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 
 void security_cred_free(struct cred *cred)
 {
+	/*
+	 * There is a failure case in prepare_creds() that
+	 * may result in a call here with ->security being NULL.
+	 */
+	if (unlikely(cred->security == NULL))
+		return;
+
 	call_void_hook(cred_free, cred);
 
 	kfree(cred->security);
-- 
2.20.1


