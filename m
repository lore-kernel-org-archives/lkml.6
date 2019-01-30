Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D213C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DDA21873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548836942;
	bh=Wggf9yNgigzGoIZcTHJiT05VJTlBrJGMll4+jbu8jLU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=rAaR5h6famfF+zDsQYtJ89KdTbP/6B2fuHW4/+u8bh0yMa8qhMXM5laOSWhFEDBBw
	 vpHInALqS0782Gkdhnrafn0OWAu4qFo3rR9zi1pNllhwQhPdHkQeXj44mJidKkhZzK
	 xmjWbgBbEODFfAWcKqTgVuzV/rMKml+WdGDjGnb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfA3I3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:29:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfA3I3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:29:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4CCD2184D;
        Wed, 30 Jan 2019 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548836940;
        bh=Wggf9yNgigzGoIZcTHJiT05VJTlBrJGMll4+jbu8jLU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=UV6hIDvLTUSEznHh7KOOy9QgifP1ZSYtCWN7GcAd3BLxQbiR23o4qSRN96qihY5VD
         3b8mcHIuT+2neyjKH8wWUcH+MwMiJ49P0lsQNRDk/ilXG4ALvPL8dKx/nLrFdpOWoG
         SCHjcN5TjxoRkhsggqUo8OCrOdblRevPFB2q41QA=
Date:   Wed, 30 Jan 2019 09:28:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty: ldisc: add sysctl to prevent autoloading of ldiscs
Message-ID: <20190130082857.GB24317@kroah.com>
References: <20190121162642.GA2944@kroah.com>
 <20190122000142.GB19379@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122000142.GB19379@mit.edu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:01:42PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Jan 21, 2019 at 05:26:42PM +0100, Greg Kroah-Hartman wrote:
> > By default, the kernel will automatically load the module of any line
> > dicipline that is asked for.  As this sometimes isn't the safest thing
> > to do, provide a sysctl to disable this feature.
> > 
> > By default, we set this to 'y' as that is the historical way that Linux
> > has worked, and we do not want to break working systems.  But in the
> > future, perhaps this can default to 'n' to prevent this functionality.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks for the review!
