Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389795-1520279019-2-14253989260776377429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520279018; b=WJx0NR9loh99KIaCCkDKLAOpSRenGXqEj8TM5X3wqf7NTyT
    DHs+i6BmufW+JNrG1MUvKC6W2uwDjjBrPNltAsxJN9IlEnzam8l/Xw1Ro17VMnUV
    totQ7pCnlAg34e6bB8qq04QdCQsa0KXZ57lg/h3TlwqaQnHXZxnCU3ydu8Z719ax
    QNIa17ZTkdsHvnIEhZj0wDMJzJKrmLujLRVxPSxnemkKtbZcgQmAjuXaFhJvB1Nz
    YEok90hf3MgY8gWvwhHmd3+uEBCLNqGCfj9B+qQSIuYTaABiyQqzoQhhYXjI5Blj
    4ZgF05/yNHr68fhZ+eoQkFs7X04teRPa/Tj2+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520279018; bh=gOPo3uyYxyEMG0Eti8gP1X43PSejLJzcnwf3Fm
    rAd6Y=; b=TLTmsJpXzF+Aj6kp0x2uARZSHyL9tdQpgeVZCOns5z2U76P4fX1sVG
    OENwwJgiHOxWbtLmd+lTrWz6HiFSPDYyVymKHskB3XFKBvTIv7XNBLn4IwIfwV7l
    3Aps9+hM0x/JNeMH/MHAggtbwll9uf5dtYQguRb25JJzLrzN5OokeaJuW9uR+RJ0
    RvPRFtNaRLBKF/pCtQHW++7P0ohO6J9gqe7YhtLiTii8i0G/wQ5rPYvgfPAKEet5
    OivCG9GsG6KFSODsH/kvBtgnzatH4R5DYW/+nsWRw0y1+03VfR4orpnJGDIWVmLA
    wiq0F0CQzjZTBQVIEArhPNoqfxbusQsw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1752507AbeCETnY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 14:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeCETnX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Mar 2018 14:43:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E28206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELuB1eJiga31A6fRMmoPgu378cp2P0BvmIt6lnnoDsAI4/trgK+vsOlwQBXufnmIYsT6uFPG/Be0XWLHDHkGXnw=
MIME-Version: 1.0
In-Reply-To: <20180301061750.GB8999@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-14-git-send-email-hao.wu@intel.com> <CANk1AXSMtbnQDAO+XgVEOLh_F13OJyB3LCEPAc6_-U7CXnkfNw@mail.gmail.com>
 <20180301061750.GB8999@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Mon, 5 Mar 2018 13:42:41 -0600
X-Gmail-Original-Message-ID: <CANk1AXSKUgvwW_Gm9jUgis5sKipgLL+jT_t5cjWyrtzqYmxg5g@mail.gmail.com>
Message-ID: <CANk1AXSKUgvwW_Gm9jUgis5sKipgLL+jT_t5cjWyrtzqYmxg5g@mail.gmail.com>
Subject: Re: [PATCH v4 13/24] fpga: region: add compat_id support
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

On Thu, Mar 1, 2018 at 12:17 AM, Wu Hao <hao.wu@intel.com> wrote:
> On Wed, Feb 28, 2018 at 04:55:15PM -0600, Alan Tull wrote:
>> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
>>
>> Hi Hao,
>
> Hi Alan,
>
> Thanks for the review.
>
>>
>> > This patch introduces a compat_id member and sysfs interface for each
>> > fpga-region, e.g userspace applications could read the compat_id
>> > from the sysfs interface for compatibility checking before PR.
>> >
>> > Signed-off-by: Wu Hao <hao.wu@intel.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-class-fpga-region |  5 +++++
>> >  drivers/fpga/fpga-region.c                        | 19 +++++++++++++++++++
>> >  include/linux/fpga/fpga-region.h                  | 13 +++++++++++++
>> >  3 files changed, 37 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
>> > new file mode 100644
>> > index 0000000..419d930
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-class-fpga-region
>> > @@ -0,0 +1,5 @@
>> > +What:          /sys/class/fpga_region/<region>/compat_id
>> > +Date:          February 2018
>> > +KernelVersion: 4.16
>> > +Contact:       Wu Hao <hao.wu@intel.com>
>> > +Description:   FPGA region id for compatibility check.

