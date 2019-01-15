Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48C820656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0EzqVoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAOFt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:49:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36320 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfAOFt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:49:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so1267075ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 21:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpDueNevsRnBidYxEIG5wN4kZWrXUeP6KI/DD4jLB6I=;
        b=O0EzqVoIxzmVIZM12+KvajTa7YNnrgNEiUxITL1g8xIbDam5W1NEhq/s9d7YHwN+PP
         XATmOV2jPxEP+bRp+ZLga2wrGJRgQsbdL2WcwB9FKyO8KcBHWVV4W5sATL3tpaMgJPVd
         6QMrdzSu1WwY6Bhb5oaa7T3xKHW9y8+TiDmbBuVVLfvH5E14IlZocYhmQrUPX2WsW5Co
         XJulCJl6eJMVwVyrc958EKp/I6gr7exN0hfcThFCWpEA9n+yLVK7Gwm6N1fZ0ILLuySO
         HKQJBD+tA9sQ9Iqao96pBaWYUP0TO1qWclWalwAlRmao9m6YO0p6HHdSSsK1VdK1dCWO
         SWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpDueNevsRnBidYxEIG5wN4kZWrXUeP6KI/DD4jLB6I=;
        b=dpURzhsZ61FntECHz9DsBRMHHJ6C9NG37YNINKTv6OonxHY6CUMh1+s5mexhEBQzBx
         9xZ6FNjZtpsLTjSLDMBtOaoKUgfrkp3ug6L9c/PwH9l1MFVlkUUV8FT4Auz/M9C9JXdx
         R4kBpa9HM8WxjNwd3nKa7gwsx2BPS9mlhPLkSlott9Vqjkhbnq0aHLqPkjRQmKfVpCO6
         BJCfARMHLBYbqYL+wZknEN3Fr1NSbhuVXVx2VvYYb0INCVS3T7LmpRHqAzZJKKWNCFlf
         UJbH0la2glXa1cf7llQmFxXMDAskaNiLE26wj7Kfi5DTdb8ZEATCRjR8WWPTv4YbVWQ9
         tfXg==
X-Gm-Message-State: AJcUukctVbfI6gmM0NsU9Mv0XQcOfvlNIZopTTJILBPnSFdiI22g4Pgd
        1sfePHDA/ieyRk8Lu87Td+mCEw+Wcigd1IPGyic=
X-Google-Smtp-Source: ALg8bN5OmwOZTAglchoZ0zIX+KX6ppLL5TIM4Zj1pbvhiVmNkbV1j5lJsGW4kQ3VZ0qMAHaPw3wqjzbWAvrAULMS8zg=
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr1444054ljg.64.1547531365628;
 Mon, 14 Jan 2019 21:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 15 Jan 2019 11:19:13 +0530
Message-ID: <CAFqt6za3f19KPizNe=BqC5OX5rEp5sqwnAARLdz18ZPuoB2xUg@mail.gmail.com>
Subject: Re: [PATCH] staging/android/vsoc: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:56 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/mutex.h.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  drivers/staging/android/vsoc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
> index 22571abcaa4e..8a75bd27c413 100644
> --- a/drivers/staging/android/vsoc.c
> +++ b/drivers/staging/android/vsoc.c
> @@ -29,7 +29,6 @@
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  #include <linux/interrupt.h>
> -#include <linux/mutex.h>
>  #include <linux/cdev.h>
>  #include <linux/file.h>
>  #include "uapi/vsoc_shm.h"
> --
> 2.17.1
>
