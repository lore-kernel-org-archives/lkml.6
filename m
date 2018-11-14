Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D295D208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWpaLsON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D295D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbeKOC5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:57:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52534 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKOC5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:57:06 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so24907018itb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8oUlVQXUFUM9bB+4ICaT17c+/ifiDl+U97gagHW1d6s=;
        b=oWpaLsONb2zIfyw0KX5aI2bED/FCJnkyoG2sSEBUYElFuTyP2KyfgbcdXRcU6aQVo4
         nuQZq9sTNWGlk5AY3GyWBtayOBqwxs7aSLx6skw9ChkifmCeKJpClfshrAVsRExhgjfk
         bxKN2rAuj8ZYQByFu2gFFP5S5FjjlTa8Nb2uzA6Jpvxq7sy9OqxJWWPIjwW/z4TZAGUi
         WpIfNU3Z62k+wPPXHnalAp2htgB86hD6TvoR7tzyUjOW9tHXcAVeO/GqWpe4ru0Sc0i6
         078yw/OsHliMW0Lm8DOqX8SgIGWVUOunnr5cFTNtmkm0QWrew90sfF8lVRIgp1lAf29/
         sljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8oUlVQXUFUM9bB+4ICaT17c+/ifiDl+U97gagHW1d6s=;
        b=hyySDBqFjX0xeWws7YOpPPCXR+jDX24I9V5omElNUzfK51IL0K/Bv6CHzc9cZzOjLA
         Hx/s1K6Zysv0BN2QoM+MuGon59TXsXpcofEDIX1UXgbYt3dOyNWzieU23cs7IV80L5/k
         2H6uRcN0hc2kyqnc82pZDgC58PJEzMnAcWfzgBzVSVVLCgQgmu+uoWU8Rblz3l9iMy1s
         0IWY7usCsxoamh36YkMmIWIiQXQrKRo0l9L8MPtH6ou/YTgy4xS001nzDjqMUOXWjmNm
         kyEEieL1P8O7c4tCoEFQ1eg1Sr4gx6lO9PO8wY1r/35/wcPNf0aeg9/ZyteeApY+aERM
         W9ag==
X-Gm-Message-State: AA+aEWZaU+C6iFxVLEX6l/HBOLFdnfczs0Yu3kUXUKoLJdNwLfj/l0Uw
        K9nvotJCBI9CAML6wfMxyiIrIdpX6AqZRExYK1zM8Q==
X-Google-Smtp-Source: AJdET5d6uQO0BZfJKapkv7IPHCLPtE2+5jqDR/pv6efqEFaCA1/zXZ9ah3lo9KOx9sTuNYCPQnTKmK15Ww7xBouwCkc=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr2481410itf.166.1542214386654;
 Wed, 14 Nov 2018 08:53:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 08:52:46
 -0800 (PST)
In-Reply-To: <CANq1E4T6+bacZ9iGREtWiyM8eUkAQoxhgFM6rPrzNRkzAcnfJg@mail.gmail.com>
References: <00000000000080f8fa057a67b75c@google.com> <0000000000002d2a5b057a94f7ff@google.com>
 <CANq1E4T6+bacZ9iGREtWiyM8eUkAQoxhgFM6rPrzNRkzAcnfJg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 14 Nov 2018 08:52:46 -0800
Message-ID: <CACT4Y+b8801QqLe4axBct-cZ2a-jr2S2=MSRhg7rV20bPvUHxQ@mail.gmail.com>
Subject: Re: BUG: GPF in non-whitelisted uaccess (non-canonical address?)
To:     David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dtor@google.com>
Cc:     syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 4:20 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hey
>
> On Wed, Nov 14, 2018 at 1:25 AM syzbot
> <syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com> wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13b4e77b400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=72473edc9bf4eb1c6556
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1646a225400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108a6533400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
>>
> [...]
>> BUG: GPF in non-whitelisted uaccess (non-canonical address?)
>
> This uses sendpage(2) to feed data from a file into a uhid chardev.
> The default behavior of the kernel is to create a temporary pipe, then
> splice from the file into the pipe, and then splice again from the
> pipe into uhid.
>
> The kernel provides default implementations for splicing between files
> and any other file. The default implementation of `.splice_write()`
> uses kmap() to map the page from the pipe and then uses the
> __kernel_write() (which uses .f_op->write()) to push the data into the
> target file. The problem is, __kernel_write() sets the address-space
> to KERNEL_DS `set_fs(get_ds())`, thus granting the UHID request access
> to kernel memory.
>
> I see several ways to fix that, the most simple solution is to simply
> prevent splice/sendpage on uhid (by setting f_op.splice_write to a
> dummy). Alternatively, we can implement a proper splice helper that
> takes the page directly, rather than through the __kernel_write()
> default implementation.

also +dtor for uhid
