Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F145D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="juJLRXvm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIAyLxRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F145D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbeGYTNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:41 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36117 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbeGYTNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:40 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so3181179ywg.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uuhDyEcstHBQ8PS0szoXCUUz/3BpR1x30Grc7yDaEtg=;
        b=juJLRXvm+Q4cUCLMYEm8zdmYx0QBoN+BVZBOwc0oMx/SCQ6VGL+G78iA2/wHxCYVXz
         wRSIoOUifvrBJCDVA6oSodF6ytIJnc66QgjXv3wyYK6rgYsfzcAyF06gUhGPeAcuyU6g
         UrcpSGDT3gdeDskz5gmpuXONeUNo0F6WBEmXyrk4o8HB2gvsDUa+CUrOYJVJOq3ulp0i
         xXNf9DqXRuYwEGUriTiUI1DcPFozAMhtH5l+/lr21Zcgi5V6cKzCejdddQzHJp4DtbGn
         4Fn2Sy55kxQ0TJpREfHJw4eUaNoHPN7NTrn7HYN8X9vJH2yQkrkkB4+k8aMBKsFtcI3H
         k9pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uuhDyEcstHBQ8PS0szoXCUUz/3BpR1x30Grc7yDaEtg=;
        b=AIAyLxRlBQP0XrdMP1+DuyyCk29OWhBndKK7e7jUAwmVaDzAmEIRAjyAvb2ckzRQcs
         EYpFR3n4gQ57rLjDrhZ6hlMqD6Qu4Stlk69l9jLB90G2tE9QjYEQA15BjiFIW6Nefi1P
         AgDvaLvf4qeYISaMnF9RYWOUksWpHwQ+Xwc/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uuhDyEcstHBQ8PS0szoXCUUz/3BpR1x30Grc7yDaEtg=;
        b=Ywu16LgH2Y48UPE/R9bi2eua/R6q/h7T1SS3ispgEUjzA5xDq18ahFqyHjnyZxgbqU
         7pnq3sObHmqXAMD2WiuhAzvqYnjKR3bS6xxLtALZ8mkbySFBphEressLpd8FL7UrhkhT
         sW8A1wsBysUobx0wAP+j9Ml9kiDr67OA17sTHWogrRAEX9khU5Xa+dQhit78Y7mI6+x2
         o3w6DbGpXbOkAOZvXd+btXulOdAk4OEAKW/QpphrZKw+gIyn69Loo8+7Nu2d3sYwcwFx
         MMk//SS3xJf1XNYZ4rWN048BHMAA63OtRjf87RQp7ILKprKVRpZRG5QeeN5/psndTZ5D
         cK0w==
X-Gm-Message-State: AOUpUlET5QU9liSs9Lu7l917Q/f1ItevF5krt0d+Q0ERde5OyPWlqqY4
        f1N7TPVT4R6uRfQCpMPoS1ULCdy4wg6uTk6U/dlbxQ==
X-Google-Smtp-Source: AAOMgpfCvch4NFLjqtKRG3ScqwpR03WH2RI12A4s/+sjqJbw22jtWcZpppzwbiN2R7fCkbRDerv6F9Fy2fiCsJY6yeU=
X-Received: by 2002:a0d:d287:: with SMTP id u129-v6mr11863210ywd.95.1532541654329;
 Wed, 25 Jul 2018 11:00:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 11:00:53
 -0700 (PDT)
In-Reply-To: <20180725171901.4468-1-zsm@chromium.org>
References: <20180725171901.4468-1-zsm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 25 Jul 2018 11:00:53 -0700
X-Google-Sender-Auth: sPU5IcjAZs85ev7hAtgin7IOOh8
Message-ID: <CAGXu5jJhgbDYK4ZQtkZtpNPMMYwz-iH4224eULmLDdrvp-s4BA@mail.gmail.com>
Subject: Re: [PATCH v2] tracefs: Annotate tracefs_ops with __ro_after_init
To:     Zubin Mithra <zsm@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:19 AM, Zubin Mithra <zsm@chromium.org> wrote:
> tracefs_ops is initialized inside tracefs_create_instance_dir and not
> modified after. tracefs_create_instance_dir allows for initialization
> only once, and is called from create_trace_instances(marked __init),
> which is called from tracer_init_tracefs(marked __init). Also, mark
> tracefs_create_instance_dir as __init.
>
> Signed-off-by: Zubin Mithra <zsm@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/tracefs/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index bea8ad876bf9..7098c49f3693 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
>  static struct tracefs_dir_ops {
>         int (*mkdir)(const char *name);
>         int (*rmdir)(const char *name);
> -} tracefs_ops;
> +} tracefs_ops __ro_after_init;
>
>  static char *get_dname(struct dentry *dentry)
>  {
> @@ -478,7 +478,8 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
>   *
>   * Returns the dentry of the instances directory.
>   */
> -struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
> +__init struct dentry *tracefs_create_instance_dir(const char *name,
> +                                         struct dentry *parent,
>                                           int (*mkdir)(const char *name),
>                                           int (*rmdir)(const char *name))
>  {
> --
> 2.18.0.233.g985f88cf7e-goog
>



-- 
Kees Cook
Pixel Security
