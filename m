Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0835C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8821745
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="E0srrJjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8821745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeHMWkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:40:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44432 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbeHMWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:40:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so8137065pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=say7xZ6GehzIP2luI/K/VuGrL60Wjxwc5bS7vGGCBx0=;
        b=E0srrJjJhs3ZRQSbUhFjYWw+4zxd28gGmnOS2hn3v8CHt5+GHlUVSi7vhIiQhNOFk/
         U74zgNJPiG5PtpHZpmVRoJ3+1zH/cnZAucWr21z4jo3SvHz58goMp6PMBhldlwvU7hzt
         PS6x8tliKECyp5lB2LjZZdt02/hb89N/o6DkufVkW/gZg/8V9IcfizTCFcwZasN1+xfO
         nCU3AFh8zEf01yTA3r2oEdI35l/tMCGu9xyzwBoyVanCcWzVslQZfPKl9jSnhL3+80e5
         PaiIz/tr6STJC+4mmhYHNa2m+4l+GrGtEEhBOeUWFiVO59NIkYqne4kmODY3XG4ilOsg
         9ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=say7xZ6GehzIP2luI/K/VuGrL60Wjxwc5bS7vGGCBx0=;
        b=W6hWeYhgd03hca3j/gMuopZjlhyWTt65KmnXdEKxrebrCXlYjGqhWtvrzFLKvlEmcT
         h9mJJf70+Tr+YK35CmU3aLJ2LLZDvx7bV3Z+lfLtBwpPXaGaO1yJGM51nzjvRGmtKMt6
         ZIocRX6OvFUM6V2Gk1vr8lNJgB88BG93bMQYAETOcn1VnQDwMebU4gVLzcYpL11en99f
         fXUTE+A55KvDpo6QEJEijrm3U2b8iRdLQ3//Xu0i3EYR2/+trhtp5wdPFtEjCSyjeYAx
         sow00AAC3RMffZv6Zm0oi5Ek6lj671+r1ecqlRZTDE/PmI0FCI+UE/McBIAeKRmMiCoS
         SU/g==
X-Gm-Message-State: AOUpUlE7QstY5/7PG0THnJJw0HI/9OJuwRk7GmWhfyNF6mRpyEjZEiMF
        vBBlc6TjHSM53ssIncV9zyv0jw==
X-Google-Smtp-Source: AA+uWPydoEoprqNsTVKZ4LPrS5TtHPQbEALFHcZ5t3FzsrFDfAMtjlhRhlwiOj9taUjcHWDV653kcA==
X-Received: by 2002:a63:7f16:: with SMTP id a22-v6mr18271975pgd.255.1534190220338;
        Mon, 13 Aug 2018 12:57:00 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m15-v6sm32066788pfk.149.2018.08.13.12.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:57:00 -0700 (PDT)
Date:   Mon, 13 Aug 2018 12:56:57 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH 2/5] vmbus: add driver_override support
Message-ID: <20180813125657.739a1465@xeon-e3>
In-Reply-To: <CY4PR21MB07739595C31B9B9349604C0ADC390@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
        <20180810230611.2114-1-kys@linuxonhyperv.com>
        <20180810230611.2114-2-kys@linuxonhyperv.com>
        <CY4PR21MB07739595C31B9B9349604C0ADC390@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 19:30:50 +0000
"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> wrote:

> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Friday, August 10, 2018 4:06 PM
> 
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > 
> > Add support for overriding the default driver for a VMBus device
> > in the same way that it can be done for PCI devices. This patch
> > adds the /sys/bus/vmbus/devices/.../driver_override file
> > and the logic for matching.
> > 
> > This is used by driverctl tool to do driver override.
> > https://gitlab.com/driverctl/driverctl
> > 
> > Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index b1b548a21f91..e6d8fdac6d8b 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -498,6 +498,54 @@ static ssize_t device_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(device);
> > 
> > +static ssize_t driver_override_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t count)
> > +{
> > +	struct hv_device *hv_dev = device_to_hv_device(dev);
> > +	char *driver_override, *old, *cp;
> > +
> > +	/* We need to keep extra room for a newline */
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;  
> 
> Does 'count' actually have a relationship to PAGE_SIZE, or
> is PAGE_SIZE just used as an arbitrary size limit?  I'm
> wondering what happens on ARM64 with a 64K page size,
> for example.  If it's just arbitrary, coding such a constant
> would be better.

This comes from original code how sysfs works.
Sysfs uses PAGE_SIZE for string buffers on store. This code
snippet was cloned from PCI version of same thing.

> > +/*
> > + * Return a matching hv_vmbus_device_id pointer.
> > + * If there is no match, return NULL.
> > + */
> > +static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver *drv,
> > +							struct hv_device *dev)
> > +{
> > +	const uuid_le *guid = &dev->dev_type;
> > +	const struct hv_vmbus_device_id *id;
> > 
> > -	return NULL;
> > +	/* When driver_override is set, only bind to the matching driver */
> > +	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
> > +		return NULL;  
> 
> This function needs to be covered by the device lock, so that
> dev->driver_override can't be set to NULL and the memory freed
> during the above 'if' statement.  When called from vmbus_probe(),
> the device lock is held, so it's good. But when called from
> vmbus_match(), the device lock may not be held: consider the path
> __driver_attach() -> driver_match_device() -> vmbus_match().

The patch clones existing locking model from PCI.
So either both are broken, or somehow vmbus is behaving differently.
I will investigate.





