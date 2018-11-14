Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E87C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952C22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0/x6z+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A952C22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeKNWYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:24:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35573 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:24:09 -0500
Received: by mail-it1-f194.google.com with SMTP id v11so23539531itj.0;
        Wed, 14 Nov 2018 04:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUK9ED3CGmfy2q2tBvspaedhayJyFr6MSALmrjvTLo4=;
        b=A0/x6z+st9j6GH9CXLUDz9HJNXKynXCIH2GV2BVn/kxh5m5pb97LANJhW2DpA2KQbf
         tkBxCi+F8oXh1toDEtAcnp+J617K9vJ/vkrKBZcUmuAChYKexl9ve+Uh1tiy8htYI70S
         oqcUhgLFxa7SEptjH9OKH9anH1SUDcR/dbe9MVx3ON5NHuiz9KZnqUNh5uaquZuDrHf2
         lZJQY42L6umjMsVEcWGaKu8Mc6ILpogtTaQfnjkOywsO/46zfdSK6h6Ve0VxLWDjnj7D
         EjiOg6v3m2oz2PGobsDLhEufJ/+6nuF6KLHKBsCE3kH86lbR+o5grgR42drrhd4MDWzM
         jf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUK9ED3CGmfy2q2tBvspaedhayJyFr6MSALmrjvTLo4=;
        b=gQeJmjw51Ha72UJnJjys9loViGGfl+zAwErGhMMmw13CL1unJI2x9Cx8t5xIRA2pBd
         Y5s/hdcBnHxcrX41FTjEpFthonurPLVol16y9+QvgR9uasmBFYaNR+BTOcU3fAQE6pmx
         voyWQBjNrArTE0aMGswN9fPaHvzhgZacd5HJBeIvcC5og08blvhE/NI1PnHnkGFjnTrI
         Cp6L5OEXBnsjd8R15dLBqPArLPAnhRt3v0lIhFkZLJ7YvndgqnICczSI6tbiRzj6vlLO
         l/aqyX7apVUXt8ij72jQsZHhasDWIxBU9SYnfFcKAZKNuvrP7m9JcDuDkZW3cYlKviVm
         cWtQ==
X-Gm-Message-State: AGRZ1gJRb/TwFF8Md0WEyfF4omGnkfQBiwj8Ndn3uhCTs5DJw27puZQQ
        U7zKNkYprxeMqzCCC/zwN2k0w30g0VKTX2oXDsg=
X-Google-Smtp-Source: AFSGD/U5oklVr111fS/Djg9lZKlZ5qg6NtMY+4ir6MZTH8js5kZDdwcET6CgNO3XTd8ms3H4Jx1PRU+WTAm6GEHCj2E=
X-Received: by 2002:a24:67c8:: with SMTP id u191-v6mr1856210itc.47.1542198066377;
 Wed, 14 Nov 2018 04:21:06 -0800 (PST)
MIME-Version: 1.0
References: <00000000000080f8fa057a67b75c@google.com> <0000000000002d2a5b057a94f7ff@google.com>
In-Reply-To: <0000000000002d2a5b057a94f7ff@google.com>
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Wed, 14 Nov 2018 13:20:53 +0100
Message-ID: <CANq1E4T6+bacZ9iGREtWiyM8eUkAQoxhgFM6rPrzNRkzAcnfJg@mail.gmail.com>
Subject: Re: BUG: GPF in non-whitelisted uaccess (non-canonical address?)
To:     syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Wed, Nov 14, 2018 at 1:25 AM syzbot
<syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com> wrote:
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b4e77b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=72473edc9bf4eb1c6556
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1646a225400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108a6533400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
>
[...]
> BUG: GPF in non-whitelisted uaccess (non-canonical address?)

This uses sendpage(2) to feed data from a file into a uhid chardev.
The default behavior of the kernel is to create a temporary pipe, then
splice from the file into the pipe, and then splice again from the
pipe into uhid.

The kernel provides default implementations for splicing between files
and any other file. The default implementation of `.splice_write()`
uses kmap() to map the page from the pipe and then uses the
__kernel_write() (which uses .f_op->write()) to push the data into the
target file. The problem is, __kernel_write() sets the address-space
to KERNEL_DS `set_fs(get_ds())`, thus granting the UHID request access
to kernel memory.

I see several ways to fix that, the most simple solution is to simply
prevent splice/sendpage on uhid (by setting f_op.splice_write to a
dummy). Alternatively, we can implement a proper splice helper that
takes the page directly, rather than through the __kernel_write()
default implementation.

Thanks
David
