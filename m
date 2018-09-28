Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE41C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7DC20685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yzl2AJ6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7DC20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeI2ALX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:11:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43106 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeI2ALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:11:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so6105255oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilgNc6a8XgOReujnZrboH821Vl49z2OUd72qlpAXZhE=;
        b=yzl2AJ6GE7owhX/ixCGDKqtlefjGHnWSzhlCHTn1BaOfz6v4m687gcYPG5oVkA+1oM
         9hBor+LVefDkbKY19H0oEi09EircWaQiuTSNn2pdbkM1d5rhhHYSVZZzLeHmIUUk++M1
         MVVZjpQuYOD38vvsfKthTln81DdJp/fniCMNV762zBcXU4VhcO4gfgttymb+bWxp5/av
         U5VENL68vzGrbXLACoS8DdHj1hqD5V2XKjhYeYqjOBZRdOXu1bYZXYCfKABsGBRNMc/I
         WmKycjl/QlyPRclZoN/Td+5pPTt+OCsDISqGtJb2W/XWOXcgKHPN+g8NSOQXBlOro+9u
         i62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilgNc6a8XgOReujnZrboH821Vl49z2OUd72qlpAXZhE=;
        b=UZ0XAXXRo5r3abauLdLjYfefDYEsXgGtp3ESVrMxE4HFS3a/EG9HR/SO/w5s7g+W03
         r3icIbkU6SsVyDx2oKxGlRiuPMBAL/AJFmOUbmNIbvOH24GyA4oxlDDVlL99AXTlhdex
         lrQes9F3jGWtJGHGDPKS07207dzmdEtzcfHI0M1+b7OszS/gUKarDg3m471qeHHNd6TX
         6q+XrvE6yPYCYuJoLHaZ0APza/iZ1V48LxfKYlNb9a1bUH/KIpRtI5429CYumtGcxlci
         ockfmUjNIzczllFYerhj5LHVRh0mYlByXW3H1bopCVe+aRizrQdEA6rTeGUmNUNkxqNI
         bgqw==
X-Gm-Message-State: ABuFfoh9Zgh3iTf48VCk8Tx6ejJD7OCBRFgHRrGhMiDHJ5Ripp29TEnx
        w9IRbJSOjE6NiHY93wu0aCDhmOqJGAUljAOh0NdNNw==
X-Google-Smtp-Source: ACcGV63Wh1knkDtbvGIJQDcOFq8y3E4cJvIThpF2sWpbi6dnYJYcI6k8E3HPsKOt5LkpDpR4F/9+UrT4TeKpTra1aIk=
X-Received: by 2002:aca:4792:: with SMTP id u140-v6mr6661318oia.215.1538156791809;
 Fri, 28 Sep 2018 10:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180926214433.13512.30289.stgit@localhost.localdomain> <20180926215201.13512.55945.stgit@localhost.localdomain>
In-Reply-To: <20180926215201.13512.55945.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Sep 2018 10:46:20 -0700
Message-ID: <CAPcyv4gK59QVke3a3Lt4Ds_yYTLiDFjte8DcPqaH1pZ4otFrAg@mail.gmail.com>
Subject: Re: [RFC workqueue/driver-core PATCH 5/5] nvdimm: Schedule device
 registration on node local to the device
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:52 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch is meant to force the device registration for nvdimm devices to
> be closer to the actual device. This is achieved by using either the NUMA
> node ID of the region, or of the parent. By doing this we can have
> everything above the region based on the region, and everything below the
> region based on the nvdimm bus.
>
> By guaranteeing NUMA locality I see an improvement of as high as 25% for
> per-node init of a system with 12TB of persistent memory.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Looks good to me. This does have a dependency on the current contents
of libnvdimm development tree.
