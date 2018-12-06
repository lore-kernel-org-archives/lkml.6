Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C35C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479D520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544101126;
	bh=27/7qHG/+IjMquh7MizK4kDrJrvNbMniTgs4H1XSJ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jMP2Ya2j/uI8NahWMJhB/QRzzfBYLB7J5WxeCF5wmUkrRkVVmU9IV451qLHWYTjBx
	 B4XlwK5NSgQF3Mkd9Y9YCXJlmFO1wYqvAZo2AbxC+blhegV5JrNxTt45NSJan377vP
	 yXZq8Oegpaa92iyekkG+YV6fYT36gdYoffOEf/50=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479D520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeLFM6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbeLFM6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:58:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28EB20878;
        Thu,  6 Dec 2018 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544101124;
        bh=27/7qHG/+IjMquh7MizK4kDrJrvNbMniTgs4H1XSJ6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBSz+GOf2g2HkM4ubvwhSDo4b8SqSywuK5r/2RHDoQnZSzGcG6PF2cKG3PpfG/MeP
         klB038jmi0K6ukjI/iMF05Hlk8SNSztKcfl+5MsMm995EX3c8GarQsGXAS1Y/FO6QV
         AtH+0TZ0R/8rfeOBxapL99qwv1r74aV2YJ+aTkcQ=
Date:   Thu, 6 Dec 2018 13:58:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] driver core: platform: Respect return code of
 platform_device_register_full()
Message-ID: <20181206125842.GA1480@kroah.com>
References: <20181203182141.29720-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203182141.29720-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 08:21:41PM +0200, Andy Shevchenko wrote:
> The platform_device_register_full() might return an error pointer. If we
> instantiate platform device which is optional we may simplify the routine at
> removal stage by simply calling platform_device_unregister(). For now it
> requires to check parameter for being an error pointer in each caller.
> 
> To make users' life easier, check for an error pointer inside driver core.
> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - rebase on top of linux-next since the conflicting patch has been applied there

What conflicting patch?  This now doesn't apply to my tree.

Let me fix it up by hand...

