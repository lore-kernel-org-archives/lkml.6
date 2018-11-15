Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E099C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485B62245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm9ed8Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485B62245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbeKOWRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:17:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35588 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKOWRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:17:42 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so28908818itj.0;
        Thu, 15 Nov 2018 04:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=is3h91peBzNy9h+Q6qm60zHf7MaxLumfMUHhTejcg/s=;
        b=rm9ed8Ept0t8NH3vLefqOTD4O0S65Ld/rcmZLlUQ0FecS9eGHtBi+8i0lldI2L4y5z
         AD9GtGSdXcRRQS0LoWWeG1jcyjrX9lDvE5FgJygDxrBnRbm9u5r6N9AJDjY/0U1spHgh
         HHZJcMEm81cw8SOXb7nJaDUHlFGbp6pw2d5QRq2C1XlEvp+LRq5FT9B3I7yLXPbcxee7
         qbiO5PTj7+nNGrFGFjVFpu7G8UOSVqdpuJdKUXsip5YbdhVjit/tjkU8qbQ981s/bqWx
         ZgLCvQ8/umfEvYq9xj9HcMLOxA4Ee6C477FCOH+zu6BIMk6dtQR+s0HmELLSVNCzvQPc
         fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=is3h91peBzNy9h+Q6qm60zHf7MaxLumfMUHhTejcg/s=;
        b=lYYUqYU8HffDLTsr3nMHpgw4ylUg1RFQ0nuPaG3vx+onMfBMagaJSK/SS16Mb4UrOx
         NuAZ9uQCzV2kOMr5X6TxhOF/ralrWXnTx3mW5/5SX4MntO8pqD1hpKCLrvVIQNgS8NXZ
         GEaUCxqHgDA9EUVulSytQmHhRDJisDW8v5yL/Ps6t3x0RnWdBr0GfNNYIDJXWiFcznoW
         LZ6pPmBev8w/YAJuYq6DiVAwH0Qp5k8OZpVid33fNPet4pjWxnhDQeRhECFcMnW1JslJ
         Fl8SHQ5vIZC4hFqog9CJF2Ze2dmawcpcN6OlhmKjUYnmdJWBmaImaYcIfdBmSw0H1RiC
         pw1A==
X-Gm-Message-State: AGRZ1gIXAmQ8BlvfK6WkDw/7px47w6Fykd+TvgQLmR1mD1jPzZnDXm0j
        eyztvFAWOGNP6lkSFKgOyKOvca+QOolwKHueFn0=
X-Google-Smtp-Source: AJdET5cUSj/GQLaICf7CR/B7mrpWWMqdLdQgrglEH656dk5xQSn/gXa3tGmdmCLg+IdiK6qQvgzNq+CUUqLsyH2KFCw=
X-Received: by 2002:a24:d983:: with SMTP id p125-v6mr5459737itg.97.1542283806377;
 Thu, 15 Nov 2018 04:10:06 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org>
In-Reply-To: <20181114215509.163600-1-ebiggers@kernel.org>
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Thu, 15 Nov 2018 13:09:55 +0100
Message-ID: <CANq1E4Qr+k5hWbxKBQQTO0dSP0QFk4V+hJ9Fmmqz6=cOmfD1KA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     ebiggers@kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, jannh@google.com,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
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

I think `uaccess_kernel()` would be enough. UHID does not check any
credentials. If you believe this should be there nevertheless, feel
free to keep it. Either way:

Acked-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

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
