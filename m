Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40C12087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfwlQMJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40C12087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJKEiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:38:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44168 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeJKEiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:38:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so3100676pli.11;
        Wed, 10 Oct 2018 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rxo2nE3ZYImNhRRbbf/Z5fCX+JsHGAPHVysn95bb4qA=;
        b=gfwlQMJrxh5OGni5oV2IjWWT+f2Emre5hVsk/2UcCcdecD0Y2oKY5vziufQLvZpX/o
         llUJvxMoxD7GMbFIYje5Ax6/6DVioI+VPR1U4P1RQqqSV2aWQXlSk5lJIH1decpXqQ0f
         YklGxWHCmx6XHCciMftvVhFz4mscZb7rFIVSCdIAREA2zJpMGer8rhcRdU+DwObXSDKn
         EN1FRpr+CwvtmVHyp4xjviuhzy1Dmn8X3FCGc3DASB3v34hyItbvw4d9ixIxVJayK4Sy
         LPu08bkjhq97NKlgZuxigEE7Yw413ivxL41THio9LYcBJ0Q+smRrtRMKhALujh+8y+e2
         Y8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rxo2nE3ZYImNhRRbbf/Z5fCX+JsHGAPHVysn95bb4qA=;
        b=H2lPd5TAxjKawYcmA7/IkRTw6rCEQf13PcqOdLQb2tHLnPXwIyv/vJrR0cYBlgMDM5
         eR97wQhQjK+Il22gfi29oMWpAlqqds2hfSFWes2h+nnR5t9rZwLFRkSUHwOVV8c2x56I
         bEZ84uVeB0bbEfFnxfFKshFMvIYhhEAk2me2leG/X5XU8+FxZDfZVHosSSSk6Nz4qvTh
         vX87ZiN4tHHE5AX4OwL9i0ovUMKfiEMMMlVda57w/sO3IiiKMWnS/DsOxnM0glPFf7lq
         Brn5+JmIb3ZhuP+ofTqZhXs6NfQkdKhOkEd62mJb+eYMN0gmQgZJsF1RpuI3XIijafs+
         E1Bw==
X-Gm-Message-State: ABuFfogEagK8V2/ANYW4KOJdXXBmMix2xZOjJTd82YLe5Vwlk6U3Cu69
        gi6XaLMIgt5t/PEesWFD7Hue32bT
X-Google-Smtp-Source: ACcGV60fjTvBT38ETlC37Pk9uPqcj6QMfPBCHMpXMk7w0oBsijgu96jmOZRj/P2vnAawOsRHy/AX5w==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14-v6mr34796159plr.241.1539206042269;
        Wed, 10 Oct 2018 14:14:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l10-v6sm45260154pgs.45.2018.10.10.14.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:14:01 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:13:57 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (core) Add hwmon_mode structure and mode
 sysfs node
Message-ID: <20181010211356.GA1706@Asurada-Nvidia.nvidia.com>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-2-nicoleotsuka@gmail.com>
 <2c535925-5b75-75e6-e383-645fdf45f519@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c535925-5b75-75e6-e383-645fdf45f519@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Wed, Oct 10, 2018 at 06:08:30AM -0700, Guenter Roeck wrote:
> > +available_modes The available operating modes of the chip.
> > +		This should be short, lowercase string, not containing
> > +		whitespace, or the wildcard character '*'.
> > +		This attribute shows all the available of the operating modes,
> > +		for example, "power-down" "one-shot" and "continuous".
> > +		RO
> > +
> > +mode		The current operating mode of the chip.
> > +		This should be short, lowercase string, not containing
> > +		whitespace, or the wildcard character '*'.
> > +		This attribute shows the current operating mode of the chip.
> > +		Writing a valid string from the list of available_modes will
> > +		configure the chip to the corresponding operating mode.
> > +		RW
> > +

> This is not a well defined ABI: The modes would be under full and arbitrary
> control by drivers, and be completely driver dependent. It isn't just the sysfs
> attribute that makes the ABI, it is also the contents.

> Also, being able to set the mode itself (for whatever definition of mode)
> is of questionable value. This is not only for the modes suggested here, but
> for other possible modes such as comparator mode vs. interrupt mode (which,
> if configurable, should be via platform data or devicetree node entries).
> For the modes suggested here, more in the other patch.

