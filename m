Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952ACC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D95D222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550050477;
	bh=bpKIGqwfvriBDdJ2TvoYx9+jDU+Hk5PNkjSw9907Kxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWoCbaflKhIRnh2axDjjBivjsxrNOvJn7NV4uT8lSVPnIxpePR2nBpzABv400q72/
	 8m74OLE8XBJCjUW+oqQxBJIZzYOEL4jz+y6FJk/+qdUVd2DuS0ft+wUA1W7SWSpsNw
	 TnLM/XWnsFjF4RhkowAJhhU6kpU48XHpDxbT0xyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfBMJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:34:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40104 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfBMJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:34:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25-v6so1389820ljk.7;
        Wed, 13 Feb 2019 01:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zahirVm0TD8tFdJrSdrC51Xnvqieohwgze4d7k+/G7Q=;
        b=WKFYCFVLQ6wf2I/Y0sQ7RHoYg2sbAbaUGpo5vgEVYfXI7JLbf50ojayraJAHLGWaO3
         IFI6IXm6clpkKZqYjGfd+KgxXTQJVQS5cxWSjiYYqp3pOgudsI57DnQcIi5ww0uMHCqr
         ixp8NAWyvZa6x5qo20WEAlm6ljOF5ngHdNiad6v1FSDk7VvEmTepyMV/Lr1EAVjfxEPd
         7WdfPJvfdnFVL41LvkYIhLHve2UTORHMVYfeRfMJy3ZvbfK6KMxrD2Xw4Z1Ejs4vv0V1
         9BBpecgg0ZhvyCWleqIjHA3ul5J2Q0z4ON+PiRAVHOFzAt6Yilm2XbPnis0TT/oTqYNt
         kslg==
X-Gm-Message-State: AHQUAub6T5IEt2M4QCLYiwF+rSsRyaj1ORU0L39RJxLNe2FCK0AylHco
        /XApMQKbH0yu3Z90YWsqOQI=
X-Google-Smtp-Source: AHgI3IaRJCwj3e+LCgQoHC4dx8FrwaR9d+qs+kXoyIoYIa5MBf99ovZP7nNxWUm2hA3UFhtHXXjbrQ==
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr5076658ljh.74.1550050472709;
        Wed, 13 Feb 2019 01:34:32 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q3sm3643252lfj.50.2019.02.13.01.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:34:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtqvx-0007j6-8w; Wed, 13 Feb 2019 10:34:25 +0100
Date:   Wed, 13 Feb 2019 10:34:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190213093425.GH28278@localhost>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus>
 <20190211092251.GV4686@localhost>
 <86o97iv2px.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o97iv2px.fsf@baylibre.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:06:50PM +0100, Loys Ollivier wrote:
> 
> On Mon 11 Feb 2019 at 09:22, Johan Hovold <johan@kernel.org> wrote:
> 
> > On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> >> On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> >> > Add binding for Mediatek-based GNSS receivers.
> >> > 
> >> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

> >> reset-gpios is the standard name.
> >> 
> >> > +- gtop,fix-gpios	: GPIO used to determine device position fix state
> >> > +			  (pin name: FIX, 3D_FIX)
> >
> > I'm thinking we might need a standard name for fix-gpios as well. This
> > isn't a feature that is globaltop (or mediatek) specific, and other
> > manufacturers provide similar functionality through pins named UI_FIX,
> > or even LCKIND (lock indicator).
> >
> > The pin is typically used to drive an indicator LED AFAIU, but the
> > characteristics of the signal varies from device to device (fw to fw),
> > for example, pulse when no lock and low otherwise, or pulse when a 2d or
> > 3d-fix is acquired, etc.
> >
> 
> Yes most GNSS recevivers provide a similar feature even if behavior of
> the line differs.
> 
> > I'm not sure how useful the pulsing would be for software, but someone
> > might find a use for it in some form.
> >
> 
> Well it is useful to know when you start acquiring "valid" positionning
> data. I'm using this as a trigger to start recording position.

Sure, but a non-pulsing signal might have been easier to deal with if it
was meant to be used by software.

> > Rob, is this something we want to keep in the binding, and if so, how
> > about using a generic name such as "gnss-fix-gpios"?
> 
> Name "gnss-fix-gpios" sounds good to me.

Let's go with that then.

Johan
