Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F4EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1C021582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0AwmyWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1C021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeKOIkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:40:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32965 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbeKOIkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:40:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so9855384otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+3YCIKA/gWrJIUEbUoijV3YM8/vfZ8BqgZtbjwKWds=;
        b=K0AwmyWxkMow4TwEeqKDcFFjLZwlgCBdUcBxqhaNRFdcd0nXiIQEtosgZIBA47Ef/b
         GfpYDM8pj7viDLQWJ/MA2Fslx9NUdCe+O8rcJZyFLNlqZIYWD7cmlAOpErbgFIlmD0wg
         eLSO9lx8dV0au4nXWIXA5cfAAXruWMA4re4fj7hsC3q9eoapDSRGp8uOfp8iBSHflUOu
         Ozd/6JuLke5hLD6iatjP9yVan/YzXvqgxDjJqymZhmvLWJy+fknxKzEmJpjjRfitfrqN
         Gis3wDpWWEuulx9CSoJZ2Wb13waOU7x2vI+NBRPdocIPf9vGygU6bhtN0hcTPb8lJ5Aa
         KEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+3YCIKA/gWrJIUEbUoijV3YM8/vfZ8BqgZtbjwKWds=;
        b=O7QOmAnqKZU46KPWp3qz/gsKlNEzKQjNeCDvSOd1PXBL84xD9MaEalsFIqiRnFjO+p
         JSt6nd8LRcMFe3kNDtPpTtL1rBFg7bVwyUgmHbumoSSJEXSoTHWwMosba+IJTRg7PEeU
         rfgmr4JFIkLvRrKBwdOzAC6G2XmFZ0n7nxT+iw64jKoVcg4nuuKGTdxf5l1MMH3ZnAvE
         NXH3dhzHPFFb/YMwwEjxbu1sCAidY5l7dzLfqopyEdu5uR/Wie5+2vCMZpfwKGVktIDp
         dx8v/jquVpu6W//V+yrB/hYId7r0bOzEU1KqtME9rojQcSbzesc1m1lvgswjZjYLRrdK
         Z0rw==
X-Gm-Message-State: AGRZ1gKic35hYoIgjpkT7AhkxACTChyWr0drq7yk5LAsruyjD0OWPI11
        bEz5PPRsmL3KVRMfjWs/0EeNCBMUpdvTJI5KhJtv1A==
X-Google-Smtp-Source: AJdET5e9jRymRUU3R1UyzxwA9nt95uNQmYNCg4wFO1l7HXf1YB5KawnPd2pEPC1h3wosfEf4BUT9t8BgkxHI0+bugPc=
X-Received: by 2002:a9d:638f:: with SMTP id w15mr2085738otk.230.1542233124928;
 Wed, 14 Nov 2018 14:05:24 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org>
In-Reply-To: <20181114215509.163600-1-ebiggers@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 14 Nov 2018 23:04:58 +0100
Message-ID: <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
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

On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> When a UHID_CREATE command is written to the uhid char device, a
> copy_from_user() is done from a user pointer embedded in the command.
> When the address limit is KERNEL_DS, e.g. as is the case during
> sys_sendfile(), this can read from kernel memory.  Alternatively,
> information can be leaked from a setuid binary that is tricked to write
> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
>
> No other commands in uhid_char_write() are affected by this bug and
> UHID_CREATE is marked as "obsolete", so apply the restriction to
> UHID_CREATE only rather than to uhid_char_write() entirely.
>
> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> helpers fault on kernel addresses"), allowing this bug to be found.
>
> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> Cc: <stable@vger.kernel.org> # v3.6+
> Cc: Jann Horn <jannh@google.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  drivers/hid/uhid.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 3c55073136064..051639c09f728 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/atomic.h>
>  #include <linux/compat.h>
> +#include <linux/cred.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/hid.h>
> @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
>
>         switch (uhid->input_buf.type) {
>         case UHID_CREATE:
> +               /*
> +                * 'struct uhid_create_req' contains a __user pointer which is
> +                * copied from, so it's unsafe to allow this with elevated
> +                * privileges (e.g. from a setuid binary) or via kernel_write().
> +                */
> +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> +                                   task_tgid_vnr(current), current->comm);
> +                       ret = -EACCES;
> +                       goto unlock;
> +               }
>                 ret = uhid_dev_create(uhid, &uhid->input_buf);
>                 break;
>         case UHID_CREATE2:
> --
> 2.19.1.930.g4563a0d9d0-goog
>
