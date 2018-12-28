Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAECC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4844720869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementarea-net.20150623.gappssmtp.com header.i=@elementarea-net.20150623.gappssmtp.com header.b="aWIE28Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeL1Osd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 09:48:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42068 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeL1Osc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 09:48:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so17688188edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 06:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UqZrBk/bDXnGiwPoVhGqa4oXoq27TAOZ7ISWzrMmnuI=;
        b=aWIE28GwCgJBl+JGA25u2V3JkDXEqspi5KMixEs44SbKCyPm83ShC7YqOeilOyPey5
         ubIljwb38m90s4vuJqHvD8Iva1oLH5OhUTqkkKAd1aHfuCt/26SycqZhNVdpHUhUUdWE
         vPe96wovSuO60EnheH5sUBOH2aAQXwggWuuKx+NwJARs4xftVJBJ0BPjMdzfP8oANmL5
         co39VfrDCDCutXZucQ++FnaBWyqYlVd10wLjsU/eqw7MkohwKHf4uCodA6WziVVzrYF1
         7YYjzu87KrWQGy7u5IHuRK78OQXpfDc9JFhEoVCLQocyXdsDKGSrZivWYP1f2NfM4Ups
         dKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UqZrBk/bDXnGiwPoVhGqa4oXoq27TAOZ7ISWzrMmnuI=;
        b=ugfxyOPGhFfjFDi3lX2gP3RCecQerB8niOyHzcuoAMUeMBgN8xmnTQ7xereugD/F3N
         MroN6ajZVP8qXxxVGGpsaE23O0pmZ+Lu2jOSC/BlYed2Tqz070bsZ7hyi2yvGcNwaCHb
         d68NyAWDUtzkUbNhe1wkvtB9AZwicpVxvbOvfwHRMXBhBT/Ha+oLrN8t9gQKy2keRTUF
         TbL2Ms197QCSWaPdIQbOZBmxbs4eqOLAIHqWuNMnWpma6Fw7LJILiJWhXViA4g2LYSoR
         inDZJgVPvltNHiLnJ9jVguhOkIxq+0dTJ6VDVBcl/1wokzMpz8mNKkFb6bvW9lUxECdE
         V8SQ==
X-Gm-Message-State: AA+aEWYvTRjrIZUqedi751Y5VwY2w35BnwUVgQHprmtDc2PN0CyUxlUd
        ZpJ9P8f/au4n9ZII8wJLMyntmA==
X-Google-Smtp-Source: AFSGD/XskYoGNQkHLRaNcQoY1iKfsjO5nzqXdHuwOQCTCUAJOQc8SleAr3veSEcNikE5jofV/RAFwQ==
X-Received: by 2002:a50:ccdd:: with SMTP id b29mr22319885edj.102.1546008509762;
        Fri, 28 Dec 2018 06:48:29 -0800 (PST)
Received: from ch-sta-l-li0012.sensirion.lokal ([209.206.26.2])
        by smtp.gmail.com with ESMTPSA id w56sm13180478edb.72.2018.12.28.06.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 06:48:28 -0800 (PST)
From:   Andreas Brauchli <a.brauchli@elementarea.net>
X-Google-Original-From: Andreas Brauchli <andreas.brauchli@sensirion.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>
Cc:     andreas.brauchli@sensirion.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: sps30: add support for self cleaning
Date:   Fri, 28 Dec 2018 15:47:47 +0100
Message-Id: <20181228144747.15730-1-andreas.brauchli@sensirion.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181222172346.7d520112@archlinux>
References: <20181222172346.7d520112@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 17:23:46 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 18 Dec 2018 21:28:09 +0100
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
> 
> > Self cleaning is especially useful in cases where sensor undergoes
> > frequent power on/off cycles. In such scenarios it is recommended to
> > turn self cleaning at least once per week in order to maintain reliable
> > measurements.
> > 
> > Self cleaning is activated by writing 1 to a dedicated attribute.
> > Internal fan accelerates to its maximum speed and keeps spinning
> > for about 10 seconds blowing out accumulated dust.
> > 
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> Applied to the togreg branch of iio.git.   I took this today rather than
> leaving it on the list for longer simply because I'm not sure I'll be
> very timely in applying patches.
> 
> If anyone has any comments, it'll only be out as testing so we can
> still modify if that make sense for at least the next couple of weeks.

I backported and tested the whole series on a 4.9.53 raspberry pi with an SPS30.

Tested-by: Andreas Brauchli <andreas.brauchli@sensirion.com>

Cheers,
Andreas

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > v2:
> >  * removed TODO item
> >  * sensor cleaning is not measurement related per se so drop in_ prefix
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio-sps30 |  8 +++++
> >  drivers/iio/chemical/sps30.c                  | 35 ++++++++++++++++++-
> >  2 files changed, 42 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sps30
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30
> b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > new file mode 100644
> > index 000000000000..e7ce2c57635e
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > @@ -0,0 +1,8 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
> > +Date:		December 2018
> > +KernelVersion:	4.22
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Writing 1 starts sensor self cleaning. Internal fan accelerates
> > +		to its maximum speed and keeps spinning for about 10 seconds in
> > +		order to blow out accumulated dust.
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index fa3cd409b90b..f3b4390c8f5c 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -7,7 +7,6 @@
> >   * I2C slave address: 0x69
> >   *
> >   * TODO:
> > - *  - support for turning on fan cleaning
> >   *  - support for reading/setting auto cleaning interval
> >   */
> > 
> > @@ -37,6 +36,7 @@
> >  #define SPS30_READ_DATA_READY_FLAG 0x0202
> >  #define SPS30_READ_DATA 0x0300
> >  #define SPS30_READ_SERIAL 0xd033
> > +#define SPS30_START_FAN_CLEANING 0x5607
> > 
> >  enum {
> >  	PM1,
> > @@ -104,6 +104,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int
> size)
> >  		break;
> >  	case SPS30_STOP_MEAS:
> >  	case SPS30_RESET:
> > +	case SPS30_START_FAN_CLEANING:
> >  		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
> >  		break;
> >  	case SPS30_READ_DATA_READY_FLAG:
> > @@ -275,7 +276,39 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> > 
> > +static ssize_t start_cleaning_store(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct sps30_state *state = iio_priv(indio_dev);
> > +	int val, ret;
> > +
> > +	if (kstrtoint(buf, 0, &val) || val != 1)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = sps30_do_cmd(state, SPS30_START_FAN_CLEANING, NULL, 0);
> > +	mutex_unlock(&state->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_WO(start_cleaning, 0);
> > +
> > +static struct attribute *sps30_attrs[] = {
> > +	&iio_dev_attr_start_cleaning.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group sps30_attr_group = {
> > +	.attrs = sps30_attrs,
> > +};
> > +
> >  static const struct iio_info sps30_info = {
> > +	.attrs = &sps30_attr_group,
> >  	.read_raw = sps30_read_raw,
> >  };
> > 
> > --
> > 2.20.1
> > 
