Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E037620835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E037620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJJRAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:00:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33980 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJRAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:00:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id v69-v6so3568045oif.1;
        Wed, 10 Oct 2018 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjgCZIO4bnVghC79Vw8Imu6isoX2KXUGeJptQ414m/U=;
        b=jb0nQDtBmwToCzVxtuWo1nQDRVinhqNuhfzRb6zzbiQm8esAc5DzavGsw6c6ZD4zYS
         U0eBAg+bdInyDmFo6wKHzb0j7w/JQ+B1AAkPTa/JNivDkyhZ8/qwP0T+jh4YLQQySDBw
         bq0IQR7wKFGb0IU3YA+DY04y8EtW5k09v2PuL7tFo4fZjK/Jo1A7/AhNttguAkt+vEqe
         z8KlQtJ69oGQF07VOdNSez7gZtS2cV/4Pnf4HgbERO8fEVGknTTqr+9Xnfx5M9oENUyN
         PAa7mhEyxQT0pErppmyWJePX7QM5Bi5eKbQusEM7+xL4oGc/tgDk5yxeO4T20mM8IWcR
         yWzw==
X-Gm-Message-State: ABuFfoje/b0BjUPNnyaLYlAzzV9LB8Uas02zfV9e+wrOiFRHr8TXJhND
        M0uvaMifV3Il047sEiWYYNxbdEd+gZFJG3/sL9I=
X-Google-Smtp-Source: ACcGV60fXpFx+Isaix1R6P42Bt+Jx8zuKDokAxTAmeyQqvn+A2ZTyBbSy0OaStRXNLQw+GiGurV7RXkKXIqVs0rbsjM=
X-Received: by 2002:aca:c2c3:: with SMTP id s186-v6mr1217339oif.193.1539164321032;
 Wed, 10 Oct 2018 02:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk> <20181009112013.14238-16-linux@rasmusvillemoes.dk>
In-Reply-To: <20181009112013.14238-16-linux@rasmusvillemoes.dk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Oct 2018 11:38:29 +0200
Message-ID: <CAJZ5v0jmdnbhzPGbcFarQx-AfpLn72-BqDGowg=p=hEkB+J08w@mail.gmail.com>
Subject: Re: [PATCH v2 15/23] ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     jbaron@akamai.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:21 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> dynamic debug may be implemented via static keys, but ACPI is missing
> out on that runtime benefit since it open-codes one possible definition
> of DYNAMIC_DEBUG_BRANCH.
>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index de8d3d3fa651..21e03aa32aae 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -982,7 +982,7 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
>  #define acpi_handle_debug(handle, fmt, ...)                            \
>  do {                                                                   \
>         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
> -       if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT))          \
> +       if (DYNAMIC_DEBUG_BRANCH(descriptor))                           \
>                 __acpi_handle_debug(&descriptor, handle, pr_fmt(fmt),   \
>                                 ##__VA_ARGS__);                         \
>  } while (0)
> --
> 2.19.1.3.g1d92a00e68
>
