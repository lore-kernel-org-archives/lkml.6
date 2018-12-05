Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3172DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF9720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zsVR+TSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF9720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeLEHGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:06:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEHGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:06:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D16206B7;
        Wed,  5 Dec 2018 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543993583;
        bh=/cKE/U/SeujIjazvnCQW//Pd4Pi77WBrSOuKFuP72fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zsVR+TSL081M85lNrECrY18VKihCDCC7n8jBLbJG85EnTziiM/8Ge9HJlOkt9wFuA
         cyEUlO7yZrXwTPcI0vGh/39z0GSBh85piImPk/Rw+/BGqQCRXqZ3YHpo4vCeb8Fpk8
         xBfEdQYH2kx2L/0V80kLfAEHOnSie9zCZgTV+45c=
Date:   Wed, 5 Dec 2018 08:06:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ville Syrjala <ville.syrjala@linux.intel.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] hid2hci: Fix udev rules for linux-4.14+
Message-ID: <20181205070621.GE16346@kroah.com>
References: <20180620164240.6535-1-ville.syrjala@linux.intel.com>
 <20181204204117.14964-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204204117.14964-1-ville.syrjala@linux.intel.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:41:17PM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Since commit 1455cf8dbfd0 ("driver core: emit uevents when
> device is bound to a driver") the kernel started emitting
> "bind" and "unbind" uevents which confuse the hid2hci
> udev rules.
> 
> The symptoms on an affected machine (Dell E5400 in my case)
> include bluetooth devices not appearing and udev hogging
> the cpu as it's busy processing a constant stream of these
> "bind"+"unbind" uevents.

What is causing a "stream" of bind and unbind events?  This only happens
when a device is attached to a driver or removed from a driver, which is
caused by something else happening.  This should not be a normal
occurance, unless something odd is happening to your hardware?

thanks,

greg k-h
