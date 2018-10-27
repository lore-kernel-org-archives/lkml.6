Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A71C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409D20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epQQ4/7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A409D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJ0UrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:47:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeJ0UrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 16:47:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id a28-v6so543375ljd.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUlhzbHtvpiLt0g9FBXvPQo4KTNlW9kYFGAu6kOyU3k=;
        b=epQQ4/7+6GimaKbY56IBgbZpjMwZowJoxq6Z+vgiOktccDVervEGnbuFN1bQgRV8Wt
         sOilyXGTCO1LmNychbqvDtv08BJWESTHYeQJ8m1/t8Q6XOIpDVxZx7rU0jzevnDsbNyh
         ot+YXX9+GlIiqx0aaF3F+9u2QehhXuLS384csxohT29OJGeshz0YjN7eYo2YAjwMsXqZ
         z1NX+eSQPkwwDucswLdA9V6mXRNn6DxrSLqOkeWPPV5bc4FBxjC7JEBs5mEymO4aD+7D
         9+TUuHc7wjJnyfkrm9lJ6YW4MQCVgyV4Zdm4mw+kLmz4wPvJbeGN2VHQf2YQMU6Ypja/
         dPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUlhzbHtvpiLt0g9FBXvPQo4KTNlW9kYFGAu6kOyU3k=;
        b=B1HAzSTEXn8kVycck2hI2NWj69EAi0CEz9dY87twSvAbl6BW0ELCQu3J9SvfWAwL6X
         CDYXkBLo/BDl8HvbZ+GBVpDkuPZXTGc6c0m4DuHwY9SaOoESdoAB983aXdEac3fJs4D/
         DLwZ7GRuGHZd++9OLCmzneELA2Bu9uYewTauvxlopodqHcC8qej7BDzRrEXq0IZiyaO0
         sRKOXHOXPXhZA2zRgJncfzpizOe/x6nUrJjB9pmMozlXCEP9CobIwCsmlyv2HFT0RaaM
         pe9FUIvnRFla23dtc1G8YQNZdhlr4QH3FNEkN8phbQ2j6LENvK5Nb1EWKfatgvHbfJqZ
         819Q==
X-Gm-Message-State: AGRZ1gJnBlfDzlhP8DvRcvWBVv+qgh1uOA5C2ORE5AH/v31IUI78LxAo
        hXW9UtbWtk0Iyw8zV0GLCI9C2tkjk5vzgAsHHuA=
X-Google-Smtp-Source: AJdET5dZWhS3JQTK+Kl61CMyik7F2Q5uGGb57OY1gKIUrtla3tP5c2ycw9J4HZibGdDgkMFjzsTiP4mJASH9MIl8a00=
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr5287431ljc.61.1540641981105;
 Sat, 27 Oct 2018 05:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk> <20181026232409.16100-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20181026232409.16100-2-linux@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 27 Oct 2018 14:06:09 +0200
Message-ID: <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] compiler_attributes.h: add __attribute__((format_arg))
 shorthand
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Sat, Oct 27, 2018 at 1:24 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 6b28c1b7310c..08264df52322 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -32,6 +32,7 @@
>  # define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
>  # define __GCC4_has_attribute___designated_init__     0
>  # define __GCC4_has_attribute___externally_visible__  1
> +# define __GCC4_has_attribute___format_arg__          1

Thank you Rasmus for doing this already on top of this tree!

>  # define __GCC4_has_attribute___noclone__             1
>  # define __GCC4_has_attribute___optimize__            1
>  # define __GCC4_has_attribute___nonstring__           0
> @@ -140,6 +141,18 @@
>  #define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
>  #define __scanf(a, b)                   __attribute__((__format__(scanf, a, b)))
>
> +/*
> + * Optional

I did quick check and gcc >= 4.1, clang >= 3.0, icc >= 13 compilers
seem to support it (or at least recognize it, even if they just ignore
it), so we do not need to make it optional, no? Did I miss some case?

Thanks!

Cheers,
Miguel
