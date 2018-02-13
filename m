Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3051079-1518493359-2-9292044187447932517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518493357; b=q2BMPKlrJFYn66ApPqhAf/0BmvGizjDZOAAf+K98ue+fsk7
    kCwnn6JkkMuCuXnYKx9E/BN90/mxIRpqmq/6p2S+0meocgAh/u2JF/WRZNb6pIAd
    9YNjUd84HTvPd5ZPHkcdhDaG+N+YY0N2hzsZp3RwytU3+ij8nxSXzxPKTfiCPXr3
    TEkVir6R60rY8xumBoqd3mrnryUf4M18Kszls2Vjzv+3y+z9ub+KlszQLyRVrlWq
    KxXFFnsGiG4+qufUUKKqbtaaXGYAO7k2sxLWUSWc0fL6vEOhAOcaNy1aDaA5qYeR
    ZYBVobIEXG1EJDAoG+j0P2bMXKk1DcWcANnT6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518493357; bh=HdKb/eIpmGSmfz6JUHSn8WQkJW
    yeki9z6BKdndkKqac=; b=e8vIcfH86kCHoUCU2eJpmSdf2wjH2EqMmJklqtArGn
    mEpGNKd/v4rUb5pnzuF160LjBgy+BtnmV3OSHqpkYbI7dqKdjBHxRStQPneTyKBO
    xQjX9p5uEepC+po9vSUd9xcMu1rM7HAOIdaUQoRLYgPODwio2BR7f/kqVde4DBQ3
    DEoUbURqLinobBWe+xHAIaL565VjF3zEYO9WloIuc1enorK5wLx9h31QJ6alnj1R
    6YQEhupGBtj6ZXBQESYO/L5fe44eY8gL3GZzv0XQD3b6KhTQC2QiVuCuHh1A6eDz
    9IibtR86/QIzepAP+d198TDMNlIjIdGf4mO/MxhpFN6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeBMDme (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 22:42:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:34138 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933323AbeBMDmc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Feb 2018 22:42:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,505,1511856000";
   d="scan'208";a="30935823"
Date: Tue, 13 Feb 2018 11:33:01 +0800
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
Subject: Re: [PATCH v3 18/21] fpga: dfl: afu: add header sub feature support
Message-ID: <20180213033301.GA10936@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-19-git-send-email-hao.wu@intel.com>
 <CANk1AXT0s1W99cRvWmT80nB+Buivt9xmjziDAz6pyxY-EJF2Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXT0s1W99cRvWmT80nB+Buivt9xmjziDAz6pyxY-EJF2Fw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 11:43:28AM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Thanks for documenting the reset.  Please add this documentation to
> the function header that is in fpga-dfl.h.

Sure, thanks for the review. 

I will add the description to the function header.

> 
> One question for clarification below.
> 
> This patch looks good.
> 
> > The port header register set is always present for port, it is mainly
> > for capability, control and status of the ports that AFU connected to.
> >
> > This patch implements header sub feature support. Below user interfaces
> > are created by this patch.
> >
> > Sysfs interface:
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-port.x>/id
> >   Read-only. Port ID.
> >
> > Ioctl interface:
> > * FPGA_PORT_RESET
> >   Reset the FPGA Port and its AFU.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> 
> Acked-by: Alan Tull <atull@kernel.org>
> 
> > ----
> > v3: rename driver name to fpga-dfl-afu
> >     add more description for reset ioctl.
> >     fix some checkpatch issues.
> > ---
> >  .../ABI/testing/sysfs-platform-fpga-dfl-afu        |  7 ++++
> >  drivers/fpga/dfl-afu-main.c                        | 44 +++++++++++++++++++++-
> >  include/uapi/linux/fpga-dfl.h                      | 17 +++++++++
> >  3 files changed, 67 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu
> > new file mode 100644
> > index 0000000..f4bcd94
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-afu
> > @@ -0,0 +1,7 @@
> > +What:          /sys/bus/platform/devices/fpga-dfl-port.0/id
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns id of this port. One DFL FPGA device
> > +               may have more than one port. Userspace could use this id to
> > +               distinguish different ports under same FPGA device.
> 
> Potentially >1 port per FPGA, but only one port per fpga-region, right?

Yes.

Thanks
Hao

> 
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index d9f4b81..b01376c 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -18,25 +18,66 @@
> >
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/fpga-dfl.h>
> >
> >  #include "fpga-dfl.h"
> >
> > +static ssize_t
> > +id_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +       int id = fpga_port_id(to_platform_device(dev));
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%d\n", id);
> > +}
> > +static DEVICE_ATTR_RO(id);
> > +
> > +static const struct attribute *port_hdr_attrs[] = {
> > +       &dev_attr_id.attr,
> > +       NULL,
> > +};
> > +
> >  static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
> >  {
> >         dev_dbg(&pdev->dev, "PORT HDR Init.\n");
> >
> > -       return 0;
> > +       fpga_port_reset(pdev);
> > +
> > +       return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
> >  }
> >
> >  static void port_hdr_uinit(struct platform_device *pdev,
> >                            struct feature *feature)
> >  {
> >         dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
> > +
> > +       sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
> > +}
> > +
> > +static long
> > +port_hdr_ioctl(struct platform_device *pdev, struct feature *feature,
> > +              unsigned int cmd, unsigned long arg)
> > +{
> > +       long ret;
> > +
> > +       switch (cmd) {
> > +       case FPGA_PORT_RESET:
> > +               if (!arg)
> > +                       ret = fpga_port_reset(pdev);
> > +               else
> > +                       ret = -EINVAL;
> > +               break;
> > +       default:
> > +               dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> > +               ret = -ENODEV;
> > +       }
> > +
> > +       return ret;
> >  }
> >
> >  static const struct feature_ops port_hdr_ops = {
> >         .init = port_hdr_init,
> >         .uinit = port_hdr_uinit,
> > +       .ioctl = port_hdr_ioctl,
> >  };
> >
> >  static struct feature_driver port_feature_drvs[] = {
> > @@ -76,6 +117,7 @@ static int afu_release(struct inode *inode, struct file *filp)
> >
> >         dev_dbg(&pdev->dev, "Device File Release\n");
> >
> > +       fpga_port_reset(pdev);
> >         feature_dev_use_end(pdata);
> >
> >         return 0;
> > diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> > index 75bdf88..9bf273d 100644
> > --- a/include/uapi/linux/fpga-dfl.h
> > +++ b/include/uapi/linux/fpga-dfl.h
> > @@ -30,8 +30,11 @@
> >  #define FPGA_MAGIC 0xB6
> >
> >  #define FPGA_BASE 0
> > +#define PORT_BASE 0x40
> >  #define FME_BASE 0x80
> >
> > +/* Common IOCTLs for both FME and AFU file descriptor */
> > +
> >  /**
> >   * FPGA_GET_API_VERSION - _IO(FPGA_MAGIC, FPGA_BASE + 0)
> >   *
> > @@ -50,6 +53,20 @@
> >
> >  #define FPGA_CHECK_EXTENSION   _IO(FPGA_MAGIC, FPGA_BASE + 1)
> >
> > +/* IOCTLs for AFU file descriptor */
> > +
> > +/**
> > + * FPGA_PORT_RESET - _IO(FPGA_MAGIC, PORT_BASE + 0)
> > + *
> > + * Reset the FPGA Port and its AFU. No parameters are supported.
> > + * Userspace can do Port reset at any time, e.g during DMA or PR. But
> > + * it should never cause any system level issue, only functional failure
> > + * (e.g DMA or PR operation failure) and be recoverable from the failure.
> > + * Return: 0 on success, -errno of failure
> > + */
> > +
> > +#define FPGA_PORT_RESET                _IO(FPGA_MAGIC, PORT_BASE + 0)
> > +
> >  /* IOCTLs for FME file descriptor */
> >
> >  /**
> > --
> > 1.8.3.1
> >
