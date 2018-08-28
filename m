Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23741C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31682088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPUU7utf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31682088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeH1Q15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:27:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36406 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1Q14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:27:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so1853572wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=05kE+rEM/SVtQM4ag8xkAlkFSh7FQJHB6Uzw1ymvp0M=;
        b=rPUU7utfP1hYg11HbjT52vZr6DX3B9lEkMKS69kqAV8E+jkaEeurohKTKCVe1soYG/
         Ui0zr/+/1bgk1Af+0grt4jB3l8fgBxskvWxsp5Q7nDe9Ne6ypag42/I3gVbBJUQ9t0+E
         9XAEfFp2skDkO1M/DYHjGTaGok4kYBxeemOoJDrH1VGvwaOGfIXi/6U+4nNc0Vydw3Ui
         GRkDhNJyXM6xVmjDaMaVpAFjT4GWjNcQHr3gpSkJKwITs73tA+jKpY08VoBF2R5h2Iqw
         WS9W2d4pbXnDlGSroRg8CAV44jJcUVJZOn3BB7q11iVu9p7GdUal4twMgCGj/JdKawBY
         eGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05kE+rEM/SVtQM4ag8xkAlkFSh7FQJHB6Uzw1ymvp0M=;
        b=ftqKr2kNs0ipefZVdKwGAiE88yqh7zmJ6bCHvaOkiEUAG6Z0chcP8HNEoeWbjRf1+b
         pV6GYJNiX2m+khRONj50zhYPu9d4b+JVxJsoi1R4cgwrNNIza5OSp1RZmeaRFDDDu+90
         YdWxUU4Noy9IFnv4Mb6KF0qz7oeUmUoLWtuJdn8F9HJIaP/w/djB7TwM+aiZnYnaW0CO
         erueIJcAvYualL+kOJH00o9crS6CefS0pXRgWEM0NXGSIRN1JVrM8UqknixhVT4ToXTO
         sdTBEQIDI9AmeepazhuRpucEJBLkXkhWk4AE6ZtLlXtPEJmh3FQAlJTrPnz4gm3hGSj/
         tXAA==
X-Gm-Message-State: APzg51Bhyt/qKEDkjHaXYPRnbqZp1QVBlkt/dtX6qBqlqkQCZL1Uu3bI
        r11tfegr2s2J3xL7YfhuVGU=
X-Google-Smtp-Source: ANB0VdbwTg8JNwFmzN6lS7pSyEi8mXS5LEv/6xgIRloGXEeBWkU5WCywwXZ6aqBhTlFGtFLBRFXTZA==
X-Received: by 2002:a1c:c64c:: with SMTP id w73-v6mr1166257wmf.98.1535459787681;
        Tue, 28 Aug 2018 05:36:27 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id b144-v6sm922718wmd.23.2018.08.28.05.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 05:36:26 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:36:22 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] proc: readdir /proc/*/task
Message-ID: <20180828123622.GA2087@darwi-kernel>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-11-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827231503.26899-11-adobriyan@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:15:01AM +0300, Alexey Dobriyan wrote:
> ---
>  fs/proc/base.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Missing description and S-o-b. Further comments below..

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 33f444721965..668e465c86b3 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3549,11 +3549,11 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
>  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
>  	     task;
>  	     task = next_tid(task), ctx->pos++) {
> -		char name[10 + 1];
> -		unsigned int len;
> +		char name[10], *p = name + sizeof(name);
> +

Multiple issues:

- len should be 11, as was in the original code
  (0xffffffff = 4294967295, 10 letters)

- while we're at it, let's use a constant for the '11' instead of
  mysterious magic numbers

- 'p' is clearly overflowing the stack here

>  		tid = task_pid_nr_ns(task, ns);
> -		len = snprintf(name, sizeof(name), "%u", tid);
> -		if (!proc_fill_cache(file, ctx, name, len,
> +		p = _print_integer_u32(p, tid);
> +		if (!proc_fill_cache(file, ctx, p, name + sizeof(name) - p,

You're replacing snprintf() code __that did proper len checking__
with code that does not. That's not good.

I can't see how the fourth proc_fill_cache() parameter, ``name +
sizeof(name)'' safely ever replace the original 'len' parameter.
It's a pointer value .. (!)

Overall this looks like a broken patch submitted by mistake.

Thanks,

-- 
Darwish
http://darwish.chasingpointers.com
