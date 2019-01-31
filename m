Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C24BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5EE218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nw0migVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfAaScE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:32:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36634 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:32:04 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so2583805vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDk+CLgBU4fqCAuiQFiByBkhwOJSwSq6bQ5TuhUxDsc=;
        b=nw0migVOEyRPRnhpjCDv0fsfjRunx8TofHLxMf2qtZTzEu7C6pZrvnJH4o0iKDf6xb
         o9qFrlhhF6v3kzEtJO6G6HwD01WS9OB48Hrjnev7Nx9nd25YKSshmXhjcDu1EsVArA7s
         Bzpw/8arqnFbqaCFKklmPX+nBR745Y30ZbYmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDk+CLgBU4fqCAuiQFiByBkhwOJSwSq6bQ5TuhUxDsc=;
        b=cMe+y7oM3RK9s/Mkkswmco8s9KGC0IfAHZ/7/Fxd2+YEJGCpi6wNdfopurLuBja6Sg
         rE38U931jWev+MYessJ16qeOOa/XaTK+C9dFDQz+1QnkbApE0j+2dSPdHflTP8vrOFIs
         BnQrTX5lzf3f13qNov5/He5liVremFZABMljeZ9XheUb9XFJ4KwzizLEsen5Dx4S9Dut
         9vwQDKShgV9S6I1fe0mxMfgabQwwXTGyp050QnKqsctYR/9Rh6Cb61S8AiV1IZru+Ihz
         a4mT8BioQSP4pAqd8rXB7UEO3+XH3f+jUqwKVhwaQaO2EKqzhYJKX/tXKnpINjVFl5Bc
         Knfg==
X-Gm-Message-State: AJcUukfJjqY/pHSpdLAxgssBRHAcE4ZUBmwXQu+6gORs8gk5eJ+RlnN2
        YImUDb208xweKlodlYsoYH7Lapf5WlE=
X-Google-Smtp-Source: ALg8bN6Y28YnK5MZRF8iqpZP4RnwigNkm8vJIhOHton5+tuAEVpABjAjURB2Rq1RkWVfMeARZdxZpQ==
X-Received: by 2002:a67:7ad3:: with SMTP id v202mr14777940vsc.49.1548959522321;
        Thu, 31 Jan 2019 10:32:02 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id e67sm5352712vsd.32.2019.01.31.10.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:32:00 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id c24so1395055uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:32:00 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr13909469uap.14.1548959519907;
 Thu, 31 Jan 2019 10:31:59 -0800 (PST)
MIME-Version: 1.0
References: <00000000000074cbc30580b16bc3@google.com> <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com>
In-Reply-To: <20190131105152.GB13686@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 1 Feb 2019 07:31:48 +1300
X-Gmail-Original-Message-ID: <CAGXu5jLzMdar2d7pmHvzCNdP+5wuEqPk4k7C+aU8ZKzSVxci=A@mail.gmail.com>
Message-ID: <CAGXu5jLzMdar2d7pmHvzCNdP+5wuEqPk4k7C+aU8ZKzSVxci=A@mail.gmail.com>
Subject: Re: general protection fault in relay_open_buf
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> Can you test the patch below?
>
> thanks,
>
> greg k-h
>
> --------------
>
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 04f248644e06..9e0f52375487 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -428,6 +428,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
>         dentry = chan->cb->create_buf_file(tmpname, chan->parent,
>                                            S_IRUSR, buf,
>                                            &chan->is_global);
> +       if (IS_ERR(dentry))
> +               dentry = NULL;
>
>         kfree(tmpname);
>
> @@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
>                 dentry = chan->cb->create_buf_file(NULL, NULL,
>                                                    S_IRUSR, buf,
>                                                    &chan->is_global);
> -               if (WARN_ON(dentry))
> +               if (IS_ERR_OR_NULL(dentry))
>                         goto free_buf;
>         }
>

Thanks! (Can we find other cases of this with static analysis?)

Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
Reported-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
Tested-by: Kees Cook <keescook@chromium.org>




--
Kees Cook
