Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A0FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F1B20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYf9XT2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F1B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeKJCoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbeKJCoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:44:23 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19912081C;
        Fri,  9 Nov 2018 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541782978;
        bh=kNNy2Sm5KbxvdaNop0Svhi0ijerAG1rf13f5IyrIySk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYf9XT2CKAsop/Nqqdt+Uq+9xLDKdZpJ6rFwqJMhSJFB0tkaVf8ZrdzWewPoF1342
         C9ahu6grvK3FuHyrX5Be+tO0tQk21lQzc2oydFaG85puZ4dzvIXQUbzu/cI3PgmA/z
         yV271TkK/aYN+B7qacy0IroIsDOjAhWRRgUOAueg=
Date:   Fri, 9 Nov 2018 09:02:57 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/1] serial: imx - Add dma buffer confugration via
 sysfs
Message-ID: <20181109170257.GA14151@kroah.com>
References: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
 <20181015140118.GA16234@kroah.com>
 <1539764425.3694.1.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539764425.3694.1.camel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:20:25AM +0200, Fabien Lahoudere wrote:
> Hi Greg,
> 
> On Mon, 2018-10-15 at 16:01 +0200, Greg KH wrote:
> > On Thu, Oct 11, 2018 at 11:25:03AM +0200, Fabien Lahoudere wrote:
> > > In order to optimize serial communication on imx53 and imx6, we may
> > > need to tweak DMA period and buffer length per period.
> > 
> > Why can you not just automatically determine this information?  What is
> > userspace going to know that the kernel can not just learn now?
> > 
> > Having tunables is nice, but it is even better to not need them at all.
> 
> I agree that it is better to let the kernel do the configuration.

Great!

> However in our case we use several serial communication for different device
> and one of them need to tweak that configuration to get small data with a better
> period. However having this parameter for all serial port implies a bigger number
> of interrupts for others too.

Why can you not dynamically figure this out?  How are you figuring it
out "by hand" today in userspace?

thanks,

greg k-h
