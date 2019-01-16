Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D7BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76AF20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCX6EvMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAPSmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:42:07 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40650 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfAPSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:42:07 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so2528313uao.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEnQV8MN4U/4B+Ox+HlUduKEEyFf3+VbksN6axDmC4E=;
        b=QCX6EvMUxpjSHQXqO6/ODO1oXCy1BuA11y+vMK7fiUeONPrteA53TAvOuSBsuLikLu
         IhUSBIU3XPO6w3BQmBFOOSu+vyUKVqUh1Wd2E9i73Dk3s2Xy7r0Urll6r7qQMK33ZIWZ
         Vft9KXarjIKgzQizchu9yp8VxYeMyK38438yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEnQV8MN4U/4B+Ox+HlUduKEEyFf3+VbksN6axDmC4E=;
        b=mCtN3zdSq8fcmsYLI2ucmYlQWaaTy1hlEOgyK+FcHlB1iWDxWLfXMxSw7iXStRZD/m
         6XZLqU50tZrMKyPGx38dW0+ZiBwgDvsfQzj+8EZBXV/eTMMgsk9w90K2j3QQabAHyKSF
         nXRpagH/WPoNORkceDOnbbMXhD7MpGrvdZcLdjT30HEyXndbu8Zbs4cBhyeSZLWRJcS4
         oiFBtqqSUqDRmdXxsFSsviqfOSWYV7OS/+MTWzc21hsHGCK5j2psyJUj6jur9Me/inxo
         KzxA7yo1fmyRyBaMdDonjO2u0gVwCFD7ByVD6sqHk/Yefwj2/caR0FgyFl6XWDe8dAoq
         ITDA==
X-Gm-Message-State: AJcUukfN9B5ptncv5ovB1LDanpGEBUTes+P3s00t4jSEbR8Ub5sIm2rS
        JSBz0FkNb1l3pqtTg8sKGuevj/IGNSI=
X-Google-Smtp-Source: ALg8bN7bfLmdrYBCCUB9nKQyLPrJZS8cWwFOc/7Eygl/D/MUsty3qRgk7VpaZlLL9ajCEH2npa6AbA==
X-Received: by 2002:ab0:26cb:: with SMTP id b11mr4228008uap.112.1547664125124;
        Wed, 16 Jan 2019 10:42:05 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id l10sm74471551vkl.54.2019.01.16.10.42.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:42:04 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id s184so1666167vkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:42:03 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr4091463vka.4.1547664122884;
 Wed, 16 Jan 2019 10:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-6-w@1wt.eu>
In-Reply-To: <20190112152844.26550-6-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 16 Jan 2019 10:41:50 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+LvQsLSO+TtVr5hrUTYHA0Hqrc=pxPMv++erySJ8pV7g@mail.gmail.com>
Message-ID: <CAGXu5j+LvQsLSO+TtVr5hrUTYHA0Hqrc=pxPMv++erySJ8pV7g@mail.gmail.com>
Subject: Re: [PATCH 6/8] ASoC: intel: skylake: change snprintf to scnprintf
 for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> ---
>  sound/soc/intel/skylake/skl-debug.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
> index 5d7ac2ee7a3c..bb28db734fb7 100644
> --- a/sound/soc/intel/skylake/skl-debug.c
> +++ b/sound/soc/intel/skylake/skl-debug.c
> @@ -43,7 +43,7 @@ static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
>         ssize_t ret = 0;
>
>         for (i = 0; i < max_pin; i++)
> -               ret += snprintf(buf + size, MOD_BUF - size,
> +               ret += scnprintf(buf + size, MOD_BUF - size,
>                                 "%s %d\n\tModule %d\n\tInstance %d\n\t"
>                                 "In-used %s\n\tType %s\n"
>                                 "\tState %d\n\tIndex %d\n",
>

While working on a Coccinelle script to find more cases of this, I
noticed that this code is buggy: it keeps overwriting the same
position in the buf string: "buf + size" and don't take "ret" into
account at all. This needs to be:

ret += scnprintf(buf + size + ret, MOD_BUF - size - ret,

-- 
Kees Cook
