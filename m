Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDCC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AB32075B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOew55sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AB32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIITif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 15:38:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40603 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeIITif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 15:38:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so12743759qkd.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bI8u8Gvb6WCXlrSi5I0fl1dSwkcMjdZ0wqgzEqGcuMU=;
        b=LOew55sqg8oi/KoNbTgV0btD41PHCpHOkgeZaBN0IFsXGiGmn+/EfoDraHbq/fS0l3
         n/bwL9R88OICd34DzcpHXl3NRlUjGtxG63Oc8/K9AlTnvlXXw4jIlhxNGMGktyejDZJW
         Zhe3ullVnpXZqK+fVDb/AuPEYar+j9mK4nkhp9CzXSF7c+8LNaOHzM6616Jn5zWmmN/j
         ocyzqbpDY/ipkR3e8RDME6vvAJEt0GE+76sCmFgmZ4axTjySqXEfgsq3aWovY3i0us/o
         MoXFeLurscT1O3dWio1KZjCfgFn4z6pzLmffVLQ8ftjr2WAKq3f08gnKGXYu4VzhdMpS
         2scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bI8u8Gvb6WCXlrSi5I0fl1dSwkcMjdZ0wqgzEqGcuMU=;
        b=T7cr6wtxffWqDi36/ZncL5jO7uDql5kuWM2xhS/R92qEmmJIR5kmbS9UHLxUc2wIHX
         vvcPYKkHCrd2KnIEsQsk0aAek5pB95vyQMix1PwzO/OelpLclrssK5m0zPzXL0Yr+D2e
         SQJyy8ZsXPouW/zSd5gZt2QyHVaYsnQyNXgN7QRb3KLgnoBK+vbCOKtNyfKXpSDBjCB5
         SyPH/eHiww16FYqPLijvq09sy/TNGPn/R8fF6LVknUTvujj+v0UupvDrX3eELQ5b1CJI
         utm6YvF77/0Tl+kDmsIEnhIIOdLfKD04fG88vfTJqzRM7HOilxo60hHT7GaU+kHzT6v8
         UgNg==
X-Gm-Message-State: APzg51AvRvRd2ZU5TWfjTqC4pMW1MEf4DHrPJ4vho4C41QlUsLeGbMeb
        WwrnaVf5YYjx/NIjbqBV98UcCtzILniRMlDPTyA=
X-Google-Smtp-Source: ANB0VdZU3lzTW5uQepFFFzJuC611WwYbEW1jz/fhjefysnAAdtSSlXuOKvVDRTMiFePWcaq753x0oNUN3OTvtHP51LE=
X-Received: by 2002:ae9:e118:: with SMTP id g24-v6mr11930787qkm.306.1536504519759;
 Sun, 09 Sep 2018 07:48:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 07:48:19 -0700 (PDT)
In-Reply-To: <20180909093611.GA4614@zn.tnic>
References: <20180908190553.GA4573@gmail.com> <20180909093611.GA4614@zn.tnic>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 16:48:19 +0200
Message-ID: <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 11:36 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Alternatively, if you don't want to let the crazy ifdeffery in that
> function grow even more, you can simply do:
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc9897f62..1728743360d4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -136,7 +136,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>   * to sched_rt_avg_update. But I don't trust it...
>   */
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> -       s64 steal = 0, irq_delta = 0;
> +       s64 steal __maybe_unused = 0, irq_delta = 0;
>  #endif

Indeed. But note that the attribute needs to be written before the
variable name so that it applies to both variables (or write it twice)
--- see https://godbolt.org/z/cwOeXZ

Also, if we go that route, I would simply remove the #ifdef entirely.

Cheers,
Miguel
