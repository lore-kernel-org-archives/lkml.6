Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3E2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QxzLB34T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE3E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeKABLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:11:14 -0400
Received: from casper.infradead.org ([85.118.1.10]:59966 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeKABLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l9dsZ7YjPZgnv8Upl6majTM+PA8YpYYu0yaUpQUPKGA=; b=QxzLB34TR0senKALbv7nDf50ys
        9xFP7f53HMBlwVh9uHXJWglAgue9VDo6q9lgDxTYtKdbpoV6dEMSrWcvwpq2hMiOWRrMF15q6Wv3K
        cf8EtkvEBEeaK8cvbR7KpVVhXSWK0eJ2xewb9n3nZnFn1xrlwDtNrIYO2w9gHzdvqcb/h72MGtPcG
        8YMcge0kRtP8HkSO+6dJZs6yZRh9Ixt+3VvhEbSWElAUFIEgkQ7Bv9cqDC68JjbOI12Gxsize2mrG
        ocRgLgXs2wC3k73JZjTIyLcKB6gy28s06NJru7oOydLpGh87VIZ54WMc5nF4XIlF+JbWVAOWkA7e/
        3zKnYLNQ==;
Received: from 177.206.134.103.dynamic.adsl.gvt.net.br ([177.206.134.103] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHt6V-0007mg-HB; Wed, 31 Oct 2018 16:12:24 +0000
Date:   Wed, 31 Oct 2018 13:12:18 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Sean Young <sean@mess.org>, Michael Krufky <mkrufky@linuxtv.org>,
        Brad Love <brad@nextdimension.cc>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb: Allow MAC addresses to be mapped to stable device
 names with udev
Message-ID: <20181031131218.6cd8ce0c@coco.lan>
In-Reply-To: <13768.1541001100@warthog.procyon.org.uk>
References: <12108.1540984768@warthog.procyon.org.uk>
        <20181031104912.s3tqjl3u43ou3kwo@gofer.mess.org>
        <20181030223249.dhwhxdjipzmjxzsy@gofer.mess.org>
        <153778383104.14867.1567557014782141706.stgit@warthog.procyon.org.uk>
        <20181030110319.764f33f0@coco.lan>
        <8474.1540982182@warthog.procyon.org.uk>
        <13768.1541001100@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 31 Oct 2018 15:51:40 +0000
David Howells <dhowells@redhat.com> escreveu:

> David Howells <dhowells@redhat.com> wrote:
> 
> > > > > Devices without a mac address shouldn't have a mac_dvb sysfs attribute,
> > > > > I think.  
> > > > 
> > > > I'm not sure that's possible within the core infrastructure.  It's a
> > > > class attribute set when the class is created; I'm not sure it can be
> > > > overridden on a per-device basis.
> > > > 
> > > > Possibly the file could return "" or "none" in this case?  
> > > 
> > > That's very ugly. Have a look at, for example, rc-core wakeup filters:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/rc/rc-main.c#n1844  
> > 
> > By analogy, then, I think the thing to do is to put something like struct
> > rc_dev::sysfs_groups[] into struct dvb_device (or maybe struct dvb_adapter)
> > and then the dvb_mac attribute in there during dvb_register_device() based on
> > whether or not the MAC address is not all zeros at that point.  
> 
> Hmmm...  This is trickier than it seems.  At the point the device struct is
> registered, the MAC address hasn't yet been read:
> 
> [   13.865905] cx23885: CORE cx23885[1]: subsystem: 4254:0952, board: DVBSky S952 [card=50,autodetected]
> [   14.095559] cx25840 8-0044: cx23885 A/V decoder found @ 0x88 (cx23885[1])
> [   14.723127] cx25840 8-0044: loaded v4l-cx23885-avcore-01.fw firmware (16382 bytes)
> [   14.738377] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
> [   14.738378] cx23885: cx23885[1]: cx23885 based dvb card
> [   14.742536] i2c i2c-7: Added multiplexed i2c bus 9
> [   15.096912] ts2020 9-0060: Montage Technology TS2022 successfully identified
> [   15.096933] dvbdev: DVB: registering new adapter (cx23885[1])
> [   15.096936] cx23885 0000:06:00.0: DVB: registering adapter 2 frontend 0 (Montage Technology M88DS3103)...
> [   15.124665] cx23885: DVBSky S952 port 1 MAC address: 00:17:42:54:09:52
> [   15.124666] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
> [   15.124674] cx23885: cx23885[1]: cx23885 based dvb card
> [   15.128860] i2c i2c-6: Added multiplexed i2c bus 10
> [   15.228172] ts2020 10-0060: Montage Technology TS2022 successfully identified
> [   15.228188] dvbdev: DVB: registering new adapter (cx23885[1])
> [   15.228190] cx23885 0000:06:00.0: DVB: registering adapter 3 frontend 0 (Montage Technology M88DS3103)...
> [   15.255996] cx23885: DVBSky S952 port 2 MAC address: 00:17:42:54:09:53
> [   15.255999] cx23885: cx23885_dev_checkrevision() Hardware revision = 0xa5
> [   15.256004] cx23885: cx23885[1]/0: found at 0000:06:00.0, rev: 4, irq: 19, latency: 0, mmio: 0xf7a00000
> 
> The device structs are registered at 15.096936 and 15.228190 and this is the
> point by which I think I have to set the device::groups pointer.
> 
> However, the device isn't fully initialised at this point and the MAC address
> hasn't yet been read - and so the attribute doesn't appear.  proposed_mac is
> set right after lines 15.124665 and 15.255996.  Interestingly, a third of a
> second elapses between the device registration and the MAC being printed for
> each adapter.
> 
> Any suggestions?

Yeah, I was afraid about that. At V4L2 core, what we do is that we first
do everything, including firmware load, and only after having everything
setup, we register the char device.

I suspect it should be possible to do that too at dvb-usb and dvb-usb-v2,
but some work would be needed.

> 
> David
> ---
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index b7171bf094fb..edbfa5549994 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -450,6 +450,23 @@ static int dvb_register_media_device(struct dvb_device *dvbdev,
>  	return 0;
>  }
>  
> +static ssize_t dvb_mac_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct dvb_device *dvbdev = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%pM\n", dvbdev->adapter->proposed_mac);
> +}
> +static DEVICE_ATTR_RO(dvb_mac);
> +
> +static struct attribute *dvb_device_attrs[] = {
> +	&dev_attr_dvb_mac.attr,
> +	NULL
> +};
> +static const struct attribute_group dvb_device_attr_grp = {
> +	.attrs	= dvb_device_attrs,
> +};
> +
>  int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
>  			const struct dvb_device *template, void *priv,
>  			enum dvb_device_type type, int demux_sink_pads)
> @@ -533,6 +550,14 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
>  
>  	mutex_unlock(&dvbdev_register_lock);
>  
> +	if (adap->proposed_mac[0] || adap->proposed_mac[1] ||
> +	    adap->proposed_mac[2] || adap->proposed_mac[3] ||
> +	    adap->proposed_mac[4] || adap->proposed_mac[5]) {
> +		dvbdev->sysfs_groups[0] = &dvb_device_attr_grp;
> +		dvbdev->sysfs_groups[1] = NULL;
> +		adap->device->groups = dvbdev->sysfs_groups;
> +	}
> +
>  	clsdev = device_create(dvb_class, adap->device,
>  			       MKDEV(DVB_MAJOR, minor),
>  			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
> @@ -1010,6 +1035,31 @@ void dvb_module_release(struct i2c_client *client)
>  EXPORT_SYMBOL_GPL(dvb_module_release);
>  #endif
>  
> +static ssize_t dvb_adapter_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct dvb_device *dvbdev = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", dvbdev->adapter->num);
> +}
> +static DEVICE_ATTR_RO(dvb_adapter);
> +
> +static ssize_t dvb_type_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct dvb_device *dvbdev = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", dnames[dvbdev->type]);
> +}
> +static DEVICE_ATTR_RO(dvb_type);
> +
> +static struct attribute *dvb_class_attrs[] = {
> +	&dev_attr_dvb_adapter.attr,
> +	&dev_attr_dvb_type.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(dvb_class);
> +
>  static int dvb_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct dvb_device *dvbdev = dev_get_drvdata(dev);
> @@ -1050,6 +1100,7 @@ static int __init init_dvbdev(void)
>  		retval = PTR_ERR(dvb_class);
>  		goto error;
>  	}
> +	dvb_class->dev_groups = dvb_class_groups,
>  	dvb_class->dev_uevent = dvb_uevent;
>  	dvb_class->devnode = dvb_devnode;
>  	return 0;
> diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
> index 881ca461b7bb..d6becdd2d56e 100644
> --- a/include/media/dvbdev.h
> +++ b/include/media/dvbdev.h
> @@ -127,6 +127,7 @@ struct dvb_adapter {
>   *
>   * @list_head:	List head with all DVB devices
>   * @fops:	pointer to struct file_operations
> + * @sysfs_groups: Additional sysfs attributes
>   * @adapter:	pointer to the adapter that holds this device node
>   * @type:	type of the device, as defined by &enum dvb_device_type.
>   * @minor:	devnode minor number. Major number is always DVB_MAJOR.
> @@ -157,6 +158,7 @@ struct dvb_adapter {
>  struct dvb_device {
>  	struct list_head list_head;
>  	const struct file_operations *fops;
> +	const struct attribute_group *sysfs_groups[2];
>  	struct dvb_adapter *adapter;
>  	enum dvb_device_type type;
>  	int minor;



Thanks,
Mauro
