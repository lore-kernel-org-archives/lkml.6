Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9F9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF5214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="FqinnVBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAF5214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeJSAkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:40:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSAkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:40:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so14558032plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9cayDzcVMP4WLKuDaSK5zDDTxeiv+ZcJ/644yHDAQU=;
        b=FqinnVBq9YhYlfg/fXTTZVtk0EpfL8v1W9eYVkj0VWYi5L4DsgbisNSDY5eIV86YF3
         mN2TEc9uMZUiDhhNwya7IiOeUszkeefa/zDcJZu42ucC6bStLHI1Gs09dYsQwnl78Gmy
         H1bRoETBZx2/VjsMMdPatAkmmVmabS0sbF49YSM4TyYGqu/dlRiOiATKfYrIRQvkqZgF
         FNhPyPYPizxjoa567FrgFQC1rH4UOYBR/6JbOF/QG+9gsT40xa1h9Cg9JUfoxnvbNCbJ
         tt+Ntfhp9wHwEi+oSzGuFdv+gZvN6Lu3VsKJwkh5MV2fGUH6Et/Fh3vuoT5wu2x/gPes
         9RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9cayDzcVMP4WLKuDaSK5zDDTxeiv+ZcJ/644yHDAQU=;
        b=kM+buqno6Yo9AtQdEY1d8qSIFeE3iOk/X0xa71j9OuMXPGfLvsl8xKVRyYT3s6LvJ7
         taW8181exN4hS/K+AC0SwcbqNLN9BvuAZHB9GYDJEKBNzLHZblzP1BcwFcLiEz1DUW8i
         YQUjf6JSzmq9jKKM2pS9JxqLwpR6EM7rnIychnQcqT9GCUKJslcJNG9sNxD4EWhELp9I
         0lafyyPVXqYuLRWMyhIO4snP02NecQRpQ4hJwwC77MdfJTO2gAFuBuan4vHsCF6bIpTH
         K5F9a+Z35Pwb8dymlU5ApVGRQ/tQp2McjNEwhWtT5hPOtPUGSBgFsmsqty+tSVNR471p
         Lm7g==
X-Gm-Message-State: ABuFfohiKNmPGNJVETDNa8yQ4EBC3sCu2SyTslF7l3wJcdlVpYom/qmg
        +zooRrW1l+6ne5mZVS6U55wAaQ==
X-Google-Smtp-Source: ACcGV63uJidS+GmhWnM38K5DITO3VrIjqK6rlAcIC87XWJKvIJw2/hFuJDjHHHQ9tl5puLr6cFn/IA==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr19215642pld.131.1539880744703;
        Thu, 18 Oct 2018 09:39:04 -0700 (PDT)
Received: from shemminger-XPS-13-9360 ([167.220.105.188])
        by smtp.gmail.com with ESMTPSA id a1-v6sm32981925pfj.38.2018.10.18.09.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:39:04 -0700 (PDT)
Date:   Thu, 18 Oct 2018 09:39:02 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     kys@microsoft.com, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org
Subject: Re: [PATCH V2 3/4] vmbus: add per-channel sysfs info
Message-ID: <20181018093902.7b36c570@shemminger-XPS-13-9360>
In-Reply-To: <20181018171953.079f6fb6.olaf@aepfle.de>
References: <20170918034955.10913-1-kys@exchange.microsoft.com>
        <20170918035419.11062-1-kys@exchange.microsoft.com>
        <20170918035419.11062-3-kys@exchange.microsoft.com>
        <20181018171953.079f6fb6.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 17:19:53 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> Am Sun, 17 Sep 2017 20:54:18 -0700
> schrieb kys@exchange.microsoft.com:
> 
> > This extends existing vmbus related sysfs structure to provide per-channel
> > state information. This is useful when diagnosing issues with multiple
> > queues in networking and storage.  
> 
> > +++ b/drivers/hv/vmbus_drv.c
> > +static ssize_t write_avail_show(const struct vmbus_channel *channel, char *buf)
> > +{
> > +	const struct hv_ring_buffer_info *rbi = &channel->outbound;
> > +
> > +	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
> > +}
> > +VMBUS_CHAN_ATTR_RO(write_avail);  
> 
> This is upstream since a year.
> 
> But I wonder how this can work if vmbus_device_register is called,
> and then something reads the populated sysfs files before vmbus_open returns.
> Nothing protects rbi->ring_buffer in this case, which remains NULL
> until vmbus_open populates it.
> 
> A simple reproduce, with a modular kernel, is to boot with init=/bin/bash
> head /sys/bus/vmbus/devices/*/channels/*/*
> 
> Olaf


Good catch, actually the problem goes across all of the ring buffer sysfs files
so it existed long before that.

The channel ring buffer could be missing.

I am less worried about the open from init case, and more worried about issues
when channels are closed (as happens when changing number of channels on a net device).

As Al has pointed out for years, sysfs is riddled with dangling reference issues.

