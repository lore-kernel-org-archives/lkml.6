Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A6EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2B120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UICJGTVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2B120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeKSXpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:45:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34257 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeKSXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:45:36 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so19169085iob.1;
        Mon, 19 Nov 2018 05:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BCue+2M0/f1DEp6pP//BGApptyIqgDRAQ+GaVWHHyQ=;
        b=UICJGTVu5X/cUeiGuQuZD25efKkD0MP8VZeZ6HPyDeDwh0iOKLguAl4qIGBKKjQg1l
         fCd0dksjJdpB2KMHgbJ8TeNGakMn3+M6mfRToq6cIhZ9K0ZhPKKClaL8Vz77NWJdrgMF
         pL6YzVmMLakwb4Qr2UDonuFt5jxPDYx22FU46F1tr+dsi20o7WFEbEIN0ccDmbS3Wp0i
         xA/BOAkQHhHsaNVxFzoxst0XPIfqI3oggyWJg7N3sz+SAN0BYyHYqe3Z19B2c/Jzt832
         +CzAq26aWKxybqLdj+qkzwg7WaIGjy4RJjrOyI3gyr09KJIu9/151Tw+gX2rVwQpTu2L
         VxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BCue+2M0/f1DEp6pP//BGApptyIqgDRAQ+GaVWHHyQ=;
        b=SJaDdI/3y+vx/fWu3rg4j6foHXslCZSIQ96IZF5t1UvZVK6BskdyeLglYTZp2oLdNp
         p5fbAAtoksrmiq959PTIEIXLuiwaWRonA+WONTOEHqrqoky3fwyv94lOMSlUhyjs3/aG
         Y/hqfk48NtAp7P8IF6MXXXXZtzyi6uC5oERcbqfN+uAl+uw+Ip5eYUUtL+T1xN+j90w4
         tRt//DX+sHJzZR7SWua8L/Xp5pxweVrege4xGTqyOu8jOzC1mpgwv4A3t3NY1hbWiqJd
         xeHAOVWVbX5jCyr4d7UtuxZHYTVrAt7OmdjhqA7UElZAQaRcPRN2nFvJPiwsmKRtzapX
         mo8Q==
X-Gm-Message-State: AA+aEWaHt+lNzVj1rFxq3oQPCw7FwoFbkzG7Kij85YgWXuKUtK/2mVJj
        tGjzW2camlp5XcCNrmEGr1ljW9OtcHMgCE+hWW4=
X-Google-Smtp-Source: AFSGD/WQkh6bTm3VHk9dsFn1XuQ475AvZP/B6r9kB0GAoxc72CapAjBiuRHfpimNTupFQ3pAubCrebxAfaJZAFg4wLo=
X-Received: by 2002:a6b:f104:: with SMTP id e4mr10655940iog.271.1542633718389;
 Mon, 19 Nov 2018 05:21:58 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm>
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Mon, 19 Nov 2018 14:21:47 +0100
Message-ID: <CANq1E4QDP9EiJZG2pqfKtA_ESoBgNb5ECjause2tTUdYWaqYZA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     Jiri Kosina <jikos@kernel.org>
Cc:     ebiggers@kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Mon, Nov 19, 2018 at 1:52 PM Jiri Kosina <jikos@kernel.org> wrote:
>
>
> [ David added to CC ]
>
> On Wed, 14 Nov 2018, Eric Biggers wrote:
>
> > From: Eric Biggers <ebiggers@google.com>
> >
> > When a UHID_CREATE command is written to the uhid char device, a
> > copy_from_user() is done from a user pointer embedded in the command.
> > When the address limit is KERNEL_DS, e.g. as is the case during
> > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > information can be leaked from a setuid binary that is tricked to write
> > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> >
> > No other commands in uhid_char_write() are affected by this bug and
> > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > UHID_CREATE only rather than to uhid_char_write() entirely.
> >
> > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > helpers fault on kernel addresses"), allowing this bug to be found.
> >
> > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > Cc: <stable@vger.kernel.org> # v3.6+
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Thanks for the patch. I however believe the fix below is more generic, and
> would prefer taking that one in case noone sees any major flaw in that
> I've overlooked. Thanks.

As Andy rightly pointed out, the credentials check is actually needed.
The scenario here is using a uhid-fd as stdout when executing a
setuid-program. This will possibly end up reading arbitrary memory
from the setuid program and use it as input for the hid-descriptor.

To my knowledge, this is a rather small attack surface. UHID is
usually a privileged interface, which in itself already gives you
ridiculous privileges. Furthermore, it only allows read-access if you
happen to be able to craft the message the setuid program writes
(which must be a valid user-space pointer, pointing to a valid hid
descriptor).
But people have been creative in the past, and they will find a way to
use this. So I do think Eric's patch here is the way to go.

Lastly, this only guards UHID_CREATE, which is already a deprecated
interface for several years. I don't think we can drop it any time
soon, but at least the other uhid interfaces should be safe.

Thanks
David
