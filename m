Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524C2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BB120835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BB120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJJRAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:00:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37405 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJJRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:00:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so4695971oth.4;
        Wed, 10 Oct 2018 02:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hH+8/99u9OXa/5V5UrRTd3XaejdRbgV2PYxl64xEHec=;
        b=tdbPTo2ChUDi5CS5BC44YxLtGjxR2g1n9MAxm7etUznbNEYfgDJork5yoh8UsLr2Tf
         D6MVI0pefQunVtedSN590opWTQa39VGIKCS4E9RcXgAGAx35cJ2OqpQ1k0BKHDgmE6me
         YWU2ZMPczdMp6TDi/uX/chGe/xTktSuK5ACOhPIxZNVIew1ppkqy6Dx/q73oosDdSdhF
         8hjOtxO87x9QMnaVFrK06Y8m2O12exR4Z2LMGpBgW9RLfiiEJtyl2WZDgc/jivdRR5re
         SLcrb0hLdCKQcTGTOOSQ3Ats6avs2i2ZG/7B/EluHDxl5+EGKc1zwAxQxeY9UPOrqcTf
         BdUg==
X-Gm-Message-State: ABuFfojFeNb/UaLKyX1SUNMmOjyPKJ2S8yHgWdD1NuHuCIV+kXw74DQq
        hEeHQrnXqW/3ljc5HMKJiU8dIyImWO5sWW5kNpz9YwVg
X-Google-Smtp-Source: ACcGV62ZK/IjigU+xivdu4wXQ/pbFP8GSttkg42XTXZMrHLlJI0OCnqBHK/0Z3RnBj88k4naPM+1Jw2nTM8THFPlA2k=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr14462915otg.139.1539164340395;
 Wed, 10 Oct 2018 02:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk> <20181009112013.14238-17-linux@rasmusvillemoes.dk>
In-Reply-To: <20181009112013.14238-17-linux@rasmusvillemoes.dk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Oct 2018 11:38:49 +0200
Message-ID: <CAJZ5v0jA8-5gpWR0spqLzBi-hQeXvt4u4Bie9BgOLWfhgErqBA@mail.gmail.com>
Subject: Re: [PATCH v2 16/23] ACPI: remove unused __acpi_handle_debug macro
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     jbaron@akamai.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:20 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> If CONFIG_DYNAMIC_DEBUG is not set, acpi_handle_debug directly invokes
> acpi_handle_printk (if DEBUG) or does a no-printk (if !DEBUG). So this
> macro is never used.
>
> Cc: linux-acpi@vger.kernel.org
> Acked-by: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/acpi.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 21e03aa32aae..e12d5ef1a054 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -948,9 +948,6 @@ acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
>  #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
>  __printf(3, 4)
>  void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const char *fmt, ...);
> -#else
> -#define __acpi_handle_debug(descriptor, handle, fmt, ...)              \
> -       acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_ARGS__);
>  #endif
>
>  /*
> --
> 2.19.1.3.g1d92a00e68
>
