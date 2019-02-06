Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E549C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355A32081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRk/rHuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfBFIwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:52:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45194 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfBFIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:52:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so5262255ljd.12;
        Wed, 06 Feb 2019 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pKp9pLyHx+s34EKHeLUFMMbpdPnaYczVbQqBa/dSsJw=;
        b=PRk/rHuDWh+nDDJEoyODDEyyEfm7kwn4gIuKZe99o8iJP+UykIahyQm6dFaOxEoHIo
         KtYtXk9FvDaWfn0E8HR6oEH6umHYRd0E3PAkL7r6XtglMFQRGsf1DC95sYW2cFvfC5n9
         ynCxsxM0FqWpVHW4AqPmRnVxUHdxzTbobAAD+GrlSXAZzSLF5ptDdY0QvkdSaPIH8T94
         QpnukKqGcAFUZcFtVqn7P6v7jQ2IS1vjZR3Re6hEisgDAexW9pWQNhskY6Wy/w9/qUV2
         20GUMIdBWzgkF3CwE5PubSppM8VNo4KkfiuFbK0bgPODMMkRxWGKYh3izxciqtWxZnso
         /+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pKp9pLyHx+s34EKHeLUFMMbpdPnaYczVbQqBa/dSsJw=;
        b=SwvGdoCXtaSlwfXulfR+b1wyYv6utXnqAYCuyQKvuJS7v6TQOU/2nVDE1FKu/IoK2U
         jn+0G62IcMeM7E9KmMQ6wOOBU7tAW1HeOIHRuycvG6ySNjOaz3MAjEbMuThO8jT1xU3f
         5qF3CzQkIPliyA1PHc17pvE5I/vBvwR6RHkAsSdBGqplw09jS2SZLtXWwqTYTKvdnQDL
         TKy1TFvfLDaj6SvAlQQGC7uDB0Z8YLYiduWJTSZ9cHCc/UaNB7PsPvcvlY7PXsZW7Zgd
         ZBKvgq0LVr4DZHC7rgMF2UEJHDjy61GsSTw4RmYlXQaZVNiUqmDcnCcYH7TVETFOWTV7
         2ZRA==
X-Gm-Message-State: AHQUAub+P4AKvMYpmahGQ1KApfeul7b/dicGG3uKyif6b31wkU0OvdTT
        MuHhReLA5NIIPZem7HWQ+ZA=
X-Google-Smtp-Source: AHgI3IaGCjfyaGT6Kt/O/uAOZWfN3sIEhskJQQVMOOO7S4eZaLKya6fYehMcP9f0jH6Lsol822mQzQ==
X-Received: by 2002:a2e:8795:: with SMTP id n21-v6mr1228421lji.109.1549443129630;
        Wed, 06 Feb 2019 00:52:09 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id x21sm4202240lfe.6.2019.02.06.00.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 00:52:08 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 63C584606E4; Wed,  6 Feb 2019 11:52:03 +0300 (MSK)
Date:   Wed, 6 Feb 2019 11:52:03 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 05/32] timerfd/timens: Take into account ns clock offsets
Message-ID: <20190206085203.GB25251@uranus>
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-6-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206001107.16488-6-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:10:39AM +0000, Dmitry Safonov wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> Make timerfd respect timens offsets.
> Provide two helpers timens_clock_to_host() timens_clock_from_host() that
> are useful to wire up timens to different kernel subsystems.
> Following patches will use timens_clock_from_host(), added here for
> completeness.
> 
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  fs/timerfd.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index 803ca070d42e..c7ae1e371912 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -26,6 +26,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/compat.h>
>  #include <linux/rcupdate.h>
> +#include <linux/time_namespace.h>
>  
>  struct timerfd_ctx {
>  	union {
> @@ -433,22 +434,27 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
>  }
>  
>  static int do_timerfd_settime(int ufd, int flags, 
> -		const struct itimerspec64 *new,
> +		struct itimerspec64 *new,
>  		struct itimerspec64 *old)
>  {
>  	struct fd f;
>  	struct timerfd_ctx *ctx;
>  	int ret;
>  
> -	if ((flags & ~TFD_SETTIME_FLAGS) ||
> -		 !itimerspec64_valid(new))
> -		return -EINVAL;

Please don't defer this early test of a @flags value. Otherwise
if @flags is invalid you continue fget/put/clock-to-host even
if result will be dropped out then.
