Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A578F24C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A578F24C34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeGCHuW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:50:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45919 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933390AbeGCHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:50:17 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so769327qti.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nJw203+kTuGM/GWtxAgco2/tHTBdPaVv7e6NnXnZVbI=;
        b=OhP4mRGd7CnRCBcKOUKOjTugMlOKbkUiiLmsM+dcTQ0iRAuowwJATKXebBeaJqcZWD
         X6B86mTVw9u/Gazo2u4i94fnnHrxWTX68hPF46t79h1XdG6NDk1jZiFViWnSyatLAH9n
         GIVuHBWxshWxgUUKBo68DGkLvVif1ymrUbJ4JfiEmLTa5QNsgtHXNN92njJnulnbLtD2
         fcJ6SL1puahih1MaiATmmZxsJsSu3ITbxcEjEsr+27c/tqwDh7S6Jcok7JT01QIRdKR3
         OcpcEgDQFn+nNM1vTKiu5H19iQISeYV1h2D+DTsd4eW3MyqbVedr5dge0MzzAvyweptC
         +Vnw==
X-Gm-Message-State: APt69E38vSc+Uf9CUH7/vYKGi9rLk7vdppiemQiD71tPdNzXKVI8z42H
        sLyZr/zrY09R8hsbR5Ie9bHa/PC21unWxfWOdt2qWg==
X-Google-Smtp-Source: AAOMgpdzrC1UhjXLitfMQ/96VXleMccmA17jSL1NdinsIOexZRgKDaZK87f1SkVZiimRHOLc5jJ/Q42q9Irsi3JSQF4=
X-Received: by 2002:ac8:1a18:: with SMTP id v24-v6mr16081176qtj.115.1530604217132;
 Tue, 03 Jul 2018 00:50:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2fca:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:50:16 -0700 (PDT)
In-Reply-To: <20180702235937.111619-1-drosen@google.com>
References: <20180702235937.111619-1-drosen@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 3 Jul 2018 09:50:16 +0200
Message-ID: <CAO-hwJLocBwuS7TGaXW88B-V8xSheATNDuvobv-Vk+hU0hei0A@mail.gmail.com>
Subject: Re: [PATCH] HID: debug: check length before copy_to_user()
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 1:59 AM, Daniel Rosenberg <drosen@google.com> wrote:
> If our length is greater than the size of the buffer, we
> overflow the buffer
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Cc: stable@vger.kernel.org
> ---

Looks good:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-debug.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index 8469b6964ff64..b48100236df89 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -1154,6 +1154,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
>                         goto out;
>                 if (list->tail > list->head) {
>                         len = list->tail - list->head;
> +                       if (len > count)
> +                               len = count;
>
>                         if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
>                                 ret = -EFAULT;
> @@ -1163,6 +1165,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
>                         list->head += len;
>                 } else {
>                         len = HID_DEBUG_BUFSIZE - list->head;
> +                       if (len > count)
> +                               len = count;
>
>                         if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
>                                 ret = -EFAULT;
> @@ -1170,7 +1174,9 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
>                         }
>                         list->head = 0;
>                         ret += len;
> -                       goto copy_rest;
> +                       count -= len;
> +                       if (count > 0)
> +                               goto copy_rest;
>                 }
>
>         }
> --
> 2.18.0.399.gad0ab374a1-goog
>
