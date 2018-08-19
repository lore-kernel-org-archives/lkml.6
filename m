Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F41AC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473772145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="voiTHF89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473772145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeHSTck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeHSTck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:32:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E6620779;
        Sun, 19 Aug 2018 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534695640;
        bh=rRXTzX2VKhY+eeZuzijwFBCyuGeDfRImxuPQLzuumO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=voiTHF89gEtHhId0fA7Y/3i9yCV64Vp7vTlYbVL9nqTBell3GFPZlyhTpkEo9w9AA
         6NBTmdOefCgZAn4/HydcCHtxc0gNrgqbCwvzJlOnQkMR1tUokxyKfTZcxi1DtjSdGC
         8sKjVY8aLxSzIlY6fUYn/wc8KY7H7pMHjDeKVrr8=
Date:   Sun, 19 Aug 2018 17:20:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180819172036.5e8d6d28@archlinux>
In-Reply-To: <20180818153416.GA3543@gmail.com>
References: <20180815163852.GA4910@embeddedor.com>
        <20180815172700.GA29039@gmail.com>
        <64cccc17-ebfe-205a-6b2c-2a72aae765b0@embeddedor.com>
        <20180818153416.GA3543@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2018 17:34:40 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi Gutavo,
> 
> Sorry for the delay.
> 
> On Wed, Aug 15, 2018 at 12:50:10PM -0500, Gustavo A. R. Silva wrote:
> > Hi Marcus,
> > 
> > On 8/15/18 12:27 PM, Marcus Folkesson wrote:  
> > > Hi,
> > > 
> > > On Wed, Aug 15, 2018 at 11:38:52AM -0500, Gustavo A. R. Silva wrote:  
> > >> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > >> where we are expecting to fall through.
> > >>
> > >> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> > >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > >> ---
> > >>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > >> index 063e89e..d609654 100644
> > >> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > >> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > >> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> > >>  		switch (i) {
> > >>  		case X:
> > >>  			ec_accel_channels[X].scan_index = Y;
> > >> +			/* fall through */
> > >>  		case Y:
> > >>  			ec_accel_channels[Y].scan_index = X;
> > >> +			/* fall through */
> > >>  		case Z:
> > >>  			ec_accel_channels[Z].scan_index = Z;
> > >>  		}  
> > > 
> > > Hum, I'm not sure we are supposed to fall through here, even if it does
> > > not hurt to do so.  
> > 
> > Yeah. You're right. It doesn't hurt but is actually redundant. I think
> > the original intention was to break instead of falling through.
> >   
> > > I even think we can remove the switch and put that outside the for-loop,
> > > e.g:
> > > 
> > > 	ec_accel_channels[X].scan_index = Y;
> > > 	ec_accel_channels[Y].scan_index = X;
> > > 	ec_accel_channels[Z].scan_index = Z;
> > > 
> > > 	for (i = X ; i < MAX_AXIS; i++) {
> > > 		if (state->sensor_num == MOTIONSENSE_LOC_LID && i != Y)
> > > 			state->sign[i] = -1;
> > > 		else
> > > 			state->sign[i] = 1;
> > > 	}
> > >   
> > 
> > I like this, but the code clearly depends on MAX_AXIS. So, if MAX_AXIS
> > will be always 3, then the change you suggest is just fine. Otherwise,
> > it seems that adding a break to each case is the right way to go.
> > 
> > What do you think?  
> 
> Well, I guess it is a matter of taste after all.
> I don't think the number of axis will change, but just put the break in
> place is good enough.
> 
> Anyway, If we choose to not use the switch, I think we should remove the
> for-loop as well, eg:
> 
> 	ec_accel_channels[X].scan_index = Y;
> 	ec_accel_channels[Y].scan_index = X;
> 	ec_accel_channels[Z].scan_index = Z;
> 
> 	if (state->sensor_num == MOTIONSENSE_LOC_LID) {
> 		state->sign[X] = -1;
> 		state->sign[Y] = 1;
> 		state->sign[Z] = -1;
> 	} else {
> 		state->sign[X] = 1;
> 		state->sign[Y] = 1;
> 		state->sign[Z] = 1;
> 	}
> 
> But someone else may like to give their point of view on this change.

Looks like the right tidy up to me.  The original code was 'novel' :)

Jonathan
> 
> > 
> > Thanks for the feedback.
> > --
> > Gustavo  
> 
> Best regards
> Marcus Folkesson

