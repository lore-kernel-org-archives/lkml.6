Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD3FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AFC22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0deHWiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AFC22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeKOEXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:23:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33342 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeKOEXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:23:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so9151755otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAhEP5PNMrH23hKOuO24tYIVT3au/oY4s3WYk1e/KL0=;
        b=p0deHWiZ8zp2wgZTk6marRA0FNp3CpR2cza+puGBNr8SlZQJFmKhWx2tlBXQddFWIa
         i93pCArFx/l+YOFdmXR+K+P/ADB9/r7hVwIBosn2m56UTQPKw1DnSgo2IDO/aZcqnAbG
         MGGpmLJCScMbmFbrqTVhgN9ftqeAi1SAo3QWOFXuHQyAkp+UhS7q4pE8/ao+I1+T8Gyl
         7lIi6cC7CgBP/TUN2C2uZIavPFMofsWbYak0YuDQYOoHuSS6GoOidMSWyWp8+/5b8A8f
         eR6UZYQgJ+KOL7umdLhDC06riniUCJ/tS02w+I1GyCF0yC2rxdCt/3UXpTbWbm3Pinc7
         FAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAhEP5PNMrH23hKOuO24tYIVT3au/oY4s3WYk1e/KL0=;
        b=sYdIR4TIS2TJHA+HcBTEOx7vbfjE7W50OhhCLm6dO8Uwlq7tqBqLnQ6gDBIGzL70pN
         7zb/SpY9+HGLJ6V9p0hWq0QxsKK4ihKT5GJNz/BFN7D1nGNlzm55GMsXqpYa+jG1dJ9c
         D8Bgb+EA9cmxwQEjmQudIpA/sfVusUhmUbOwOas++4TpE4rp3LUj3TYPf/4JNDpkD8z/
         SkFQxHl1xIidaOD/Kj5ToWb136HDzweZObRCnhdkgpd1JmIpqcvQ9wSa5z3K793M1tnx
         4cJ8I92BDDR7fdYIo8TjeJ/ygSW6C5aPQ/zdtDtGUhPrWGzxJnA1U6WfUn1I2Nz+7WQS
         YruQ==
X-Gm-Message-State: AGRZ1gLwKaMEa0wztQnufWCtDkZSED9hPQCAWq3XH1b11chfMRom/j6F
        vInY7AIeKGyOoobZg6ObRW0WofZ3jzPohXXh/FR2iA==
X-Google-Smtp-Source: AJdET5dCO6gbG9eIyc6vSx4dKX1Lob5XV0danCUc3USqrx+ffG8it47ZjllmOXi3ClS2TsxXGJxlINqNA8XU+gTmUa4=
X-Received: by 2002:a9d:460e:: with SMTP id y14mr1841611ote.198.1542219545541;
 Wed, 14 Nov 2018 10:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20181114171447.GA87768@gmail.com> <20181114180217.195917-1-ebiggers@kernel.org>
In-Reply-To: <20181114180217.195917-1-ebiggers@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 14 Nov 2018 19:18:39 +0100
Message-ID: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
Subject: Re: [PATCH] HID: uhid: prevent uhid_char_write() under KERNEL_DS
To:     ebiggers@kernel.org
Cc:     dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>, dtor@google.com,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Andy

On Wed, Nov 14, 2018 at 7:03 PM Eric Biggers <ebiggers@kernel.org> wrote:
> When a UHID_CREATE command is written to the uhid char device, a
> copy_from_user() is done from a user pointer embedded in the command.
> When the address limit is KERNEL_DS, e.g. as is the case during
> sendfile(), this can read from kernel memory.  Therefore, UHID_CREATE
> must not be allowed in this case.
>
> For consistency and to make sure all current and future uhid commands
> are covered, apply the restriction to uhid_char_write() as a whole
> rather than to UHID_CREATE specifically.
>
> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> helpers fault on kernel addresses"), allowing this bug to be found.
>
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com

Wheeeee, it found something! :)

> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> Cc: <stable@vger.kernel.org> # v3.6+
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/hid/uhid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 3c55073136064..e94c5e248b56e 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -705,6 +705,12 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
>         int ret;
>         size_t len;
>
> +       if (uaccess_kernel()) { /* payload may contain a __user pointer */
> +               pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
> +                           __func__, task_tgid_vnr(current), current->comm);
> +               return -EACCES;
> +       }

If this file can conceivably be opened by a process that doesn't have
root privileges, this check should be something along the lines of
ib_safe_file_access() or sg_check_file_access().

Checking for uaccess_kernel() prevents the symptom that syzkaller
notices - a user being able to cause a kernel memory access -, but it
doesn't deal with the case where a user opens a file descriptor to
this device and tricks a more privileged process into writing into it
(e.g. by passing it to a suid binary as stdout or stderr).

Looking closer, I wonder whether this kind of behavior is limited to
the UHID_CREATE request, which has a comment on it saying "/*
Obsolete! Use UHID_CREATE2. */". If we could keep this kind of ugly
kludge away from the code paths you're supposed to be using, that
would be nice...
