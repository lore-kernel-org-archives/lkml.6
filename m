Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1884C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774B620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQsLW93Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774B620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeKZTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeKZTHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:07:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA442086E;
        Mon, 26 Nov 2018 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543220074;
        bh=8ukvXMCc3Gu2teV2zI0yJSYwANp43x7k33vqpKeEbbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQsLW93Z9AEcD+H0HIeI3DyOR18pOPSV9CgefF5dUzfx3FA+Mwmbjv+IHigHDvCng
         TTCAJI3HOuQQzHykCAcvdHAhE9buiX1DzWty82X4M7cI3z0Q/9GySPKXibEFK8A65B
         ojBDOteHeCO+jJEk3PHEBKP+QyWhuQ2meJTqu02g=
Date:   Mon, 26 Nov 2018 09:14:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amanoel Dawod <amanoel@amanoeldawod.com>
Cc:     akpm@linux-foundation.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-ID: <20181126081432.GA30722@kroah.com>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
 <20181126065646.GA9680@kroah.com>
 <CACd_pd8o5vA85ppNp3hzm+awBvwq6VEONij6rHAPExmPfjaWRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_pd8o5vA85ppNp3hzm+awBvwq6VEONij6rHAPExmPfjaWRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Mon, Nov 26, 2018 at 03:09:31AM -0500, Amanoel Dawod wrote:
> Changing the name did not break anything. Pretty much I dumped the original
> .psf file to .inc
> format with new naming using psftools extracting the bitmap data. Then
> manually editing it
> removing useless header, leaving bitmaps data alone.

I did not refer to any name, just the #define that you changed.

> Do you mean adding it at end of lists with other fonts? if that's what you
> mean,
> no real reason, but just wanted it to be after sun12x22 always as in
> Kconfig.

You can put it wherever you want in the Kconfig file (but you should put
it at the end, as it is a new font.)  I mean the #defines, you need to
just add it at the end please, do not change any existing #defines.


> Please let me know if that must be changed.
> Now regarding "From:" line, please accept my apology as it my first time
> dealing
> with submissions and git send-mail. Should I re-submit the patch with
> modified subject line?

Not subject line, From: line from your email client.  And you need to
change the patch anyway before it could be added, so you have to resend
it :)

thanks,

greg k-h
