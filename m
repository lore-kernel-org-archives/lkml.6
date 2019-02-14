Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A832177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550138080;
	bh=EBCQMqitVGVdkF7MnatK48y3fX++OhsGTPrQj4kfmnY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FOYh5wBBjtp11xT2JZacWsvbmm6o+bMWYSpMPSrK5zJN22MyBiqZm+0Xmh50yv8GP
	 GujRbXqlgFHECb3CnviQRaf/f9wtt2AOIIvysUHVxvTbAHJHHFTYUlBKiL41f9ScTN
	 CPCKr8ofY0Ek70CRglgmtOfI16H4JUofkeV+r78I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438102AbfBNJyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:54:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46428 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438090AbfBNJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:54:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so9421133otm.13;
        Thu, 14 Feb 2019 01:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RN7YV9HrVY/nPI8NJM+RzPh8fPcnbjaFRtrbzWbe7ME=;
        b=scPBCX0u40nCEUpxRG8HyrVPduHwEcZW9O2KooV4hiJ+pdYJwVYYNuVVJH2M0oRYW8
         sq8qnczUx5hhT89PA3LoOfZMJRuqVf84QnWkSdg7NF1NUtj2uSbJib36uP/oQWBbDiLt
         VQQX7+ZMQTfA8tEV5opLvE/B8vx0JoVwD9y+H11qbKEq+ZVxyQnA2QnKWv3rBMO8fEjH
         f92XPO5NvZ89Kk4aTevIWJeunxvEtLHRGrWmiXMAxo9Yaj7dII6z6iq78DoIKYKGlmUg
         /PQ8lAm9C3bDpdqnnloAOADLakTw7bcMMHlMC3IeUXWmUfRgfZkzPN2IEQrW3a5cT3tR
         NzgA==
X-Gm-Message-State: AHQUAuZSoVmCw6hLCBMCC1SOOvXBOe6+mJJmvAsyWq30JDKPqBjhuZcr
        UPvD5KeGQe8Nb/LOE9Bwf/hQEQEnpPC71DjUhsc=
X-Google-Smtp-Source: AHgI3Iae73/DAGJM6VpkODDOx+4B3ZTCAAsGR1vR6l2OpR00YLZ5T3VAXk1ckuw4PLSf/2H+4rMTkdEuXCRT4Rm90dU=
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr1668754oth.244.1550138077514;
 Thu, 14 Feb 2019 01:54:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550114271.git.vaishali.thakkar@linaro.org> <f62c54a270864b450d2a4f884de6946551e7ff45.1550114271.git.vaishali.thakkar@linaro.org>
In-Reply-To: <f62c54a270864b450d2a4f884de6946551e7ff45.1550114271.git.vaishali.thakkar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 10:54:25 +0100
Message-ID: <CAJZ5v0gaj9E1tehFN-PWkuSi3D39KsqD5HUzcjTLP-9qhKGemA@mail.gmail.com>
Subject: Re: [PATCH 1/5] base: soc: Add serial_number attribute to soc
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        bjorn.andersson@linaro.org, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 4:41 AM Vaishali Thakkar
<vaishali.thakkar@linaro.org> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Add new attribute named "serial_number" as a standard interface for
> user space to acquire the serial number of the device.
>
> For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
> attribute, but this provides a human readable standardized name for this
> property.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-soc | 7 +++++++
>  drivers/base/soc.c                          | 7 +++++++
>  include/linux/sys_soc.h                     | 1 +
>  3 files changed, 15 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
> index 6d9cc253f2b2..919109697bf0 100644
> --- a/Documentation/ABI/testing/sysfs-devices-soc
> +++ b/Documentation/ABI/testing/sysfs-devices-soc
> @@ -26,6 +26,13 @@ Description:
>                 Read-only attribute common to all SoCs. Contains SoC family name
>                 (e.g. DB8500).
>
> +What:          /sys/devices/socX/serial_number
> +Date:          January 2019
> +contact:       Bjorn Andersson <bjorn.andersson@linaro.org>
> +Description:
> +               Read-only attribute supported by most SoCs. Contains the SoC's
> +               serial number.

Do I understand it correctly that the attr is not present if the
serial number is not there?

If so, you should say that here.

> +
>  What:          /sys/devices/socX/soc_id
>  Date:          January 2012
>  contact:       Lee Jones <lee.jones@linaro.org>
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> index 10b280f30217..b0933b9fe67f 100644
> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -33,6 +33,7 @@ static struct bus_type soc_bus_type = {
>
>  static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
>  static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
> +static DEVICE_ATTR(serial_number, S_IRUGO, soc_info_get,  NULL);
>  static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
>  static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
>
> @@ -57,6 +58,9 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
>         if ((attr == &dev_attr_revision.attr)
>             && (soc_dev->attr->revision != NULL))
>                 return attr->mode;
> +       if ((attr == &dev_attr_serial_number.attr)
> +           && (soc_dev->attr->serial_number != NULL))
> +               return attr->mode;
>         if ((attr == &dev_attr_soc_id.attr)
>             && (soc_dev->attr->soc_id != NULL))
>                 return attr->mode;
> @@ -77,6 +81,8 @@ static ssize_t soc_info_get(struct device *dev,
>                 return sprintf(buf, "%s\n", soc_dev->attr->family);
>         if (attr == &dev_attr_revision)
>                 return sprintf(buf, "%s\n", soc_dev->attr->revision);
> +       if (attr == &dev_attr_serial_number)
> +               return sprintf(buf, "%s\n", soc_dev->attr->serial_number);
>         if (attr == &dev_attr_soc_id)
>                 return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
>
> @@ -87,6 +93,7 @@ static ssize_t soc_info_get(struct device *dev,
>  static struct attribute *soc_attr[] = {
>         &dev_attr_machine.attr,
>         &dev_attr_family.attr,
> +       &dev_attr_serial_number.attr,
>         &dev_attr_soc_id.attr,
>         &dev_attr_revision.attr,
>         NULL,
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> index bed223b70217..2a13bc033bd6 100644
> --- a/include/linux/sys_soc.h
> +++ b/include/linux/sys_soc.h
> @@ -12,6 +12,7 @@ struct soc_device_attribute {
>         const char *machine;
>         const char *family;
>         const char *revision;
> +       const char *serial_number;
>         const char *soc_id;
>         const void *data;
>  };
> --
> 2.17.1
>
