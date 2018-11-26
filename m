Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D2B20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0NIA8cW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D2B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeK0GB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeK0GB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:01:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF3C20660;
        Mon, 26 Nov 2018 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543259214;
        bh=+MBMhlaHQL6BF6DWR6Y3zqmLzyN0GD2H2COiqWXqEEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NIA8cW8J528wbCEFjBxOEpQbfdbv54yIhyug4LgjOlu2brjkIr2kISt0Twq+Gzsd
         D81FMl09QQPNZDc+KLI7oE8xC1vrJNeVcc+iC0gOXZnyv1FLdN8UzG7MKJo3qdhFHy
         s5+V+j0sCoxG57ll6dBZUnvCUJvTHPbiXoQ1/y/U=
Date:   Mon, 26 Nov 2018 20:06:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
Message-ID: <20181126190652.GB32595@kroah.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114224921.12123-5-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:49:17PM -0700, Keith Busch wrote:
> System memory may have side caches to help improve access speed. While
> the system provided cache is transparent to the software accessing
> these memory ranges, applications can optimize their own access based
> on cache attributes.
> 
> In preparation for such systems, provide a new API for the kernel to
> register these memory side caches under the memory node that provides it.
> 
> The kernel's sysfs representation is modeled from the cpu cacheinfo
> attributes, as seen from /sys/devices/system/cpu/cpuX/cache/. Unlike CPU
> cacheinfo, though, a higher node's memory cache level is nearer to the
> CPU, while lower levels are closer to the backing memory. Also unlike
> CPU cache, the system handles flushing any dirty cached memory to the
> last level the memory on a power failure if the range is persistent.
> 
> The exported attributes are the cache size, the line size, associativity,
> and write back policy.

You also didn't document your new sysfs attributes/layout in a
Documentation/ABI/ entry which is required for any sysfs change...

thanks,

greg k-h
