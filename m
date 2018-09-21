Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C4E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDmKNVd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C4E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbeIUPBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:01:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42572 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbeIUPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:01:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so5699408pff.9;
        Fri, 21 Sep 2018 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KzZd453GUuIu0SX8RHhASXACzk7RqyOC4TCjCGWKCnY=;
        b=MDmKNVd0ab3ekACfqJbHx6FWFujNuzFmvCYu8MviPaM3S0vsQtuVp/NhdQORwRCWqG
         OT0fIGrHqvOale2a5irpc1OjOcDgUibzYPH44pQekw3QmCh2JZ43sJDhrriW3NV5TYiE
         gd9P8BHZiMZQHKnCRmPdYAnCdONvFW8Wo8hCAsIcd+v/+NLGFaUB0dpXDuM/aU7Yqwx7
         yj/fGr9F783+jvdsilmYIJF3G7lOJwNiTLvqowdPCEv8mjXyUO9ibbrKZpnXQImkFiOJ
         uALYsooCf1qitrAi0m2/lf/ablhUeiCHHC9U0ZoO1remSH5vJidP803n/MSas3qRUiru
         ww/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KzZd453GUuIu0SX8RHhASXACzk7RqyOC4TCjCGWKCnY=;
        b=XIvb3whIooryCdMHjtpSzgB8a22dSXX8TDNU9U+MVyzcYsFzql6t3HMcmnaK7Ac0Ln
         NaoSlzQ2jDAMIsA0QrmtNhrKWDAigVUqbocOoBBeC7LXxF21ICCugBBcMRuyGsi2OjGD
         sFmDa5Yyc3Qc96Nc3GHB/MtIjzHveJcu9GK+eaWRNiukgoDDrmE2dzqNK8QBJa0xDR5a
         e4STTPVpWKCJ7mVsqVZFuou3TFL69iyFwOCzN9rnduKrBRIUJUzs6vHhFg7f/ouqO5+N
         UiDRnxRiFmXxcIkB4Yjo+kyahgtrbk0IUORptHv+vwg1O+2hzch8GVu8Z8PZtHN1NBpR
         XwLw==
X-Gm-Message-State: APzg51B2WImATvxlK5KBpwsHBzEsG69yl2iSdmCoc4cH1G9g0CfGyWgJ
        Q3g9Hk97zOK4cGQidRa44HQ=
X-Google-Smtp-Source: ANB0VdaFJdMjHK36rgKbC0Yu78LQFzuAQXuRRapEOdbyjYXl0V4lBmdidKpZXl04CkEY7S2jYdbucw==
X-Received: by 2002:a62:174a:: with SMTP id 71-v6mr46075549pfx.217.1537521206174;
        Fri, 21 Sep 2018 02:13:26 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id c1-v6sm34330732pfi.142.2018.09.21.02.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:13:25 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:13:18 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Phil Reid <preid@electromag.com.au>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180921091318.GA2151@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
 <4633d30b-b493-d70b-dd7b-3f5bc3e16e78@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4633d30b-b493-d70b-dd7b-3f5bc3e16e78@electromag.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:05:38AM +0800, Phil Reid wrote:
> On 20/09/2018 9:13 PM, Song Qiang wrote:
> > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > magnetometer, composed of 3 single sensors and a processing chip.
> > PNI is currently not in the vendors list, so this is also adding it.
> > 
> 
> In the subject: Isn't the RM3100 a 3axis mag.
> The 9axis bit comes when you combine it with an accel / gryo I think.
> 
> ... snip
> 

Hi Phil,

That's right!
The first time I got this sensor I googled it on the internet and the
abstract of the first webpage told me that it's a 9-axis sensor, and
it's from its offcial website! I just googled it and saw it's still
there, but after I entered the website, there isn't anything on the
webpage about '9-axis', maybe I just saw the old wrong web cache of 
google. Newer websites do say it's a 3-axis magnetometer sensor, and 
it only has three channels of data can be read. 3-axis it is.

> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> > @@ -0,0 +1,57 @@
> > +* PNI RM3100 9-axis magnetometer sensor
> > +
> > +I2C Bus:
> > +
> > +Required properties:
> > +
> > +- compatible : should be "pni,rm3100-i2c"
> > +- reg : the I2C address of the magnetometer
> > +
> 
> ... snip
> 
> > +SPI Bus:
> > +
> > +Required properties:
> > +
> > +- compatible : should be "pni,rm3100-spi"
> > +- reg : address of sensor, usually 0 or 1.
> > +
> 
> Looking at other drivers supporting i2c / spi.
> They use the same compatible for both.
> 
> eg: see iio/accel/adxl345_*.c
> 
> and it's binding doc:
> 
> Required properties:
>  - compatible : should be "adi,adxl345"
>  - reg : the I2C address or SPI chip select number of the sensor
> 

Agreed, since nodes of this sensor should be already on the bus where it
should be in DT, there's no need for compitable string to identify which
bus it's on.

yours,
Song Qiang