It would be helpful to add some explanation here that although the
intended function of compat_id is set, the way the actual value is
defined or calculated is set by the layer that is creating the FPGA
region.

>> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> > index 660a91b..babec96 100644
>> > --- a/drivers/fpga/fpga-region.c
>> > +++ b/drivers/fpga/fpga-region.c
>> > @@ -162,6 +162,24 @@ int fpga_region_program_fpga(struct fpga_region *region)
>> >  }
>> >  EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
>> >
>> > +static ssize_t compat_id_show(struct device *dev,
>> > +                             struct device_attribute *attr, char *buf)
>> > +{
>> > +       struct fpga_region *region = to_fpga_region(dev);
>>
>> This looks good, but not all users of FPGA are going to use compat_id.
>> How would you feel about making it a pointer in struct fpga_region?
>> With compat_id as a pointer, could check for non-null compat_id
>> pointer and return an error if it wasn't initialized.
>
> It sounds good to me.
>
> if (!region->compat_id)
>         return -ENOENT;

Yes, thanks!

Alan

>
>>
>> > +
>> > +       return sprintf(buf, "%016llx%016llx\n",
>> > +                      (unsigned long long)region->compat_id.id_h,
>> > +                      (unsigned long long)region->compat_id.id_l);
>> > +}
>> > +
>> > +static DEVICE_ATTR_RO(compat_id);
>> > +
>> > +static struct attribute *fpga_region_attrs[] = {
>> > +       &dev_attr_compat_id.attr,
>> > +       NULL,
>> > +};
>> > +ATTRIBUTE_GROUPS(fpga_region);
>> > +
>> >  int fpga_region_register(struct fpga_region *region)
>> >  {
>> >         struct device *dev = region->parent;
>> > @@ -226,6 +244,7 @@ static int __init fpga_region_init(void)
>> >         if (IS_ERR(fpga_region_class))
>> >                 return PTR_ERR(fpga_region_class);
>> >
>> > +       fpga_region_class->dev_groups = fpga_region_groups;
>> >         fpga_region_class->dev_release = fpga_region_dev_release;
>> >
>> >         return 0;
>> > diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>> > index 423c87e..bf97dcc 100644
>> > --- a/include/linux/fpga/fpga-region.h
>> > +++ b/include/linux/fpga/fpga-region.h
>> > @@ -6,6 +6,17 @@
>> >  #include <linux/fpga/fpga-bridge.h>
>> >
>> >  /**
>> > + * struct fpga_region_compat_id - FPGA Region id for compatibility check
>> > + *
>> > + * @id_h: high 64bit of the compat_id
>> > + * @id_l: low 64bit of the compat_id
>> > + */
>> > +struct fpga_region_compat_id {
>> > +       u64 id_h;
>> > +       u64 id_l;
>>
>> I guess each user will choose how to define these bits.
>
> Yes.
>
>>
>> > +};
>> > +
>> > +/**
>> >   * struct fpga_region - FPGA Region structure
>> >   * @dev: FPGA Region device
>> >   * @parent: parent device
>> > @@ -13,6 +24,7 @@
>> >   * @bridge_list: list of FPGA bridges specified in region
>> >   * @mgr: FPGA manager
>> >   * @info: FPGA image info
>> > + * @compat_id: FPGA region id for compatibility check.
>> >   * @priv: private data
>> >   * @get_bridges: optional function to get bridges to a list
>> >   * @groups: optional attribute groups.
>> > @@ -24,6 +36,7 @@ struct fpga_region {
>> >         struct list_head bridge_list;
>> >         struct fpga_manager *mgr;
>> >         struct fpga_image_info *info;
>> > +       struct fpga_region_compat_id compat_id;
>>
>> Here it would be a pointer instead.
>
> Yes. Will update this patch.
>
> Thanks
> Hao
>
>>
>> Alan
>>
>> >         void *priv;
>> >         int (*get_bridges)(struct fpga_region *region);
>> >         const struct attribute_group **groups;
>> > --
>> > 2.7.4
>> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
