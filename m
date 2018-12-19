Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B45121479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545223776;
	bh=5iFCQrv+5iD4o+vbfBI1uJtwK3Y9lFpf8KbleWjt32g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2teQadKScXSyGG7AaBT6vwxLym/Bs8m70Is3vhpEe9FkXyMKaRZxuXskD4B4DlJO3
	 fFB8P1B49pN3UYhSXTqNWii/2NKMS3PGY9HinzQk3uDpmN+ch4Z0w1kv/WZGGwbH5L
	 zWGVtICwbiE6PUG26JT7ybuQ5KJ0bp2mF+Lvh6kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeLSMte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLSMte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:49:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D3320989;
        Wed, 19 Dec 2018 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545223773;
        bh=5iFCQrv+5iD4o+vbfBI1uJtwK3Y9lFpf8KbleWjt32g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSZQitGWEwJRLzXqJ/6mS9qFYI5ZOAnS70ipiYkrH2H5wjVZWtGJkAOdhKydk2/gs
         7pG62VHovrpfrFDig0TFYAA0dlH0fqGxm5Nwl/+22Aa7bn5gB8tCnQX29dLGyeYy3r
         ovEqIMr0NodH/s6s+j0tbo97mEwbzjoxVQup3Dk8=
Date:   Wed, 19 Dec 2018 13:49:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] sysfs: Disable lockdep for driver bind/unbind files
Message-ID: <20181219124930.GA22496@kroah.com>
References: <20181218201443.4950-1-daniel.vetter@ffwll.ch>
 <20181219123909.28754-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219123909.28754-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 01:39:09PM +0100, Daniel Vetter wrote:
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -327,6 +327,7 @@ struct driver_attribute {
>  #define DRIVER_ATTR_WO(_name) \
>  	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
>  
> +
>  extern int __must_check driver_create_file(struct device_driver *driver,
>  					const struct driver_attribute *attr);
>  extern void driver_remove_file(struct device_driver *driver,
> -- 

I'll edit away this last chunk when I apply the patch :)

thanks for making the changes.

greg k-h
