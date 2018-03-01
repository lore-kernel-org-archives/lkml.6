Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2070142-1519885659-2-13165997018564260315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519885658; b=miskb24mXky/vdiYzUgFxK5+PwANbDWzNUtvLpVf/ElPROw
    D+Bo9FGeh/QDKVQ3kbvDovqQuEM2cbh2vFRjfjVgmnVj5xnKKAhifdxBkdB1VWvs
    2OWD5R8pUvgR4E2zN8GFrvvQgt1e221ypLqRXVMoVuNKmlJDZ2DN+Hzi86JXGEOO
    n0U8LTenQGBGjquuC99eY59mbemS3WDCt8TZ1DWSKA42tUCa4JUT3fARJRMsMXsr
    laxspfat0raDbpZvsDVkGnuCYFXqChZJdI7kGLEyDNnn7WooSGpRvbYjI9We66AY
    66zuIVwAdSCgnh/jrZeopTydhaPf9FoRbZnf+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519885658; bh=MxZy9iIb9EAH38kRJK5222cAIY
    ECkwJj4UjhZTKu+wU=; b=AaNzXHBGxQU4HwbBQeJBSqdY5yS11E6AcKhlLgyM+s
    mrkCSlNlmfjbRIzmotBI3cguoGwwFXvFbwWsZ8uJ9/JkH1xkepU35p3SM7KkQ4jP
    Cb+BOA1OvMky/cc/36EpgVfLofgSP69bPTo+3kisxBXIGN3zrDaqe4Um0ik/Lwme
    BZKUlWdtciiQlo9yqe9cwrDBVviMotpxFR719Qk1Lcq2U1/wM6G6XKAzCiSLDlRA
    2sKHpPpuUpF2OO+rD6I45vJ6+SafwQ8e2beV9+vNzm8DXs2d6DE2511xFG7pOm9/
    B8NX3b77Psv1gcB1h+2nwPeXzUYqNRB58mhoFtmFarKg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966283AbeCAG1e (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 01:27:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:14079 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966268AbeCAG1d (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 01:27:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="207919910"
Date: Thu, 1 Mar 2018 14:17:50 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v4 13/24] fpga: region: add compat_id support
Message-ID: <20180301061750.GB8999@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-14-git-send-email-hao.wu@intel.com>
 <CANk1AXSMtbnQDAO+XgVEOLh_F13OJyB3LCEPAc6_-U7CXnkfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSMtbnQDAO+XgVEOLh_F13OJyB3LCEPAc6_-U7CXnkfNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 04:55:15PM -0600, Alan Tull wrote:
> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,

Hi Alan,

Thanks for the review.

> 
> > This patch introduces a compat_id member and sysfs interface for each
> > fpga-region, e.g userspace applications could read the compat_id
> > from the sysfs interface for compatibility checking before PR.
> >
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-fpga-region |  5 +++++
> >  drivers/fpga/fpga-region.c                        | 19 +++++++++++++++++++
> >  include/linux/fpga/fpga-region.h                  | 13 +++++++++++++
> >  3 files changed, 37 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
> > new file mode 100644
> > index 0000000..419d930
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-fpga-region
> > @@ -0,0 +1,5 @@
> > +What:          /sys/class/fpga_region/<region>/compat_id
> > +Date:          February 2018
> > +KernelVersion: 4.16
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   FPGA region id for compatibility check.
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index 660a91b..babec96 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -162,6 +162,24 @@ int fpga_region_program_fpga(struct fpga_region *region)
> >  }
> >  EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
> >
> > +static ssize_t compat_id_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +       struct fpga_region *region = to_fpga_region(dev);
> 
> This looks good, but not all users of FPGA are going to use compat_id.
> How would you feel about making it a pointer in struct fpga_region?
> With compat_id as a pointer, could check for non-null compat_id
> pointer and return an error if it wasn't initialized.

It sounds good to me.

if (!region->compat_id)
	return -ENOENT;

> 
> > +
> > +       return sprintf(buf, "%016llx%016llx\n",
> > +                      (unsigned long long)region->compat_id.id_h,
> > +                      (unsigned long long)region->compat_id.id_l);
> > +}
> > +
> > +static DEVICE_ATTR_RO(compat_id);
> > +
> > +static struct attribute *fpga_region_attrs[] = {
> > +       &dev_attr_compat_id.attr,
> > +       NULL,
> > +};
> > +ATTRIBUTE_GROUPS(fpga_region);
> > +
> >  int fpga_region_register(struct fpga_region *region)
> >  {
> >         struct device *dev = region->parent;
> > @@ -226,6 +244,7 @@ static int __init fpga_region_init(void)
> >         if (IS_ERR(fpga_region_class))
> >                 return PTR_ERR(fpga_region_class);
> >
> > +       fpga_region_class->dev_groups = fpga_region_groups;
> >         fpga_region_class->dev_release = fpga_region_dev_release;
> >
> >         return 0;
> > diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> > index 423c87e..bf97dcc 100644
> > --- a/include/linux/fpga/fpga-region.h
> > +++ b/include/linux/fpga/fpga-region.h
> > @@ -6,6 +6,17 @@
> >  #include <linux/fpga/fpga-bridge.h>
> >
> >  /**
> > + * struct fpga_region_compat_id - FPGA Region id for compatibility check
> > + *
> > + * @id_h: high 64bit of the compat_id
> > + * @id_l: low 64bit of the compat_id
> > + */
> > +struct fpga_region_compat_id {
> > +       u64 id_h;
> > +       u64 id_l;
> 
> I guess each user will choose how to define these bits.

Yes.

> 
> > +};
> > +
> > +/**
> >   * struct fpga_region - FPGA Region structure
> >   * @dev: FPGA Region device
> >   * @parent: parent device
> > @@ -13,6 +24,7 @@
> >   * @bridge_list: list of FPGA bridges specified in region
> >   * @mgr: FPGA manager
> >   * @info: FPGA image info
> > + * @compat_id: FPGA region id for compatibility check.
> >   * @priv: private data
> >   * @get_bridges: optional function to get bridges to a list
> >   * @groups: optional attribute groups.
> > @@ -24,6 +36,7 @@ struct fpga_region {
> >         struct list_head bridge_list;
> >         struct fpga_manager *mgr;
> >         struct fpga_image_info *info;
> > +       struct fpga_region_compat_id compat_id;
> 
> Here it would be a pointer instead.

Yes. Will update this patch.

Thanks
Hao

> 
> Alan
> 
> >         void *priv;
> >         int (*get_bridges)(struct fpga_region *region);
> >         const struct attribute_group **groups;
> > --
> > 2.7.4
> >
