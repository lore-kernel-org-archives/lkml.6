Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8559DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8520895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 22:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjvE4LFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E8520895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFPWFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 18:05:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50794 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeFPWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 18:05:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so8492517wmd.0;
        Sat, 16 Jun 2018 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8pN4kOWxeGRepY9xcOzNW6uvB53cDLiDVi1ddd7uEPg=;
        b=QjvE4LFtmwDKQ3OasjXxjFOhk2KwKSQ30rpTCavcjhMH4gVDEu7Yn8x3TsWSqeR69d
         +P1sYpqQkMRdaMCnGC3+EIhm7uryhhgNg2jflR9Yo6BaJsYKTwqLK1Vt9uo3bQC77wwe
         lwg1p7fhb6yTijq4+En100p5YKJcTtZ/WvRCfOAyHc2YNaKEhwbJbRzehIuIS500f6HE
         /8sJ4Un54dH0PBB9JPdZNbRjkS96wQOJk2bbu/p+6cTlGuERj8bx5rkS0uPTSe9nfHXU
         dAlC931pv1G3uvlvUISl0v6tSMr5HhRe1A+4il+6fkV8o5MCbx0i11d42AEs7V55Ypts
         qYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pN4kOWxeGRepY9xcOzNW6uvB53cDLiDVi1ddd7uEPg=;
        b=WXpI7s54CpOQ/iTB0NdwsT69jX1e4OVW6OuwhGwwJs9u4/EQ5hscvbjO/nfqntUkpY
         24Octrq3/H5/wFv+Liy2dLoQnLpg6VnMS0xx83nSAcMGJTnlwP7d+qajNfLKB315UUEQ
         Dy6pWEG5kXt0riSpg50nL1cw0TSU9b8O7RVaLJpWFLj3yThcWeA9cRxmAj/9kebq7Muc
         rf9eBe0glOAle8hL7t1fYUf1Ts4vZq9dqz1DPmRyqjF5k4Rs5pZM+DxpeToDH4UUjsz5
         exkOPPv86bHQQ4ORHjhgE39ZEYGtMjQQ+QMbkjUMRtiM4IkuP0W3Vk1zhFrwHwmPIXWL
         PR6Q==
X-Gm-Message-State: APt69E3pt/uHkDhDvtYAqbYMq9PWXPamrqSVLndf5kV9WEZXUdA8+1ax
        Lwh1RK/T3VKU/ele/8FK8IAhfCJnmx4=
X-Google-Smtp-Source: ADUXVKJCQ3LFsG3AHJqf2e2d0WE0g3LLnLiGQa+XVwx4/kqD+aZV60BcP212pw0RBax41fWIpB9pjw==
X-Received: by 2002:a1c:30d7:: with SMTP id w206-v6mr4408028wmw.153.1529186708014;
        Sat, 16 Jun 2018 15:05:08 -0700 (PDT)
Received: from [192.168.1.131] ([188.25.245.15])
        by smtp.gmail.com with ESMTPSA id l10-v6sm11498620wrm.29.2018.06.16.15.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 15:05:07 -0700 (PDT)
Message-ID: <1529186697.2784.2.camel@gmail.com>
Subject: Re: wmi: usercopy: Kernel memory overwrite attempt detected to
 spans multiple pages (offset 0, size 4104)
