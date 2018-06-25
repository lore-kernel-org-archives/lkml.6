Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39E9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C402548C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXohHapR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C402548C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeFYFl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:41:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36966 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeFYFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:41:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id v25-v6so3690876lji.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=15dkHlzOV3pHj48DfVqBEinwM+w4YJRFadLj5zjOaSU=;
        b=fXohHapRB2z+xv7jNqdxUV+7ph+OEU/K6C0zZW1ezbgbPY5/HpCmWO7lkySj2Z5Gzn
         Q2lTQKc7Zvwg54ie+LBd6dDZVl4oZyUwlaVEGIPsRM32LJ7oVvYaZELrH9LeQwBv11me
         djFG/zLygh+6HkMQGU/GkfnBJksFm0zanZdKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=15dkHlzOV3pHj48DfVqBEinwM+w4YJRFadLj5zjOaSU=;
        b=X4DchMctKbJonobS8VPq4GwJOXz2IcR1e+N+pLYBNAWhTzmO27fn8+6cvGXYUmil9N
         mRwrPpvbLQtPN96Oho/jV+ryebxVWw3lUiqLSpvbRYgtM38vG7bCM1otC/17xWTcg8Gq
         V+eMVs/StEN+1vU7msyyZYaM+DgRsEebS2qApyj94ESuPls+f7GCd7u+QoTe7LDGTuAk
         q/jVAz/X8803KU1EHTuyG6C+sFdXro0nOKEyRqh3pVienxqKOU+Dr6p61ZkPqaoBAtyP
         qfo2TbeSKK37ItuVEu5B0MVW2BiJ3KQ8hWKS/juXin8XUKx0f/CQvzki4aE0Wsbyg6lR
         pqrw==
X-Gm-Message-State: APt69E2QExIuB9rgwdinYYEli/YUfwqjWwUHaTZu94zp6ggJYxW1o2D1
        N8WEsQTxMGYwzGPESQPXpVjhsNStuW/araKxOmmj4zYm/7o=
X-Google-Smtp-Source: ADUXVKKYtHUp4JB0gn9Pfq6pCEHVR1EDvx1kotMrCFYHBwHGmQBR97NICZY4rDcnLQ/ydoIfvkcDdnOe2uXkH9lqCyo=
X-Received: by 2002:a2e:60:: with SMTP id 93-v6mr6909032lja.96.1529905283409;
 Sun, 24 Jun 2018 22:41:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 22:41:22
 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 11:11:22 +0530
Message-ID: <CA+G9fYu0E0fM+WaFim1WKup5BZvjtGZ_4ii5FhTUjNZEqaAuwA@mail.gmail.com>
Subject: qemu-system-x86_64: mov_ss_trap_64 PANIC: double fault, error_code: 0x0
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Tinoco <rafael.tinoco@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kselftest test case mov_ss_trap_64 is causing kernel panic on
qemu-system-x86_64 and PASS on real x86_64 hardware.

Test code snippet,
main() {
<>
      printf("[RUN]\tMOV SS; CS CS INT3\n");
      asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
<>
}

Linux version 4.17.3-rc1 (buildslave@lkft-01) (gcc version 6.2.1 20161016
(Linaro GCC 6.2-2016.11)) #1 SMP Thu Jun 21 02:19:19 UTC 2018

This test was good on kernel 4.17.2
good  git commit: 3816828a8cd06c5e0a0a9e0456013d61d979d975

Bad on 4.17.3-rc1 (and stable-rc 4.14.52-rc1)
Bad git commit: 894caab83aab21f120cde83eb5b969b99fcf8696

git repo:
 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

qemu-system-x86_64 version 2.12.0

steps to reproduce and test log,
+ cd tools/testing/selftests/x86
+ ./mov_ss_trap_64

SS = 0x2b, &SS = 0x0x604188
Set up a watchpoint
DR0 = 604188, DR1 = 400a19, DR7 = 7000a
[RUN] Read from watched memory (should get SIGTRAP)
Got SIGTRAP with RIP=4008ea, EFLAGS.RF=0
[RUN] MOV SS; INT3
Got SIGTRAP with RIP=4008fb, EFLAGS.RF=0
[RUN] MOV SS; INT 3
Got SIGTRAP with RIP=40090d, EFLAGS.RF=0
[RUN] M[   20.305426] PANIC: double fault, error_code: 0x0
OV SS; CS CS INT3
Got SIGTRAP with RIP=400920,[   20.308317] CPU: 3 PID: 2471 Comm:
mov_ss_trap_64 Not tainted 4.17.3-rc1 #1
 EFLAGS.RF=0
[RUN] MOV SS; CSx14 INT3
[   20.311664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
 1.10.2-1 04/01/2014
[   20.314738] RIP: 0010:error_entry+0x32/0x100
<trim>
[   20.336649] Call Trace:
[   20.337523]  <ENTRY_TRAMPOLINE>
[   20.338507]  ? native_iret+0x7/0x7
[   20.339611]  ? page_fault+0x8/0x30
[   20.340693]  ? error_entry+0x86/0x100
[   20.341871]  ? trace_hardirqs_off_caller+0x7/0xa0
[   20.343212]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   20.344554]  ? native_iret+0x7/0x7
[   20.345647]  ? page_fault+0x8/0x30
[   20.346716]  ? error_entry+0x86/0x100
[   20.347853]  ? page_fault+0x8/0x30
[   20.348920]  ? ist_enter+0x6/0xa0
[   20.349961]  ? do_int3+0x34/0x120
[   20.351095]  ? int3+0x14/0x20
[   20.352047]  </ENTRY_TRAMPOLINE>
[   20.353060] Code: 48 89 7c 24 08 52 31 d2 51 31 c9 50 41 50 45 31
c0 41 51 45 31 c9 41 52 45 31 d2 41 53 45 31 db 53 31 db 55 31 ed 41
54 45 31 e4 <41> 55 45 31 ed 41 56 45 31 f6 41 57 45 31 ff 56 48 8d 6c
24 09
[   20.357895] Kernel panic - not syncing: Machine halted.

Bug ink,
https://bugs.linaro.org/show_bug.cgi?id=3916

Test case link,
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/tools/testing/selftests/x86/mov_ss_trap.c?h=linux-4.17.y

Best regards
Naresh Kamboju
