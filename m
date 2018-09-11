Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCA2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D8F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D8F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeIKPCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:02:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:02:15 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 471C6D33;
        Tue, 11 Sep 2018 10:03:39 +0000 (UTC)
Date:   Tue, 11 Sep 2018 12:03:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911100336.GA3822@kroah.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <20180911084548.GC4185@dell>
 <20180911090132.GB25161@kroah.com>
 <20180911094430.GG4185@dell>
 <743b5545-e942-b6f4-4ce6-8e10950a05fc@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743b5545-e942-b6f4-4ce6-8e10950a05fc@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:56:49AM +0200, Nicolas Ferre wrote:
> On 11/09/2018 at 11:44, Lee Jones wrote:
> > On Tue, 11 Sep 2018, Greg KH wrote:
> > 
> > > On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
> > > > On Mon, 10 Sep 2018, Lee Jones wrote:
> > > > 
> > > > > Enjoy!
> > > > > 
> > > > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > > > > 
> > > > >    Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> > > > > 
> > > > > for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> > > > > 
> > > > >    tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
> > > > 
> > > > Due to a comedy of errors, I'm voiding this pull-request.
> > > 
> > > Um, I can't do that as my tree can not be rebased :(
> > 
> > Oh dear. :(
> > 
> > > I can take follow-on patches, so I will go apply the patch posted so
> > > that my tree builds again.  I recommend you just apply it as well.
> > 
> > What a pickle.  As per my last email, it looks as though this set was
> > applied under false pretences.  The MFD patch which was carrying my
> > Ack was doing so incorrectly.  The author mistakenly applied it to the
> > wrong patch.  After re-review (actually initial review) I wish to NACK
> > the implementation.
> 
> What? We discussed this to the bone!
> 
> Radu followed all the recommendations, collected all the feedback from major
> subsystems SPI and USART, resent the series again.
> 
> It was then forgotten. Wrong series was finally applied (which could trigger
> 0-day reports, I warn you)... and now we are discussing about the
> implementation of *v2* (we're at v12)!
> 
> > My suggestion would be to sit tight, rather than do anything rash and
> > see how this plays out.  After which we can fix your tree.
> 
> Come on, Greg's tree is fixed now. We can catch-up with v11..v12 changes
> with patches and cleanup the mess together.
> 
> Just one misalignment with one patch merged for v4.19-rc1, fixed the same
> day, cannot generate such a reaction after months of development.

I agree, my tree is now fixed, no harm done.  Just apply the same patch
to whomever also pulled it into their trees and all is good.

thanks,

greg k-h
