Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1FB206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549628413;
	bh=XnlxXyijRmqrtT+0VZNQikf4A0qTv32kc4E1M722Wx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2RGDcUzlPoxtZquyJHln+P6vrvjR7IhgTyq+AZbSN4ojr2n90XnUpkXYsU3kcSLhT
	 jKhB+7EFYzmu89OmS9BAxmpIyXZRwD1pnLy6QjbGqp/sd4SFs/4GFerZXhP6R0GHxV
	 CJBcpUG2G6vihxthK0PD+KqDzkJ2K8R7MFClopCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfBHMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:20:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCE92086C;
        Fri,  8 Feb 2019 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549628402;
        bh=XnlxXyijRmqrtT+0VZNQikf4A0qTv32kc4E1M722Wx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiugXncEbshcVUzvc/7/cSqr+H4jhzoTM7viR7hLv9BnBjJf0eBXn1+kDijAwSInC
         DuYYcpleC3kvvwcrWUG4S+iBv4Q3+WibkD0Tq02Rz9eWRblFUlhb7+RpLPlj1PcrY2
         R5722FSeecjEBxklsCeCS6kiY1JAqodadcadnxNQ=
Date:   Fri, 8 Feb 2019 13:19:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/6] fieldbus_dev: support HMS Profinet IRT industrial
 controller
Message-ID: <20190208121959.GF23483@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <20190124201251.15159-7-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124201251.15159-7-TheSven73@googlemail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:12:51PM -0500, Sven Van Asbroeck wrote:
> The Anybus-S PROFINET IRT communication module provides instant integration
> to any Ethernet based LAN via SMTP, FTP, HTTP as well as PROFINET and
> Modbus-TCP. Additional protocols can be implemented on top of TCP/IP
> or UDP using the transparent socket interface.
> 
> Official documentation:
> https://www.anybus.com/docs/librariesprovider7/default-document-library
> /manuals-design-guides/hms-hmsi-168-52.pdf
> 
> This implementation is an Anybus-S client driver, designed to be
> instantiated by the Anybus-S bus driver when it discovers the Profinet
> card.
> 
> If loaded successfully, the driver registers itself as a fieldbus_dev,
> and userspace can access it through the fieldbus_dev interface.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>

This email address doesn't match your "From:" line in the email :(

You also seem to switch between 3 different addresses for this patchset,
pick one please :)

thanks,

greg k-h
