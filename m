Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E36C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6858120870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoeFA30K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6858120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeJ2VPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:15:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39427 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeJ2VPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:15:04 -0400
Received: by mail-it1-f194.google.com with SMTP id m15so9121199itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2pqBSAuWhqNkxH8kbmPXrZIjdf5oyYt/tamuozcC3ts=;
        b=VoeFA30KS3kI+guEejiwT6D2PrChjY/9LakiMKMcuSVEda7ikTkDbAvAwTtxAJ6qMj
         g64i5zaWLLIZkjQcSRcxctdlPXmh25Nz5lugKDsyQBUdiT+DpmzSjakKu4rfinAvNNUA
         qk+FUBhyC2HGv3fAQONKzz0UxUqRDMmSBRFgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2pqBSAuWhqNkxH8kbmPXrZIjdf5oyYt/tamuozcC3ts=;
        b=Pgo2NP7gQU5/Td832uJRiYKs3q8az4C7qAeSL490zWQTrHEg84VtbGznllGiyTX0tk
         NgvWDzc83pmd2mjdtuZfSKINtkkhGZFmwfuuMPydIbh8hJ02ILXhuStDHtrY2sbdtJtC
         E5l3HCudolwAgeoZwgnpSAH2hf02kxWmkF9lwPbRaD/pMfBhSWHhdWm/Da3XaPIvG+tJ
         1GCYmD4JbgnyKcp04HKw4nQ0A8UyiFIMatuqnmlaAX+gZmIW4CQ7TwN/MPCiGAYL+kHl
         DMHai09drUy2XOm0waYBCGxUVBcDiTv9aM6vFXhjO+3dIPDKwVWXZViIzxxKBwLmdguB
         vAIg==
X-Gm-Message-State: AGRZ1gLK2lTnekTvZ+R8n3LosrY4WPAKlDLYBOKhogNdoMO2wHx9XPir
        HGwI5jPdyltZLLTU+aqJPnjD55rdTA1s2fluMZO1gg==
X-Google-Smtp-Source: AJdET5dzRB6Jx+xwCyefPDsiVAUKv8lO9DLz00pX5lMafYev3h0ZdKF2aIWhbayqMyQw08ZJZzTqB7CmyKFVeKx6BtY=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr9430192itc.26.1540815995451;
 Mon, 29 Oct 2018 05:26:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 05:25:55 -0700 (PDT)
In-Reply-To: <20181024084958.4627-3-kai.heng.feng@canonical.com>
References: <20181024084958.4627-1-kai.heng.feng@canonical.com> <20181024084958.4627-3-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Oct 2018 13:25:55 +0100
Message-ID: <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
Subject: Re: [PATCH 2/4 v5] memstick: Prevent memstick host from getting
 runtime suspended during card detection
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2018 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
> helpers to let memstick host support runtime pm.
>
> There's a small window between memstick_detect_change() and its queued
> work, memstick_check(). In this window the rpm count may go down to zero
> before the memstick host powers on, so the host can be inadvertently
> suspended.
>
> Increment rpm count before calling memstick_check(), and decrement rpm
> count afterward, as now we are sure the memstick host should be
> suspended or not.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/memstick/core/memstick.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 76382c858c35..5f16a8826401 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>
>  #define DRIVER_NAME "memstick"
>
> @@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_dev *card)
>   */
>  void memstick_detect_change(struct memstick_host *host)
>  {
> +       pm_runtime_get_noresume(host->dev.parent);
>         queue_work(workqueue, &host->media_checker);
>  }
>  EXPORT_SYMBOL(memstick_detect_change);
> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work)
>                 host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
>
>         mutex_unlock(&host->lock);
> +
> +       pm_runtime_put(host->dev.parent);
>         dev_dbg(&host->dev, "memstick_check finished\n");
>  }
>

I am not sure this works, sorry.

More precisely, I don't think there is a guarantee that the calls to
pm_runtime_get|put*() becomes properly balanced. In principle
memstick_detect_change() could be called, without actually causing a
new work to be scheduled if there is already such a work in the queue
(depends on the workqueue configuration). Isn't it so?

Kind regards
Uffe
