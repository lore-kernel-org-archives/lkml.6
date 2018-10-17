Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB33F21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJQSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:30:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35782 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeJQSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:30:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id 14so21657319oth.2;
        Wed, 17 Oct 2018 03:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpY7DEoVkPKId/asZO0ktMSN2EwMNI3Sxvkepc0/1bw=;
        b=Fds6Ge7e0TCgIqwLe1RMni0byvd6kKGzJdYxu6j8PWC9Wyq6jkENHNMZeU9rplZyyf
         K6TBOUioidXX4dhj4+hpTYvpuHqABTb2Yga5tFaxLfl0lSF26eM6PgBcbLgLqsPTZD1x
         thiEaz8KaqjZPRu18KosKxun0Veb/gkug4IoERKXBMB5MJp4f1QlqdRtMiHe3bWl9zub
         QKjsQtx+s2rX7vkU9aApMdRCnYO7HuW3wg9KEpfBqW/Te5ykQoaI8IDWv8IKTth9J4pf
         YsvLE6VPD+r7Diwz0b5SQkpbi1Ii8gUIE16KaeQyVu2+Xf6nvdoLqFg9j8GbTZNd+Ygw
         L3XA==
X-Gm-Message-State: ABuFfoi9g6s3T5KbSFILFHCKSi+bO17y9HU9jFtCaMGBAFRdWbD1WsY1
        DD5cBvBd4A/rU5q7dxZcVQCeXbJD75PavwqWG/XIQg==
X-Google-Smtp-Source: ACcGV627v6Pm/myy8vCShvnZQWCOBF0Pnm8WCCwcQ0fFDjz2sGYqZOXUttuOrAuDGLypyOeV0EFFIvw0E6vdiuVArgI=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr17067700otg.139.1539772546961;
 Wed, 17 Oct 2018 03:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <3560687.cIWiBQCOek@aspire.rjw.lan>
In-Reply-To: <3560687.cIWiBQCOek@aspire.rjw.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Oct 2018 12:35:35 +0200
Message-ID: <CAJZ5v0hYbcGaf9kOWvqEona6qz6UgLXk5CQhvPa0qTqcqsO=GA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: TAD: Add low-level support for real time capability
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 1:59 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add low-level support for the (optional) real time capability of the
> ACPI Time and Alarm Device (TAD) to the ACPI TAD driver.
>
> This allows the real time to be acquired or set via sysfs with the
> help of the _GRT and _SRT methods of the TAD, respectively.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Any objections or concerns here?

If not, I will queue this up.

