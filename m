Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF63C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6452173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546877951;
	bh=7i7bSf3+28hwU+JQF6kEntEoezVRfYszvSYXYHYr/CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IAGOFidT44jqJJKhGTUetXBord5JGuiN73KhFp5fN2OwnuD9rCgBOzjK64Sxn2INO
	 JkDsLyLsz1zumuV2qzH0Xbj0iLuSaUFap57ZsZmTnhOLQ6awqEGRPp6fuBCuBnKI0C
	 rXtb92teL+AFPHw8ogW6hS5tTu9DKqEADp8BWkqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfAGQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfAGQTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:19:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF8D2147C;
        Mon,  7 Jan 2019 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546877948;
        bh=7i7bSf3+28hwU+JQF6kEntEoezVRfYszvSYXYHYr/CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZJ2nRoD7PjVq+ybfZHAgNL7zL4ontvQB7ZI+QwQXxMMeLsfd4Tgd1D25hEzZjWzq
         jmmU4OFVmVxWkLU0EthiuxC+t0Rj9KN1mLdSYY+RMQtJnHsypM89hADjbvYlkgvnCa
         X9+rRJCF6McI1M/gcProGW5qgucq5AJ6nUXffXEo=
Date:   Mon, 7 Jan 2019 17:19:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] USB: host: ehci: allow tine of highspeed nak-count
Message-ID: <20190107161906.GC2292@kroah.com>
References: <20181114171315.27549-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114171315.27549-1-ben-linux@fluff.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:13:15PM +0000, Ben Dooks wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> At least some systems benefit with less scheduling if the NAK count
> value is set higher than the default 4. For instance a Tegra3 with
> an SMSC9512 showed less interrupt load when this was changed to 14.
> 
> To allow the changing of this value, add a sysfs node to each of
> the controllers to allow run-time changing.

That's going to be a pain, why can you not just figure this out at
runtime and adjust it that way?

Also, you can't add a sysfs file and not also add a Documentation/API/
update :(

Can you fix this up to work without needing manual adjustments?

thanks,

greg k-h
