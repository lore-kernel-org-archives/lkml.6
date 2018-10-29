Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7367FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EFA20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5c1zljh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EFA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeJ3FCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:02:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43152 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeJ3FCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:02:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id r71so5802106qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1DR+RIO5BlWOrivcvLmawj6hbljwesJm2IQ19ZJRXE=;
        b=p5c1zljhmRn++uFLDQJG7wSM/ME79LYP0OfyX1+/ZE1kHhszzBkSHsOXkzVdwWojqE
         S8xB9/I/6C4Mj1npkW9+dQvZoM7ymjKCaIxeW0+Eu81UEjXqtuMLJdYMw11DzEdTXijB
         D7B4bbpY5fM0GiKs24KEZRoKtXzvb/6+8AeCdfJBw6wydgF5CkqRW6jbkAb0aFrh9u3U
         E4vKDl/pQZ+NL4cdM1dfI4YVbhl5ZD7FZtg/IK4yOdqKPIkmaVvTm1duXYONNolr+7gF
         g1ELp2w3m9TySV5F3tbhx89fxXI/TVOg3CXwrd58tmZoaPG+s0/f7N7p3smMkO/J1lLz
         6X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1DR+RIO5BlWOrivcvLmawj6hbljwesJm2IQ19ZJRXE=;
        b=i+YJpj6U3gBwqXwJPleRXVj7xCRaCYoTAnVqUkduHaFfIUSXOm5+JCeEjw5beREZsk
         zA++aqeNZTeP8ocbq2T8CTHZm0Vs9k5ckUp99eZ1Dtg7/pUStmR8r8OforT1xkM5+4NF
         rZoLPn3TMbQDbgyimwFJ8a5COvSXclH0IZeYpy2xIPMQTI5+up82pi0Z+BlxPPgNbZWr
         1Qq9HEQcl5VllGY2hPFyiJ0EOW6ieNhCfc226g5NUXGRDKs3AlkXSN346+YnP7Njef/A
         KYlkCQQLKjEhbzK7AB8ZwoL0MnvUl46g9DxDGhLuxG8kMNg/im645q4bs9HUD4ZTaROI
         tWMA==
X-Gm-Message-State: AGRZ1gJH3e6Qz481WwK6GhZKBSzw7b+d3mNXYhSYLiIuSbFZ5oHUQAGF
        Om9O58YgxICDIJI+8NsWtabGX/0xTLvblaheIoLca22Q
X-Google-Smtp-Source: AJdET5fJWDjUpewGLp/MmzA0YctC9XMZq4aw1kUyZ0C2tjEi/16/n5jPxpZ/hXi24oi5ctROFPXCrXWS7IxlNghcf6g=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr13630399qkg.70.1540843923124;
 Mon, 29 Oct 2018 13:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181029200920.28901-1-semen.protsenko@linaro.org>
In-Reply-To: <20181029200920.28901-1-semen.protsenko@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 22:11:52 +0200
Message-ID: <CAHp75Vd7XpPgx+RuOon6HD0U7LcKrqJLgukEk0wfYFrii=2DJg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/SRCU: Fix ctags
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:09 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> ctags indexing ("make tags" command) throws this warning:
>
>     ctags: Warning: include/linux/notifier.h:125:
>     null expansion of name pattern "\1"
>
> This is the result of DEFINE_PER_CPU() macro exapansion. Fix that by
> getting rid of line break.
>
> Similar fix was already done in commit 25528213fe9f ("tags: Fix
> DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.

Why not to add Fixes tag here as well?

>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/linux/notifier.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index f35c7bf76143..0096a05395e3 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -122,8 +122,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>
>  #ifdef CONFIG_TREE_SRCU
>  #define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> -       static DEFINE_PER_CPU(struct srcu_data,                 \
> -                       name##_head_srcu_data);                 \
> +       static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data); \
>         mod struct srcu_notifier_head name =                    \
>                         SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
>
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
