Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84859C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5186920823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548173342;
	bh=QWn9JPdaiwqvfBJhe9HTXWa1i/vBnpqXyOr4SEkb4X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cKGWDaDwpSWdhHlUZ6Paqb6Kp13GK08OJdOTWnYBCeIE1wzWoKh64PVwLsWpZin0+
	 zVPoEKAcVu7GGmOK3CKojX5I7E93LAaeRQnzM8MYfpAJ+WlZ/4TLVocnq2ddP+dLVP
	 FYdeGQ6sIUlz8fh+X9oY4oUHcsN6Uy0umdFpDJ+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfAVQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbfAVQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:09:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FD120823;
        Tue, 22 Jan 2019 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548173339;
        bh=QWn9JPdaiwqvfBJhe9HTXWa1i/vBnpqXyOr4SEkb4X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWhfxlUVWoufOSgh8ZpNhIMv4Cdy18dpW17t7zqjd4csG1NbnpttFzQ+6cKiFTdCn
         qcfBYxfcyIt1JXZCm3Vy9kdoHWQU3WytsUEgsPONHHnfLPINLElOSMw3sI3rZcRrdL
         kibLXI/jKNwv+GbKnIyn82JG1g8Z+CzZYo5SPCow=
Date:   Tue, 22 Jan 2019 17:08:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: no need to check return value of debugfs_create
 functions
Message-ID: <20190122160857.GD21349@kroah.com>
References: <20190122152151.16139-7-gregkh@linuxfoundation.org>
 <20190122155606.GB7579@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122155606.GB7579@sirena.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:56:06PM +0000, Mark Brown wrote:
> On Tue, Jan 22, 2019 at 04:21:06PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> Given that all the rest of the function is doing is further debugfs
> operations and when it fails people trying to use the debugfs do welcome
> some diagnostics I'm not sure that's particularly helpful.

The only way it will fail is if we are out of memory.  And you are in a
bigger mess then, no one cares about debugfs calls, just make them and
move on, you should never care about the result of such a call.

thanks,

greg k-h
