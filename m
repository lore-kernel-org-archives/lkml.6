Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E3020672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3qpkAXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E3020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeLJSPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:15:19 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33374 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeLJSPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:15:18 -0500
Received: by mail-yb1-f196.google.com with SMTP id f125so5615102ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuehRAXwp6mdHZsj5VUFLh2brCcNVmkWlVypCdcPeY0=;
        b=R3qpkAXm6C5O/r+kPsUl7sYflI2Y07RLUMb1SRFacItz5TPs97X+JUORH8Yyv2yf5b
         GM6jzNw8QHgneFYurrcSzClS+eJyY93XBE3WIaqaSEa5PBUqpvs3aUvr1UNlcHxcBvHu
         L7Y9jEC/CUFy5VJPGeruOHS7oUVFunmin7xBQpp6qgNFX+jeuX68KsTUAKdpyfGzHaW3
         VLtxumIXteNHWPU4B9+9BrYET9U/kgLJViE8LhplfuNfB/buUGoGmBFSophXOtq/xGOt
         Aj415qyVchUPFblZ3ZEhOH2oRhqHbflZbXv5+zGS5ryIg8idH04SksQJCprR4EQBhfEi
         NTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuehRAXwp6mdHZsj5VUFLh2brCcNVmkWlVypCdcPeY0=;
        b=ryIG46oD6Xl9eKqrz+cPGKnHvCSRMJW5VmVF9UxiiN5MqA0ABUS47pA21BhA7Hp76n
         vbmrJtET/hdwGUJxYYa72ml60I4PIWJ0FjxcVtZoGM2z/cf92YMcqKmKCXwS58H4UZzW
         dS32mBfHLPdCWwrUE8oCQqqyD44fmJatT8y1HaHpfSNbbIav2QwCd8NWwiDoJCFvRtHb
         r6Hd5MIA4iMrCmcCz9DTiQYiXJXnAtSYD5ojUFZ3ZZClGVmvA2oNrJiP9PahX3aI5zTL
         +Sn5090C9j6UTjEwAP8Lv/qx/9Keg7jrkx+/k6MaLHF7QrRMqeC6issUuhbLqtHe5qAl
         vn1Q==
X-Gm-Message-State: AA+aEWbKgQuH4yxMSlAn3UpRw7rHgu4LdhEaPlbO8HWMulbAPxEyhEJa
        VBG7DWMjv8x0azfWLrbDrakjKEm7QFv3vT9jwB0r6A==
X-Google-Smtp-Source: AFSGD/ULuXiOh/wkA0CqsqjrRtbZWStDURFmbEsXmPhmF/l7+/p4wXMIWztX12IOWZR+yz1bttXFCSTy4jIiaqxej+I=
X-Received: by 2002:a25:48c7:: with SMTP id v190-v6mr12782626yba.7.1544465717396;
 Mon, 10 Dec 2018 10:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com> <20181127121849.23975-7-enric.balletbo@collabora.com>
In-Reply-To: <20181127121849.23975-7-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 10 Dec 2018 10:15:05 -0800
Message-ID: <CABXOdTd3_KGfJG-E7UBgnxKJcyFNVZ2FqdqH6y-G0gkEUZjk0Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] mfd / platform: cros_ec: instantiate only if th EC
 has a VBC NVRAM.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros-ec-vbc driver is DT-only and there is a DT property that
> indicates if the EC has the VCB NVRAM, in such case instantiate the
> driver but don't instantiate on the other cases.
>
> To do this move the check code to its parent instead of play with the
> attribute group visibility. This changes a bit the actual behaviour.
> Before the patch if an EC doesn't have a VBC NVRAM an empty vbc folder
> is created in /sys/class/chromeos/<ec device>, after the patch the empty
> folder is not created, so, the folder is only created if the vbc is set.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Fixed build error as reported by kbuild test robot.
>
> Changes in v2:
> - Remove unnecessary IS_ENABLED.
> - Remove dev_err message telling that VBC is found.
> - Use dev_warn instead of dev_err as the error is ignored.
>
>  drivers/mfd/cros_ec_dev.c             | 19 ++++++++++++++++++-
>  drivers/platform/chrome/cros_ec_vbc.c | 16 ----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d9b16ce79319..1ba98a32715e 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -21,6 +21,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> @@ -386,12 +387,16 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>         { .name = "cros-ec-debugfs" },
>         { .name = "cros-ec-lightbar" },
>         { .name = "cros-ec-sysfs" },
> -       { .name = "cros-ec-vbc" },
> +};
> +
> +static const struct mfd_cell cros_ec_vbc_cells[] = {
> +       { .name = "cros-ec-vbc" }
>  };
>
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>         int retval = -ENOMEM;
> +       struct device_node *node;
>         struct device *dev = &pdev->dev;
>         struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
>         struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> @@ -479,6 +484,18 @@ static int ec_device_probe(struct platform_device *pdev)
>                          "failed to add cros-ec platform devices: %d\n",
>                          retval);
>
> +       /* Check whether this EC instance has a VBC NVRAM */
> +       node = ec->ec_dev->dev->of_node;
> +       if (of_property_read_bool(node, "google,has-vbc-nvram")) {
> +               retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> +                                        cros_ec_vbc_cells,
> +                                        ARRAY_SIZE(cros_ec_vbc_cells),
> +                                        NULL, 0, NULL);
> +               if (retval)
> +                       dev_warn(ec->dev, "failed to add VBC devices: %d\n",
> +                                retval);
> +       }
> +
>         return 0;
>
>  failed:
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index da3bbf05e86f..af9bfe6f385c 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -108,21 +108,6 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
>         return data_sz;
>  }
>
> -static umode_t cros_ec_vbc_is_visible(struct kobject *kobj,
> -                                     struct bin_attribute *a, int n)
> -{
> -       struct device *dev = container_of(kobj, struct device, kobj);
> -       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> -       struct device_node *np = ec->ec_dev->dev->of_node;
> -
> -       if (IS_ENABLED(CONFIG_OF) && np) {
> -               if (of_property_read_bool(np, "google,has-vbc-nvram"))
> -                       return a->attr.mode;
> -       }
> -
> -       return 0;
> -}
> -
>  static BIN_ATTR_RW(vboot_context, 16);
>
>  static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
> @@ -133,7 +118,6 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>  struct attribute_group cros_ec_vbc_attr_group = {
>         .name = "vbc",
>         .bin_attrs = cros_ec_vbc_bin_attrs,
> -       .is_bin_visible = cros_ec_vbc_is_visible,
>  };
>
>  static int cros_ec_vbc_probe(struct platform_device *pd)
> --
> 2.19.1
>