I could foresee an objection here but still wrote the change after
seeing quite a few drivers (especially TI's chips) share the same
pattern for operating modes: power-down, one-shot and continuous.
For example, I could add it to ina3221 driver instead of touching
the core code, but later I would do the same for the ina2xx driver
(just received a board having ina230/226.)

Although I don't mind doing this and will put it to ina3221 driver
in v2, yet maybe we could think about a better way to abstract it?

Thank you
Nicolin
------

> In short, NACK. I am open to enhancing the ABI, but I don't see the value
> of this attribute.
> 
> Guenter
> 
> 
> >   update_interval	The interval at which the chip will update readings.
> >   		Unit: millisecond
> >   		RW
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index 975c95169884..5a33b616284b 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -72,25 +72,88 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
> >   }
> >   static DEVICE_ATTR_RO(name);
> > +static ssize_t available_modes_show(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> > +	const struct hwmon_chip_info *chip = hwdev->chip;
> > +	const struct hwmon_mode *mode = chip->mode;
> > +	int i;
> > +
> > +	for (i = 0; i < mode->list_size; i++)
> > +		snprintf(buf, PAGE_SIZE, "%s%s ", buf, mode->names[i]);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%s\n", buf);
> > +}
> > +static DEVICE_ATTR_RO(available_modes);
> > +
> > +static ssize_t mode_show(struct device *dev,
> > +			 struct device_attribute *attr, char *buf)
> > +{
> > +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> > +	const struct hwmon_chip_info *chip = hwdev->chip;
> > +	const struct hwmon_mode *mode = chip->mode;
> > +	unsigned int index;
> > +	int ret;
> > +
> > +	ret = mode->get_index(dev, &index);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%s\n", mode->names[index]);
> > +}
> > +
> > +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> > +			  const char *buf, size_t count)
> > +{
> > +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> > +	const struct hwmon_chip_info *chip = hwdev->chip;
> > +	const struct hwmon_mode *mode = chip->mode;
> > +	const char **names = mode->names;
> > +	unsigned int index;
> > +	int ret;
> > +
> > +	/* Get the corresponding mode index */
> > +	for (index = 0; index < mode->list_size; index++) {
> > +		if (!strncmp(buf, names[index], strlen(names[index])))
> > +			break;
> > +	}
> > +
> > +	if (index >= mode->list_size)
> > +		return -EINVAL;
> > +
> > +	ret = mode->set_index(dev, index);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(mode);
> > +
> >   static struct attribute *hwmon_dev_attrs[] = {
> > -	&dev_attr_name.attr,
> > +	&dev_attr_name.attr,		/* index = 0 */
> > +	&dev_attr_available_modes.attr,	/* index = 1 */
> > +	&dev_attr_mode.attr,		/* index = 2 */
> >   	NULL
> >   };
> > -static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
> > -					 struct attribute *attr, int n)
> > +static umode_t hwmon_dev_is_visible(struct kobject *kobj,
> > +				    struct attribute *attr, int n)
> >   {
> >   	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> > -	if (to_hwmon_device(dev)->name == NULL)
> > -		return 0;
> > +	if (n == 0 && hwdev->name)
> > +		return attr->mode;
> > +	else if (n <= 2 && hwdev->chip->mode)
> > +		return attr->mode;
> > -	return attr->mode;
> > +	return 0;
> >   }
> >   static const struct attribute_group hwmon_dev_attr_group = {
> >   	.attrs		= hwmon_dev_attrs,
> > -	.is_visible	= hwmon_dev_name_is_visible,
> > +	.is_visible	= hwmon_dev_is_visible,
> >   };
> >   static const struct attribute_group *hwmon_dev_attr_groups[] = {
> > @@ -591,6 +654,16 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >   		struct attribute **attrs;
> >   		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
> > +		/* Validate optional hwmon_mode */
> > +		if (chip->mode) {
> > +			/* Check mandatory properties */
> > +			if (!chip->mode->names || !chip->mode->list_size ||
> > +			    !chip->mode->get_index || !chip->mode->set_index) {
> > +				err = -EINVAL;
> > +				goto free_hwmon;
> > +			}
> > +		}
> > +
> >   		if (groups)
> >   			for (i = 0; groups[i]; i++)
> >   				ngroups++;
> > diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> > index 99e0c1b0b5fb..06c1940ca98b 100644
> > --- a/include/linux/hwmon.h
> > +++ b/include/linux/hwmon.h
> > @@ -365,14 +365,38 @@ struct hwmon_channel_info {
> >   	const u32 *config;
> >   };
> > +/**
> > + * Chip operating mode information
> > + * @names:	A list of available operating mode names.
> > + * @list_size:	The total number of available operating mode names.
> > + * @get_index:	Callback to get current operating mode index. Mandatory.
> > + *		Parameters are:
> > + *		@dev:	Pointer to hardware monitoring device
> > + *		@index:	Pointer to returned mode index
> > + *		The function returns 0 on success or a negative error number.
> > + * @set_index:	Callback to set operating mode using the index. Mandatory.
> > + *		Parameters are:
> > + *		@dev:	Pointer to hardware monitoring device
> > + *		@index:	Mode index in the mode list
> > + *		The function returns 0 on success or a negative error number.
> > + */
> > +struct hwmon_mode {
> > +	const char **names;
> > +	unsigned int list_size;
> > +	int (*get_index)(struct device *dev, unsigned int *index);
> > +	int (*set_index)(struct device *dev, unsigned int index);
> > +};
> > +
> >   /**
> >    * Chip configuration
> >    * @ops:	Pointer to hwmon operations.
> >    * @info:	Null-terminated list of channel information.
> > + * @mode:	Pointer to hwmon operating mode (optional).
> >    */
> >   struct hwmon_chip_info {
> >   	const struct hwmon_ops *ops;
> >   	const struct hwmon_channel_info **info;
> > +	const struct hwmon_mode *mode;
> >   };
> >   /* hwmon_device_register() is deprecated */
> > 
> 
