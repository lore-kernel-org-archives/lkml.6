Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeEUWQO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:16:14 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41989 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbeEUWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:16:08 -0400
X-Google-Smtp-Source: AB8JxZobOPKCGOInLGEzblc5OcUaICWMfrcwHkFRCAmSs59aOA3xx0kxQ16G4AbXaECWaUd4SGMxu6WYiYlqwfvZFLI=
MIME-Version: 1.0
In-Reply-To: <1526462116-10894-1-git-send-email-xieyisheng1@huawei.com>
References: <1526462116-10894-1-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:16:06 +0300
Message-ID: <CAHp75VeJxQDuSXZNDgZsHsoWg37oe=h3L796jcv=44kZfZcSuQ@mail.gmail.com>
Subject: Re: [PATCH] intel_th: pti: Convert to use sysfs_match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 12:15 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> The helper returns index of the matching string in an array,
> use it to simpler the code.

IIRC I sent the patch with the same semantics week or so ago against this file.

>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/hwtracing/intel_th/pti.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
> index 5669433..75cb368 100644
> --- a/drivers/hwtracing/intel_th/pti.c
> +++ b/drivers/hwtracing/intel_th/pti.c
> @@ -272,15 +272,12 @@ static ssize_t lpp_dest_store(struct device *dev, struct device_attribute *attr,
>                               const char *buf, size_t size)
>  {
>         struct pti_device *pti = dev_get_drvdata(dev);
> -       ssize_t ret = -EINVAL;
> -       int i;
> +       ssize_t ret;
>
> -       for (i = 0; i < ARRAY_SIZE(lpp_dest_str); i++)
> -               if (sysfs_streq(buf, lpp_dest_str[i]))
> -                       break;
> +       ret = sysfs_match_string(lpp_dest_str, buf);
>
> -       if (i < ARRAY_SIZE(lpp_dest_str) && pti->lpp_dest_mask & BIT(i)) {
> -               pti->lpp_dest = i;
> +       if (ret >= 0 && pti->lpp_dest_mask & BIT(ret)) {
> +               pti->lpp_dest = ret;
>                 ret = size;
>         }
>
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
