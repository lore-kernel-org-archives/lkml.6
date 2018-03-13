Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3767103-1520965870-2-2381172547971015843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520965869; b=m4ReCbzrddmO3Nn38Fm5BF/sElobH3SpGBHhzfb6gl3hL8c
    mlixpKriOKFbZlIvhh3KhKYv3/w5jZ6SZMTCMlaN70i/HE0BdQ1EYjw5HOo538QB
    KZCAdMTJG56S9xGd341na94g9YkIFtx5i9Tdu6WBL4VKC2e2Kl23Oqvj+XAGSj+L
    H34DBgelO8/567GgKiV2s+nmNpXW9H67PQBeFqN9jx4mOuT4LQmLhR/C0PP7G3vg
    iiR+AIVKjcMIRlFtIhrw7VuoBc+nWIa5+Oh1h9N4ClxhfiX+6pnlcR+DZCtjOvAi
    qD7F7wpMq/vmzxG9IKmIdEFzgb+KYS0mkjdGc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520965869; bh=o3DbWHiWiOpZZ0JTLn6ecBkYGGJ0VlEmBJlx7V
    SCvAE=; b=GRsCSUNLfAaHH28MMh56L40qJIjKlYZgDrwqhwZ3UJ5tUzV2nzwUTG
    hhfUOZxFV7C3vGz3Qo68p11p/uVb9YP94C6UT+qfZ1IYtF9nRbHCCPTWfoaSs1op
    jpT0QQGElw4fYDhlpa8tEh2k1cQtLVPTWq731cTKnYQl6gqZ09Pjx/+HgxBACB75
    hT+tlhmVLgDVdaZC+xma5mKsOBP0tWkCqmTwyz9vVDtPauMqa9DHu0pWD9JR1SzJ
    qAZFPjhPfLHxDZMpcfPw8a1IEBpvbMdrnau3ZpWvkaT+d23K1KDaskZ9XLwXOiEt
    XpB2TU9vr4hjtnARHeVXPYsXx1lN5dSw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCMSbH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 14:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeCMSbG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Mar 2018 14:31:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0238B21778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELtaHor0vEuSBP64I11jE4vL9RNVOON6Orda+KC0ovkUCxOWNnPUD+rOSjESjRg0dWmkMl4abd0bMfSJrwhYQW0=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-10-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-10-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 13 Mar 2018 13:30:24 -0500
X-Gmail-Original-Message-ID: <CANk1AXSfXBXj_NH4Qcj6EDXEzAD_+T1sVudJdMbbgKK7hk13Mg@mail.gmail.com>
Message-ID: <CANk1AXSfXBXj_NH4Qcj6EDXEzAD_+T1sVudJdMbbgKK7hk13Mg@mail.gmail.com>
Subject: Re: [PATCH v4 09/24] fpga: dfl-pci: add enumeration for feature devices
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

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Thanks again for splitting the pci part of the code from enumeration
and everything else.

One thing that may need to be fixed below, so with that fixed, adding my ack.

