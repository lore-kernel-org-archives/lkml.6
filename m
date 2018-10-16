Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D1AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3359A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYJtExkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3359A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeJPSvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:51:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44532 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeJPSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:51:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so13765664qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6CBLWZT8J4f4taQpJpwVZZyZ7oNxV+GAn6RrXp9lk4=;
        b=bYJtExkTE+JUwvraN0Gtyhc1KAzKFzAvKlSK30Cd6CHmIWcut34hXPZcE61NU2nlIv
         tZCmXVCQMLOI2F2wV6dQR2US4bkGpAvh6CuOyNV39GNUPyRXLAO5WJj+/f1TxeZDkVck
         fMq7KVoKPa+8YqowAtqoP4Qle2aleUS39fB8shj+8pHjENc4jd5/gcZpHianP3GMNNkR
         HzEymHghGqDn85fjZKXbNaTUpfhbmpDHLp9JTtypuE6EDy+roVhBOYgtDk0CQ8kUWkGO
         P+k2p0ycoKBA2vz1X/T6mHNmzhBYYZZ5sJT+FFk6+5+1NqEeHC9SkmriFKE+k9eHqcKE
         HoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6CBLWZT8J4f4taQpJpwVZZyZ7oNxV+GAn6RrXp9lk4=;
        b=cLSKe3UxSsO6EC6rDIwe0EOphOEm2JFiSHt6AdmgKKtwdzNcT29zzLicGPe0KbIk89
         Sn3H3ylZ0+DTu01TCIDJ6Ls+1mRuTlwbvN41bsTXoTm6mB75m5YTwyG1eOudnQWSRkl8
         j8A6q+2B+shVFSlbJIIKhlAxsSru3YZB1ztfNPgU+YoGT4k9y+8J2ro0O8Tm6WNdupoK
         AI+RWcVOPr24LRQLqDuG2wloFPEpoGTcPgiBf5Xa1UElScZkzrknT/5dN4ErayVUmfRi
         SvxjDlepxmheHlmZJh0fF3OvthBj9xvTRu34e+qEe185rLizczo234HHpSUGLZRs6FAH
         sjwQ==
X-Gm-Message-State: ABuFfohK8lHg09M8qhhYWDrq54aES/vNu8KuZ8cZRzvYsqNMx/4vB3TR
        09wRuoLRgCBzW2YV41gyU5pKxHj0LHn732wtSRo=
X-Google-Smtp-Source: ACcGV60DXw2bqhnCtVnTmUw4rE2ZYUup17oAsV4yPA9y/BF/JJXe2xixzK6aUtYxuUk4Ya2RBp67nk9p4VrfI0frb2g=
X-Received: by 2002:a37:27d0:: with SMTP id n199-v6mr18953796qkn.33.1539687688251;
 Tue, 16 Oct 2018 04:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com> <20181016072244.1216-2-a.hajda@samsung.com>
In-Reply-To: <20181016072244.1216-2-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Oct 2018 14:01:16 +0300
Message-ID: <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
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

On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code seqences with simple call, so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..23fabefb217a 100644
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
> + * @fmt: printf-style format string
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

> +       if (err != -EPROBE_DEFER) {

Why not

if (err == ...)
 return err;

...
return err;

?

Better to read, better to maintain. No?

> +               va_start(args, fmt);
> +
> +               vaf.fmt = fmt;
> +               vaf.va = &args;
> +

> +               __dev_printk(KERN_ERR, dev, &vaf);

It would be nice to print an error code as well, wouldn't it?

> +               va_end(args);
> +       }
> +
> +       return err;
> +}
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