> ---
>  drivers/acpi/acpi_tad.c |  201 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>
> Index: linux-pm/drivers/acpi/acpi_tad.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_tad.c
> +++ linux-pm/drivers/acpi/acpi_tad.c
> @@ -52,6 +52,201 @@ struct acpi_tad_driver_data {
>         u32 capabilities;
>  };
>
> +struct acpi_tad_rt {
> +       u16 year;  /* 1900 - 9999 */
> +       u8 month;  /* 1 - 12 */
> +       u8 day;    /* 1 - 31 */
> +       u8 hour;   /* 0 - 23 */
> +       u8 minute; /* 0 - 59 */
> +       u8 second; /* 0 - 59 */
> +       u8 valid;  /* 0 (failed) or 1 (success) for reads, 0 for writes */
> +       u16 msec;  /* 1 - 1000 */
> +       s16 tz;    /* -1440 to 1440 or 2047 (unspecified) */
> +       u8 daylight;
> +       u8 padding[3]; /* must be 0 */
> +} __packed;
> +
> +static int acpi_tad_set_real_time(struct device *dev, struct acpi_tad_rt *rt)
> +{
> +       acpi_handle handle = ACPI_HANDLE(dev);
> +       union acpi_object args[] = {
> +               { .type = ACPI_TYPE_BUFFER, },
> +       };
> +       struct acpi_object_list arg_list = {
> +               .pointer = args,
> +               .count = ARRAY_SIZE(args),
> +       };
> +       unsigned long long retval;
> +       acpi_status status;
> +
> +       if (rt->year < 1900 || rt->year > 9999 ||
> +           rt->month < 1 || rt->month > 12 ||
> +           rt->hour > 23 || rt->minute > 59 || rt->second > 59 ||
> +           rt->tz < -1440 || (rt->tz > 1440 && rt->tz != 2047) ||
> +           rt->daylight > 3)
> +               return -ERANGE;
> +
> +       args[0].buffer.pointer = (u8 *)rt;
> +       args[0].buffer.length = sizeof(*rt);
> +
> +       pm_runtime_get_sync(dev);
> +
> +       status = acpi_evaluate_integer(handle, "_SRT", &arg_list, &retval);
> +
> +       pm_runtime_put_sync(dev);
> +
> +       if (ACPI_FAILURE(status) || retval)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int acpi_tad_get_real_time(struct device *dev, struct acpi_tad_rt *rt)
> +{
> +       acpi_handle handle = ACPI_HANDLE(dev);
> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER };
> +       union acpi_object *out_obj;
> +       struct acpi_tad_rt *data;
> +       acpi_status status;
> +       int ret = -EIO;
> +
> +       pm_runtime_get_sync(dev);
> +
> +       status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
> +
> +       pm_runtime_put_sync(dev);
> +
> +       if (ACPI_FAILURE(status))
> +               goto out_free;
> +
> +       out_obj = output.pointer;
> +       if (out_obj->type != ACPI_TYPE_BUFFER)
> +               goto out_free;
> +
> +       if (out_obj->buffer.length != sizeof(*rt))
> +               goto out_free;
> +
> +       data = (struct acpi_tad_rt *)(out_obj->buffer.pointer);
> +       if (!data->valid)
> +               goto out_free;
> +
> +       memcpy(rt, data, sizeof(*rt));
> +       ret = 0;
> +
> +out_free:
> +       ACPI_FREE(output.pointer);
> +       return ret;
> +}
> +
> +static char *acpi_tad_rt_next_field(char *s, int *val)
> +{
> +       char *p;
> +
> +       p = strchr(s, ':');
> +       if (!p)
> +               return NULL;
> +
> +       *p = '\0';
> +       if (kstrtoint(s, 10, val))
> +               return NULL;
> +
> +       return p + 1;
> +}
> +
> +static ssize_t time_store(struct device *dev, struct device_attribute *attr,
> +                         const char *buf, size_t count)
> +{
> +       struct acpi_tad_rt rt;
> +       char *str, *s;
> +       int val, ret = -ENODATA;
> +
> +       str = kmemdup_nul(buf, count, GFP_KERNEL);
> +       if (!str)
> +               return -ENOMEM;
> +
> +       s = acpi_tad_rt_next_field(str, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.year = val;
> +
> +       s = acpi_tad_rt_next_field(s, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.month = val;
> +
> +       s = acpi_tad_rt_next_field(s, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.day = val;
> +
> +       s = acpi_tad_rt_next_field(s, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.hour = val;
> +
> +       s = acpi_tad_rt_next_field(s, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.minute = val;
> +
> +       s = acpi_tad_rt_next_field(s, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.second = val;
> +
> +       s = acpi_tad_rt_next_field(s, &val);
> +       if (!s)
> +               goto out_free;
> +
> +       rt.tz = val;
> +
> +       if (kstrtoint(s, 10, &val))
> +               goto out_free;
> +
> +       rt.daylight = val;
> +
> +       rt.valid = 0;
> +       rt.msec = 0;
> +       memset(rt.padding, 0, 3);
> +
> +       ret = acpi_tad_set_real_time(dev, &rt);
> +
> +out_free:
> +       kfree(str);
> +       return ret ? ret : count;
> +}
> +
> +static ssize_t time_show(struct device *dev, struct device_attribute *attr,
> +                        char *buf)
> +{
> +       struct acpi_tad_rt rt;
> +       int ret;
> +
> +       ret = acpi_tad_get_real_time(dev, &rt);
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%u:%u:%u:%u:%u:%u:%d:%u\n",
> +                      rt.year, rt.month, rt.day, rt.hour, rt.minute, rt.second,
> +                      rt.tz, rt.daylight);
> +}
> +
> +static DEVICE_ATTR(time, S_IRUSR | S_IWUSR, time_show, time_store);
> +
> +static struct attribute *acpi_tad_time_attrs[] = {
> +       &dev_attr_time.attr,
> +       NULL,
> +};
> +static const struct attribute_group acpi_tad_time_attr_group = {
> +       .attrs  = acpi_tad_time_attrs,
> +};
> +
>  static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
>                              u32 value)
>  {
> @@ -447,6 +642,12 @@ static int acpi_tad_probe(struct platfor
>                 if (ret)
>                         goto fail;
>         }
> +
> +       if (caps & ACPI_TAD_RT) {
> +               ret = sysfs_create_group(&dev->kobj, &acpi_tad_time_attr_group);
> +               if (ret)
> +                       goto fail;
> +       }
>
>         return 0;
>
>
