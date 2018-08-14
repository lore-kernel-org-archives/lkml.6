Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AF5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97064215E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="VyfMTTOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97064215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbeHNTXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:23:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeHNTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:23:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id h12-v6so9346912pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABONiHC0qSwiuKM5JoeYEvivOsqn8NYNPj94p+0qIEs=;
        b=VyfMTTOX5r7j99vA8nFLD5eDCXMN71E1UBTL3vnyzE6QIbX7B/wsawcknLtbJcr/GD
         yEdXzDwGkFHj4kNk185NMCNU6Jp8AOXcRhlSJsn2sDnyU2rpFxQW+gur8a+fQ/IHGoL/
         6I3cGQDJtJZPMzhkAwppSwzYQTOHrRYCpyI6E3ZYhl8P5ehtOUXrsIx9x2SzH69uvpmc
         9mfDucZvjFUo8Pvwb19FYAK0IHdRgm+xXoHU5GmhiNhNN74ckkTu/5jk9xQh4YV0tv5Z
         FgpUpQKOQfbNDynudXqWiyzigkSRED+gZmptYLbQQmZQ2kGl0EpZcH7u+CRhCFLTyPxy
         IHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABONiHC0qSwiuKM5JoeYEvivOsqn8NYNPj94p+0qIEs=;
        b=qR0R9ECVd9pOjiM3mngdLbxLKu5JFDvqJsGBPJqiM4cA9bTWhYF7CyRbO6ei8Ax0SC
         yzqdPvDw+3rQSLQLSbrJznLe0WF6G35Jf+EgYhR9H+q6mQN8hU94sdjTqdsXhr4b1+cW
         xLZPohW3ZFMuQRIXPVrhL0MFhheghNkFgBQWSskLUVCFFHTL6LLP9jUdOo9h0OW9s/dM
         cagAxV9ljcDtAC61wsiMdSrBVoh6XVmjdE7ywiI4w1uZczVjVoIq9RH8KOsw6PRqJXuz
         kblO2SQ4Cw6Lu1WvW96OmDxSLEfHbSQ2TjOHRn4a9hIOP5s/6ngYbCxDfgDgN2rUOSaP
         0A5w==
X-Gm-Message-State: AOUpUlHmMSQM3Mahvx7epelZI8jzmBsIIu9PU11fyGqIYUSq15CAtEKb
        tklvGbKZQcruiBM5jX0TTfG4Hg==
X-Google-Smtp-Source: AA+uWPybTTT0nLRTqaLUX2CVFe3E5pyLl2yEj1MYvNzLYb16TYHpytdTyQAzF7IJ0RpuK6JHbv4pTQ==
X-Received: by 2002:a65:4b87:: with SMTP id t7-v6mr21322125pgq.391.1534264517819;
        Tue, 14 Aug 2018 09:35:17 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c88-v6sm30723525pfe.132.2018.08.14.09.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 09:35:17 -0700 (PDT)
Date:   Tue, 14 Aug 2018 09:35:14 -0700
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
Message-ID: <20180814093514.7febc8d5@xeon-e3>
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

The function hv_vmbus_get_id is called from that path.
i.e. __device_attach -> driver-match_device -> vmbus_match.
and __device_attach always does:
	device_lock(dev);

The code in driver _override_store uses the same device_lock 
when storing the new value.

This is same locking as is done in pci-sysfs.c

