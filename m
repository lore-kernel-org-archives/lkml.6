Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6CFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184D320854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Mugjt6nP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tD+MMYHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184D320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeIKNLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:11:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51481 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbeIKNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:11:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CBC521BBE;
        Tue, 11 Sep 2018 04:12:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 11 Sep 2018 04:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DA3G5M7zZpcZhR/mjjpWJW++YRI+/GFy6R3BfoKjqM8=; b=Mugjt6nP
        +rIRnH7mbYVlq3cr+3UcrHuVGbQwPpoyL+6KBjuUuZm+HPJ/E2So/ywYyYYb39TV
        /rKMzQt1IJvGbDEnpkGZA4Z5RJdY+DeiDJRoIYHtVlYnY2oiQjkirns6FCb89+uO
        I0MUV/kh1Cq4zRUQkJESg4CFfzhDDX3o+VSGFinokTMN+FJQvSqvAKlA8eqFr8IK
        ub+RH7lfQZW4th4mxQdr7d7zqlRslIOcpH3lPVobxxxqM4FSKwUccBX42g+2obf8
        dVBVP6KSphz7gy0Fgtg50sB+EMrx/RZ7bxFCne9WI1dbuRh14FxtIquJKoaiwAAf
        ndD2A8XxX94B6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=DA3G5M7zZpcZhR/mjjpWJW++YRI+/
        GFy6R3BfoKjqM8=; b=tD+MMYHlAB5XM0yi4RBdte2lKmQjgWJCGM9aFY9gqdVYc
        mFttLBL5PNfC2NJiBpXeXicKPMj2+Bxrv8qWjNb7Ea89uITsafAgmuDfYyev1kKY
        EuHfjLE1eYYo/SKVj+YmExAywOdGX5JVAg532TEicJm+NWzXuk7BCUIfqWUl45KG
        sePG7vx1HeJVPeeUn5O/pr4qvDDkq4cBTwcU2NeLYVwnFVt6+Xoa4WcL321wx3yz
        i4MxZG9ntKGJjxU6v/QBKH4ux3KPU2NpEB6zlv+nuXqw7dWdsSqRjb87DaXmlJhi
        PpI9mmUT4eZgN8N0FNa/0+m4twlVX5uF04m2ccX+A==
X-ME-Proxy: <xmx:BXmXW72eD78KK7mLOyaNO7WtW3iGJ21F7Er_1Zwe2gOG6xbGNGCUAA>
    <xmx:BXmXWyk-y-frV_9kc23w8rcKirFLqNhFBtTg1g6_ZzspYK5vVbIRDA>
    <xmx:BXmXW5pIIVwyjTcbt63Zl6pjSlk-iCjwzxyOscUGgS0rod-wneNNSg>
    <xmx:BXmXW-6asVXIljllbU3HGuSYqvC5T5dM2vH9fALaCcRRht__SpyT2g>
    <xmx:BXmXWxqL3-GeyRVDRJ_D6Q9zA8-U4BtfNQ2hlpjzeyrHuLRpOrk87Q>
    <xmx:BnmXW6-0KDwLbAmv_jknoHktFN3DO2stC5QzFBONDBOUJAjmAN_6cg>
X-ME-Sender: <xms:BXmXW2xe25sBFI2-AGNYSmBsbPqsc0mmNtYv7-nM21NAJV9sLphoXg>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 19A09E48AA;
        Tue, 11 Sep 2018 04:12:52 -0400 (EDT)
Date:   Tue, 11 Sep 2018 10:12:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <20180911081251.GC8963@kroah.com>
References: <20180911124743.558e33dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911124743.558e33dc@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:47:43PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the usb tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/usb/core/hcd.c: In function '__usb_hcd_giveback_urb':
> drivers/usb/core/hcd.c:1741:16: warning: unused variable 'flags' [-Wunused-variable]
>   unsigned long flags;
>                 ^~~~~
> 
> Introduced by commit
> 
>   ed194d136769 ("usb: core: remove local_irq_save() around ->complete() handler")

Ugh, sorry I missed this :(
