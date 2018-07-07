Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F0AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7B216F8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7B216F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeGGP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:59:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753572AbeGGP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:59:26 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EACADBB;
        Sat,  7 Jul 2018 15:59:24 +0000 (UTC)
Date:   Sat, 7 Jul 2018 17:59:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
Message-ID: <20180707155921.GA26504@kroah.com>
References: <20180627220656.19298-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627220656.19298-1-javierm@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:06:56AM +0200, Javier Martinez Canillas wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.
> 
> Since drivers and devices are registered in a non-deterministic way, it is
> possible that a device that is a dependency has not been registered yet by
> the time that is looked up.
> 
> In this case the driver that requires this dependency cannot probe and has
> to defer it. So the driver core adds it to a list of deferred devices that
> is iterated again every time that a new driver is probed successfully.
> 
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
> 
>   $ cat /sys/kernel/debug/devices_deferred
>   48070000.i2c:twl@48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
> 
> This information could be obtained partially by enabling debugging, but it
> means that the kernel log has to be parsed and the probe deferral balanced
> with the successes. This can be error probe and has to be done in a ad-hoc
> manner by everyone who needs to debug these kind of issues.
> 
> Since the information is already known by the kernel, just show it to make
> it easier to debug.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>

This doesn't apply to my tree anymore :(

Can you rebase and resend?

thanks,

greg k-h
