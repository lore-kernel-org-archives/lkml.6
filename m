Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CD320656
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB3BgDEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfADNrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:47:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40321 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:47:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so25431069lfe.7;
        Fri, 04 Jan 2019 05:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GAvkoIRXt8aXaoDK6Iin6R48/Wao2wwPJF2MIc6IMkI=;
        b=bB3BgDEj518DRR1JrrFSWwlmFOGVup9clzk4dfgNSvDJebcpeozuvTHIo+xy1itxGM
         X0D1RBesoqklTR4IfG8cGNO7zJwlwVm+bjR2CVT0vO5pRfu6lET2yG2lqx7JNErQQ97T
         R6ScuusbSFALBifBpwOz9wdFG97gpcXwsOMeeLtIMTYF4kQxgB2Bz8iOzVFGVoLCG4li
         f23dW2HU03xddcVDkrc6ckDwPmDpTe3T6E07HAnPB6FqOpKLUnBVHR/IpDvGkLCE5K0M
         FosGAfhNxcluPNn73ONLN7K114f0ehzQFvc9aPlyzFa1kB6lqUzrXM5FUuUugGeMgHmC
         Axzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GAvkoIRXt8aXaoDK6Iin6R48/Wao2wwPJF2MIc6IMkI=;
        b=icZX4hwRNsQ/fydCM3hsTWI/EoSKf+LgnCW9y/PQL6f55WmwDTmVDQjzgMcBbkwx+d
         jYB+Ea9reOU58HbICPbSWdvLf6IS3LIZ3+1gupU6Vy3gCIcpN3apNW4Yvtew+o7/sbwA
         v0PUJqdD8K/AlLw1W17pVtaUrr1fgpthGH//82A0Y+gIN4oWW8coLy6+grIUzbQYns1e
         A24PpAdPDpaLEaLszDbuJ0OY11nqixREFwznGEi++T1AAa61W25GBJm3ZIzjyd1N0RnT
         txCc4iOXQwPGG+hqpEuVaDz6MPngMGCRXcCWL9yxiY511IL1qaT07wXg8zPXO6Z8Ud3L
         TdJw==
X-Gm-Message-State: AJcUukcQDQA6ZjKL1/TcizSs0ZeIzz8z3V+UXVJWzmD7E54VwKzftCQX
        VV0CK2jEuHAzRL7K+H+FJNcJoHU19GZHHfC0AHs=
X-Google-Smtp-Source: ALg8bN6YFWoMyTXL91qfR7DfjRn0teMXLDpdd9S5+oFBNjxOyghOyFEHFDUkIoT8y0uYS3x7lRjuswgd1AP2ImcGjXQ=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr16674825lfa.40.1546609634823;
 Fri, 04 Jan 2019 05:47:14 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
In-Reply-To: <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Fri, 4 Jan 2019 16:47:03 +0300
Message-ID: <CAE5jQCe=+-CpGToU=5sXrTfv+nbHxpvZexS6BNstvGNGF2Uszw@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I wanted to tell you that I started investigating the other private
> report you sent us, but couldn't find the time to properly come with a
> fix as the fuzzed data is hard to discriminate from valid data.

Oops, I thought I was "over securing" these issues and everyone
ignored them since I heard default policy here is to not send reports
privately without a good reason, so I re-evaluated them and sent
publicly...

OTOH these ones seem to be not too severe: on the first glance they
require a physical or root access, and even if they don't, *these
ones* are only NULL dereferences.

Best regards
Anatoly

