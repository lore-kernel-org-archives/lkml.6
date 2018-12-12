Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C632C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C07A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544611012;
	bh=jZ4xbfLaQLo9am49hxu9DWSWjyVtHnPGKIhyJQ6zf0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p2rec1fXX3xzr2f9Fb+kNPhxNxEMK00o1N4pjsS+90CJ0fdKy9cTW45zUsq/2Z+dz
	 6nlndxzPt9AkbFkyPJNwZ+hPJqmz3OsjwdYCv5Y3brY7Rb0z0PORgOBNP+/c9r7Kri
	 3usZJE0qPmt2LAXCRLr1gnsZd2Pegk3jtukqvTn0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C07A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeLLKgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeLLKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:36:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B139420849;
        Wed, 12 Dec 2018 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544611010;
        bh=jZ4xbfLaQLo9am49hxu9DWSWjyVtHnPGKIhyJQ6zf0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5ffa1R6QpyU3YLwVJHtOnMZoYp8JmXZuRa/arrTg68pNB5nOmnJwsr8VYuJQHwzN
         1OzFKLXHSMfK8KK1+QBeLo67H39yCvbGbBTvlwRYLLqrQrJfEpTNi30IikRKfGQXus
         9sfPguT/cSpvu7EbU/Bifh3IWUfEEelU6AsM8UNk=
Date:   Wed, 12 Dec 2018 11:36:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        david.kershner@unisys.com, eric@anholt.net, stefan.wahren@i2se.com,
        viro@zeniv.linux.org.uk, kernelpatch@126.com,
        natechancellor@gmail.com, keescook@chromium.org,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181212103648.GA24255@kroah.com>
References: <20181209162742.19767-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209162742.19767-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 11:27:42AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/staging/fwserial/fwserial.c           | 32 +++----------------
>  drivers/staging/greybus/loopback.c            | 16 ++--------
>  drivers/staging/rtlwifi/debug.c               | 23 ++++---------
>  .../staging/unisys/visorhba/visorhba_main.c   | 14 +-------
>  .../interface/vchiq_arm/vchiq_debugfs.c       | 14 +-------
>  5 files changed, 14 insertions(+), 85 deletions(-)


Please break this up into one-patch-per-driver, so that the correct
people can properly review it, and you don't send patches out to people
who have no interested in other drivers.

thanks,

greg k-h
