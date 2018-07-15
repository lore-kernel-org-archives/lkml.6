Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF5720882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWlVnac9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF5720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeGOIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 04:04:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43750 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeGOIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 04:04:20 -0400
Received: by mail-lf0-f66.google.com with SMTP id m12-v6so30051334lfc.10;
        Sun, 15 Jul 2018 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yRvnPedgbgbF1WZd0OSHNfkodvpFzXuGxAjQO6mdsgM=;
        b=cWlVnac9sL8nXQyaKhJ6mf7AgUGurfHnglzS3o2b6fGrRq7MkS5F99ayOhjnEwIRgA
         2x/SxEhEXwEZz3W+2fcmYWIl2AvSFEHGn65ANIIYLxIleQwlFlzpi0eH+8HQcicC+YIJ
         qHGG9nuol4kruSs+bblvWuKned9gvLkP1ZyGu1ybw94JQembquh1B9qQet5N+jcEmBP+
         +1hve4i9FiysgwHMr6rMTsUphfqsY6VweVnlab7eTIDkCa9RDEdLMkI9bdYIoe6AaNqY
         K4b1mcEWgHJ+ZiZw65UPxTRAyEqP4bhGPUkgNEmVYPFP1qUrBCiaS8ByJatSPjbv2Hx8
         pG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRvnPedgbgbF1WZd0OSHNfkodvpFzXuGxAjQO6mdsgM=;
        b=pQ3fGDcpIt7biO2Fmo2V3EBgXkTWAKoJAJzSkomrEFuNY2eYtxPorbPvfEu9GthbRD
         N7FTbAhTTLwoe7Y67EE/gRoJOVSx3INjAX/eylKMmy68W0nup6h9pp5XT9CDAMURm+Yx
         /CnNlNH5CR4Ddfdo9A/feqoRwmidN6j+PdyYiYVT8VCxYdBdl8rZFq3zW6X++TUzqJzH
         VYgQ6xFVgDlC5bha0blF1cWxZnmW3LbIOx6DEIiqwqGjPx392TCjdXbfJSRqA+E9C7a9
         RbaqinAZYjQB6V4cje5dt8nrGM1HXG+wPhaF5H070NRCVN/WKeeB2q2keLP7+PzPsOkk
         M9xg==
X-Gm-Message-State: AOUpUlFoKTFcuB2SFcJDQc5b4dI/svmTirjRVKWXNFasWcj7AlD+aBlD
        YGWAUd7y+6h1MsKvph/CFYw+wQ==
X-Google-Smtp-Source: AAOMgpc4orgK6QlNrJ8pu7KjEynizM0gwAYOlJHgwkgEsJm1ydY5QS20KnAakTt5tIdt6HfQPwQPWA==
X-Received: by 2002:a19:e4c1:: with SMTP id x62-v6mr8727023lfi.76.1531640538554;
        Sun, 15 Jul 2018 00:42:18 -0700 (PDT)
Received: from gmail.com (c-2ec26dfb-74736162.cust.telenor.se. [46.194.109.251])
        by smtp.gmail.com with ESMTPSA id o11-v6sm2071624ljh.34.2018.07.15.00.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 00:42:17 -0700 (PDT)
Date:   Sun, 15 Jul 2018 09:42:25 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Message-ID: <20180715074225.GB15123@gmail.com>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com>
 <20180714085109.mbhk6aybpjsbuq6l@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714085109.mbhk6aybpjsbuq6l@penguin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 08:51:09AM +0000, Dmitry Torokhov wrote:
> On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> > Hi Alexey,
> > 
> > Good catch!
> > 
> > On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > > anywhere in the driver.
> > > 
> > > The patch adds one to error handling code and to pxrc_disconnect().
> > > 
> > > Found by Linux Driver Verification project (linuxtesting.org).
> > > 
> > > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > 
> > Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> 
> Hmm, the biggest question however if we need to "take" the device, as I
> do not think interface can outlive the device, and whether we actually
> need to store it in pxrc, as we only need it during set up, as far as I
> can see.

Yep, the device is only used during setup.
I interpret the comments for usb_get_dev() as you should take a
reference count on the device even if you only use the interface, but I
could be wrong.

From usb_get_dev()::

	 * usb_get_dev - increments the reference count of the usb device structure
	 * @dev: the device being referenced
	 *
	 * Each live reference to a device should be refcounted.
	 *
	 * Drivers for USB interfaces should normally record such references in
	 * their probe() methods, when they bind to an interface, and release
	 * them by calling usb_put_dev(), in their disconnect() methods.

I can fix the driver to not take the device if that is what we want.
If not Alexey want to fix it of course, it is his catch :-)

> 
> Thanks.
> 
> -- 
> Dmitry

Best regards
Marcus Folkesson