=D0=BF=D1=82, 4 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 16:25, Benjamin Tis=
soires <benjamin.tissoires@redhat.com>:
>
> Hi Anatoly,
>
>
> On Fri, Jan 4, 2019 at 1:32 PM Anatoly Trosinenko
> <anatoly.trosinenko@gmail.com> wrote:
> >
> > Hello,
> >
> > When writing the attached file to /dev/uhid, a NULL dereference occurs
> > in kernel. As I understand, the problem is not UHID-specific, but is
> > related to HID subsystem.
>
> Thanks for the report.
> I wanted to tell you that I started investigating the other private
> report you sent us, but couldn't find the time to properly come with a
> fix as the fuzzed data is hard to discriminate from valid data.
>
> A couple of notes though:
> - writing to uhid needs to be done by root. Any distribution that
> doesn't enforce that is doomed to have several security issues
> - we could somehow reproduce those fuzzed data on a USB or Bluetooth
> connection, but that would require physical access to the device, so
> you are doomed also
> - last IIRC, there was some attempts by the ChromeOS team to allow
> access to the HID stack from the Chrome plugins, I don't know if this
> is able to generate the issues.
>
> On the specifics reported here:
>
> >
> > How to reproduce:
> > 1) Checkout the fresh master branch of the Linux kernel (tested on
> > commit 96d4f267e)
> > 2) Compile it with the attached config (kvm-xfstests capable)
> > 3) Take one of reproducers and execute
> > cat /vtmp/repro > /dev/uhid
> >
> > What happens:
> >
> > For chicony.bin:
> >
> > root@kvm-xfstests:~# cat /vtmp/chicony.bin > /dev/uhid
> > [   19.072703] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000002
> > [   19.073371] #PF error: [normal kernel read fault]
> > [   19.073755] PGD 8000000078b2c067 P4D 8000000078b2c067 PUD 0
> > [   19.074223] Oops: 0000 [#1] SMP PTI
> > [   19.074809] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
> > 4.20.0-xfstests-10979-g96d4f267e40 #1
> > [   19.075965] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.11.1-1ubuntu1 04/01/2014
> > [   19.077599] Workqueue: events uhid_device_add_worker
> > [   19.078019] RIP: 0010:ch_switch12_report_fixup+0x13/0x70
>
> This driver expects the device to be connected on USB, and you are
> triggering the oops because you are on uhid.
> I am chasing the USB dependencies in most drivers, but this is a hard
> task to do when I do not have access to the actual devices.
>
> I guess one way of fixing that is to add a check for the actual
> transport driver during probe:
> hid_is_using_ll_driver(hdev, &usb_hid_driver)
>
> Patches are welcome :)
>
> > [   19.078462] Code: 49 8b 00 3e 80 60 20 df b8 01 00 00 00 c3 66 0f
> > 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 8f 48 19 00 00 48 89 f0 48
> > 8b 49 d8 <80> 79 02 01 74 01 c3 81 7f 3c 21 14 00 00 75 f6 83 3a 7f 76
> > f1 80
> > [   19.080103] RSP: 0018:ffffa1d880367c48 EFLAGS: 00010286
> > [   19.080541] RAX: ffff9b653d27b180 RBX: ffff9b653a6fb948 RCX: 0000000=
000000000
> > [   19.081133] RDX: ffffa1d880367c5c RSI: ffff9b653d27b180 RDI: ffff9b6=
53a6fa000
> > [   19.081780] RBP: ffff9b653d27b180 R08: 000000064992eed0 R09: 0000000=
000000000
> > [   19.082409] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9b6=
53a6fa000
> > [   19.083017] R13: ffffffff83f14510 R14: ffffffff83f14440 R15: 0000000=
000000000
> > [   19.083619] FS:  0000000000000000(0000) GS:ffff9b653fc00000(0000)
> > knlGS:0000000000000000
> > [   19.084362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   19.085164] CR2: 0000000000000002 CR3: 00000000788b8004 CR4: 0000000=
000360ef0
> > [   19.085789] Call Trace:
> > [   19.086011]  hid_open_report+0x81/0x2c0
> > [   19.086341]  hid_device_probe+0x135/0x160
> > [   19.086754]  ? __driver_attach+0x110/0x110
> > [   19.087109]  really_probe+0xe0/0x390
> > [   19.087411]  ? __driver_attach+0x110/0x110
> > [   19.087782]  bus_for_each_drv+0x78/0xc0
> > [   19.088134]  __device_attach+0xcc/0x130
> > [   19.088477]  bus_probe_device+0x9f/0xb0
> > [   19.088832]  device_add+0x422/0x680
> > [   19.089144]  ? __debugfs_create_file+0xb5/0xf0
> > [   19.089536]  hid_add_device+0xec/0x280
> > [   19.089880]  uhid_device_add_worker+0x15/0x60
> > [   19.090270]  process_one_work+0x238/0x5d0
> > [   19.090627]  worker_thread+0x3d/0x390
> > [   19.090959]  ? process_one_work+0x5d0/0x5d0
> > [   19.091331]  kthread+0x121/0x140
> > [   19.096732]  ? __kthread_create_on_node+0x1a0/0x1a0
> > [   19.097164]  ret_from_fork+0x3a/0x50
> > [   19.097483] CR2: 0000000000000002
> > [   19.097779] ---[ end trace 1b547acaae113039 ]---
> > [   19.098186] RIP: 0010:ch_switch12_report_fixup+0x13/0x70
> > [   19.098621] Code: 49 8b 00 3e 80 60 20 df b8 01 00 00 00 c3 66 0f
> > 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 8f 48 19 00 00 48 89 f0 48
> > 8b 49 d8 <80> 79 02 01 74 01 c3 81 7f 3c 21 14 00 00 75 f6 83 3a 7f 76
> > f1 80
> > [   19.100251] RSP: 0018:ffffa1d880367c48 EFLAGS: 00010286
> > [   19.100707] RAX: ffff9b653d27b180 RBX: ffff9b653a6fb948 RCX: 0000000=
000000000
> > [   19.101321] RDX: ffffa1d880367c5c RSI: ffff9b653d27b180 RDI: ffff9b6=
53a6fa000
> > [   19.102448] RBP: ffff9b653d27b180 R08: 000000064992eed0 R09: 0000000=
000000000
> > [   19.103029] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9b6=
53a6fa000
> > [   19.103601] R13: ffffffff83f14510 R14: ffffffff83f14440 R15: 0000000=
000000000
> > [   19.104173] FS:  0000000000000000(0000) GS:ffff9b653fc00000(0000)
> > knlGS:0000000000000000
> > [   19.104823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   19.105289] CR2: 0000000000000002 CR3: 00000000788b8004 CR4: 0000000=
000360ef0
> > [   19.105864] BUG: sleeping function called from invalid context at
> > include/linux/percpu-rwsem.h:34
> > [   19.106578] in_atomic(): 0, irqs_disabled(): 1, pid: 5, name: kworke=
r/0:0
> > [   19.107671] INFO: lockdep is turned off.
> > [   19.108384] irq event stamp: 3576
> > [   19.108976] hardirqs last  enabled at (3575): [<ffffffff82e01ed5>]
> > __kmalloc_track_caller+0x185/0x310
> > [   19.112970] hardirqs last disabled at (3576): [<ffffffff82c015f4>]
> > trace_hardirqs_off_thunk+0x1a/0x1c
> > [   19.114557] softirqs last  enabled at (3504): [<ffffffff834002b1>]
> > peernet2id+0x51/0x80
> > [   19.115897] softirqs last disabled at (3502): [<ffffffff83400292>]
> > peernet2id+0x32/0x80
> > [   19.117319] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G      D
> >     4.20.0-xfstests-10979-g96d4f267e40 #1
> > [   19.118739] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.11.1-1ubuntu1 04/01/2014
> > [   19.120049] Workqueue: events uhid_device_add_worker
> > [   19.120767] Call Trace:
> > [   19.121127]  dump_stack+0x67/0x90
> > [   19.121622]  ___might_sleep.cold.13+0x9f/0xaf
> > [   19.122278]  exit_signals+0x1c/0x200
> > [   19.122792]  do_exit+0xac/0xaf0
> > [   19.123619]  ? process_one_work+0x5d0/0x5d0
> > [   19.124520]  ? kthread+0x121/0x140
> > [   19.125050]  rewind_stack_do_exit+0x17/0x20
> >
> > For sony.bin:
> >
> > root@kvm-xfstests:~# cat /vtmp/sony.bin > /dev/uhid
> > [   16.891931] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.892432] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.892894] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.893362] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.893844] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.895389] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.898165] sony 0003:054C:1000.0001: ignoring exceeding usage max
> > [   16.901190] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.903797] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.906401] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.908957] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.911449] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.913936] sony 0003:054C:1000.0001: unknown main item tag 0x1
> > [   16.916551] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.918454] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.919743] sony 0003:054C:1000.0001: unknown main item tag 0x4
> > [   16.920834] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > [   16.921904] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > [   16.923006] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.924082] sony 0003:054C:1000.0001: unknown main item tag 0x2
> > [   16.925195] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.926289] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.927400] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > [   16.928546] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000028
> > [   16.929951] #PF error: [normal kernel read fault]
> > [   16.930884] PGD 800000007a52b067 P4D 800000007a52b067 PUD 0
> > [   16.931836] Oops: 0000 [#1] SMP PTI
> > [   16.932437] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
> > 4.20.0-xfstests-10979-g96d4f267e40 #1
> > [   16.933752] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.11.1-1ubuntu1 04/01/2014
> > [   16.935372] Workqueue: events uhid_device_add_worker
> > [   16.936321] RIP: 0010:hid_validate_values+0x48/0x110
>
> In a sense, it's good to have a fault there because this was added to
> make sure we do not blindly accept any data. The fact that it doesn't
> fail gracefully is a sign that there is something else.
> Maybe Roderick could have a look?
>
> Cheers,
> Benjamin
>
> > [   16.937690] Code: 4c 69 ce 03 01 00 00 4a 8d 44 08 0c 48 8b 44 c7
> > 08 48 85 c0 0f 84 a9 00 00 00 39 88 30 08 00 00 76 53 41 89 c9 4e 8b
> > 4c c8 30 <45> 39 41 28 72 69 48 83 c4 08 c3 89 f6 48 69 c6 18 08 00 00
> > 48 8b
> > [   16.941067] RSP: 0018:ffffb2c880367ab0 EFLAGS: 00010286
> > [   16.941935] RAX: ffff8d54b881c870 RBX: ffff8d54b881dd08 RCX: 0000000=
000000000
> > [   16.943203] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d5=
4b881c000
> > [   16.945406] RBP: ffff8d54bacb3580 R08: 0000000000000007 R09: 0000000=
000000000
> > [   16.946590] R10: 0000000000000000 R11: ffff8d54b80293e6 R12: ffff8d5=
4b881c000
> > [   16.947668] R13: dead000000000100 R14: ffff8d54b881c000 R15: ffff8d5=
4ba4fb818
> > [   16.948765] FS:  0000000000000000(0000) GS:ffff8d54bfc00000(0000)
> > knlGS:0000000000000000
> > [   16.949838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   16.950663] CR2: 0000000000000028 CR3: 000000007a4e8002 CR4: 0000000=
000360ef0
> > [   16.951513] Call Trace:
> > [   16.951870]  sony_input_configured+0xd6d/0x1060
> > [   16.952608]  ? kobject_set_name_vargs+0x6f/0x90
> > [   16.953257]  ? dev_set_name+0x57/0x70
> > [   16.953783]  ? init_timer_key+0xed/0x120
> > [   16.954353]  hidinput_connect+0x2fb/0x89b
> > [   16.954974]  hid_connect+0x2f3/0x370
> > [   16.955489]  hid_hw_start+0x38/0x60
> > [   16.956052]  sony_probe+0xba/0x160
> > [   16.956541]  hid_device_probe+0xf7/0x160
> > [   16.957103]  ? __driver_attach+0x110/0x110
> > [   16.957689]  really_probe+0xe0/0x390
> > [   16.958206]  ? __driver_attach+0x110/0x110
> > [   16.958797]  bus_for_each_drv+0x78/0xc0
> > [   16.959290]  __device_attach+0xcc/0x130
> > [   16.959832]  bus_probe_device+0x9f/0xb0
> > [   16.960407]  device_add+0x422/0x680
> > [   16.960772]  ? __debugfs_create_file+0xb5/0xf0
> > [   16.962459]  hid_add_device+0xec/0x280
> > [   16.963517]  uhid_device_add_worker+0x15/0x60
> > [   16.964304]  process_one_work+0x238/0x5d0
> > [   16.965062]  worker_thread+0x3d/0x390
> > [   16.965737]  ? process_one_work+0x5d0/0x5d0
> > [   16.966499]  kthread+0x121/0x140
> > [   16.967089]  ? __kthread_create_on_node+0x1a0/0x1a0
> > [   16.967988]  ret_from_fork+0x3a/0x50
> > [   16.968742] CR2: 0000000000000028
> > [   16.969394] ---[ end trace bc79f619177a8c3e ]---
> > [   16.970267] RIP: 0010:hid_validate_values+0x48/0x110
> > [   16.971167] Code: 4c 69 ce 03 01 00 00 4a 8d 44 08 0c 48 8b 44 c7
> > 08 48 85 c0 0f 84 a9 00 00 00 39 88 30 08 00 00 76 53 41 89 c9 4e 8b
> > 4c c8 30 <45> 39 41 28 72 69 48 83 c4 08 c3 89 f6 48 69 c6 18 08 00 00
> > 48 8b
> > [   16.974023] RSP: 0018:ffffb2c880367ab0 EFLAGS: 00010286
> > [   16.974805] RAX: ffff8d54b881c870 RBX: ffff8d54b881dd08 RCX: 0000000=
000000000
> > [   16.975925] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d5=
4b881c000
> > [   16.977035] RBP: ffff8d54bacb3580 R08: 0000000000000007 R09: 0000000=
000000000
> > [   16.978269] R10: 0000000000000000 R11: ffff8d54b80293e6 R12: ffff8d5=
4b881c000
> > [   16.979446] R13: dead000000000100 R14: ffff8d54b881c000 R15: ffff8d5=
4ba4fb818
> > [   16.980503] FS:  0000000000000000(0000) GS:ffff8d54bfc00000(0000)
> > knlGS:0000000000000000
> > [   16.981675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   16.982566] CR2: 0000000000000028 CR3: 000000007a4e8002 CR4: 0000000=
000360ef0
> > [   16.983712] BUG: sleeping function called from invalid context at
> > include/linux/percpu-rwsem.h:34
> > [   16.985362] in_atomic(): 0, irqs_disabled(): 1, pid: 5, name: kworke=
r/0:0
> > [   16.985947] INFO: lockdep is turned off.
> > [   16.986296] irq event stamp: 4040
> > [   16.986584] hardirqs last  enabled at (4039): [<ffffffffab201ed5>]
> > __kmalloc_track_caller+0x185/0x310
> > [   16.987354] hardirqs last disabled at (4040): [<ffffffffab0015f4>]
> > trace_hardirqs_off_thunk+0x1a/0x1c
> > [   16.988522] softirqs last  enabled at (3962): [<ffffffffabc0032f>]
> > __do_softirq+0x32f/0x440
> > [   16.989788] softirqs last disabled at (3955): [<ffffffffab0b32f6>]
> > irq_exit+0xa6/0xe0
> > [   16.992028] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G      D
> >     4.20.0-xfstests-10979-g96d4f267e40 #1
> > [   16.993354] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.11.1-1ubuntu1 04/01/2014
> > [   16.994960] Workqueue: events uhid_device_add_worker
> > [   16.996048] Call Trace:
> > [   16.996593]  dump_stack+0x67/0x90
> > [   16.997203]  ___might_sleep.cold.13+0x9f/0xaf
> > [   16.998004]  exit_signals+0x1c/0x200
> > [   16.998660]  do_exit+0xac/0xaf0
> > [   16.999232]  ? process_one_work+0x5d0/0x5d0
> > [   16.999987]  ? kthread+0x121/0x140
> > [   17.000709]  rewind_stack_do_exit+0x17/0x20
> >
> >
> > Best regards
> > Anatoly
