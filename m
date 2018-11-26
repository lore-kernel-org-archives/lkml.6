Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56220672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1NWKqr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB56220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKZRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeKZRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:50:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E6B20672;
        Mon, 26 Nov 2018 06:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543215434;
        bh=1ujLcqYoIvHqA/sSs0KcZ+gJjiBWa+BS8cGhuk7+PfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1NWKqr9adJzEKuvI7GCVEdT4wImI8swORG1q5p6jUdX7TzUX9DLd4Mall+dE9Kgb
         e744SkYZweqs4SQMHGqa7RyiX2l9ySIhRMOBneXFvrTDm4CVGt6a6A0OMTLaHz++qj
         +24eROgTb6o44OMS9+PdgPYOywBMa7mNVElJYJMM=
Date:   Mon, 26 Nov 2018 07:57:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nimrud <amanoeladawod@gmail.com>
Cc:     akpm@linux-foundation.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-ID: <20181126065712.GB9680@kroah.com>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126034734.9423-1-amanoeladawod@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:47:34PM -0500, nimrud wrote:
> This patch adds an option to compile-in a high resolution and large
> Terminus (ter16x32) bitmap console font for use with HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf (size 16x32)
> with the help of psftools and minor hand editing deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>

Also, your "From:" line on your email does not match this name, so that
needs to be fixed before we could take the patch :(

thanks,

greg k-h
