Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C2FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B77120861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMXBbatg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfAVGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:42:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36121 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAVGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:42:50 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so18696196itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 22:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndWGJy7fWM7SEDYQT9UtimesU13A7WSjjIXUhm+p4kw=;
        b=HMXBbatgpTHWNYlUjPDxEbtCJN2vqrNWbWG5lSa+uPssbhwYP+3zlxGkV6kN0FQ4Mr
         t3uM4tILFgVhtzFna1nVaZGdb+XWtEiMQZn3sv3/OD1061pOZXvhL7dO3DmVtbyhAaB4
         YSgxiKaytlowdZ7+YBW0i549c083TaPHaUQdYKMLWGVp6aVm+09K5QrBCIBT1sbNfE5k
         MdTYTqRnSxr8ZV47Exf+kFJg15QEVI0dYOwk24MM8BAvMCacnkll1qL0C3O7R6myzyYr
         R0zfiMQFBdWRiIloPjbBmXsHhbw4jM7n9ZrDbOmIwPNUjPp1eAwn4Xtl6GmAY9HNwA+G
         BQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndWGJy7fWM7SEDYQT9UtimesU13A7WSjjIXUhm+p4kw=;
        b=JleJB/T1KC9Kbg+AHOErG5KhRtcjk4R36EgCh3SX9b+75PhVtr/VXjGWxGKNLupbbX
         WRyjR70OyboUTdN0G4CDBlNltHXOHQsPcezPrBjISsW9JXhKd5PfFlaI6DIK3hk5+BVw
         ITGe/UsRRCmq0jN5p9unmm5QE7tb5xV85nkta6igQaBZWpXKEK9ysDE2OAGvRn/cXQpn
         jF/vDsV+LfXT8LVlBWlJE9HOKK56mS/4Z5SPx0FDTf9YJFtnbAfNf2Zg5uHO0KsT4l4H
         anHpDqdiiQB4irMJ27iItTPwJ4G0e57maLx+yI/H6kAG3IUlcu2/H1w+JElyi0Y94S2w
         Badg==
X-Gm-Message-State: AJcUukdK2zqRV6TjmzTtlq0ZmU2oIM3mI5OUErvhKt+amNzyyuHlVX3A
        8MXz/sQNgriqrG9Mnco/oa8=
X-Google-Smtp-Source: AHgI3IY/96UkGbISUQlpqK/6PZQUqusK7crG8gGfiXuIIk2DAlbnu/REs/ViJ1Ps75fA3Zdy1eyU5Q==
X-Received: by 2002:a24:e302:: with SMTP id d2mr1432723ith.155.1548139369635;
        Mon, 21 Jan 2019 22:42:49 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id t7sm5790313iom.27.2019.01.21.22.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 22:42:49 -0800 (PST)
Date:   Tue, 22 Jan 2019 01:42:46 -0500
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
Message-ID: <20190122064246.GA28613@ubu-Virtual-Machine>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:46:48AM +0000, Dexuan Cui wrote:
> > From: Kimberly Brown <kimbrownkd@gmail.com>
> > Sent: Monday, January 21, 2019 6:08 PM
> > Subject: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show functions
> > 
> > The channel level "_show" functions are vulnerable to race conditions.
> > Add a mutex lock and unlock around the call to the channel level "_show"
> > functions in vmbus_chan_attr_show().
> > 
> > This problem was discussed here:
> > https://lkml.org/lkml/2018/10/18/830
> > 
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1414,6 +1414,7 @@ static ssize_t vmbus_chan_attr_show(struct kobject
> > *kobj,
> >  		= container_of(attr, struct vmbus_chan_attribute, attr);
> >  	const struct vmbus_channel *chan
> >  		= container_of(kobj, struct vmbus_channel, kobj);
> > +	ssize_t ret;
> > 
> >  	if (!attribute->show)
> >  		return -EIO;
> > @@ -1421,7 +1422,10 @@ static ssize_t vmbus_chan_attr_show(struct
> > kobject *kobj,
> >  	if (chan->state != CHANNEL_OPENED_STATE)
> >  		return -EINVAL;
> > 
> > -	return attribute->show(chan, buf);
> > +	mutex_lock(&vmbus_connection.channel_mutex);
> > +	ret = attribute->show(chan, buf);
> > +	mutex_unlock(&vmbus_connection.channel_mutex);
> > +	return ret;
> >  }
> 
> It looks this patch is already able to fix the original issue:
> 6712cc9c2211 ("vmbus: don't return values for uninitalized channels"),
> as chan->state can't be CHANNEL_OPENED_STATE when
> channel->ringbuffer_page is not set up yet, or has been freed.
> 
> Thanks,
> -- Dexuan

I think that patch 6712cc9c2211 fixes the problem when the channel is
not set up yet, but it doesn't fix the problem when the channel is being
closed. The channel could be freed after the check that "chan->state" is
CHANNEL_OPENED_STATE, while the "attribute->show()" function is running.

Actually, there should be checks that "chan" is not null and that
"chan->state" is CHANNEL_OPENED_STATE within the locked section. I'll
need to fix that.
