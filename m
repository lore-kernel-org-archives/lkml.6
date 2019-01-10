Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E0EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FC5214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOQeyuEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfAJPIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:08:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52865 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfAJPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:08:48 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so17901751itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fabSKJsPWSm8V1hJ+QRifE5/oUxLz8u3EnVzsiAV5rY=;
        b=FOQeyuExviHoqBBnSK5Cd0spFg6ZxmnoZAfgjdaLCtCAEBWIL/7ZySruA4SdMJYBgY
         3y44peU7PeOUm7TX/2hiVZEOvkHXK/qoVf2u/cGxQnW/HDXrvdy/wmWkQSPceimH2uA7
         uBoDqgeg/TYWfDHcDZHSvIeBFzwIREk9TrxlS6p2Hdr0GkHE4664vaqpU7fBtfjYiAXP
         psu+zzrV+QutAAH5RE/lRYHKyv71puUmL2+ZF63qD0o1erZju0Sd+K2B5CGDgSMFXMus
         HKedh+rx0GOCCVHynUyxE0uRFyfEc+o0Ys5SRQ/tdm3pULl+pqE/1as6K4Ltz/L3fA6s
         aKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fabSKJsPWSm8V1hJ+QRifE5/oUxLz8u3EnVzsiAV5rY=;
        b=p/jv3tkGLqe/+RpoaPdBpt3FWSuBQD/hbvfH9oYigTqSD19/s0X9qqftQGvpP40NTc
         7cx0Sdu7X0GBX7+y/YWRsE97i6VRdKugucAWWkUurUaHO43gSPT1aUa3YAO5imFtqkYo
         +M4V6cVvr2Wvohs3TjFRHYNQDq2DIbxBTGAq0W3l0dCen0r5viF5ag4jdL/7lONONFb3
         9GQKSx02nO9zOUQgyA0tHo+7jn9FLVfi8vk7nKpiucCb3lwdQRfoOcqD+TT8J62GT4Dk
         o6ZCmJO5dgmMqVg4WZXiT1zzNRm6V3K3nMWo5o/CWcg9uzDgvq37MkAidB9NcfTa5BIP
         BPbA==
X-Gm-Message-State: AJcUukfZQmhg92jffzYgW+NQdIfDyzcH00XvlpxUJSiwM89a136iK2yZ
        HAMlBrDtslcmmozL7r6vIMOFyxCEgdbC4dTyYMQ=
X-Google-Smtp-Source: ALg8bN7DtoJh59PV2P4R63FNhoQIp7uQ+kK5yP5wKPJN5Q3VNIlXvG7TK/y2f9biLVkJUeFLslvJIxL49q49l+UJ6cY=
X-Received: by 2002:a24:c705:: with SMTP id t5mr7119481itg.60.1547132925867;
 Thu, 10 Jan 2019 07:08:45 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamus+rx1idSZrfHERXvbeWeUC3Fiy5UNL_pbp_-ZbafEjQ@mail.gmail.com>
 <4f72df46-d2ca-e15d-4df1-fe525bbfcdd0@enneenne.com>
In-Reply-To: <4f72df46-d2ca-e15d-4df1-fe525bbfcdd0@enneenne.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Thu, 10 Jan 2019 10:08:33 -0500
Message-ID: <CAEAjamvo5H8LKCEyQe4B-41MeYBJ9AbmnandugLWcDY_rn8Z=g@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in drivers/pps/pps.c
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that timeout.nsec doesn't need to be patched.
But before going further, I'm just curious why such timeout variables
in the kernel
are defined as signed type variable in the first place?

Thanks,
Kyungtae Kim

On Wed, Jan 9, 2019 at 4:20 AM Rodolfo Giometti <giometti@enneenne.com> wrote:
>
> On 08/01/2019 21:24, Kyungtae Kim wrote:
> > We report a bug in linux-4.20: "UBSAN: Undefined behaviour in drivers/pps/pps.c"
> >
> > kernel config: https://kt0755.github.io/etc/config_v4.20_stable
> > repro: https://kt0755.github.io/etc/repro.a6372.c
> >
> > pps_cdev_pps_fetch() lacks the bounds checking for computing
> > fdata->timeout.sec * HZ, that causes such integer overflow when the result
> > is larger than the boundary.
> > The  patch below checks the possibility of overflow right before the
> > multiplication.
> >
> > =========================================
> > UBSAN: Undefined behaviour in drivers/pps/pps.c:82:30
> > signed integer overflow:
> > -7557201428062104791 * 100 cannot be represented in type 'long long int'
> > CPU: 0 PID: 10159 Comm: syz-executor6 Not tainted 4.20.0 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xb1/0x118 lib/dump_stack.c:113
> >   ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
> >   handle_overflow+0x1cf/0x21a lib/ubsan.c:190
> >   __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
> >   pps_cdev_pps_fetch+0x575/0x5b0 drivers/pps/pps.c:82
> >   pps_cdev_ioctl+0x567/0x910 drivers/pps/pps.c:191
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   do_vfs_ioctl+0x1aa/0x1160 fs/ioctl.c:698
> >   ksys_ioctl+0x9e/0xb0 fs/ioctl.c:713
> >   __do_sys_ioctl fs/ioctl.c:720 [inline]
> >   __se_sys_ioctl fs/ioctl.c:718 [inline]
> >   __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:718
> >   do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4497b9
> > Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f8cf875bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f8cf875c6cc RCX: 00000000004497b9
> > RDX: 0000000020000240 RSI: 00000000c00870a4 RDI: 0000000000000014
> > RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 0000000000005c10 R14: 00000000006eecb0 R15: 00007f8cf875c700
> > =========================================
> >
> > ---
> >   drivers/pps/pps.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > index 8febacb..66002e1 100644
> > --- a/drivers/pps/pps.c
> > +++ b/drivers/pps/pps.c
> > @@ -79,6 +79,8 @@ static int pps_cdev_pps_fetch(struct pps_device
> > *pps, struct pps_fdata *fdata)
> >                  dev_dbg(pps->dev, "timeout %lld.%09d\n",
> >                                  (long long) fdata->timeout.sec,
> >                                  fdata->timeout.nsec);
> > +               if (fdata->timeout.sec > S64_MAX / HZ)
> > +                               return -EINVAL;
> >                  ticks = fdata->timeout.sec * HZ;
> >                  ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
>
> It looks good to me. Do you think is better adding a check for timeout.nsec also?
>
> Now you have to produce a patch according to
> linux/Documentation/process/submitting-patches.rst and then submitting it! :-)
>
> Ciao,
>
> Rodolfo
>
> --
> GNU/Linux Solutions                  e-mail: giometti@enneenne.com
> Linux Device Driver                          giometti@linux.it
> Embedded Systems                     phone:  +39 349 2432127
> UNIX programming                     skype:  rodolfo.giometti
