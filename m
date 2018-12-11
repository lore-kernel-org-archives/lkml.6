Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC449C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D46620849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOtUU/Hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D46620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLKKQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:16:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36252 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeLKKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:16:33 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so2893159itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQQbudlyyqw9QYq7OpcsZgG7rfcHPWsyg5HZGpcEpbs=;
        b=BOtUU/Hr/acuLDPKBCKOLuS6NcmQjAuorPMHXadIlCWy43QnoB8zK30s54Pc/552O7
         0N/W7Fy+0eXh0VZgSEfSm6RU9sviBltEIg9fp64/q0EqEzQpexFj46BQDBAj5opkSoxw
         52xCxxVZpO3HW8s0PQm8/6vdriKo/JGLN9M+ljd2/XrrQy+AkGFoTApXZt3PnzMjRb5+
         jVlTGXedbK5B1VhdsHRqcTsRYtQqGXCbdDcGY21FK+5/d8qadUUG8Pb8LcPOdfOhAFae
         4RLmfMZyfkqyZ2DxxV68LsRIPuapyCaWKEZcH51Eu1rNjVE9vVV435Wu7kA12rDXBLVG
         0+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQQbudlyyqw9QYq7OpcsZgG7rfcHPWsyg5HZGpcEpbs=;
        b=cqZNAVBDQGKqE/W/4bh0gCtXN8DeX7BoAPZI7urvbGWnRdg3ssmpSFXsFC55Mhg4us
         FXEjCxM+suncnnijpwCPjiLI2Y/7rTPw3e+88alckoj/v9Brc136B/8reg+zpu3Vukn+
         AVCPLdqikUi7jq1678s/nsxaNlmNtCrR0sVa/8rc9CRiZV1kK/YVrzc0ZbAzb1EAUDD4
         GrdObXgBz2oNHiRRzVUDx1SdRYXufCVmN4JVAzWZ52nKqxhgRq1keHWvJ3QqTKur7Djn
         YRdfGxxxV0oklg8XkaWT9pZax6/WB+xYfMIgalOGD+nwR4vsj2j56T6yXzBhvzEd7hqO
         xoVw==
X-Gm-Message-State: AA+aEWY6tnZ/KGM1QpZR1ABvt/UH6ey9Z5ao67eEMa/FairB30M/SApR
        daiZAAdb1UF7nPF2VyV7lPJ7rqz4b6t874mJ2/AX1Q==
X-Google-Smtp-Source: AFSGD/VwoKxxhm3cSAV/rJ0M/u6rPFpBKmU+VaoppwUI7SQk1Ilb8+DUU9YoGLgkxRtzxMLmT9UUczlOhgZkDNodR90=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr1464115itl.144.1544523391894;
 Tue, 11 Dec 2018 02:16:31 -0800 (PST)
MIME-Version: 1.0
References: <bug-201949-27@https.bugzilla.kernel.org/> <20181210154550.03bf3fe93944a7c786ba924d@linux-foundation.org>
In-Reply-To: <20181210154550.03bf3fe93944a7c786ba924d@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Dec 2018 11:16:20 +0100
Message-ID: <CACT4Y+a_J1sjL352sY=+6paZDg2-4V9UPa8t3XBNeZfYw_ZHWA@mail.gmail.com>
Subject: Re: [Bug 201949] New: KASAN: use-after-free Read in __handle_mm_fault
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        bugzilla-daemon@bugzilla.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>, jaguo2014@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:45 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).

Looking at the reproducer this looks like a bug in sg ioctl.
+block/scsi_ioctl.c maintainers

> On Mon, 10 Dec 2018 10:56:31 +0000 bugzilla-daemon@bugzilla.kernel.org wrote:
>
> > https://bugzilla.kernel.org/show_bug.cgi?id=201949
> >
> >             Bug ID: 201949
> >            Summary: KASAN: use-after-free Read in __handle_mm_fault
> >            Product: Memory Management
> >            Version: 2.5
> >     Kernel Version: 4.19-rc2,4.20-rc5,4.20-rc6
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Other
> >           Assignee: akpm@linux-foundation.org
> >           Reporter: jaguo2014@outlook.com
> >         Regression: No
> >
> > Created attachment 279915
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=279915&action=edit
> > poc.c
> >
> > Syzkaller hit 'KASAN: use-after-free Read in __handle_mm_fault' bug.
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in handle_pte_fault mm/memory.c:3744 [inline]
> > BUG: KASAN: use-after-free in __handle_mm_fault+0x1b5d/0x1d20 mm/memory.c:3889
> > Read of size 8 at addr ffff888000048008 by task syz-executor666/2067
> >
> > CPU: 0 PID: 2067 Comm: syz-executor666 Not tainted 4.20.0-rc5+ #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x75/0xae lib/dump_stack.c:113
> >  print_address_description+0x65/0x270 mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report+0x25b/0x380 mm/kasan/report.c:412
> >  handle_pte_fault mm/memory.c:3744 [inline]
> >  __handle_mm_fault+0x1b5d/0x1d20 mm/memory.c:3889
> >  handle_mm_fault+0xfc/0x350 mm/memory.c:3926
> >  do_user_addr_fault arch/x86/mm/fault.c:1423 [inline]
> >  __do_page_fault+0x4f4/0xaa0 arch/x86/mm/fault.c:1489
> >  async_page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1142
> > RIP: 0033:0x4014fd
> > Code: Bad RIP value.
> > RSP: 002b:00007ffdaac075f0 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 00007ffdaac07790 RCX: 00007f6df4bee2f0
> > RDX: 0000000000000001 RSI: 00007f6df4bea270 RDI: 00007f6df4e08ae0
> > RBP: 0000000000000000 R08: 00007f6df4e08800 R09: 00007f6df4bea270
> > R10: 00007f6df4e08800 R11: 0000000000000202 R12: 0000000000000000
> > R13: 00007ffdaac07920 R14: 0000000000000000 R15: 0000000000000000
> >
> > The buggy address belongs to the page:
> > page:ffffea0000001200 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> > flags: 0x0()
> > raw: 0000000000000000 ffffea0000001208 ffffea0000001208 0000000000000000
> > raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff888000047f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >  ffff888000047f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >ffff888000048000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >                       ^
> >  ffff888000048080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >  ffff888000048100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ==================================================================
> >
> >
> > Syzkaller reproducer:
> > # {Threaded:false Collide:false Repeat:true RepeatTimes:0 Procs:8 Sandbox:
> > Fault:false FaultCall:-1 FaultNth:0 EnableTun:false UseTmpDir:true
> > EnableCgroups:false EnableNetdev:false ResetNet:false HandleSegv:true
> > Repro:false Trace:false}
> > r0 = syz_open_dev$sg(&(0x7f0000000180)='/dev/sg#\x00', 0x0, 0x0)
> > ioctl$SCSI_IOCTL_SEND_COMMAND(r0, 0x1, &(0x7f0000000080)={0x1, 0x0, 0x8, "ae"})
> >
> > --
> > You are receiving this mail because:
> > You are the assignee for the bug.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20181210154550.03bf3fe93944a7c786ba924d%40linux-foundation.org.
> For more options, visit https://groups.google.com/d/optout.
