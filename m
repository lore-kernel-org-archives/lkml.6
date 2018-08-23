Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946FEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C0E2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuRa2LBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C0E2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHXDEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:04:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44261 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXDEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:04:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so247764plb.11;
        Thu, 23 Aug 2018 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3NGBTikZVTjhm7BaifILrjxyduiquLNjtzjAR5gHJFI=;
        b=OuRa2LBLzZvWVWw8Cwzgh0diOH9FdstQaiCDLGJqA1HZMZhqxnliNyTLCR5j2ECfjv
         do7eD+XZN6enVBSLzPTr3QQbo+B4VHQQ2XoP1yZ8r3rCHH8m5WOf9+s4AVXBkqjg0fjB
         eFLfcXcHdYZ4jhBY5XACswQuS2xQ/uuQtKGUjmKvh164lLQjmt8beJbLZRLGMYzBIkHF
         kFKRZI6k5dRnupwKSfkVNU7cLB8jvrzuV2+ip/qVi2jrbNl0ezuWE2nehl85fca77k9S
         p+nybPvf8FiexTTjVt+IaDISJlqLj79jdgTrYywCYsS15CB/M/SCp6LDK4dOGUoLB7hS
         +raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NGBTikZVTjhm7BaifILrjxyduiquLNjtzjAR5gHJFI=;
        b=LZV9RGyTUE0sFGnUTL0+UdtH1JJYlQyQ54yRB2ZE4p3Sh/kvniwPXfkblYKXYmnjzB
         5JyiictRF9wCDwLIGEcM0pOoinppyIgNjNR2XdUoAkcisBIhwIArte6N9ksS0T3y5MD4
         aWKCIVBmayux5Gs7UUDyMMm13s1ziiTzBmLgwV0dx7FkCaJByc4tmxX+RXyD3NlR4q/o
         NuVYhoRm90leTCruA6yyQLvWyQDsnUCRLw1IhX3uiLbgdoVmmla0U0BSdGt6jAuIAy8k
         ihzl6Ck9EEoaxG2dyinABChxcxDo0M1SZqtfIz+PVnMp9FOeFe/OC5vwV+MNTrmsH6dp
         i/vQ==
X-Gm-Message-State: AOUpUlEGl3vjRi92RTqxrR0K3DlfSsvjR6zE2x/NWbboKcWgnOglnMyn
        nFJ7bTRYehfXigew/M5Qskc=
X-Google-Smtp-Source: AA+uWPwZM2eSi0uhwvBBndO9LEcCYOWBn94bdhPMy8BIRSN5R40fYLf8RniVsCqK0I3X/jNGrMm2HQ==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr59690086plr.242.1535067134657;
        Thu, 23 Aug 2018 16:32:14 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j191-v6sm10293090pfc.136.2018.08.23.16.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 16:32:13 -0700 (PDT)
Date:   Thu, 23 Aug 2018 16:32:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        joe@perches.com, andi@etezian.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Message-ID: <20180823233211.GD53155@dtor-ws>
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823233028.GC53155@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add Elan folks to the discussion.

On Thu, Aug 23, 2018 at 04:30:28PM -0700, Dmitry Torokhov wrote:
> Hi Derek,
> 
> On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
> > We only need to wait 10ms instead of 30ms before starting fastboot or
> > sending IAP on the touchscreen. Also, instead of delaying everytime
> > sw_reset is called, this delays 10ms in the function that starts
> > fastboot. There's also an explicit 20ms delay before sending IAP when
> > updating the firmware, so no additional delay is needed there. This
> > change also has the benefit of not delaying when wakeup is enabled
> > during suspend. This is because sw_reset is called, yet fastboot
> > isn't.
> > 
> > Change-Id: I9e3019720186ba0023891fafeb4fe3d2510e454b
> 
> This is not needed ;)
> 
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/input/touchscreen/elants_i2c.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> > index d21ca39b0fdb..18ce04ba0173 100644
> > --- a/drivers/input/touchscreen/elants_i2c.c
> > +++ b/drivers/input/touchscreen/elants_i2c.c
> > @@ -284,12 +284,6 @@ static int elants_i2c_sw_reset(struct i2c_client *client)
> >  		return error;
> >  	}
> >  
> > -	/*
> > -	 * We should wait at least 10 msec (but no more than 40) before
> > -	 * sending fastboot or IAP command to the device.
> > -	 */
> > -	msleep(30);
> > -
> >  	return 0;
> >  }
> >  
> > @@ -500,6 +494,12 @@ static int elants_i2c_fastboot(struct i2c_client *client)
> >  	const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
> >  	int error;
> >  
> > +	/*
> > +	 * We should wait at least 10 msec (but no more than 40) before sending
> > +	 * fastboot command to the device.
> > +	 */
> > +	usleep_range(10 * 1000, 11 * 1000);
> > +
> >  	error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
> >  	if (error) {
> >  		dev_err(&client->dev, "boot failed: %d\n", error);
> > @@ -643,6 +643,10 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
> >  			dev_err(&client->dev, "Failed close idle: %d\n", error);
> >  		msleep(60);
> >  		elants_i2c_sw_reset(client);
> > +		/*
> > +		 * We should wait at least 10 msec (but no more than 40) before
> > +		 * sending IAP command to the device.
> > +		 */
> >  		msleep(20);
> 
> So the original comment was talking about timing on fastboot or IAP
> command, but the original code had 50 msec wait here (30 from
> elants_i2c_sw_reset plus the 20), thus already violating 40 msec rule
> for IAP. Unless Elan folks can confirm it is OK to reduce the wait here
> I'd prefer we kept it at 50. Firmware update is does not happen that
> often anyway.
> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Dmitry
