Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE1DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724AD2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+d4xyg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724AD2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeHXDG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:06:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:06:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8-v6so3402100pgs.4;
        Thu, 23 Aug 2018 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WSNr20WxcWJxrdsXmR3kOdnfGDIiolHz6aUydrZXF/A=;
        b=e+d4xyg1COFYWpqzZxI2tbxNjvu4t0uMClUyAaMbYMUrJSRyiAivfRll8W9YftyZzx
         QG/EtQPNByD2tXVuTS6JefeHfOv88QohSR1DuUC/qv+nphjy45ztPu5CjOGsCIrEwyWs
         Wew8MfSbTa4k7VO14SP/UcJ9VRwSDuFiL6DgYeuHiqeksdCTMLDdzLubyW2JMzuQxNck
         uBHPoQ1N/k+DBxkge301OAjCyt9qpImH+X0czhwbihUk4oD8unnLXay7R+G0C95E5BeR
         0dowP9UnsTYH7ucNHXHgcCi9XskRi3NVlRl2VccaPLGATdyP9uA5NkxEEQj9LDpWG85u
         xg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WSNr20WxcWJxrdsXmR3kOdnfGDIiolHz6aUydrZXF/A=;
        b=AOXyGYGFOiNTXUKfG9TrwrzrI25asSYSczdrOs8lmIJ8Xfe2rxHn4oYfAK7nFnTVXE
         XTA9o5UdUbUT/RgQs09GToepuuLXprvbjbA3xbwOBCZHCYGDW14hMRcjcxELFMp2rm0m
         SEsLRabr2f+HJjOkfqhLmpW0ALUm4V5LTPb1CXRd3sd3Fh2YyzRa+se96G4O+Fdwhjqr
         J6BlZ0tP6oSvjDp31wUbvrATT1mZ/g7xq9+uoDf3L1hhSNz8Oobi/cwZFm/6iy33v71n
         hLxwF+aVVFcfBcHVCjcI7EhlQX+/iLlWhj0Q/riFZhf4ERYzLQIAzA8cW/WwgJlIMG4p
         Pkag==
X-Gm-Message-State: AOUpUlGyDudQfwwx0PbkD3UVT7NEEFkoG1/boEOlT9NEdZypt1O34hjM
        Wk4kVBCeZUwoOKf3barHLWA=
X-Google-Smtp-Source: AA+uWPzD9pksIu24VukXaf9CFBWcRXJ4AbJjz02ha+Ep4cq6TM2Fbvp0LHQ2HhqDTZhYceefnGD/vw==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr64458322pfa.63.1535067267430;
        Thu, 23 Aug 2018 16:34:27 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y3-v6sm8506858pfi.24.2018.08.23.16.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 16:34:26 -0700 (PDT)
Date:   Thu, 23 Aug 2018 16:34:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Derek Basehore <dbasehore@chromium.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        joe@perches.com, andi@etezian.org, gregkh@linuxfoundation.org,
        James Chen <james.chen@emc.com.tw>,
        KT Liao <kt.liao@emc.com.tw>
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Message-ID: <20180823233424.GE53155@dtor-ws>
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws>
 <20180823233211.GD53155@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823233211.GD53155@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For real now...

On Thu, Aug 23, 2018 at 04:32:11PM -0700, Dmitry Torokhov wrote:
> Let's add Elan folks to the discussion.
> 
> On Thu, Aug 23, 2018 at 04:30:28PM -0700, Dmitry Torokhov wrote:
> > Hi Derek,
> > 
> > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
> > > We only need to wait 10ms instead of 30ms before starting fastboot or
> > > sending IAP on the touchscreen. Also, instead of delaying everytime
> > > sw_reset is called, this delays 10ms in the function that starts
> > > fastboot. There's also an explicit 20ms delay before sending IAP when
> > > updating the firmware, so no additional delay is needed there. This
> > > change also has the benefit of not delaying when wakeup is enabled
> > > during suspend. This is because sw_reset is called, yet fastboot
> > > isn't.
> > > 
> > > Change-Id: I9e3019720186ba0023891fafeb4fe3d2510e454b
> > 
> > This is not needed ;)
> > 
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > >  drivers/input/touchscreen/elants_i2c.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> > > index d21ca39b0fdb..18ce04ba0173 100644
> > > --- a/drivers/input/touchscreen/elants_i2c.c
> > > +++ b/drivers/input/touchscreen/elants_i2c.c
> > > @@ -284,12 +284,6 @@ static int elants_i2c_sw_reset(struct i2c_client *client)
> > >  		return error;
> > >  	}
> > >  
> > > -	/*
> > > -	 * We should wait at least 10 msec (but no more than 40) before
> > > -	 * sending fastboot or IAP command to the device.
> > > -	 */
> > > -	msleep(30);
> > > -
> > >  	return 0;
> > >  }
> > >  
> > > @@ -500,6 +494,12 @@ static int elants_i2c_fastboot(struct i2c_client *client)
> > >  	const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
> > >  	int error;
> > >  
> > > +	/*
> > > +	 * We should wait at least 10 msec (but no more than 40) before sending
> > > +	 * fastboot command to the device.
> > > +	 */
> > > +	usleep_range(10 * 1000, 11 * 1000);
> > > +
> > >  	error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
> > >  	if (error) {
> > >  		dev_err(&client->dev, "boot failed: %d\n", error);
> > > @@ -643,6 +643,10 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
> > >  			dev_err(&client->dev, "Failed close idle: %d\n", error);
> > >  		msleep(60);
> > >  		elants_i2c_sw_reset(client);
> > > +		/*
> > > +		 * We should wait at least 10 msec (but no more than 40) before
> > > +		 * sending IAP command to the device.
> > > +		 */
> > >  		msleep(20);
> > 
> > So the original comment was talking about timing on fastboot or IAP
> > command, but the original code had 50 msec wait here (30 from
> > elants_i2c_sw_reset plus the 20), thus already violating 40 msec rule
> > for IAP. Unless Elan folks can confirm it is OK to reduce the wait here
> > I'd prefer we kept it at 50. Firmware update is does not happen that
> > often anyway.
> > 
> > Thanks.
> > 
> > -- 
> > Dmitry
> 
> -- 
> Dmitry

-- 
Dmitry