> The Device Feature List (DFL) is implemented in MMIO, and features
> are linked via the DFLs. This patch enables pcie driver to prepare
> enumeration information (e.g locations of all device feature lists
> in MMIO) and use common APIs provided by the Device Feature List
> framework to enumerate each feature device linked.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> v3: split from another patch
>     use common functions from DFL framework for enumeration.
> v4: rebase
> ---
>  drivers/fpga/dfl-pci.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 197 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index d91ea42..8ce8a94 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -22,9 +22,52 @@
>  #include <linux/errno.h>
>  #include <linux/aer.h>
>
> +#include "dfl.h"
> +
>  #define DRV_VERSION    "0.8"
>  #define DRV_NAME       "dfl-pci"
>
> +struct cci_drvdata {
> +       struct fpga_cdev *cdev; /* container device */
> +       struct list_head regions; /* list of pci bar mapping region */
> +};
> +
> +/* pci bar mapping info */
> +struct cci_region {
> +       int bar;
> +       void __iomem *ioaddr;   /* pointer to mapped bar region */
> +       struct list_head node;
> +};
> +
> +static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
> +{
> +       struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +       struct cci_region *region;
> +
> +       list_for_each_entry(region, &drvdata->regions, node)
> +               if (region->bar == bar) {
> +                       dev_dbg(&pcidev->dev, "BAR %d region exists\n", bar);
> +                       return region->ioaddr;
> +               }
> +
> +       region = devm_kzalloc(&pcidev->dev, sizeof(*region), GFP_KERNEL);
> +       if (!region)
> +               return NULL;
> +
> +       region->bar = bar;
> +       region->ioaddr = pci_ioremap_bar(pcidev, bar);
> +       if (!region->ioaddr) {
> +               dev_err(&pcidev->dev, "can't ioremap memory from BAR %d.\n",
> +                       bar);
> +               devm_kfree(&pcidev->dev, region);
> +               return NULL;
> +       }
> +
> +       list_add(&region->node, &drvdata->regions);
> +
> +       return region->ioaddr;
> +}
> +
>  /* PCI Device ID */
>  #define PCIE_DEVICE_ID_PF_INT_5_X      0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X      0xBCC0
> @@ -45,6 +88,143 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>
> +static int cci_init_drvdata(struct pci_dev *pcidev)
> +{
> +       struct cci_drvdata *drvdata;
> +
> +       drvdata = devm_kzalloc(&pcidev->dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&drvdata->regions);
> +
> +       pci_set_drvdata(pcidev, drvdata);
> +
> +       return 0;
> +}
> +
> +static void cci_pci_release_regions(struct pci_dev *pcidev)
> +{
> +       struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +       struct cci_region *tmp, *region;
> +
> +       list_for_each_entry_safe(region, tmp, &drvdata->regions, node) {
> +               list_del(&region->node);
> +               if (region->ioaddr)
> +                       pci_iounmap(pcidev, region->ioaddr);
> +               devm_kfree(&pcidev->dev, region);
> +       }
> +}
> +
> +static void cci_remove_drvdata(struct pci_dev *pcidev)
> +{
> +       struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +
> +       cci_pci_release_regions(pcidev);

Would it make sense to call fpga_enum_info_free here?  I understand
fpga_enum_info_alloc uses devm, but it does a get_device which needs
to be put.

> +       pci_set_drvdata(pcidev, NULL);
> +       devm_kfree(&pcidev->dev, drvdata);
> +}
> +
> +static void cci_remove_feature_devs(struct pci_dev *pcidev)
> +{
> +       struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +
> +       /* remove all children feature devices */
> +       fpga_remove_feature_devs(drvdata->cdev);
> +}
> +
> +/* enumerate feature devices under pci device */
> +static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> +{
> +       struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> +       struct fpga_cdev *cdev;
> +       struct fpga_enum_info *info;
> +       resource_size_t start, len;
> +       void __iomem *base;
> +       int port_num, bar, i, ret = 0;
> +       u32 offset;
> +       u64 v;
> +
> +       /* allocate enumeration info via pci_dev */
> +       info = fpga_enum_info_alloc(&pcidev->dev);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       /* start to find Device Feature List from Bar 0 */
> +       base = cci_pci_ioremap_bar(pcidev, 0);
> +       if (!base) {
> +               ret = -ENOMEM;
> +               goto enum_info_free_exit;
> +       }
> +
> +       /*
> +        * PF device has FME and Ports/AFUs, and VF device only has 1 Port/AFU.
> +        * check them and add related "Device Feature List" info for the next
> +        * step enumeration.
> +        */
> +       if (feature_is_fme(base)) {
> +               start = pci_resource_start(pcidev, 0);
> +               len = pci_resource_len(pcidev, 0);
> +
> +               fpga_enum_info_add_dfl(info, start, len, base);
> +
> +               /*
> +                * find more Device Feature Lists (e.g Ports) per information
> +                * indicated by FME module.
> +                */
> +               v = readq(base + FME_HDR_CAP);
> +               port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
> +
> +               WARN_ON(port_num > MAX_FPGA_PORT_NUM);
> +
> +               for (i = 0; i < port_num; i++) {
> +                       v = readq(base + FME_HDR_PORT_OFST(i));
> +
> +                       /* skip ports which are not implemented. */
> +                       if (!(v & FME_PORT_OFST_IMP))
> +                               continue;
> +
> +                       /*
> +                        * add Port's Device Feature List information for next
> +                        * step enumeration.
> +                        */
> +                       bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> +                       offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +                       base = cci_pci_ioremap_bar(pcidev, bar);
> +                       if (!base)
> +                               continue;
> +
> +                       start = pci_resource_start(pcidev, bar) + offset;
> +                       len = pci_resource_len(pcidev, bar) - offset;
> +
> +                       fpga_enum_info_add_dfl(info, start, len, base + offset);
> +               }
> +       } else if (feature_is_port(base)) {
> +               start = pci_resource_start(pcidev, 0);
> +               len = pci_resource_len(pcidev, 0);
> +
> +               fpga_enum_info_add_dfl(info, start, len, base);
> +       } else {
> +               ret = -ENODEV;
> +               goto enum_info_free_exit;
> +       }
> +
> +       /* start enumeration with prepared enumeration information */
> +       cdev = fpga_enumerate_feature_devs(info);
> +       if (IS_ERR(cdev)) {
> +               dev_err(&pcidev->dev, "Enumeration failure\n");
> +               ret = PTR_ERR(cdev);
> +               goto enum_info_free_exit;
> +       }
> +
> +       drvdata->cdev = cdev;
> +
> +enum_info_free_exit:
> +       fpga_enum_info_free(info);

This is the only place I saw fpga_enum_info_free being called.

Thanks,
Alan

> +
> +       return ret;
> +}
> +
>  static
>  int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>  {
> @@ -82,9 +262,22 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>                 goto release_region_exit;
>         }
>
> -       /* TODO: create and add the platform device per feature list */
> -       return 0;
> +       ret = cci_init_drvdata(pcidev);
> +       if (ret) {
> +               dev_err(&pcidev->dev, "Fail to init drvdata %d.\n", ret);
> +               goto release_region_exit;
> +       }
> +
> +       ret = cci_enumerate_feature_devs(pcidev);
> +       if (ret) {
> +               dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> +               goto remove_drvdata_exit;
> +       }
> +
> +       return ret;
>
> +remove_drvdata_exit:
> +       cci_remove_drvdata(pcidev);
>  release_region_exit:
>         pci_release_regions(pcidev);
>  disable_error_report_exit:
> @@ -95,6 +288,8 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>
>  static void cci_pci_remove(struct pci_dev *pcidev)
>  {
> +       cci_remove_feature_devs(pcidev);
> +       cci_remove_drvdata(pcidev);
>         pci_release_regions(pcidev);
>         pci_disable_pcie_error_reporting(pcidev);
>         pci_disable_device(pcidev);
> --
> 2.7.4
>
