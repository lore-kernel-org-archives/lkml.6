Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C350C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808520672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zWaeplGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E808520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeLELCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeLELCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:02:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA9F20672;
        Wed,  5 Dec 2018 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544007727;
        bh=EVR5PqemlrMfLkbI5SPuiM9ZlhcV0dBm4rcpjaoCMNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWaeplGNQm/fm8Q/Q8ymHBV+g4hVmGtkowQEz7P3/cIAI25Z5ms/zQBIHgykWreQ4
         PbEInNz5oVpa2nHZX5ixqouEf2OVC88s0QOAY8ptY4aEocxzRQdyA3l5kRXIIqMBtV
         0lyiDtjka/q6GIeMku1h6jrKgROB+DgdCnf0SWz4=
Date:   Wed, 5 Dec 2018 12:02:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amanoel Dawod <amanoeladawod@gmail.com>
Cc:     akpm@linux-foundation.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-ID: <20181205110204.GA17143@kroah.com>
References: <20181126092115.754-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126092115.754-1-amanoeladawod@gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:21:15AM -0500, Amanoel Dawod wrote:
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

Can you please run scripts/checkpatch.pl and fix up the issues that it
finds in this patch.  It's a lot:
	total: 1792 errors, 2058 warnings, 2127 lines checked

thanks,

greg k-h
