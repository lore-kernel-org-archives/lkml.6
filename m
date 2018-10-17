Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E72ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4wQBUOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B894F2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJQTZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:25:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46186 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:25:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id q12-v6so16162307qkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gm14wcv0UJ3h+HAjuqDJB23Iqp24MW+nuJIjnVCbduQ=;
        b=J4wQBUOa6lAcuFkWggJY9RyE9k9J4wWwkgisTHLo3u0Ta3naw17TU9/BPNbI4TMoZl
         IhR2d5r58fdDgf9I4t/qKGVkkHQXtYxATLtyIaBow17MUoquaeM/vuvEsa/vVCF51K8d
         XGh8w6AQoRnk33AwmnPjUVZROsFstNsXBJ8WvWbiULNJvpjJwqG/Eqg3qhWSDxIN3Ti2
         WSM64PLXaE7inckmajwlmqyHNKhOc//pJKd/rmZH9pr3+JcYZfKEIiRiQyjgJzhHcacH
         9dIpHHThvMvgQ0wpMheDKVUZI5Hfx+XJHv9Ye49sIm5WiiGezu5T7XOchkr2Dn9P9BI+
         4pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gm14wcv0UJ3h+HAjuqDJB23Iqp24MW+nuJIjnVCbduQ=;
        b=WB5pYfe2/TnvB4tvkfEWfyR6Yjj2mqvNFbL9HTvE5acsAvXseglXQWy67IpCD52ima
         PG5BMeZdcul0XFn+D+c/SoylU22o6/k4y64ndYQ3ZwMDyzIdItJhQA0IXrDeb0wATWRz
         f/S+sUcwZ4b6OY0cMMU5aKdqSUENcVJyHsgwpms3dF/ccIl3IR9M1+3KPUy+qfltgku0
         UX48FwzdgPT4v39Kb1pVGPbf1zokh/7HIKFEX53s1B63O1CO9rF5LyAxzaqooP4Pesbs
         3JGygBm4LYN5OCYLHy3ff59ltuTfmqaYTX6eMKgkaNMqlCvIGkM1dn1pAyN08wxtSU1W
         WIDA==
X-Gm-Message-State: ABuFfohKYlyntrtsEjWCSAcNdEJhNUhGD1k0CCCR3R+woo3ccls+aiGs
        8bQZRzXsjgaDQvfV97YvbINfIKrjp4I6WybylYM=
X-Google-Smtp-Source: ACcGV60f7ERSRBhbp4MlU1c9bU1WzFu66Mua4xyQWX2agfZIXsso3VGtPWhkh0qtx9coE0TAgsDN84pOR7ErhzZXn5U=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr22780311qkc.219.1539775826426;
 Wed, 17 Oct 2018 04:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f@eucas1p2.samsung.com>
 <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com> <20181017085824.30806-1-a.hajda@samsung.com>
In-Reply-To: <20181017085824.30806-1-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 14:30:15 +0300
Message-ID: <CAHp75VeV-fFZpPLJ26br-JL5WeAAKRJmAcWya-EgHQ6S3BRg+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: add probe_err log helper
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:58 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
> v2:
>   - added error value to log message,
>   - fixed code style,
>   - added EXPORT_SYMBOL_GPL,
>   - Added R-B by Javier (I hope the changes did not invalidate it).
> ---
>  drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..aa6f3229d066 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string, not ended with newline
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);
> + *     return err;
> + * with
> + *     return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       if (err == -EPROBE_DEFER)
> +               return err;
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
> +       dev_err(dev, "%pV, %d\n", &vaf, err);
> +       va_end(args);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(probe_err);
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 90224e75ade4..06c2c797d132 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1577,6 +1577,8 @@ do {                                                                      \
>         WARN_ONCE(condition, "%s %s: " format, \
>                         dev_driver_string(dev), dev_name(dev), ## arg)
>
> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.18.0
>


-- 
With Best Regards,
Andy Shevchenko
