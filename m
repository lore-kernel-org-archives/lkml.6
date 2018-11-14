Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7689122360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFdyO1iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7689122360
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeKOETB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:19:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40659 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeKOETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:19:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so14936897lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nVS9yrBpV6adwpAPF4fTDrEIGWoTMgCXG0+kahiL60=;
        b=TFdyO1izUBzRqugaJM3zA9eBi1fp6DJgcZyOHv1TtoXbI0xZLbNcAGRxulltGcgPCV
         kadafPOwUdqSgwNwA190pHenJ3qnDXkPfvInwrxXY05hYNqKIFo2gwVDVGkeQqM7uXbZ
         qNEh8u0tUWI/vLX6oQ7BdEj4bwheBqx08toUS8bsaWEj5u6aoQ/dWNGy6W0OEi/XrRR2
         GuCqkEtPjurKk6p42lMJ0ZFIl/T3dGZ+4EKf2qZ6Uts3BBZqtlF17BT71GXmh7kTGZEp
         3qAqpy93cRirsgtMkY70lHj+EP3mhPZfESbdkBKBN1n/LJauDUpMHmeGKTv1kBman2fB
         y/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nVS9yrBpV6adwpAPF4fTDrEIGWoTMgCXG0+kahiL60=;
        b=QJNwWk9EsQF8ZZNwi0AN5anuqdWfpzfmlsuIWOaEM8HCWXlkzY8Vb4CF1hDKfB8N6G
         y3TFKgemIL55K1DfQhVPk3RqmGlcEKZ2bi4e+7/R48nPf9Z3Sq0/TkIi4u6ZtN0ElZAe
         sJCrF8Pb8vxTalRg0wS92XZuiXe1UXnjzwnkLKwhqSIAyjBSPXkbYp5YTm8+OuzHOK74
         WkRJJnNLc5crUQMNpgSkWmNzwEi1qk5zcwPz24z7yMUeGplRSsjRXR/8ZDF8OiLRkzPQ
         9WgcDtiCPqSZ0HxyGzQLm7GPwQcPCpaI83iksVljf0CTQnUDgCkr68rGvFYGTSIuZFfF
         PFAQ==
X-Gm-Message-State: AGRZ1gJlGijZQPBTLj4Wds+SUHfqaP0utV30RIwAtw/MDRRvKGDjZUvd
        31Kdpx4qMYtgnZyJ2LFZWZWnDwzUawJOc2p3wKJTqQ==
X-Google-Smtp-Source: AJdET5fqHhsuBa3BZLs88942qFC5ngiYRXzeZyXBQgjZU2wH9kJTNmuANJGs87gGEMQgB58ztzfvZ3UmJ1cmObuSN0M=
X-Received: by 2002:a2e:117:: with SMTP id 23-v6mr1720540ljb.131.1542219283102;
 Wed, 14 Nov 2018 10:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20181114171447.GA87768@gmail.com> <20181114180217.195917-1-ebiggers@kernel.org>
In-Reply-To: <20181114180217.195917-1-ebiggers@kernel.org>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 14 Nov 2018 10:14:30 -0800
Message-ID: <CAE_wzQ9U19_5MUqj_qC4G3KFV2UywUDQAMnm78GyBzc-qRMa3w@mail.gmail.com>
Subject: Re: [PATCH] HID: uhid: prevent uhid_char_write() under KERNEL_DS
To:     ebiggers@kernel.org
Cc:     dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:03 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> When a UHID_CREATE command is written to the uhid char device, a
> copy_from_user() is done from a user pointer embedded in the command.
> When the address limit is KERNEL_DS, e.g. as is the case during
> sendfile(), this can read from kernel memory.  Therefore, UHID_CREATE
> must not be allowed in this case.

Hmm,  instead  of disallowing access, can we switch back to USER_DS
before trying to use the user pointer?

>
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
> +
>         /* we need at least the "type" member of uhid_event */
>         if (count < sizeof(__u32))
>                 return -EINVAL;
> --
> 2.19.1.930.g4563a0d9d0-goog
>
