Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD15C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BA20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVWvrZuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9BA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeLMWBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:01:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45572 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:01:54 -0500
Received: by mail-io1-f65.google.com with SMTP id n3so2866946iog.12;
        Thu, 13 Dec 2018 14:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ck5VNCk3zkFstAhB+usPuWzSRVaH44SPvmgAQ6M6EtQ=;
        b=OVWvrZuH/ia9nIoXmzEXyez1ZSQstM3L2KvOZohCIHh0cfj8YNFVpSE7d1BF8g/1wZ
         xtvVNWjCmHzMMo0KPckWlAF3jzaNxHtOkIK96knYHyC8JqdmPTPHgj0rPtknb61p4Rue
         +zoqzWQQDhLLozWHj/T60SWaoy6IcTbrjPQaKYlrkMricZ1QffESSB8Rdq/NJYARqUFW
         we7OpFmpLn2VnTJSRcX24IBGuzjv9VzxypzCXQUi5tsAnnxjO4DiMOkPBFlzzgihifG0
         oaoDOBiSXkNsch8repiN+0qb+Upr7Pp90nT/xt2KSL7vB/te624k2neQ1+aIAQ6+3Ilq
         j8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ck5VNCk3zkFstAhB+usPuWzSRVaH44SPvmgAQ6M6EtQ=;
        b=KdOXT3tuIetdzymn7ts/jxIZ6GhZLlp5bbonhiykOtEnt2oA2Hg9iwxf3uDuFVjlXr
         /OFIkD5BGNTbDtg49o61FxuaD9QhU2sR/UG4MSdGQ5SPSsx3NYXizWyCkpl2nEAzIBA8
         1y1lkbw9fucPpF6yMgL2WKAlE3eLE/pcsQHJKE9nrMS5sucIktzgtnsI5oLTVBPY4+Xt
         rZp/FcoSz7rtrJneIR59J+mor/rbN04GKXTsoYyvxliRTfcU8jfTvJ7Dz8lMJNtpH55w
         FMR4U095yr7DT3FU9wwq+ioNxWixGVoFD1Kour+0Ev70bHx5q11W+/kGybdvxsUOZqZo
         1xwQ==
X-Gm-Message-State: AA+aEWaH/ansfucpqsuKyB21dbrHdtNGDlPnilQd8EmWSjInati2fndY
        KLq+y8Q5I4cUe5wpzlUYh+U=
X-Google-Smtp-Source: AFSGD/WeJCzN7UnlPQBAwaGoxO6yqpxdj5SA7KTcQVniOqOxDBe2KRyb2Q5YJyZvuzhns03JqrfJ3A==
X-Received: by 2002:a6b:6203:: with SMTP id f3mr553286iog.36.1544738513502;
        Thu, 13 Dec 2018 14:01:53 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id d192sm1430024iog.81.2018.12.13.14.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 14:01:52 -0800 (PST)
Date:   Thu, 13 Dec 2018 15:01:46 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 04/11] staging: iio: adt7316: fix handling of dac high
 resolution option
Message-ID: <20181213220146.GA2496@r2700x.localdomain>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-5-jeremyfertic@gmail.com>
 <20181212082315.GI3116@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212082315.GI3116@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:23:16AM +0300, Dan Carpenter wrote:
> On Tue, Dec 11, 2018 at 05:54:56PM -0700, Jeremy Fertic wrote:
> > @@ -651,10 +649,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> >  	u8 config3;
> >  	int ret;
> >  
> > +	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
> > +		return -EPERM;
> 
> return -EINVAL is more appropriate than -EPERM.
> 
> regards,
> dan carpenter
> 

I chose -EPERM because the driver uses it quite a few times in similar
circumstances. At least with this driver, -EINVAL is used when the user
attempts to write data that would never be valid. -EPERM is used when
either the current device settings prevent some functionality from being
used, or the device never supports that functionality. This patch is the
latter, that these two chip ids never support this function.

I'll change to -EINVAL in a v2 series, but I wonder if I should hold off
on a separate patch for other instances in this driver since it will be
undergoing a substantial refactoring. Is there any rule of thumb about
when -EPERM is appropriate for a driver, or is -EINVAL almost always the
better option?

