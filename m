Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E78120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="YM2kqrve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfAQRLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:11:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37245 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfAQRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:11:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so4715900pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqfVIg7yFjrTzWvVaXbwKW1bCMZ7k6hvwzPZ7Gi3uzc=;
        b=YM2kqrvesE06nwhDJHOupevX1TSY629WTBKZJnr7CwPZWu0rv/bKG5Cwbd26qVjguj
         aPzCSnCWaXJG/zdRpinCKYM38uPIiAE/2l17hxIWGgIRc0qR+UAmVFxcsSTkjIgzRIxS
         0J4J0+ohoUF8ilC/KOIKSj6jJ1NDj4Xfcj+nAQTfitS/B6jLZuyQjPKr3oyDeB+nyKCV
         qPVPwOvugcQl0znIeDLUX0Tm5mEgBhAunRScOh7jhZVYiGTXsIE/LyAkLM2Fte/+PP+S
         RgnKhso4uD9Dd12kHzEpJ9/hiTGllR50uv1PD3C+JOmLYk1gxFSWFjfc8W+2aJaJJXN4
         XemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqfVIg7yFjrTzWvVaXbwKW1bCMZ7k6hvwzPZ7Gi3uzc=;
        b=oGLdLglIpd2BkB4Wpp2/XBayNXXiuDBlf6PSRHNwppQi5M4Yi0XjYWeCag8eJz2pNc
         Nhm7J1Wl2u/Mwa1nA3sAGN+Ayr/Xwd4sPhGiTeCGTm2G3+/grNGG273TdjgD1Zx5tKxT
         nQ3JcVMUwKeG+SxVDTmKYtmPUwS2Illa+xIUV9o+qafwLczbdyBcBdLwgFGGopZjYbWO
         n/iOqjrZFgPl9QiucV5Gxjo/gCgGgMX/2O+Ngzspp39Aby5VxyJPWcUU9y5giSMghPjp
         FwvX2ZrTgBZLDHHyEoD/Ee878r1oSc0rZPNc0kbNx5BDr3PN86AwHcEaEabhJN9QJeA8
         c1tQ==
X-Gm-Message-State: AJcUukf9J0nguPgDMqNZq0BFxfbmLN9U5NNP0nVWDUlrrtHJCODTsiMe
        cmgdWZ2bQfK0ptv5ikXf3tDyUg==
X-Google-Smtp-Source: ALg8bN6tOi2nqSk7pXeOn47gLx17P5dNb8OvExKWp0QqXfhQPouqGigKhzh4L5O+CLa5rMhEWbraMw==
X-Received: by 2002:aa7:84d3:: with SMTP id x19mr15601015pfn.220.1547745071406;
        Thu, 17 Jan 2019 09:11:11 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id k24sm4032961pfj.13.2019.01.17.09.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 09:11:11 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:11:03 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kimbrownkd <kimbrownkd@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Message-ID: <20190117091019.1fb0c186@hermes.lan>
In-Reply-To: <KU1P153MB0166DA6E76D0080C4AD43E01BF830@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <20190105043518.GA4072@ubu-Virtual-Machine>
        <20190117043759.GA3395@ubu-Virtual-Machine>
        <KU1P153MB0166DA6E76D0080C4AD43E01BF830@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +static ssize_t channel_intr_in_full_show(const struct vmbus_channel
> *channel,
> +					 char *buf)
> +{
> +	return sprintf(buf, "%llu\n", channel->intr_in_full);
> +}


intr_in_full is u64, which is not the same as unsigned long long.
to be correct you need a cast here.

> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index dcb6977afce9..7e5239123276 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -751,6 +751,27 @@ struct vmbus_channel {
> >  	u64	interrupts;	/* Host to Guest interrupts */
> >  	u64	sig_events;	/* Guest to Host events */
> > 
> > +	/* Interrupt counts for 2 types of Guest to Host interrupts */
> > +	u64 intr_in_full;	/* in ring buffer, full to not full */
> > +	u64 intr_out_empty;	/* out ring buffer, empty to not empty */
> > +
> > +	/*
> > +	 * The total number of write operations that encountered a full
> > +	 * outbound ring buffer.
> > +	 */
> > +	u64 out_full_total;
> > +	/*
> > +	 * The number of write operations that were the first to encounter a
> > +	 * full outbound ring buffer.
> > +	 */
> > +	u64 out_full_first;

Adding more fields changes cache layout which can cause
additional cache miss in the hot path.  

> > +	/*
> > +	 * Indicates that a full outbound ring buffer was encountered. The flag
> > +	 * is set to true when a full outbound ring buffer is encountered and
> > +	 * set to false when a write to the outbound ring buffer is completed.
> > +	 */
> > +	bool out_full_flag;

Discussion on kernel mailing list. Recommends against putting bool
in structures since that pads to full sizeof(int).  Could this be
part of a bitfield?

> >  	/* Channel callback's invoked in softirq context */
> >  	struct tasklet_struct callback_event;
> >  	void (*onchannel_callback)(void *context);
> > @@ -936,6 +957,23 @@ static inline void *get_per_channel_state(struct
> > vmbus_channel *c)
> >  static inline void set_channel_pending_send_size(struct vmbus_channel *c,
> >  						 u32 size)
> >  {
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&c->outbound.ring_lock, flags);
> > +
> > +	if (size) {
> > +		++c->out_full_total;
> > +
> > +		if (!c->out_full_flag) {
> > +			++c->out_full_first;
> > +			c->out_full_flag = true;
> > +		}
> > +	} else {
> > +		c->out_full_flag = false;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&c->outbound.ring_lock, flags);

If this is called often, the additional locking will impact performance.

> >  	c->outbound.ring_buffer->pending_send_sz = size;
> >  }
> > 

Could I propose another alternative.

It might be more useful to count the guest to host interaction events
rather than the ring buffer.

For example the number of calls to:
	vmbus_set_event which means host exit call
	vmbus_setevent fastpath using sync_set_bit
	calls to rinbuffer_write that returned -EAGAIN

These would require less locking, reuse existing code paths
and not require additional state.

