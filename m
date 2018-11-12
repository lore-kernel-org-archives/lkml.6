Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF971223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoF+MiGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF971223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeKMFnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:43:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36547 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeKMFnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:43:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id z17-v6so4523029pgv.3;
        Mon, 12 Nov 2018 11:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XHHadNktu0j6KGsGASHvM1gHUTwckemiePV7JCpX+yo=;
        b=DoF+MiGkuR4lAmLwaKSf67QbG5ivtO/3qrCu8jQYWSSDYAb4FkkHAGVtGLhb0gOmDG
         CiB4k/zjvoG3g7qrfDGrWZxB8bw6D0I6TWAW3RDFaayIP7DDWdJ7+njV1zQGotA7b53N
         Pfl1SHS9YghGn2hVwAfmOMhLFMQg9ZUs7xypS9k+uUjiagI/XxVbdnkJHDIxVOBjVx/f
         K+eT/T50ADnyFOOLHSteFHoa96VAoET0lqH2Maxu4udcxVomJ+1UoLjQV/k597uj+JxM
         8uNuP1uaovlibfhZaMc07RXrHl/yfkUJ0mUXywGK/6z+nGJPdvGQEVU7e1IaSckt7CW/
         Ae1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHHadNktu0j6KGsGASHvM1gHUTwckemiePV7JCpX+yo=;
        b=fkoyAavnmRYxw6f/9NEtawsAGBy9UeCUnd6lBm6GojflW8Ge9++g5MCr3ZtvMUYD9U
         B7N4gkmcyv52lwEgjc9FxEcwkQB+mzgzqkHqgtyOgCBN0MymikL48qS9pTy9yC3uMfC0
         ZZ9tQnZ7s5EhjhcGLrupvcePCzi8DUaU6TJWEBz54wkWe2oK7BE9GalNyPDWVYbQTJWY
         vUyMbfRymaIntscaVRXcpl1dWsrcjBs4m22UcMIKeB3I/PqXIzxlQr6/c7Do9yS/kn1g
         YkGHvHzRmAgsaTjO0o9C5DBchGvuDeVZA/C8LrqPHIdedYqEOEQI8EYAhbyWm+0g4g5B
         wOjQ==
X-Gm-Message-State: AGRZ1gKNZv4mqqQ0O4vXU2EpfBlDRyxcBPaiY4EF0KPj27iMHdhPJtxb
        jI5k5j0NkFink5vvNWVJ+ZI=
X-Google-Smtp-Source: AJdET5ej1AyML3n69SoIDHX4PTeth53A027INvyoIp+9ImJ2gtr0mUHlI1+SoDke2cC3saXcAPxX8Q==
X-Received: by 2002:a62:3891:: with SMTP id f139-v6mr2167130pfa.196.1542052137576;
        Mon, 12 Nov 2018 11:48:57 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x23-v6sm16442308pfm.126.2018.11.12.11.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:48:56 -0800 (PST)
Date:   Mon, 12 Nov 2018 11:48:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     liujian <liujian56@huawei.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: input: fix UBSAN warning in
 input_defuzz_abs_event
Message-ID: <20181112194853.GH192687@dtor-ws>
References: <1541166531-248528-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541166531-248528-1-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 02, 2018 at 09:48:51PM +0800, liujian wrote:
> syzkaller triggered a UBCAN warning:
> 
> [  196.188950] UBSAN: Undefined behaviour in drivers/input/input.c:62:23
> [  196.188958] signed integer overflow:
> [  196.188964] -2147483647 - 104 cannot be represented in type 'int [2]'
> [  196.188973] CPU: 7 PID: 4763 Comm: syz-executor Not tainted
> 4.19.0-514.55.6.9.x86_64+ #7
> [  196.188977] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  196.188979] Call Trace:
> [  196.189001]  dump_stack+0x91/0xeb
> [  196.189014]  ubsan_epilogue+0x9/0x7c
> [  196.189020]  handle_overflow+0x1d7/0x22c
> [  196.189028]  ? __ubsan_handle_negate_overflow+0x18f/0x18f
> [  196.189038]  ? __mutex_lock+0x213/0x13f0
> [  196.189053]  ? drop_futex_key_refs+0xa0/0xa0
> [  196.189070]  ? __might_fault+0xef/0x1b0
> [  196.189096]  input_handle_event+0xe1b/0x1290
> [  196.189108]  input_inject_event+0x1d7/0x27e
> [  196.189119]  evdev_write+0x2cf/0x3f0
> [  196.189129]  ? evdev_pass_values+0xd40/0xd40
> [  196.189157]  ? mark_held_locks+0x160/0x160
> [  196.189171]  ? __vfs_write+0xe0/0x6c0
> [  196.189175]  ? evdev_pass_values+0xd40/0xd40
> [  196.189179]  __vfs_write+0xe0/0x6c0
> [  196.189186]  ? kernel_read+0x130/0x130
> [  196.189204]  ? _cond_resched+0x15/0x30
> [  196.189214]  ? __inode_security_revalidate+0xb8/0xe0
> [  196.189222]  ? selinux_file_permission+0x354/0x430
> [  196.189233]  vfs_write+0x160/0x440
> [  196.189242]  ksys_write+0xc1/0x190
> [  196.189248]  ? __ia32_sys_read+0xb0/0xb0
> [  196.189259]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [  196.189267]  ? do_syscall_64+0x22/0x4a0
> [  196.189276]  do_syscall_64+0xa5/0x4a0
> [  196.189287]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  196.189293] RIP: 0033:0x44e7c9
> [  196.189299] Code: fc ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00
> 
> the syzkaller reproduce script(but can't reproduce it every time):
> 
> r0 = syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> 0x1)
> write$binfmt_elf64(r0, &(0x7f0000000240)={{0x7f, 0x45, 0x4c, 0x46, 0x40,
> 0x2, 0x2, 0xffffffff, 0xffffffffffff374c, 0x3, 0x0, 0x80000001, 0x103,
> 0x40, 0x22e, 0x26, 0x1, 0x38, 0x2, 0xa23, 0x1, 0x2}, [{0x6474e557, 0x5,
> 0x6, 0x2, 0x9, 0x9, 0x6c3, 0x1ff}], "", [[], [], [], []]}, 0x478)
> ioctl$EVIOCGSW(0xffffffffffffffff, 0x8040451b, &(0x7f0000000040)=""/7)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> r1 = syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> 0x1)
> openat$smack_task_current(0xffffffffffffff9c,
> &(0x7f0000000040)='/proc/self/attr/current\x00', 0x2, 0x0)
> ioctl$EVIOCSABS0(r1, 0x401845c0, &(0x7f0000000000)={0x4, 0x10000, 0x4,
> 0xd1, 0x81, 0x3})
> eventfd(0x1ff)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2,
> 0x200)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> syz_open_dev$evdev(&(0x7f0000000100)='/dev/input/event#\x00', 0x2, 0x1)
> 
> Typecast int to long to fix the issue.

Does this fix 32-bit platforms where long equals int? BTW, I'd prefer if
we did not have to do 64 bit arithmetic on 32 bit arches here, if
possible.

Thanks.

-- 
Dmitry
