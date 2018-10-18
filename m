Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7986EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCCE2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="n1kWfhyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCCE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeJSAnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:43:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46554 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSAnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:43:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id r190-v6so2820396pgr.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hD2UDmBptUsKoR5mlLPU73uQ4qeYO1A2VnT5183hWhg=;
        b=n1kWfhyScmT+fKNO8kRQETw0i7EEmPuraxf+G3v+5B6gcaoDGKs37Zzp5G8Zrytg2K
         rGtLXMQg4TZztwi4Ek2E14Fyqgym2MeVd2hAjBkVhwWf0ANe5NJ/whaWMXuASyZKmFEF
         r8cozq3WCetNhNbkVYtF0hYr0jwhf/mO9TX2zM8KKS/hUGpp26DRUlyRe/2BHJmOTPV1
         chHz1aD0Vl8s3VhPuVk2ubUmRPyRACv3Bqib95NQVzXgUDHisMiU9NWjlCJUlvFnFSch
         iCp/kHtsKUB3E3xsHHtgAtAKK4HDakxhg7T8VLQbelSkjCj4Bqq58S8tpcJh0/xZIcD5
         /UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hD2UDmBptUsKoR5mlLPU73uQ4qeYO1A2VnT5183hWhg=;
        b=dqcIY7agLlYFyzA3Iwfzf2IoUvCfLysaL1kZeKPqg9egh2vmPrHF0EuiVlqaf3X/Lo
         7aLdANhyVxF4G+EfYEqdtPgfLhxrmzbOAExSgE88EURKlS/ogUNbdxSSU+UekTJYSpYj
         e58+9FnMjJSmFywfeuQ7txJecXTOxxKbkZwov0GNvIY/0z7PQRzmbM/SmMT/ZDTKs/pH
         TJKZ/gpwV5H2MAA3uL2gxhUxaGmmSGxkwglPcQnFDwwAmkG9ipncbPS/141CzP4Oo0is
         W8HPj2l+FC8NwWEo4+KKCp+F9cCxpRRbAs6CN2kkPREyfcpfEp84ecOxEDuUz0/q+eCY
         42TQ==
X-Gm-Message-State: ABuFfojUf7qtU45udG0g0+qVqhdQUSN6Ki2Rm6JzI+13gweu2B/Zr3YF
        UKkCMaDbO7RLXFB/BOo6Nnd9Jw==
X-Google-Smtp-Source: ACcGV6003S09FZTRpbOxCHxx/H771C97nZWad7Wx221FywN+X0ysw4fsatX9N9mreoT2aFAxwlmexg==
X-Received: by 2002:a63:5224:: with SMTP id g36-v6mr29584985pgb.253.1539880911707;
        Thu, 18 Oct 2018 09:41:51 -0700 (PDT)
Received: from shemminger-XPS-13-9360 ([167.220.99.60])
        by smtp.gmail.com with ESMTPSA id e3-v6sm27538387pgc.71.2018.10.18.09.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:41:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 09:41:45 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Olaf Hering <olaf@aepfle.de>, KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: Re: [PATCH V2 3/4] vmbus: add per-channel sysfs info
Message-ID: <20181018094127.6a48fa55@shemminger-XPS-13-9360>
In-Reply-To: <CY4PR21MB0773D6885EC71F92D1A1369FD7F80@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20170918034955.10913-1-kys@exchange.microsoft.com>
        <20170918035419.11062-1-kys@exchange.microsoft.com>
        <20170918035419.11062-3-kys@exchange.microsoft.com>
        <20181018171953.079f6fb6.olaf@aepfle.de>
        <CY4PR21MB0773D6885EC71F92D1A1369FD7F80@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 15:32:35 +0000
Michael Kelley <mikelley@microsoft.com> wrote:

> From Olaf Hering  Sent: Thursday, October 18, 2018 8:20 AM
> >  
> > > This extends existing vmbus related sysfs structure to provide per-channel
> > > state information. This is useful when diagnosing issues with multiple
> > > queues in networking and storage.  
> >   
> > > +++ b/drivers/hv/vmbus_drv.c
> > > +static ssize_t write_avail_show(const struct vmbus_channel *channel, char *buf)
> > > +{
> > > +	const struct hv_ring_buffer_info *rbi = &channel->outbound;
> > > +
> > > +	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
> > > +}
> > > +VMBUS_CHAN_ATTR_RO(write_avail);  
> > 
> > This is upstream since a year.
> > 
> > But I wonder how this can work if vmbus_device_register is called,
> > and then something reads the populated sysfs files before vmbus_open returns.
> > Nothing protects rbi->ring_buffer in this case, which remains NULL
> > until vmbus_open populates it.
> > 
> > A simple reproduce, with a modular kernel, is to boot with init=/bin/bash
> > head /sys/bus/vmbus/devices/*/channels/*/*
> >   
> 
> There are multiple race conditions with this and other VMbus sysfs information.
> There's a race on the close path as well.  I've got an action on my list to get it
> cleaned up.
> 
> Michael
> 

There is also a bunch of issues with code like:

static ssize_t id_show(struct device *dev, struct device_attribute *dev_attr,
		       char *buf)
{
	struct hv_device *hv_dev = device_to_hv_device(dev);

	if (!hv_dev->channel)
		return -ENODEV;
	return sprintf(buf, "%d\n", hv_dev->channel->offermsg.child_relid);
}

Which should be using ACCESS_ONCE on hv_dev->channel or doing proper RCU.
