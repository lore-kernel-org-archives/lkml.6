Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3063047-1518494047-2-3881035851338979602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518494046; b=rav3KHm8SSSxbj5mbsVh0uOgIfCzBQrPKlMk4XAc1axok5E
    jsIyUwlZdbgslTfF2s9TEoe6V3AR0+JhhWqfPeTkRqQRZqahl5yePQOKQGXBU43G
    71so4Oj1Jmak/aQQxdulYt1fArWHB5LHrf9S1AGjokXj5cLi8/S2V9S9SnpTD0oa
    mnkMLKXA/7zMRdfFyfow50idR1Z9WqZ1fFQsllgM3EU3P+YNJlmRl+nZwZxUUsy1
    BrLjHzmuTEKIA/QyHcAX/iABy8s3z+Rt7N2eu9rbm+6C2LqBqkH7MdT3XOY0lRUS
    zC6Z3dGcO+XCKwUNkE78An0vWKHNRD3CR3CYefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518494046; bh=cghb/iL7Tcv6r7horXcuCBvObP
    NBv4U+roWD/3Bl9kc=; b=SneAOm2KvLoiEvJ2+MyKLkpQD3PcBER8ZnqKBwk6lC
    jc9+f1/+N+mqAM1NTws3FyCcRi0ptxxnOsbx6qrb7FoeQP8prUbwMV8OcbVePkwD
    mPIZVlKRAWRcBcjLrfDBxrHBYrnq0m5FaLlqy5r9V4iZZeO+GaqjO6iR7EM8xpXj
    M+fF1wa+HvoDUhPrTFu7VpITCD75d50TS2Ct0SkvskSLRkcf7bKKw638JSqbkUZI
    UujTf1f42w3LKhVhf2V8BVPJ8uHZUhFJX5uBEOMus1UD6pS2OSC2sW+QhcjUNJMU
    NTNPgO/qnqHezaEvTJ7+GImuZ8DpkccYKqeCtvrq5n+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeBMDyE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 22:54:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:22394 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933025AbeBMDyD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Feb 2018 22:54:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,505,1511856000";
   d="scan'208";a="27253207"
Date: Tue, 13 Feb 2018 11:44:31 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v3 11/21] fpga: dfl: fme: add header sub feature support
Message-ID: <20180213034431.GB10936@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-12-git-send-email-hao.wu@intel.com>
 <CANk1AXR2Q4M4c1TOQhR2J_Mz5MjwZWbR0JUXCR5jFVL_kZtcag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR2Q4M4c1TOQhR2J_Mz5MjwZWbR0JUXCR5jFVL_kZtcag@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 10:51:44AM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> > From: Kang Luwei <luwei.kang@intel.com>
> >
> > The header register set is always present for FPGA Management Engine (FME),
> > this patch implements init and uinit function for header sub feature and
> > introduce several read-only sysfs interfaces for the capability and status.
> >
> > Sysfs interfaces:
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/ports_num
> >   Read-only. Number of ports implemented
> >
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/bitstream_id
> >   Read-only. Blue Bitstream (static FPGA region) identifier number
> >
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/bitstream_metadata
> >   Read-only. Blue Bitstream (static FPGA region) meta data
> 
> Please document the meta data.  I don't see anywhere that describes it
> or how it differs from the bitstream_id.  So it could be useful to
> document it in this header a bit, and in the code, in the sysfs
> document, and in the Documentation/fpga so that people don't have to
> go hunting.

Hi Alan

Thanks a lot for the review.

The Blue Bitstream (static FPGA region) meta data contains information
like synthesis date and seed.

The Blue Bitstream (static FPGA region) id contains version information
like major, minor, patch number (e.g version 6.4.0)and etc.

I used bitstream_id a lot, but bitstream_metadata is useful in some cases
as well.

I will add more descriptions for them.

Thanks
Hao

> 
> We discussed elsewhere the static region bitstream_id verses the other
> interface_ids, so that's been discussed.
> 
> Besides that, this patch looks good and straightforward.
> 
> Thanks,
> Alan
> 
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ----
> > v2: add sysfs documentation
> > v3: rename driver to fpga-dfl-fme.
> >     improve sysfs doc and commit description.
> >     replace bitfield.
> > ---
> >  .../ABI/testing/sysfs-platform-fpga-dfl-fme        | 21 ++++++++
> >  drivers/fpga/dfl-fme-main.c                        | 60 ++++++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> > new file mode 100644
> > index 0000000..6b32799
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> > @@ -0,0 +1,21 @@
> > +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/ports_num
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. One DFL FPGA device may have more than 1
> > +               port/Accelerator Function Unit (AFU). It returns the
> > +               number of ports on the FPGA device when read it.
> > +
> > +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/bitstream_id
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> > +               identifier number.
> > +
> > +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/bitstream_meta
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> > +               meta data.
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index f7b5f7d..d17c66a 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -21,9 +21,68 @@
> >
> >  #include "fpga-dfl.h"
> >
> > +static ssize_t ports_num_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +       void __iomem *base;
> > +       u64 v;
> > +
> > +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> > +
> > +       v = readq(base + FME_HDR_CAP);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> > +                        (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
> > +}
> > +static DEVICE_ATTR_RO(ports_num);
> > +
> > +static ssize_t bitstream_id_show(struct device *dev,
> > +                                struct device_attribute *attr, char *buf)
> > +{
> > +       void __iomem *base;
> > +       u64 v;
> > +
> > +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> > +
> > +       v = readq(base + FME_HDR_BITSTREAM_ID);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> > +}
> > +static DEVICE_ATTR_RO(bitstream_id);
> > +
> > +static ssize_t bitstream_metadata_show(struct device *dev,
> > +                                      struct device_attribute *attr, char *buf)
> > +{
> > +       void __iomem *base;
> > +       u64 v;
> > +
> > +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> > +
> > +       v = readq(base + FME_HDR_BITSTREAM_MD);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> > +}
> > +static DEVICE_ATTR_RO(bitstream_metadata);
> > +
> > +static const struct attribute *fme_hdr_attrs[] = {
> > +       &dev_attr_ports_num.attr,
> > +       &dev_attr_bitstream_id.attr,
> > +       &dev_attr_bitstream_metadata.attr,
> > +       NULL,
> > +};
> > +
> >  static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
> >  {
> > +       void __iomem *base = feature->ioaddr;
> > +       int ret;
> > +
> >         dev_dbg(&pdev->dev, "FME HDR Init.\n");
> > +       dev_dbg(&pdev->dev, "FME cap %llx.\n",
> > +               (unsigned long long)readq(base + FME_HDR_CAP));
> > +
> > +       ret = sysfs_create_files(&pdev->dev.kobj, fme_hdr_attrs);
> > +       if (ret)
> > +               return ret;
> >
> >         return 0;
> >  }
> > @@ -31,6 +90,7 @@ static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
> >  static void fme_hdr_uinit(struct platform_device *pdev, struct feature *feature)
> >  {
> >         dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> > +       sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
> >  }
> >
> >  static const struct feature_ops fme_hdr_ops = {
> > --
> > 1.8.3.1
> >
