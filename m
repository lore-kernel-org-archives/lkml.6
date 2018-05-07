Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525727444-2-16100650414192692237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525727444; b=EC7w1yTY1k8ZTmFskbdrPxPVqphMi4p2oqU+/3c86Mz6pr0mWd
    /z4nIQIbK8h8mgvYtmcgFmNUaK7dxp2/omPU0lMbl097oC5SZbzLcnYwbUOFnTeB
    PNg4cLAVjSMWAz/xZixWWhV48wzqh5Lwd6a7YV5EmKMXeju5hfcIv/LExsbUtw4Q
    ujw6BjBTvtA5mqrpQFuiok61YCirs809Mp/y/1h5I4L+SV+PcYpX4fbGPOpr//+s
    mIkJ7ZMw/+lTGeKi7zqScC9ZGREld818yNhs6F3AoD7TmiCH/VvCXRPSYhEczFj8
    mljtM1xBCFnRo7VTX0PSxFITXGkPgkLfwFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525727444; bh=Cr4d3SEOoThpLtQfAoj8OcTCyv43YppETLWhB8bmPt
    M=; b=QNWHXcK8HHP5paWmVZiXq/pgwn3hbtCVeBWogdvSX64MqTtN9qzhceUO7g
    QLTCP3nV7e25oqpVa0sLHLYG3ZJtgIXn6EM7TrVBuUZE+jUKPVy45zd4EOqDC4Us
    YUrrACb5ZE3xpscDza6MClNqTMfmrvQ4OjilAPfypXoLUY9y4z2z8wOVaPH9PZt2
    Vcp+hf0CG32bRGzG3ebX0k0+u8RxN7f3dlJxcgz0O4JExXRrnrGPfbL7ca/gXYKu
    aFZnNGKYRmejnmhXw8bjVAlgPlVcHBGtQQvN08HCv3Gq7au+/Kfz9+H/uuioo/jP
    trBnIvBwp6IZLvh1aqSM9HVNfsBQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=WMmC+uX7 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=WMmC+uX7 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHvAJnICa8KxxgpB7VNbEH8AxciQQMVfTIo9GRGsMlDbMmM3o1uRWAMEsylzkR34KnImgNdT2YAzifYwM4l+OMNIiIqnMGl19F0mbuTZEtvK2ifMiOvQ
    eEUhONnfnTGyoXDGyTaaonEVTcZY5YxHYyHsH5hQ1Fz5G97MaA/Zu8woe6GOO+Hi40MxCC1VxaPONSAtGjYBwH1xilwaFcaoQ18brq6K49Ex36Ni+J1YFByZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=lFT1uBP4E_BHoWZvh0MA:9 a=QEXdDO2ut3YA:10
    a=CRMob9CPfJQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeEGVKl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbeEGVKk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 May 2018 17:10:40 -0400
X-Google-Smtp-Source: AB8JxZrl27SwWTMgh+E5Sjm0MxYlqB5+OnAu/A/gT1cK0dWZYy0z3RjpVjC2PFq1JbLlO+hSuU6EMX8eZpnugBgDm+0=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-6-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-6-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 7 May 2018 16:09:58 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ91JVPB4p+VbVv+1GssT9sP9XF6_7fwZ9kH6oFYESjyQ@mail.gmail.com>
Message-ID: <CANk1AXQ91JVPB4p+VbVv+1GssT9sP9XF6_7fwZ9kH6oFYESjyQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/28] fpga: region: add compat_id support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Thanks for making the requested changes.  Looks good.

> This patch introduces a compat_id pointer member and sysfs interface
> for each fpga region, similar as compat_id for fpga manager, it allows
> applications to read the per region compat_id for compatibility
> checking before other actions on this fpga-region (e.g PR).
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> v5: use pointer for compat_id as it's optional to implement.
> ---
>  Documentation/ABI/testing/sysfs-class-fpga-region |  9 +++++++++
>  drivers/fpga/fpga-region.c                        | 22 ++++++++++++++++++++++
>  include/linux/fpga/fpga-region.h                  |  2 ++
>  3 files changed, 33 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
>
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
> new file mode 100644
> index 0000000..9618f74
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-region
> @@ -0,0 +1,9 @@
> +What:          /sys/class/fpga_region/<region>/compat_id
> +Date:          May 2018
> +KernelVersion: 4.17
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   FPGA region id for compatibility check, e.g compatibility
> +               of the FPGA reconfiguration hardware and image. This value
> +               is defined or calculated by the layer that is creating the
> +               FPGA region. This interface returns the compat_id value or
> +               just error code -ENOENT in case compat_id is not used.
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index d6a9dd2..6929178 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -162,6 +162,27 @@ int fpga_region_program_fpga(struct fpga_region *region)
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
>
> +static ssize_t compat_id_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       struct fpga_region *region = to_fpga_region(dev);
> +
> +       if (!region->compat_id)
> +               return -ENOENT;
> +
> +       return sprintf(buf, "%016llx%016llx\n",
> +                      (unsigned long long)region->compat_id->id_h,
> +                      (unsigned long long)region->compat_id->id_l);
> +}
> +
> +static DEVICE_ATTR_RO(compat_id);
> +
> +static struct attribute *fpga_region_attrs[] = {
> +       &dev_attr_compat_id.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(fpga_region);
> +
>  /**
>   * fpga_region_create - alloc and init a struct fpga_region
>   * @dev: device parent
> @@ -262,6 +283,7 @@ static int __init fpga_region_init(void)
>         if (IS_ERR(fpga_region_class))
>                 return PTR_ERR(fpga_region_class);
>
> +       fpga_region_class->dev_groups = fpga_region_groups;
>         fpga_region_class->dev_release = fpga_region_dev_release;
>
>         return 0;
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index f2e215b..e8ad979 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -12,6 +12,7 @@
>   * @bridge_list: list of FPGA bridges specified in region
>   * @mgr: FPGA manager
>   * @info: FPGA image info
> + * @compat_id: FPGA region id for compatibility check.
>   * @priv: private data
>   * @get_bridges: optional function to get bridges to a list
>   */
> @@ -21,6 +22,7 @@ struct fpga_region {
>         struct list_head bridge_list;
>         struct fpga_manager *mgr;
>         struct fpga_image_info *info;
> +       struct fpga_compat_id *compat_id;
>         void *priv;
>         int (*get_bridges)(struct fpga_region *region);
>  };
> --
> 1.8.3.1
>
