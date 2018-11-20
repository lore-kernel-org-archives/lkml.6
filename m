Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC0C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D3420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D3420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeKUBxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:53:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41002 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeKUBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:53:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so1974737otk.8;
        Tue, 20 Nov 2018 07:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awy433pspm0+JQKnMRLvipwXUa5Rh1rljx8XVKppnFQ=;
        b=S3C4OFnrXg1uhZZbFp2EAJNeUky2fpMjVwbquJSknlVa9xAiXyJ2m9gqBIj4UqCoyf
         xjokLopzFKZCJCKcy9EMKmqxQW+OP0w9kHRkiy5dndlgU+Z1ApFjBsA/ESx8uob0f4ez
         iSuUc+JoRlvELWNG5GJ0ZT90YGO3AkyQ5GIQ5fpHUp4NYSYniTWACXUdZebWhJNi0ZgV
         Bhn+u5WfZRP02ek0scB7vUv1sMjmR00V1pWGUbySzaxV/sCQehgRU9vwEde+tCB/J+oR
         GInSTqaNQswEnQSo6qJoN0UhhENpCQzFUKkpQwPaONB7QL90HSKyjF9oIbRnnJp9zys1
         JgBg==
X-Gm-Message-State: AGRZ1gIKA5FF/ATb3OTBkT1ZSrX1gCaRf02gmZj6/Xsg/RYZQZ3732Ze
        Xnbr0uNS+ApF1RtsDWT5mmdCwY0J/4qNZhhCABU=
X-Google-Smtp-Source: AFSGD/Wxdq1a8zIL4WCkOMskfiC80xn7bCbZI8gTZSNnT9QoGEmiJfeEYL9iWpyADHJU1R6yrhzZQq8aApLlA1/cbiA=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr1477368otg.139.1542727451416;
 Tue, 20 Nov 2018 07:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20181120130012.19471-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120130012.19471-1-tiny.windzz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Nov 2018 16:23:57 +0100
Message-ID: <CAJZ5v0g==G+_HkOnjfecCimxpQgXxeTJ3e-Uyi_YHfq+BE5jRA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: big.LITTLE: add of_node_put()
To:     tiny.windzz@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:00 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> use of_node_put() to release the refcount.

I gather that the of_node_put() is missing?

If so, that should be stated in the changelog too.

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..a3b8bc09bac8 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -174,8 +174,10 @@ static int __init bl_idle_init(void)
>         /*
>          * Initialize the driver just for a compliant set of machines
>          */
> -       if (!of_match_node(compatible_machine_match, root))
> -               return -ENODEV;
> +       if (!of_match_node(compatible_machine_match, root)){
> +               ret = -ENODEV;
> +               goto out_release_node;
> +       }
>
>         if (!mcpm_is_available())
>                 return -EUNATCH;
> @@ -222,6 +224,8 @@ static int __init bl_idle_init(void)
>         kfree(bl_idle_big_driver.cpumask);
>  out_uninit_little:
>         kfree(bl_idle_little_driver.cpumask);
> +out_release_node:
> +       of_node_put(root);
>
>         return ret;
>  }
> --
> 2.17.0
>
