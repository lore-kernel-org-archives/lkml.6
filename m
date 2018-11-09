Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97474C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319B520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZnBSgjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319B520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeKJEt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJEt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:49:28 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC76320827;
        Fri,  9 Nov 2018 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541790453;
        bh=l+qY61RImmOkQALxNtKf2FH+7BsW/AdGVB5XXsYFbzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZnBSgjdqsJPE7Kod8JzX90SFR4cj1BmEG1fGpvWBQZOCgtNZHQPGG+Eo3eRpwIRE
         lVHspoXJSQHIuG416nqoLykjyiTG1SYzLtOsXE6bFiWlF1SgKr8Y2OoOE2D/D9g6Fa
         yvKVVLV/51KLxV4aEC6Xub2cKtWkbeDhx5v8LoJA=
Date:   Fri, 9 Nov 2018 11:07:33 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: remove the unused struct hcd_timeout definition
Message-ID: <20181109190733.GA14230@kroah.com>
References: <20181109183903.21607-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109183903.21607-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 07:39:03PM +0100, Christoph Hellwig wrote:
> No users of this type anywhere in the tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/usb/hcd.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 97e2ddec18b1..7dc3a411bece 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -235,11 +235,6 @@ static inline struct usb_hcd *bus_to_hcd(struct usb_bus *bus)
>  	return container_of(bus, struct usb_hcd, self);
>  }
>  
> -struct hcd_timeout {	/* timeouts we allocate */
> -	struct list_head	timeout_list;
> -	struct timer_list	timer;
> -};
> -

Nice catch, now applied.

greg k-h
