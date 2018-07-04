Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185992445F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="PKCZEUyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCKvuVLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185992445F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeGDHTC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:19:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59201 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752918AbeGDHTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:19:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D22B621B5A;
        Wed,  4 Jul 2018 03:18:59 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute4.internal (MEProxy); Wed, 04 Jul 2018 03:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=JPExlFglAqYE1LHXmgvU1MnKU0ue7
        690lNoVhyqZ4Ho=; b=PKCZEUyJ/x6IHg24rnz3inxMwczPHcP0QJYmzJ1Y4hIW9
        twR+n6lv+qHYGkmWOWPlJxdsEO3hN0Hnx1KaEc3z2736ZlDUJzg+uSVyTq9L/aL/
        UOhAnJ6l9FvZebfDH5rrFjd/+26STAHN9iuQIu+g5qa7fu2IT/JFkMVmOas+6rBk
        Lg+hNX8t9y+7u2LlV1Nl8G9cyh/qwaqm3k9xca7qAijaHdWzm4TMNzAWRvr+7YPv
        tEvyHJWmgJISyldfc+8Fu6PlqX+p8h+hwfZrchS2rh8efVD0d4mWS0N69wRPjit9
        5n3M9QEkL9Or2SITcwNTv4cOqPlOMuUgJtskL6W+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JPExlF
        glAqYE1LHXmgvU1MnKU0ue7690lNoVhyqZ4Ho=; b=jCKvuVLegG/NQGASSf3FtZ
        FjDSb7fM8v4vybyg82f/DOWVweRmoSz6zG7y7zgEE9OQ7kTlVsshk/9Y0Sl/v5yE
        YMNXKkBvXHvVFMCl+GDOcgNBewGbOsT07RuNH2ZVhUZPBDwAm4CltHMt893Dp5/V
        ddDCV3F4PwjJOVR64sy+m/rQNxhBbRl/ri6hoqcPAZtYqHkVZJvTtXVODMvM+1q+
        G3gz25oMaNPKzU1yyjcdmQpLQKw0oY4uMNojqhyjCE+0GXvJAujBLOedupZXhrps
        0akD1yYbq0WmR24VDrGiXqEwL84iqsAMMtg5HPAYaPaxBhBED57+mH9KwzJ+qNNg
        ==
X-ME-Proxy: <xmx:43Q8W7j1GMmqRw4wkIXAgWRUgF-RnSfuV91-m2aMMNcUwy7X7M4k9w>
    <xmx:43Q8W9ZMFr1KPG9Lvm3A557zomgZIp0sXioxC4OJgA459ssh40N22g>
    <xmx:43Q8W3j98sdv3JKLcbykoAqUZhi7Dm4cZ94uEqtpv9rLjp9BzWP8YA>
    <xmx:43Q8W9ZNEFGqkildDN0P0X7AAuw7unaOSb42Omns5rjSLh2jQQ5Vrg>
    <xmx:43Q8WwPnSY7ctE5HjNhKW4RQTHtXMlKD9vCM0hbqjXFPeV7n5KtQ-w>
    <xmx:43Q8Wx6Yea29fi2305EVsezgCpUqy8qZD3jUsTdEJ3Ptb2aQ310m9Q>
X-ME-Sender: <xms:43Q8W81eT5B76T_w1eOxNri8mtVXaluYbSnKsS3Q2JGuRJ0crj5ZOA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id D43B59E4A1; Wed,  4 Jul 2018 03:18:58 -0400 (EDT)
Message-Id: <1530688738.3910192.1429467464.5C781D10@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-0d8ea36c
Date:   Wed, 04 Jul 2018 16:48:58 +0930
Subject: Re: [RFC PATCH 3/4] misc: Add bmc-misc-ctrl
In-Reply-To: <20180703075424.GC27649@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-4-andrew@aj.id.au>
 <20180703075424.GC27649@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, at 17:24, Greg KH wrote:
