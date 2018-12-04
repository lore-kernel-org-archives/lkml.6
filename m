Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A43C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215C120672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZvJD6FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215C120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeLDP4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:56:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40509 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:56:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so8502571plq.7;
        Tue, 04 Dec 2018 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EXje32CS1sesbGGDolcJfJAsuFY1fojEpfFYBgrkW3o=;
        b=QZvJD6FNXOFDSVuhanryykB8yUHKz4DvyC6BBCwUUH1/Pa7Yp0NVMJQfD4v1HXnqxV
         PmyX43Jkq+L7MtYExs8pn1v+/gm5pRvLfaTpz4T9MA1HSsb1bqBXg0V1Mn59duHIhQ7K
         HemSoDQ6idxKuJovScOr9g/1Ntuu2sZc/L9NFphU5lhSXWEQiN5wxnM4DfyGAREFbu07
         wKEPL/sNB/hdHWStINnXznMjM/oqfU9CXraY2aH2F6AsLKUAZiLIvKv9vk8wV9yq3q4N
         XDz0z8+hKG6mdFVSoiIprMVk4o4/Hkpp2quCm445T2Erfa9xNK2cDrWOAqub7dUUpHnr
         AoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EXje32CS1sesbGGDolcJfJAsuFY1fojEpfFYBgrkW3o=;
        b=aICHoIigf0+iAKes5yYgBhmSERYwf6qdXyQC7q26AZN3L/g3zqtLAfuAeOe+63wIYJ
         OrG5VDvJ7PgqRbF1APwDb//goOvaleZA4EwGk8o52qeMPjXBqNpgIUzwTke0AHOlyPhZ
         5WweWtoL/w7VgCZhzvB4pn8HJJ6fXEF4bmmZaLdWjfhklGI93ZEI5Z+htIxFnWkAF21C
         EJ91M9sLog6S+0CPRNYygWJFeRTfRxxMhYpA5XuONdhsS2w5BhC174do9tkbip7FO1Py
         UAczpJ8QwvOqz0COnsBVwdh8CLFJRZafW8B/zOCIvf/iXIclWGDEKaZjOMEXy7a4rJNC
         yWwA==
X-Gm-Message-State: AA+aEWY5PyPDw1e+NyuosIhGgpn59ynAPSKAoEEBKvJR32YiPpHJ9fgC
        1PcV4bUorC1IS/tOk6JYphc2ASMU+MrEtw==
X-Google-Smtp-Source: AFSGD/UwJVnCWwRtPQCcXllCcmWOqvvX88TGxbzsuy0t2HYhBoSwojwOLmTCdJIKVYNnfKcuYHtMRA==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr14812653plb.26.1543939002710;
        Tue, 04 Dec 2018 07:56:42 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w10sm18175287pgi.81.2018.12.04.07.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:56:42 -0800 (PST)
Date:   Tue, 4 Dec 2018 21:26:35 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/26] Staging: fbtft: flexfb: Switch to the gpio
 descriptor interface
Message-ID: <20181204155634.GA16146@nishad>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
 <0bc27a5c4f06e50f9cc2d568c6ce5f983dc84925.1543142440.git.nishadkamdar@gmail.com>
 <20181126101308.GI3088@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126101308.GI3088@unbuntlaptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 01:13:08PM +0300, Dan Carpenter wrote:
> On Sun, Nov 25, 2018 at 04:56:29PM +0530, Nishad Kamdar wrote:
> > This switches the flexfb.c to use GPIO descriptors
> > rather than numerical gpios.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/fbtft/flexfb.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
> > index 2af474469e7d..c5fa59105a43 100644
> > --- a/drivers/staging/fbtft/flexfb.c
> > +++ b/drivers/staging/fbtft/flexfb.c
> > @@ -9,7 +9,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/vmalloc.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/delay.h>
> >  
> > @@ -521,7 +521,7 @@ static int flexfb_verify_gpios_dc(struct fbtft_par *par)
> >  {
> >  	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
> >  
> > -	if (par->gpio.dc < 0) {
> > +	if (!par->gpio.dc) {
> >  		dev_err(par->info->device,
> >  			"Missing info about 'dc' gpio. Aborting.\n");
> >  		return -EINVAL;
> 
> We changed par->gpio.c from an int to a pointer in patch 1 so we have
> to update all the checks as well in the same patch.  Otherwise it breaks
> `git bisect`.
> 
> (I don't know this code well.  But it just feels like it has to be
> breaking git bisect just from from glancing at the patches.  Perhaps I
> have misunderstood).
> 
> regards,
> dan carpenter
> 
Ok. I'll merge them into one patch.

Thanks for the review and the pointer.

Regards,
Nishad