From:   Mihai =?UTF-8?Q?Don=C8=9Bu?= <mihai.dontu@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Date:   Sun, 17 Jun 2018 01:04:57 +0300
In-Reply-To: <1529182886.3450.3.camel@gmail.com>
References: <1529182886.3450.3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 00:01 +0300, Mihai Donțu wrote:
> While trying to adjust the keyboard backlight mode, I hit this BUG:
> 
> Jun 16 22:16:07 mdontu-l kernel: usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 4104)!
> Jun 16 22:16:07 mdontu-l kernel: ------------[ cut here ]------------
> Jun 16 22:16:07 mdontu-l kernel: kernel BUG at mm/usercopy.c:100!
> Jun 16 22:16:07 mdontu-l kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> Jun 16 22:16:07 mdontu-l kernel: Modules linked in: vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
> Jun 16 22:16:07 mdontu-l kernel: CPU: 1 PID: 11726 Comm: smbios-keyboard Tainted: G           O    T 4.17.1-gentoo #1
> Jun 16 22:16:07 mdontu-l kernel: Hardware name: Dell Inc. Latitude E7440/07F3F4, BIOS A25 02/01/2018
> Jun 16 22:16:07 mdontu-l kernel: RIP: 0010:usercopy_abort+0x74/0x76
> Jun 16 22:16:07 mdontu-l kernel: RSP: 0018:ffff9235021b7d98 EFLAGS: 00010246
> Jun 16 22:16:07 mdontu-l kernel: RAX: 0000000000000061 RBX: ffff8be94b0d8000 RCX: 0000000000000000
> Jun 16 22:16:07 mdontu-l kernel: RDX: 0000000000000000 RSI: ffff8be95ea95538 RDI: ffff8be95ea95538
> Jun 16 22:16:07 mdontu-l kernel: RBP: 0000000000001008 R08: 00000000000ecdbf R09: 00000000000003ce
> Jun 16 22:16:07 mdontu-l kernel: R10: 0000000000000000 R11: ffffffff9384378d R12: 0000000000000000
> Jun 16 22:16:07 mdontu-l kernel: R13: ffff8be94b0d9008 R14: 0000000000000000 R15: ffff8be94e04d350
> Jun 16 22:16:07 mdontu-l kernel: FS:  00007715b596f540(0000) GS:ffff8be95ea80000(0000) knlGS:0000000000000000
> Jun 16 22:16:07 mdontu-l kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 16 22:16:07 mdontu-l kernel: CR2: 00007715b28bc350 CR3: 0000000390ee0001 CR4: 00000000001606e0
> Jun 16 22:16:07 mdontu-l kernel: Call Trace:
> Jun 16 22:16:07 mdontu-l kernel:  __check_object_size.cold.2+0x16/0x7d
> Jun 16 22:16:07 mdontu-l kernel:  wmi_ioctl+0x85/0x190
> Jun 16 22:16:07 mdontu-l kernel:  do_vfs_ioctl+0xa8/0x680
> Jun 16 22:16:07 mdontu-l kernel:  ksys_ioctl+0x60/0x90
> Jun 16 22:16:07 mdontu-l kernel:  __x64_sys_ioctl+0x16/0x20
> Jun 16 22:16:07 mdontu-l kernel:  do_syscall_64+0x6f/0x500
> Jun 16 22:16:07 mdontu-l kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jun 16 22:16:07 mdontu-l kernel: RIP: 0033:0x7715b461dbd7
> Jun 16 22:16:07 mdontu-l kernel: RSP: 002b:00007ffec2afb618 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Jun 16 22:16:07 mdontu-l kernel: RAX: ffffffffffffffda RBX: 000056c3a5638bc0 RCX: 00007715b461dbd7
> Jun 16 22:16:07 mdontu-l kernel: RDX: 000056c3a5638bc0 RSI: 00000000c0345700 RDI: 0000000000000003
> Jun 16 22:16:07 mdontu-l kernel: RBP: 0000000000001008 R08: 000056c3a5638bc0 R09: 0000000000000000
> Jun 16 22:16:07 mdontu-l kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007715b2ac9580
> Jun 16 22:16:07 mdontu-l kernel: R13: 000056c3a56323e0 R14: 00000000fffffffb R15: 0000000000000003
> Jun 16 22:16:07 mdontu-l kernel: Code: 48 0f 45 c6 48 c7 c2 e1 65 b8 92 48 c7 c6 5b 85 b7 92 51 48 0f 45 f2 48 89 f9 41 52 48 89 c2 48 c7 c7 c8 66 b8 92 e8 fd fc ea ff <0f> 0b 49 89 e8 31 c9 44 89 e2 31 f6 48 c7 c7 1c 66 b8 92 e8 74 
> Jun 16 22:16:07 mdontu-l kernel: RIP: usercopy_abort+0x74/0x76 RSP: ffff9235021b7d98
> Jun 16 22:16:07 mdontu-l kernel: ---[ end trace d1b2e9ad540f2091 ]---
> 
> I couldn't pinpoint the exact user copy call that triggers it:
> 
> (gdb) list *wmi_ioctl+0x85/0x190
> 0xffffffff81be9470 is in wmi_ioctl (drivers/platform/x86/wmi.c:816).
> 811                                            &wblock->req_buf_size,
> 812                                            sizeof(wblock->req_buf_size));
> 813     }
> 814
> 815     static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> 816     {
> 817             struct wmi_ioctl_buffer __user *input =
> 818                     (struct wmi_ioctl_buffer __user *) arg;
> 819             struct wmi_block *wblock = filp->private_data;
> 820             struct wmi_ioctl_buffer *buf = NULL;
> 
> I have attached my kernel config.

I eventually sprinkled some printk-s and got this:

 855         if (copy_from_user(buf, input, wblock->req_buf_size)) {
 856                 dev_dbg(&wblock->dev.dev, "Copy %llu from user failed\n",
 857                         wblock->req_buf_size);
 858                 ret = -EFAULT;
 859                 goto out_ioctl;
 860         }

Regards,

-- 
Mihai Donțu