> On Tue, Jul 03, 2018 at 05:04:12PM +1000, Andrew Jeffery wrote:
> > bmc-misc-ctrl is used to expose miscellaneous Baseboard
> > Management Controller (BMC) hardware features described in the devicetree
> > to userspace.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  MAINTAINERS                  |   1 +
> >  drivers/misc/Kconfig         |   8 +
> >  drivers/misc/Makefile        |   1 +
> >  drivers/misc/bmc-misc-ctrl.c | 363 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 373 insertions(+)
> >  create mode 100644 drivers/misc/bmc-misc-ctrl.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9766d7832d8b..30d39440b6f2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2741,6 +2741,7 @@ R:	Andrew Jeffery <andrew@aj.id.au>
> >  L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
> >  S:	Supported
> >  F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > +F:	drivers/misc/bmc-misc-ctrl.c
> >  
> >  BPF (Safe dynamic programs and tools)
> >  M:	Alexei Starovoitov <ast@kernel.org>
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 3726eacdf65d..f46bc8208b50 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -513,6 +513,14 @@ config MISC_RTSX
> >  	tristate
> >  	default MISC_RTSX_PCI || MISC_RTSX_USB
> >  
> > +config BMC_MISC_CTRL
> > +	tristate "Miscellaneous BMC Control Interfaces"
> > +	depends on REGMAP && MFD_SYSCON
> > +	help
> > +	  Say yes to expose scratch registers used to communicate between the
> > +	  host and BMC along with other miscellaneous control interfaces
> > +	  provided by BMC SoCs
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index af22bbc3d00c..4fb2fac7a486 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
> >  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
> >  obj-$(CONFIG_OCXL)		+= ocxl/
> >  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> > +obj-$(CONFIG_BMC_MISC_CTRL)     += bmc-misc-ctrl.o
> > diff --git a/drivers/misc/bmc-misc-ctrl.c b/drivers/misc/bmc-misc-ctrl.c
> > new file mode 100644
> > index 000000000000..ff907029163f
> > --- /dev/null
> > +++ b/drivers/misc/bmc-misc-ctrl.c
> > @@ -0,0 +1,363 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright 2018 IBM Corp.
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/device.h>
> > +#include <linux/kobject.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +struct bmc_ctrl {
> > +	struct device *dev;
> > +	struct regmap *map;
> > +	bool ro;
> > +	u32 shift;
> > +	u32 mask;
> > +	struct kobj_attribute mask_attr;
> > +	const char *label;
> > +	struct kobj_attribute label_attr;
> > +	union {
> > +		struct {
> > +			u32 value;
> > +			struct kobj_attribute value_attr;
> > +		};
> > +		struct {
> > +			u32 read;
> > +			u32 set;
> > +			u32 clear;
> > +			struct kobj_attribute read_attr;
> > +			struct kobj_attribute set_attr;
> > +			struct kobj_attribute clear_attr;
> > +		};
> 
> What is this crazy union for?  Why are you messing around with "raw"
> kobject attributes?  This is a device, you should never have to mess
> with sysfs calls or kobject calls or structures directly.  If you do,
> that's a huge hint something is wrong here.
> 
> 
> > +	};
> > +};
> > +
> > +static ssize_t bmc_misc_rmw_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct bmc_ctrl *ctrl;
> > +	unsigned int val;
> > +	int rc;
> > +
> > +	ctrl = container_of(attr, struct bmc_ctrl, value_attr);
> > +	rc = regmap_read(ctrl->map, ctrl->value, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	val = (val & ctrl->mask) >> ctrl->shift;
> > +
> > +	return sprintf(buf, "%u\n", val);
> > +}
> > +
> > +static ssize_t bmc_misc_rmw_store(struct kobject *kobj,
> > +					 struct kobj_attribute *attr,
> > +					 const char *buf, size_t count)
> > +{
> > +	struct bmc_ctrl *ctrl;
> > +	long val;
> > +	int rc;
> > +
> > +	rc = kstrtol(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ctrl = container_of(attr, struct bmc_ctrl, value_attr);
> > +	val <<= ctrl->shift;
> > +	if (val & ~ctrl->mask)
> > +		return -EINVAL;
> > +	rc = regmap_update_bits(ctrl->map, ctrl->value, ctrl->mask, val);
> > +
> > +	return rc < 0 ? rc : count;
> > +}
> > +
> > +static void bmc_misc_add_rmw_attrs(struct bmc_ctrl *ctrl,
> > +				   struct attribute *attrs[6])
> > +{
> > +	sysfs_attr_init(&ctrl->attr.attr);
> > +	ctrl->value_attr.attr.name = "value";
> > +	ctrl->value_attr.attr.mode = 0664;
> > +	ctrl->value_attr.show = bmc_misc_rmw_show;
> > +	ctrl->value_attr.store = bmc_misc_rmw_store;
> > +	attrs[2] = &ctrl->value_attr.attr;
> > +	attrs[3] = NULL;
> 
> You aren't "adding" any attributes here, you are only setting them up
> (in an odd way, see below...)
> 
> > +}
> > +
> > +static int bmc_misc_init_rmw(struct bmc_ctrl *ctrl, struct device_node *node,
> > +			     struct attribute *attrs[6])
> 
> That's an oddly-hard-coded array size for no good reason :(
> 
> 
> > +{
> > +	u32 val;
> > +	int rc;
> > +
> > +	rc = of_property_read_u32(node, "offset", &ctrl->value);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	if (!of_property_read_u32(node, "default-value", &val)) {
> > +		val <<= ctrl->shift;
> > +		if (val & ~ctrl->mask)
> > +			return -EINVAL;
> > +		val &= ctrl->mask;
> > +		regmap_update_bits(ctrl->map, ctrl->value, ctrl->mask, val);
> > +	}
> > +
> > +	bmc_misc_add_rmw_attrs(ctrl, attrs);
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t bmc_misc_sc_read_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct bmc_ctrl *ctrl;
> > +	unsigned int val;
> > +	int rc;
> > +
> > +	ctrl = container_of(attr, struct bmc_ctrl, read_attr);
> > +	rc = regmap_read(ctrl->map, ctrl->read, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	val = (val & ctrl->mask) >> ctrl->shift;
> > +
> > +	return sprintf(buf, "%u\n", val);
> > +
> > +}
> > +
> > +static ssize_t bmc_misc_sc_set_store(struct kobject *kobj,
> > +					    struct kobj_attribute *attr,
> > +					    const char *buf, size_t count)
> > +{
> > +	struct bmc_ctrl *ctrl;
> > +	long val;
> > +	int rc;
> > +
> > +	rc = kstrtol(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ctrl = container_of(attr, struct bmc_ctrl, set_attr);
> > +	val <<= ctrl->shift;
> > +	if (val & ~ctrl->mask)
> > +		return -EINVAL;
> > +	val &= ctrl->mask;
> > +	rc = regmap_write(ctrl->map, ctrl->set, val);
> > +
> > +	return rc < 0 ? rc : count;
> > +}
> > +
> > +static ssize_t bmc_misc_sc_clear_store(struct kobject *kobj,
> > +					      struct kobj_attribute *attr,
> > +					      const char *buf, size_t count)
> > +{
> > +	struct bmc_ctrl *ctrl;
> > +	long val;
> > +	int rc;
> > +
> > +	rc = kstrtol(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ctrl = container_of(attr, struct bmc_ctrl, clear_attr);
> > +	val <<= ctrl->shift;
> > +	if (val & ~ctrl->mask)
> > +		return -EINVAL;
> > +	val &= ctrl->mask;
> > +	rc = regmap_write(ctrl->map, ctrl->clear, val);
> > +
> > +	return rc < 0 ? rc : count;
> > +}
> > +
> > +static void bmc_misc_add_sc_attrs(struct bmc_ctrl *ctrl,
> > +				  struct attribute *attrs[6])
> > +{
> > +	sysfs_attr_init(&ctrl->read_attr.attr);
> > +	ctrl->read_attr.attr.name = "value";
> > +	ctrl->read_attr.attr.mode = 0444;
> > +	ctrl->read_attr.show = bmc_misc_sc_read_show;
> > +	attrs[2] = &ctrl->read_attr.attr;
> > +
> > +	sysfs_attr_init(&ctrl->set_attr.attr);
> > +	ctrl->set_attr.attr.name = "set";
> > +	ctrl->set_attr.attr.mode = 0200;
> > +	ctrl->set_attr.store = bmc_misc_sc_set_store;
> > +	attrs[3] = &ctrl->set_attr.attr;
> > +
> > +	sysfs_attr_init(&ctrl->clear_attr.attr);
> > +	ctrl->clear_attr.attr.name = "clear";
> > +	ctrl->clear_attr.attr.mode = 0200;
> > +	ctrl->clear_attr.store = bmc_misc_sc_clear_store;
> > +	attrs[4] = &ctrl->clear_attr.attr;
> > +
> > +	attrs[5] = NULL;
> > +}
> > +
> > +static int bmc_misc_init_sc(struct bmc_ctrl *ctrl, struct device_node *node,
> > +			    struct attribute *attrs[6])
> > +{
> > +	int rc;
> > +
> > +	rc = of_property_read_u32_array(node, "offset", &ctrl->read, 3);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	if (of_property_read_bool(node, "default-set"))
> > +		regmap_write(ctrl->map, ctrl->set, ctrl->mask);
> > +	else if (of_property_read_bool(node, "default-clear"))
> > +		regmap_write(ctrl->map, ctrl->clear, ctrl->mask);
> > +
> > +	bmc_misc_add_sc_attrs(ctrl, attrs);
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t bmc_misc_label_show(struct kobject *kobj,
> > +				   struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct bmc_ctrl *ctrl = container_of(attr, struct bmc_ctrl, label_attr);
> > +
> > +	return sprintf(buf, "%s\n", ctrl->label);
> > +}
> > +
> > +static ssize_t bmc_misc_mask_show(struct kobject *kobj,
> > +				   struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct bmc_ctrl *ctrl = container_of(attr, struct bmc_ctrl, mask_attr);
> > +
> > +	return sprintf(buf, "0x%x\n", ctrl->mask >> ctrl->shift);
> > +}
> > +
> > +static int bmc_misc_init_dt(struct bmc_ctrl *ctrl, struct device_node *node,
> > +			    struct attribute *attrs[6])
> > +{
> > +	int rc;
> > +
> > +	/* Example children:
> > +	 *
> > +	 * field@80.6 {
> > +	 *      compatible = "bmc-misc-control";
> > +	 *      reg = <0x80>;
> > +	 *      bit-mask = <0x1>;
> > +	 *      bit-shift = <6>;
> > +	 *      label = "ilpc2ahb-disable";
> > +	 * };
> > +	 *
> > +	 * field@70.6 {
> > +	 *      compatible = "bmc-misc-control";
> > +	 *      // Write-1-set/Write-1-clear semantics
> > +	 *      set-clear;
> > +	 *      default-set;
> > +	 *      reg = <0x70 0x70 0x7c>
> > +	 *      bit-mask = <0x1>;
> > +	 *      bit-shift = <6>;
> > +	 *      label = "lpc-sio-decode-disable";
> > +	 * };
> > +	 *
> > +	 * field@50.0 {
> > +	 *	compatible = "bmc-misc-control";
> > +	 *	read-only;
> > +	 *	reg = <0x50>;
> > +	 *	bit-mask = <0xffffffff>;
> > +	 *	bit-shift = <0>;
> > +	 *	label = "vga-scratch-1";
> > +	 * };
> > +	 */
> > +	rc = of_property_read_u32(node, "mask", &ctrl->mask);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	ctrl->shift = __ffs(ctrl->mask);
> > +	ctrl->ro = of_property_read_bool(node, "read-only");
> > +
> > +	rc = of_property_read_string(node, "label", &ctrl->label);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	ctrl->label_attr.attr.name = "label";
> > +	ctrl->label_attr.attr.mode = 0444;
> > +	ctrl->label_attr.show = bmc_misc_label_show;
> > +	attrs[0] = &ctrl->label_attr.attr;
> 
> This works?  You normally have to manually initialize a dynamic
> attribute.  Why are you doing it this way and not using an attribute
> group?
> 
> > +	ctrl->mask_attr.attr.name = "mask";
> > +	ctrl->mask_attr.attr.mode = 0444;
> > +	ctrl->mask_attr.show = bmc_misc_mask_show;
> > +	attrs[1] = &ctrl->mask_attr.attr;
> > +
> > +	if (of_property_read_bool(node, "set-clear"))
> > +		return bmc_misc_init_sc(ctrl, node, attrs);
> > +
> > +	return bmc_misc_init_rmw(ctrl, node, attrs);
> > +}
> > +
> > +static struct class bmc_class = {
> > +	.name =		"bmc",
> > +};
> 
> Why are you using a custom device class for a single device?
> 
> you need to document the heck out of this in the changelog to help
> explain all of these odd design decisions.

It got a bit perverse from attempting to separate the devicetree handling from everything else. I'll fix the issues you've pointed out and rework the sysfs/kobj stuff.

However, the patch (and the series) was intended as a straw man. I should have put more effort in to avoid some of the distraction (sorry), but I was also hoping to get feedback on the general approach (so devicetree design and how to expose the bits to userspace in a useful manner).

Regarding the class, yeah, it's probably not the right choice and I'm not going to double down on it, but it collates the fields in an easy to discover location. Not doing something like this means a lot of grubbing around in /sys/device. Is there a better approach?

Thanks for the feedback so far.

Andrew
