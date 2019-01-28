Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7899320856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnUX8q0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfA1T6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:58:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33565 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1T6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:58:49 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so14607658ioi.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6vEBKGO5zHexYUs96sgYGY3BpV2+8VZruXe5P7x5Zw=;
        b=MnUX8q0n/oXR3q4dU8thrVmaM+h/IkC9NY/kqEJGslJYBeZvHehGPPV1M9W3ZP+SiI
         nY1rNsbCUX32IHX+MtQP7qkZ+6IFbhmmrOgraKNUguyPbnEBlmBi1OuhzGKm8+0lGn0/
         mn/PDXvKcsdKFY1VPGK5svW1FTX3iZrttUg0R+hdnLOQaQs8u3EZJ1id7R5DFFLovYPz
         vA+u/9yW/5KYZDo/lEUBHFcUp84vsM1IIHcAE5RNfdzftZ75GKleALEfsdhFSIIcUJZ3
         VXfye6v5ff45U2SOCytD6nYICmu8yKzJrhFhvgDwTEAz1D10UljEuxCax600yEab8CAc
         cYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6vEBKGO5zHexYUs96sgYGY3BpV2+8VZruXe5P7x5Zw=;
        b=Maq+XPQdbMsvoBa+t5Y1baXZ0g9YRKok1F7AgqIlpUsMGzj/1Sn/m96ks77Weq0alz
         BDdC/JWujpTHJHLjw1OqDnFYu8PjfNcmrbA6Yb3FgcR57yzFyjykYmy/UH+sZgqFHNfQ
         1BPofKwrG3aFWmI7KeaRGa9xc2P5rcbkCpW1fCt4CRxKzrRuRXIfxKFKuX7+MaTDFIBk
         SZ2TxBExamLTJww/OBzGmYXolfefqnsbzM2oJWDybE2m7QEhzY6/CIvIVAi3I6HV7qoj
         IAZvL1DNZcygf6GlFywTcX6AcWx8oLs/rKDUbhXbQeaBgcvUt5Cn1ieIjGBUdsuf5SsM
         ZpBQ==
X-Gm-Message-State: AHQUAuYUBYyRwhdK/IRL+ii41gbZZH5w21phLrQNWff8/4sGmATZx3wO
        8sSe5Qw2jn/2cbJvLUI/dIw=
X-Google-Smtp-Source: AHgI3IZlxn2UBKNhNhtsOPaP41OiJ3Z+mel0OTwvzU+820A6fQaro68PYMqB36sayUlNa1Zr1dffug==
X-Received: by 2002:a6b:3705:: with SMTP id e5mr14284647ioa.240.1548705528546;
        Mon, 28 Jan 2019 11:58:48 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id r195sm215401ita.3.2019.01.28.11.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:58:47 -0800 (PST)
Date:   Mon, 28 Jan 2019 14:58:45 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190128195845.GA3723@ubu-Virtual-Machine>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:40:30PM +0000, Dexuan Cui wrote:
> > From: Kimberly Brown <kimbrownkd@gmail.com>
> > Sent: Monday, January 21, 2019 10:43 PM
> > > > @@ -1421,7 +1422,10 @@ static ssize_t vmbus_chan_attr_show(struct
> > > > kobject *kobj,
> > > >  	if (chan->state != CHANNEL_OPENED_STATE)
> > > >  		return -EINVAL;
> > > >
> > > > -	return attribute->show(chan, buf);
> > > > +	mutex_lock(&vmbus_connection.channel_mutex);
> > > > +	ret = attribute->show(chan, buf);
> > > > +	mutex_unlock(&vmbus_connection.channel_mutex);
> > > > +	return ret;
> > > >  }
> > >
> > > It looks this patch is already able to fix the original issue:
> > > 6712cc9c2211 ("vmbus: don't return values for uninitalized channels"),
> > > as chan->state can't be CHANNEL_OPENED_STATE when
> > > channel->ringbuffer_page is not set up yet, or has been freed.
> > > -- Dexuan
> > 
> > I think that patch 6712cc9c2211 fixes the problem when the channel is
> > not set up yet, but it doesn't fix the problem when the channel is being
> > closed
> Yeah, now I see your point.
> 
> > The channel could be freed after the check that "chan->state" is
> > CHANNEL_OPENED_STATE, while the "attribute->show()" function is running.
> 
> IMO the channel struct itself can't be freed while the "attribute->show()"
> function is running, because I suppose the sysfs interface should have an extra
> reference to channel->kobj (see vmbus_add_channel_kobj()), so before the sysfs
> files are removed, the channel struct itself can't disappear.
> (I didn't check the related code very carefully, so I could be wrong. :-) )
> 

I think that you're correct that the channel struct can't be freed while
the "attribute->show()" function is running. I tested this by calling
msleep() in chan_attr_show(), opening a subchannel sysfs file, and
unloading hv_netvsc. Unloading hv_netvsc should result in calls to
vmbus_chan_release() for each subchannel. I confirmed that
vmbus_chan_release() isn't called until the "attribute->show()" function
returns.


> But as you pointed, at least for sub-channels, channel->ringbuffer_page
> can indeed disappear in vmbus_close() -> ... -> vmbus_free_ring(), and
> the "attribute->show()" could crash when the race happens.
> Adding channel_mutex here seems to be able to fix the race for
> sub-channels, as the same channel_mutex is used in vmbus_disconnect_ring().
>
> For a primary channel, vmbus_close() -> vmbus_free_ring() can still
> free channel->ringbuffer_page without notifying the "attribute->show()".
> We may also need to acquire/release the channel_mutex in vmbus_close()?
>  
> > Actually, there should be checks that "chan" is not null and that
> > "chan->state" is CHANNEL_OPENED_STATE within the locked section. I'll
> > need to fix that.
> I suppose "chan" can not be NULL here (see the above).
> 
> Checking "chan->state" may not help to completely fix the race, because
> there is no locking/synchronization code in
> vmbus_close_internal() when we test and change "channel->state".
>

The calls to vmbus_close_internal() for the subchannels and the primary
channel are protected with channel_mutex in vmbus_disconnect_ring().
This prevents "channel->state" from changing while "attribute->show()" is
running.


> I guess we may need to check if channel->ringbuffer_page is NULL in
> the "attribute->show()". 
> 

For the primary channel, vmbus_free_ring() is called after the
return from vmbus_disconnect_ring(). Therefore, the primary channel's
state is changed before "channel->ringbuffer_page" is set to NULL.
Checking the channel state should be sufficient to prevent the ring
buffers from being freed while "attribute->show()" is running. The
ring buffers can't be freed until the channel's state is changed, and
the channel state change is protected by the mutex.

I think checking that "channel->ringbuffer_page" is not NULL would
also work, but, as you stated, we would need to aquire/release
channel_mutex in vmbus_close().


> PS, to prove that a race condition does exist and can really cause a panic or
> something, I usually add some msleep() delays in different paths so that I
> can reproduce the crash every time I take a special action, e.g. when I read
> the sysfs files of a NIC, I try to remove hv_netvsc driver. This way, I can prove
> a patch can indeed help, at least it can fix the crash which would happen
> without the patch. :-)
> 

Thanks! I was able to free the ring buffers while "attribute->show()"
was running, which caused a null pointer dereference bug. As expected,
the mutex lock fixed it.


> -- Dexuan
