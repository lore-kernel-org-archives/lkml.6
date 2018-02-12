Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1914214-1518457454-2-8983859373018001523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518457453; b=AyigAvLKirYg+Iw21LPZlEzXhZBVihQ/RCFblE7kABm3EUX
    LgXThYjQ9yxraiHQq/qhdF2lx/j8wLw9n5lOsxI5hjtcW2GfJA4BVXac8gjWH24J
    YEtY9Wra7A7k2SM3C/cMK25roTC9ehYpGzXXX5NK+4y8lGpJXUStpRYtZydw0s1A
    9KhIouw2yh7ilHrlw+fSODDLkfONFebgl/VFhNtdSQvZMoAN8+nikISBIgSNM9I/
    tyQeyHh2oGZUGW84x4j/AuM37R1PhZUq8PuTfYSND+ry5qGrzRxwsx1yZWHdyZFF
    DpmNYbjg2Hj/BTUYL181uj5djKUbbREwKmGipxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518457453; bh=OJtsNjivb5eeGR4aKzpPM7Amxlsfl9l9e5cZky
    oSE08=; b=jeHu+hVHpGJNBu8RGnMjy6CWoxRdLvz71LgncUr8S7x4dIa+sPfRwJ
    /v1POqmn7LhgfxCM1Q8i7RxB4Bp0iA2Ni4c0hhOrgfDXll7dqc/p1iNrsoNLvzBe
    Z4ItPcBJPxml+T8jpD9m//ypQ2Re8lyK3DHh7GVo+6Ta/hWo6jWJ+8R2U98KUBg2
    p/H7RX/V/zyFoHwHkO36GNNYc9Y7bkcsddSaZn820bs+AO/KSuUQAlChcoA13SiX
    1zkpP84oesI9xe70YVD8fEGMRX5DfI7DV7zS1BbYZC0Y1PCdwB6yVjuI9ABAJ2Wp
    2N6Vmdk82sELioMS7SVbpyDdrH4+2fkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeBLRoL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 12:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeBLRoK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Feb 2018 12:44:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF3A21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x224hBbpMAbcoPZSZbsQj0Vde2jmowmjQZGtShOFzI2RspUJXGhdoydcE/r4wb04s+BI/p7U5XJLh2B4AI9kNyiA=
MIME-Version: 1.0
In-Reply-To: <1511764948-20972-19-git-send-email-hao.wu@intel.com>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com> <1511764948-20972-19-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Feb 2018 11:43:28 -0600
X-Gmail-Original-Message-ID: <CANk1AXT0s1W99cRvWmT80nB+Buivt9xmjziDAz6pyxY-EJF2Fw@mail.gmail.com>
Message-ID: <CANk1AXT0s1W99cRvWmT80nB+Buivt9xmjziDAz6pyxY-EJF2Fw@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] fpga: dfl: afu: add header sub feature support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Thanks for documenting the reset.  Please add this documentation to
the function header that is in fpga-dfl.h.

One question for clarification below.

This patch looks good.

> The port header register set is always present for port, it is mainly
> for capability, control and status of the ports that AFU connected to.
>
> This patch implements header sub feature support. Below user interfaces
> are created by this patch.
>
> Sysfs interface:
> * /sys/class/fpga_region/<regionX>/<fpga-dfl-port.x>/id
>   Read-only. Port ID.
>
> Ioctl interface:
> * FPGA_PORT_RESET
>   Reset the FPGA Port and its AFU.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

> ----
> v3: rename driver name to fpga-dfl-afu
>     add more description for reset ioctl.
>     fix some checkpatch issues.
> ---
>  .../ABI/testing/sysfs-platform-fpga-dfl-afu        |  7 ++++
>  drivers/fpga/dfl-afu-main.c                        | 44 +++++++++++++++++++++-
>  include/uapi/linux/fpga-dfl.h                      | 17 +++++++++
>  3 files changed, 67 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu
> new file mode 100644
> index 0000000..f4bcd94
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu
> @@ -0,0 +1,7 @@
> +What:          /sys/bus/platform/devices/fpga-dfl-port.0/id
> +Date:          November 2017
> +KernelVersion:  4.15
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns id of this port. One DFL FPGA device
> +               may have more than one port. Userspace could use this id to
> +               distinguish different ports under same FPGA device.

Potentially >1 port per FPGA, but only one port per fpga-region, right?

> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index d9f4b81..b01376c 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -18,25 +18,66 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/fpga-dfl.h>
>
>  #include "fpga-dfl.h"
>
> +static ssize_t
> +id_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       int id = fpga_port_id(to_platform_device(dev));
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", id);
> +}
> +static DEVICE_ATTR_RO(id);
> +
> +static const struct attribute *port_hdr_attrs[] = {
> +       &dev_attr_id.attr,
> +       NULL,
> +};
> +
>  static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
>  {
>         dev_dbg(&pdev->dev, "PORT HDR Init.\n");
>
> -       return 0;
> +       fpga_port_reset(pdev);
> +
> +       return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
>  }
>
>  static void port_hdr_uinit(struct platform_device *pdev,
>                            struct feature *feature)
>  {
>         dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
> +
> +       sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
> +}
> +
> +static long
> +port_hdr_ioctl(struct platform_device *pdev, struct feature *feature,
> +              unsigned int cmd, unsigned long arg)
> +{
> +       long ret;
> +
> +       switch (cmd) {
> +       case FPGA_PORT_RESET:
> +               if (!arg)
> +                       ret = fpga_port_reset(pdev);
> +               else
> +                       ret = -EINVAL;
> +               break;
> +       default:
> +               dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +               ret = -ENODEV;
> +       }
> +
> +       return ret;
>  }
>
>  static const struct feature_ops port_hdr_ops = {
>         .init = port_hdr_init,
>         .uinit = port_hdr_uinit,
> +       .ioctl = port_hdr_ioctl,
>  };
>
>  static struct feature_driver port_feature_drvs[] = {
> @@ -76,6 +117,7 @@ static int afu_release(struct inode *inode, struct file *filp)
>
>         dev_dbg(&pdev->dev, "Device File Release\n");
>
> +       fpga_port_reset(pdev);
>         feature_dev_use_end(pdata);
>
>         return 0;
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 75bdf88..9bf273d 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -30,8 +30,11 @@
>  #define FPGA_MAGIC 0xB6
>
>  #define FPGA_BASE 0
> +#define PORT_BASE 0x40
>  #define FME_BASE 0x80
>
> +/* Common IOCTLs for both FME and AFU file descriptor */
> +
>  /**
>   * FPGA_GET_API_VERSION - _IO(FPGA_MAGIC, FPGA_BASE + 0)
>   *
> @@ -50,6 +53,20 @@
>
>  #define FPGA_CHECK_EXTENSION   _IO(FPGA_MAGIC, FPGA_BASE + 1)
>
> +/* IOCTLs for AFU file descriptor */
> +
> +/**
> + * FPGA_PORT_RESET - _IO(FPGA_MAGIC, PORT_BASE + 0)
> + *
> + * Reset the FPGA Port and its AFU. No parameters are supported.
> + * Userspace can do Port reset at any time, e.g during DMA or PR. But
> + * it should never cause any system level issue, only functional failure
> + * (e.g DMA or PR operation failure) and be recoverable from the failure.
> + * Return: 0 on success, -errno of failure
> + */
> +
> +#define FPGA_PORT_RESET                _IO(FPGA_MAGIC, PORT_BASE + 0)
> +
>  /* IOCTLs for FME file descriptor */
>
>  /**
> --
> 1.8.3.1
>
