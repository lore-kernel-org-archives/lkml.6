Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E818C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013D20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVLj/rSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1013D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeLEWAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:00:04 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44696 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeLEWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:00:01 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so17978499iod.11;
        Wed, 05 Dec 2018 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PR2WoUOlxh2V5Fh31suImsfSZjtFe0LlLK2xk4cpACA=;
        b=rVLj/rSLnVWKduALodCcgmPeNDFH3w86bSm6TOjeUtzdOqY/ZarolqIQ68+Isl3Rkw
         KDbA7nCcfLN1pXYhed0bhij8yv4oockcwG++P15tdkLQowNIquu0co8vj3pRzII1+pfD
         +x0HpTYeToTFyS2i/2s8Kb2eG0xWN4gZBIxRdhTelVpubl4RXNxzEAp44H+lZS5JjriB
         PZX5kKRNFkY85FZMDRViJMxa72j/DuVK2OQMLU4X3fCL3r9YBCN3S8xkIrxPbOhRIEGW
         a3KdiY748KUG7VhghPrMtKbPM2zdHgEo8gD+A8PVerOu0hahDBEizt2ghwLsO1mkx10f
         YPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PR2WoUOlxh2V5Fh31suImsfSZjtFe0LlLK2xk4cpACA=;
        b=Xh2d2J4UWK+QsV4TOQnjJK6iH2nyHqC+a3zkiwNYW3rzowQauDNbk89atTSbmMbZdh
         YSjGE0O4rozIP81CG+TagreOQd/ptxW2wH+4/YThdN2rlQGv+JPowXx6YYANBfhEcXcY
         bBJIY1LSFqYPbjK9v1wd1hNG2+gNNLPsx8R9mjjXbmxk3/eY6L3D8NgU3E7w+gbvQqUa
         N1bMPzfx2s/9Udsd49V16QRc67DQZr3ex6UfxIxNYx5rGdxzZ/EMyFhMtuvabkdwvfe7
         5b4JnOH9QlzqPbmkbqrk+ItdSYXfp+INYL5RdZEvzkDmS9qYMEcOQHmUj25G4Xm0OMRU
         fBbg==
X-Gm-Message-State: AA+aEWZ78M48DJSr0vhoNjyaRTF+T2EkaCS12ANDz4hz+zC86Zts4rEU
        ns1UU4N1fWAKwWF7SQ6hQYo=
X-Google-Smtp-Source: AFSGD/XBWLJe0Fbu3FxIv4yEWeL28XkrfJ23W4jP58+lmcXI/+fp9ELlg+Xeh76sYhjYCe3T7mQNuA==
X-Received: by 2002:a6b:ab83:: with SMTP id u125mr22080520ioe.211.1544047200754;
        Wed, 05 Dec 2018 14:00:00 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id x17sm8548303ioa.6.2018.12.05.13.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:00:00 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:59:53 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for
 'ret' equals to 0"
Message-ID: <20181205215953.GA2365@r2700x.localdomain>
References: <20181205014900.4827-1-jeremyfertic@gmail.com>
 <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:25:55AM +0530, Shreeya Patel wrote:
> On Tue, 2018-12-04 at 18:49 -0700, Jeremy Fertic wrote:
> > This reverts commit 00426e99789357dbff7e719a092ce36a3ce49d94.
> > 
> > i2c_smbus_read_byte() returns 0 when a byte with the value 0 is read
> > from
> > the device. This is a valid read so revert the check for 0.
> > 
> > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> > ---
> 
> Hi Jeremy,
> 
> As per my understanding, 0 value indicates no error but no data read.
> Then how can this be a valid case?
> 
> Can you please make me understand that how can we consider this as a
> valid case even when no data has been read?
> 
> 
> Thanks

I'm not sure I understand why the value 0 would indicate no data read.
Doesn't that just mean a byte was read with the value 0. For instance,
if the input to the adc is 0V. Can you point me to where you're seeing
that this would indicate no data read?

> 
> >  drivers/staging/iio/addac/adt7316-i2c.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316-i2c.c
> > b/drivers/staging/iio/addac/adt7316-i2c.c
> > index ac91163656b5..2d51bd425662 100644
> > --- a/drivers/staging/iio/addac/adt7316-i2c.c
> > +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> > @@ -30,10 +30,6 @@ static int adt7316_i2c_read(void *client, u8 reg,
> > u8 *data)
> >  	}
> >  
> >  	ret = i2c_smbus_read_byte(client);
> > -
> > -	if (!ret)
> > -		return -EIO;
> > -
> >  	if (ret < 0) {
> >  		dev_err(&cl->dev, "I2C read error\n");
> >  		return ret;
