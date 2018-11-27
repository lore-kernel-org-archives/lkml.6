Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19721208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1lptR2ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19721208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeK0Mk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:40:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38424 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0Mk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:40:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so14350655otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JG9hD0/bD7e0GP+xIufhYho5rtsvHt8UrJqbA5Em9zM=;
        b=1lptR2ffU+K+87U/6LvZcGcQGMmx83hqqBpDWifRCckBonbSQHB4LUqnymyz745WPg
         dm6oaQkFYajkYp/jJPAiwOE318i6YswoxSfehjAaIgxcBMHtYlCX9AKVQ7xj7iQ+XNJP
         wt/SRnnrWvHdixQt0lSbp2XQeZKm4hZUt5N3bhowrcs24MEm2TKWhefKL7URg3E1zUxZ
         O2Uj+Z8178TEdev6wATGunoHqUJTIUWzMUcGTyjKRWrl9UdF51/WQ4jOgY135SdIgvEa
         Dz9V173RiBrm8nUciK7ZSPuMhV3ScJDSFzPNb/B+GTNZEVuFQu0TZemNGWIkK/nSnizB
         1GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JG9hD0/bD7e0GP+xIufhYho5rtsvHt8UrJqbA5Em9zM=;
        b=lvRVPdISDnmmxcxcQ0P86TqaIHoll9EDdxlleN7r2YNDVJgqt+pHMcJi4i3T/oE1lN
         q02mwpMpw4yqVdCFm1a7+VICFj0IAbpXMxVN/syCPsGcPedpzxexrfY8I5ilj+KOXmCF
         hsLe0n/fX94ZedkTLBTEeFXSFjU6dniEx0d1ywtsZ7kPB4oVtkHjXvNgnMnPUgP0NWLv
         7ZwSY8f5anQp6X/5Z858CfhVy2wxQHbWYbM9R/WuQ5UfLcqfXL4Sgt8EgqJDxXbMYKRZ
         2/mamvRKPdOcNZbB7cCXLdrdoZ1TqpWf+mPDBFskH4Uu/3CfxJ91edDfO1PFIPBmpThB
         yfQQ==
X-Gm-Message-State: AA+aEWZKkPCxLeZnQEysWy3tZPbaaGJkOnvPuFHkw94ay3TDLeSiBPTE
        PmhTWtXuFqegZz33kASJ0zoPZfm3gXkEeYyLMqCTwQ==
X-Google-Smtp-Source: AFSGD/VvM6b3+k5nRKf90HGwbZImCoil6AkHVmfUF5P4Q7bQLhU4Hbo0Tg5WUkJSvb7Ti30nHnd825oX18Uc1uRNIu4=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr15458612otn.95.1543283056114;
 Mon, 26 Nov 2018 17:44:16 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041590.12967.4367086895437513524.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170041590.12967.4367086895437513524.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 17:44:05 -0800
Message-ID: <CAPcyv4h1HfFFD8f3attOhyR+bL_B_p7HRP5KXm+xjKc2nz524g@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 3/9] device core: Consolidate locking and
 unlocking of parent and device
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:06 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Try to consolidate all of the locking and unlocking of both the parent and
> device when attaching or removing a driver from a given device.
>
> To do that I first consolidated the lock pattern into two functions
> __device_driver_lock and __device_driver_unlock. After doing that I then
> created functions specific to attaching and detaching the driver while
> acquiring these locks. By doing this I was able to reduce the number of
> spots where we touch need_parent_lock from 12 down to 4.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

I was going to complain about the new addition of "This function" in
the kernel-doc, but there are other occurrences in the file so that
can wait for some future cleanup.

I missed the __device_driver_unlock comment that Jane caught.

With that fixed up.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
