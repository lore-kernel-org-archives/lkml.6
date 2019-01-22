Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE03C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D157B217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170674;
	bh=xfrjMJYlvJzXwHbvlsBZunnBkihNX/e601fqkXZ92Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bK3sxPUmPbZaNL/F8aQuHIWFA1VndryBjNhBSQm/fgn6nppUfl/W++OMSHrhzZXVO
	 UGBnTVnwZ9iVeuIVLV5feHY0oD4lTKXfcSRwdM2Zg2wB72xzwD6uZwT3WxuepVrMBA
	 WSAhk8mI/RAIgONs84WBqmgnEc/utjww6ZD4jVS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfAVPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbfAVPYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B793217D6;
        Tue, 22 Jan 2019 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170669;
        bh=xfrjMJYlvJzXwHbvlsBZunnBkihNX/e601fqkXZ92Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSfCb3I3tb0fFTHxRO/iW7Ngnpl9/cOWPRSEw2ulKFdi+shhlVVGAFBNp+J7jIUJK
         bsXIccwzddOnmQ5AhOAibHY4hGtjCFALc/JqUuoMW5GcvK3TjHvCfu8drVEezm4Wk7
         A9R80YYTHVQh2t2vi/E/J33V7L0grEXO1Zl6GLNQ=
Date:   Tue, 22 Jan 2019 16:23:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     thomas@winischhofer.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tty: sisusb_con, convert addr macros to functions
Message-ID: <20190122152322.GA17676@kroah.com>
References: <20190122151202.18152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122151202.18152-1-jslaby@suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:11:59PM +0100, Jiri Slaby wrote:
> Convert SISUSB_VADDR and SISUSB_HADDR to inline functions. Now, there
> are no more hidden accesses to local variables (vc_data and
> sisusb_usb_data).
> 
> sisusb_haddr returns unsigned long from now on, not u16 *, as ulong is
> what every caller expects -- we can remove some casts.
> 
> Call sites were aligned to be readable too.
> 
> Use sisusb_haddr on 4 more places in sisusbcon_blank and
> sisusbcon_scroll. It was open coded there with [x, y] being [0, 0].
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/usb/misc/sisusbvga/sisusb_con.c | 78 ++++++++++++-------------
>  1 file changed, 39 insertions(+), 39 deletions(-)

Subject says "tty", yet this is the USB driver.  typo?

thanks,

greg k-h
