Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2284C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6173521019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEq3HqOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfAUQ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:29:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54791 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfAUQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:29:47 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so17161230ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPMrAw0VYjVeTLtgHSgwvU76nQdwPVRJhRGf5cyWYnU=;
        b=lEq3HqOnCIHKAhCVvOWHBUAqlTInb5n29l1d0Lczqtee0bVpT5F1JleSKkAUTvbizy
         z48G1YoRGFz2AzapKtcJGnKVCPmpcvyaacvtYpbnE6X25w0BKp6GNt5dRcOT3E1UTtd0
         BbRKJHsR3x32AZsIOqZMvBNDoaAlX36GIvgTfu+haqDLz9MUlFYMzrDlrLIdwBJaFvwt
         N7HISpeC9PJsMSKh1xrmStQ1RtFN7kuEXPr8XKL8s+8heeaYQu6CGY5Y0G5MhA6fXBSw
         ces+zCN9O3meFto6XFUSo89W2KjtGPhxHvUieasEZNbGfZRsUfZc0+4c3Tc8R0+0ShjE
         IqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPMrAw0VYjVeTLtgHSgwvU76nQdwPVRJhRGf5cyWYnU=;
        b=YmI0hoXqLr/pznXPL2KawvXjDe7tpYqwtW3GK6a3boGAyU8RMe2kd5eYFfU0SsNcPq
         ih5q8zPW0ej8vHv4JOB32yklQnT6W8KMnU3WHiLvet8uHM1nBhPiHX56kynHjOaF1x+d
         EhTGGvJ+xoExmexZf2T2Crzc2CR4REXWr1+E7gJ9wg3wI1dhHZNk0zjqJlX5WsuIlYKH
         iYz7pUbedDxD9p42TQYaVy/meTi/lIbP4rApvJwnPhY2Ex62amCZxhDAG9/wf8Zdz4QL
         JtbDsVGTPZfw9nqcT3PHVwX0uxaC7tzIQbA+5baVBC4js6T+qlyt8FUBl9SDxZv85CUY
         KZ8g==
X-Gm-Message-State: AJcUukdNr1/NWeT/UBwcboDes8kpHQFgi8iy0qLmnM8muSwBB3FB/BX8
        bPTRQ3YMUIawCydFUsngCX8=
X-Google-Smtp-Source: AHgI3IaN9nZ/Wki8LeRLRZOZd/MI5pBRGgv9ByCJA8CXsJ949ib1uABImJGi7vNU+TTLYUeazvTvww==
X-Received: by 2002:a24:1a90:: with SMTP id 138mr42619iti.171.1548088185910;
        Mon, 21 Jan 2019 08:29:45 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id h139sm6525077ith.24.2019.01.21.08.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 08:29:45 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:29:38 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Message-ID: <20190121162938.GA3544@ubu-Virtual-Machine>
References: <20190105043518.GA4072@ubu-Virtual-Machine>
 <20190117043759.GA3395@ubu-Virtual-Machine>
 <KU1P153MB0166DA6E76D0080C4AD43E01BF830@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
 <20190117091019.1fb0c186@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117091019.1fb0c186@hermes.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:11:03AM -0800, Stephen Hemminger wrote:
> 
> 
> > +static ssize_t channel_intr_in_full_show(const struct vmbus_channel
> > *channel,
> > +					 char *buf)
> > +{
> > +	return sprintf(buf, "%llu\n", channel->intr_in_full);
> > +}
> 
> 
> intr_in_full is u64, which is not the same as unsigned long long.
> to be correct you need a cast here.
>

Thanks for the feedback. I'll fix this issue in all four of the "_show"
functions that are added in this patch.


> > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > > index dcb6977afce9..7e5239123276 100644
> > > --- a/include/linux/hyperv.h
> > > +++ b/include/linux/hyperv.h
> > > @@ -751,6 +751,27 @@ struct vmbus_channel {
> > >  	u64	interrupts;	/* Host to Guest interrupts */
> > >  	u64	sig_events;	/* Guest to Host events */
> > > 
> > > +	/* Interrupt counts for 2 types of Guest to Host interrupts */
> > > +	u64 intr_in_full;	/* in ring buffer, full to not full */
> > > +	u64 intr_out_empty;	/* out ring buffer, empty to not empty */
> > > +
> > > +	/*
> > > +	 * The total number of write operations that encountered a full
> > > +	 * outbound ring buffer.
> > > +	 */
> > > +	u64 out_full_total;
> > > +	/*
> > > +	 * The number of write operations that were the first to encounter a
> > > +	 * full outbound ring buffer.
> > > +	 */
> > > +	u64 out_full_first;
> 
> Adding more fields changes cache layout which can cause
> additional cache miss in the hot path.  
>

Good point. I think that the "intr_out_empty" field is in a good
location, but the "intr_in_full", "out_full_first", and "out_full_total"
fields could be moved to the end of the struct. These variables are used
only when ring buffer full conditions occur. Ring buffer full conditions
shouldn't be encountered often, and, if they are, they're a signal that
changes should probably be made to prevent them.

If you have any other suggestions for this, please let me know.


> > > +	/*
> > > +	 * Indicates that a full outbound ring buffer was encountered. The flag
> > > +	 * is set to true when a full outbound ring buffer is encountered and
> > > +	 * set to false when a write to the outbound ring buffer is completed.
> > > +	 */
> > > +	bool out_full_flag;
> 
> Discussion on kernel mailing list. Recommends against putting bool
> in structures since that pads to full sizeof(int).  Could this be
> part of a bitfield?
> 

There are currently 4 other bool variables in this struct. Maybe some or
all of the bool variables could be placed adjacent to each other and
changed into bitfields. I'll need to look into this.


> > >  	/* Channel callback's invoked in softirq context */
> > >  	struct tasklet_struct callback_event;
> > >  	void (*onchannel_callback)(void *context);
> > > @@ -936,6 +957,23 @@ static inline void *get_per_channel_state(struct
> > > vmbus_channel *c)
> > >  static inline void set_channel_pending_send_size(struct vmbus_channel *c,
> > >  						 u32 size)
> > >  {
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&c->outbound.ring_lock, flags);
> > > +
> > > +	if (size) {
> > > +		++c->out_full_total;
> > > +
> > > +		if (!c->out_full_flag) {
> > > +			++c->out_full_first;
> > > +			c->out_full_flag = true;
> > > +		}
> > > +	} else {
> > > +		c->out_full_flag = false;
> > > +	}
> > > +
> > > +	spin_unlock_irqrestore(&c->outbound.ring_lock, flags);
> 
> If this is called often, the additional locking will impact performance.
>

In hv_sock, each call of "hvs_stream_has_space()" results in a call to
"channel_set_pending_send_size()", so this could be a concern. I'll work
on addressing this issue.


> > >  	c->outbound.ring_buffer->pending_send_sz = size;
> > >  }
> > > 
> 
> Could I propose another alternative.
> 
> It might be more useful to count the guest to host interaction events
> rather than the ring buffer.
> 
> For example the number of calls to:
> 	vmbus_set_event which means host exit call
> 	vmbus_setevent fastpath using sync_set_bit
> 	calls to rinbuffer_write that returned -EAGAIN
> 
> These would require less locking, reuse existing code paths
> and not require additional state.
> 

I'm not sure that this approach would provide the data that we're
looking for. For example, we're interested in evaluating how often ring
buffer write operations encounter full conditions. For this, we need to
know how many interaction events were caused by the ring buffer being
full. Counting the number of calls to "vmbus_set_event()" and
"vmbus_setevent()" wouldn't allow us to determine what caused the events.

For counting the full conditions, the number of calls to
"ring_buffer_write()" that returned -EAGAIN isn't sufficient because
hv_sock doesn't use the -EAGAIN path to determine that the ring buffer is
full. Therefore, we need to count the number of full conditions in both
"ring_buffer_write()" and "set_channel_pending_send_size()".

