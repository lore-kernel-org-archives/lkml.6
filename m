Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CB720859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsxGiD0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfBTSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:54:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36006 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfBTSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:54:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id q11so18388146lfd.3;
        Wed, 20 Feb 2019 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JV6Cyl6pCK3iK5vDBwetgD0gngkjKzAduoHOCuYNJ78=;
        b=VsxGiD0S0pxySvBsLu+eOVTSjppiLdiq6f1fv5WgclWvnDkrjdXgtmBf3aPyNxnvRB
         h31bDX0U+WUB1jFVRgygi/X7clV1bw5SI/D/IYFrY7dQJKoFXOOmIO98Dy05fXjzwZLI
         ByXuud6os09NESyR1qLksvAorgoOSLCguYAZLtMq+oirk5BgGqrnjs13Y8l71hYc3DLB
         VXgD2ygcC7nOf+N5Ho9B9LadhUbzkKWGL9KagZxKML0fYMgQpzXcti2cAnrivhb6eMw2
         XGep0j6N/zQRhIxVQkVvqGuJ+0CaRYhKuPyLH+3bKIM4qc7xlDb/mVf8yKVJbFqJFx98
         AuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JV6Cyl6pCK3iK5vDBwetgD0gngkjKzAduoHOCuYNJ78=;
        b=FHP6h0/srjb8QG9tLhoetusE1dx/oyCwDL8in7O7W0Pb837O1eSYz4vfvP1waPh0Ff
         H4R/xWtjxsIv9NBAloRScbNhsmBhEYWwATO8dUN8BQkNSLE9u25f9c1vxzCatn/YEluR
         bAdFwJ/z0I9uox8Q2OXILdCjv5HUlH+fem/CBNrKsi0JLKhAPDnc00RQiD8rBi3Vs36P
         jgkrlnpwuH9GCAaKMx6NKvYP1AkoZ14sV9PXvp5G2DmodtV4dR2sVBxIJFLNygLkwE9h
         ytaNCu/RjNZeJa5MPdM/QXFZUy87a0c+KowdWzxvmaCviXKKkDVFlIgYPMpn19uaVOQE
         SvCw==
X-Gm-Message-State: AHQUAubGXiEBiV4z1kI9Uvgy+tNR+4D27w8YKvH3TsLqYSMHCUtr/TpI
        wftYlEjiAxHPsZnnVIC1lLE=
X-Google-Smtp-Source: AHgI3IYGWhV+BIyJve2umAoZStx2FcQYWuDHiW+7DcNlnvlIVAJCI3WuFTmVArGWn8CXwqZuFZCDTA==
X-Received: by 2002:a19:d250:: with SMTP id j77mr21097138lfg.21.1550688879460;
        Wed, 20 Feb 2019 10:54:39 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id o14sm2213982lfl.41.2019.02.20.10.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:54:38 -0800 (PST)
Date:   Wed, 20 Feb 2019 19:54:14 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: fix attribute kernel version
Message-ID: <20190220185412.GA1793@arch>
References: <20190215195759.31304-1-tduszyns@gmail.com>
 <20190220111632.4e523380@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220111632.4e523380@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:16:32AM +0000, Jonathan Cameron wrote:
> On Fri, 15 Feb 2019 20:57:59 +0100
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> > 4.22 has never existed and this change was actually added to 4.21
> > hence fix the numbering.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> 4.21 isn't going to exist either.
>
> Current is targeting 5.0.

Right, my bad.

> https://elixir.bootlin.com/linux/v5.0-rc7/source/Makefile
>
> Hmm. Shy Crocodile :)
>

Catchy name.

> Jonathan
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-sps30 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > index 143df8e89d08..bef52f3e47bc 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> > @@ -1,6 +1,6 @@
> >  What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
> >  Date:		December 2018
> > -KernelVersion:	4.22
> > +KernelVersion:	4.21
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Writing 1 starts sensor self cleaning. Internal fan accelerates
> > --
> > 2.20.1
> >
>
