Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1845249-1518454351-2-2598916842331643528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518454350; b=RTs00yyk2yLEsKIeRBO/9UfEpLPvn5GWim3uA5iAA2lzyF5
    N0QFjuxoKNri0lMfxrQtt+ofE+hwCjGx91o+zoLQ8j6LPvrXhj9Lf0ctBTSE+2sl
    KzPpMhRni8Q4FzjlQYTvuGdBiKGpk5GFT7iVim4eqobeRrjyvx5Zir0/TItjWAuD
    gVtE4pGL5NU9/rrH/4eJ+eyjh/qvHwU4969g9xbvd5KNcUsR2GM1P+JIb4tKvmnY
    oHaDooKA+ROSQZ9NdyqdGrptsYt7gg0TY9B+1VetRKtfLQZPj2nL6Jn1iF2XELc9
    xsNsFpkdbjPX3mTQIXJltqKA3noUNCsNAUx4N1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518454350; bh=XeN0dxn7d2X1bn3Wcg1q78u8/8I+rBlQa73omp
    Tn/Qs=; b=AuwKIhqIG5SyZ4xXUzOR/dUFHoJDVPTtetezUjnOROmnZEfNzgZgq7
    s87zL+L4g8OEOMHTIoAI+4L2Xkn6WiZsfqi0/kjw+rnMEt6JU2wsQWR15VOxWxGo
    iFkcnv+mT8gQxoKUlsRDzd3mnfZpiosU1Bf9U5VIF4i8hubgureNgm0AdHh6O9zj
    bCqChZ+4L5d1VnSG3RnkEthrpTjoSIkXystL6EnqlE7G6W9/zBTJw5cL1dkmY8VJ
    C4C6lp1ufwjr7e66jY/4N8yAgVYvvi/KVO63jh5nAzwDRQQyTMF5bnta/QHIIWvC
    POqYFBzwwsAbFHBACMJpZJViEyHA6J4A==
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
        id S1754267AbeBLQw1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 11:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754165AbeBLQw0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Feb 2018 11:52:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697E821781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x227R9XWRpjo2MsBVm76MWwrtxDfVzz5YTrTeqEH43YuLwBfHKhDQYp9+DPv+E/5T956wESrU4SkJy4FQrNRpJ6s=
MIME-Version: 1.0
In-Reply-To: <1511764948-20972-12-git-send-email-hao.wu@intel.com>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com> <1511764948-20972-12-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 12 Feb 2018 10:51:44 -0600
X-Gmail-Original-Message-ID: <CANk1AXR2Q4M4c1TOQhR2J_Mz5MjwZWbR0JUXCR5jFVL_kZtcag@mail.gmail.com>
Message-ID: <CANk1AXR2Q4M4c1TOQhR2J_Mz5MjwZWbR0JUXCR5jFVL_kZtcag@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] fpga: dfl: fme: add header sub feature support
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
> From: Kang Luwei <luwei.kang@intel.com>
>
> The header register set is always present for FPGA Management Engine (FME),
> this patch implements init and uinit function for header sub feature and
> introduce several read-only sysfs interfaces for the capability and status.
>
> Sysfs interfaces:
> * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/ports_num
>   Read-only. Number of ports implemented
>
> * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/bitstream_id
>   Read-only. Blue Bitstream (static FPGA region) identifier number
>
> * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/bitstream_metadata
>   Read-only. Blue Bitstream (static FPGA region) meta data

Please document the meta data.  I don't see anywhere that describes it
or how it differs from the bitstream_id.  So it could be useful to
document it in this header a bit, and in the code, in the sysfs
document, and in the Documentation/fpga so that people don't have to
go hunting.

We discussed elsewhere the static region bitstream_id verses the other
interface_ids, so that's been discussed.

Besides that, this patch looks good and straightforward.

Thanks,
Alan

>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: add sysfs documentation
> v3: rename driver to fpga-dfl-fme.
>     improve sysfs doc and commit description.
>     replace bitfield.
> ---
>  .../ABI/testing/sysfs-platform-fpga-dfl-fme        | 21 ++++++++
>  drivers/fpga/dfl-fme-main.c                        | 60 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> new file mode 100644
> index 0000000..6b32799
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> @@ -0,0 +1,21 @@
> +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/ports_num
> +Date:          November 2017
> +KernelVersion:  4.15
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. One DFL FPGA device may have more than 1
> +               port/Accelerator Function Unit (AFU). It returns the
> +               number of ports on the FPGA device when read it.
> +
> +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/bitstream_id
> +Date:          November 2017
> +KernelVersion:  4.15
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> +               identifier number.
> +
> +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/bitstream_meta
> +Date:          November 2017
> +KernelVersion:  4.15
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> +               meta data.
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index f7b5f7d..d17c66a 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -21,9 +21,68 @@
>
>  #include "fpga-dfl.h"
>
> +static ssize_t ports_num_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       void __iomem *base;
> +       u64 v;
> +
> +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> +
> +       v = readq(base + FME_HDR_CAP);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> +                        (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
> +}
> +static DEVICE_ATTR_RO(ports_num);
> +
> +static ssize_t bitstream_id_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
> +{
> +       void __iomem *base;
> +       u64 v;
> +
> +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> +
> +       v = readq(base + FME_HDR_BITSTREAM_ID);
> +
> +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> +}
> +static DEVICE_ATTR_RO(bitstream_id);
> +
> +static ssize_t bitstream_metadata_show(struct device *dev,
> +                                      struct device_attribute *attr, char *buf)
> +{
> +       void __iomem *base;
> +       u64 v;
> +
> +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> +
> +       v = readq(base + FME_HDR_BITSTREAM_MD);
> +
> +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> +}
> +static DEVICE_ATTR_RO(bitstream_metadata);
> +
> +static const struct attribute *fme_hdr_attrs[] = {
> +       &dev_attr_ports_num.attr,
> +       &dev_attr_bitstream_id.attr,
> +       &dev_attr_bitstream_metadata.attr,
> +       NULL,
> +};
> +
>  static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
>  {
> +       void __iomem *base = feature->ioaddr;
> +       int ret;
> +
>         dev_dbg(&pdev->dev, "FME HDR Init.\n");
> +       dev_dbg(&pdev->dev, "FME cap %llx.\n",
> +               (unsigned long long)readq(base + FME_HDR_CAP));
> +
> +       ret = sysfs_create_files(&pdev->dev.kobj, fme_hdr_attrs);
> +       if (ret)
> +               return ret;
>
>         return 0;
>  }
> @@ -31,6 +90,7 @@ static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
>  static void fme_hdr_uinit(struct platform_device *pdev, struct feature *feature)
>  {
>         dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> +       sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
>  }
>
>  static const struct feature_ops fme_hdr_ops = {
> --
> 1.8.3.1
>
