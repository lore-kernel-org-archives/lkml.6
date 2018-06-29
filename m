Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0ECC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82988204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQc3fgt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82988204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937420AbeF2Uni (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:43:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37180 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbeF2Ung (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:43:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so7697613lfb.4;
        Fri, 29 Jun 2018 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=deIU8Q7YXT3lVZMXyASHEU0pPu8YXogke+JaVTqTzS0=;
        b=eQc3fgt6+3dCrUQRuIQ5hhIdvjThbmE9QSYL1rXnLxx+aGlDszEFSX99PFlowCJjcp
         yniDuDf8iFmJylfxYpktPhayP3SdCyog7ta6PPK+r726abnNxrvDYr60DY7QyqlircoP
         yV1CQA0CmEP8gHL+75y6l5w6OFSf+i9SAIN4vTVJvSaF2llohJWeKmys3q4U4wJt3IIh
         tSDGREly72LqtT0V+7itwZgSKMtKfkngZKwkO4QUWkxDRRDMziOrOOggnXT5q1WemDS5
         k3Y1iyIpvb1cB2RxpeWk1Sxo5UpShjO3tjGY04C5uODI3/OFaZyY1047YZmUd1+dmzUT
         3kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=deIU8Q7YXT3lVZMXyASHEU0pPu8YXogke+JaVTqTzS0=;
        b=p5o6dlkZmbDf/GpSRO8PS9SU/iKTcUJ0ssvHoqdSzvdwZ3loPR63epzkLhB06vj2t8
         aNnGY+UGQciisftyFFlEFRpqZJZ/g9UASFy5YYHUfrkNErq37v1dt3cD1bL63cyeMP09
         CPMItNdF3NsS+3tx/FAfk13VLP+QbgF69z8q4MBExMUczrmdP7sjoK3zckKfY5kqz5bq
         M0c1MQr5cH5FZC4tBYgup8xTuV8VXKKYRFPxJAQh0uEZBZPpv2RhhtC1piR6TJPtnolT
         c7sA9XYSijV5cvXPRzrp9jwZse1paBWjCQj49b9iGulEsPwPgyJesCltdfYRz/lqQ3+p
         C94w==
X-Gm-Message-State: APt69E1bgyDFKSEmPT+PX+1kz4aqVFx7ufv0WDM0wYcr+uvGWafCXzDy
        5tiBxN82+SytXOR0IRstqN6aVLvdzQ18NjeUeBk=
X-Google-Smtp-Source: AAOMgpcpWkkf/p2UjbfWTsJXmG3k4mjiS5rxnn4lYKWGxcHDWiRkQc3JEzQk7s/H1OtZ9LW3RZdCM70sU1cAsOADJ3k=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr11382104lfc.55.1530305014892;
 Fri, 29 Jun 2018 13:43:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:43:34
 -0700 (PDT)
In-Reply-To: <20180629002843.31095-5-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org> <20180629002843.31095-5-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 22:43:34 +0200
X-Google-Sender-Auth: zSobpIYxLKeeJpEQTR7lia26FMA
Message-ID: <CAK8P3a3F2y8B3a5zhYyG2KSMmSx5L3J3C_0sV-Csa0zPOzYJhA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] dm integrity: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 2:28 AM, Kees Cook <keescook@chromium.org> wrote:

> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 86438b2f10dd..85e8ce1625a2 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -521,7 +521,12 @@ static void section_mac(struct dm_integrity_c *ic, unsigned section, __u8 result
>                 }
>                 memset(result + size, 0, JOURNAL_MAC_SIZE - size);
>         } else {
> -               __u8 digest[size];
> +               __u8 digest[SHASH_MAX_DIGESTSIZE];
> +
> +               if (WARN_ON(size > sizeof(digest))) {
> +                       dm_integrity_io_error(ic, "digest_size", -EINVAL);
> +                       goto err;
> +               }

I'm still slightly worried that some patches like this one could make
things worse
and lead to an actual stack overflow. You define SHASH_MAX_DIGESTSIZE
as '512', which is still quite a lot to put on the kernel stack. The
function also
uses SHASH_DESC_ON_STACK(), so now you have two copies. Then you
could call shash_final_unaligned(), which seems to put a third copy on
the stack,
so replacing each one with a fixed-size buffer adds quite a bit of bloat.

Is there actually a digest that can be used in dm-integrity with more than 64
byte output (matching JOURNAL_MAC_SIZE) here?

       Arnd
