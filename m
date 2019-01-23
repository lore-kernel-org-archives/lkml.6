Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD69621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548241257;
	bh=kgWdHKLafITQDbPlhqKNeuiHX8tprv5IsOKeJJWKoGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OBD8n05Eu9qRW1OL5Bgrv2WwBFtBbX58RRznhNUrR/MK5LLKKJDsIu9LiIvaHEdQO
	 kc4L671Sa+5s3LOiH/qJW3/3ESSlleCkHE827IrV+eO+qsevCg2RZ5+7vEYWROv6ep
	 Lzr+LpdqBlsy6j3uAzwfOlafioT3okQo9HLEY5OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfAWLA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAWLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:00:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B440121019;
        Wed, 23 Jan 2019 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548241255;
        bh=kgWdHKLafITQDbPlhqKNeuiHX8tprv5IsOKeJJWKoGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrqjBg6L7gnuHqgSKaRyaGIXdtN8pZ7+znYtsCU1DkTbVketJHZpUyRszonA/SjC3
         SZ+f17rii2jqa1yCqyKyCjWoJEeEYjREpd2xLazj7IIgcL8hvTNmrWRzMSrEdRK1NY
         6THm3b/YCWMMV4F1ejaPGIDpxddQy2MUotr/QtKs=
Date:   Wed, 23 Jan 2019 12:00:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah@kernel.org
Subject: Re: [PATCH v3] selftests: add binderfs selftests
Message-ID: <20190123110052.GB22520@kroah.com>
References: <20190117114854.15132-1-christian@brauner.io>
 <20190123105457.k7oobylgq6rwka55@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123105457.k7oobylgq6rwka55@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:54:58AM +0100, Christian Brauner wrote:
> On Thu, Jan 17, 2019 at 12:48:54PM +0100, Christian Brauner wrote:
> > This adds the promised selftest for binderfs. It will verify the following
> > things:
> > - binderfs mounting works
> > - binder device allocation works
> > - performing a binder ioctl() request through a binderfs device works
> > - binder device removal works
> > - binder-control removal fails
> > - binderfs unmounting works
> > 
> > The tests are performed both privileged and unprivileged. The latter
> > verifies that binderfs behaves correctly in user namespaces.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey Shuah,
> 
> If you're ok with the patch in its current form, can you please make
> sure that this still lands in 5.0? If at all possible I'd like to have
> all ducks in a row and release binderfs with selftests and everything.
> :)

I can take it in my tree with the other binderfs patches if I can get an
ack from Shuah.

thanks,

greg k-h
