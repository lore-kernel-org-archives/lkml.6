Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7351DC5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D8120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzuWUGp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfARWph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:45:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44754 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfARWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:45:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so6940528plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vE+GFFAs0SL0g7lQx5BpIQpFtFj61cY+qRhW080jkkA=;
        b=dzuWUGp8pUVAry45JBppGT6bUTDsk3bhemfCoUpnZZjC7HWF/kgxe8MHNIeTW3mTJM
         39v9aMShMzW6M24m5F+l6OzQ+6o0/0Yg8fopgcs/fkTlA0nRjoEy5FbVNaNkvGQRMsME
         H8lhz90E6R2GdxNHAga6bew4nZNDynhZcOsu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vE+GFFAs0SL0g7lQx5BpIQpFtFj61cY+qRhW080jkkA=;
        b=hN34CeZ1jpPMrfxz80uwb0c1+fTMlwOW1rLzaVR7h/eOZ9DV9+y1TPoIH3E1Ig3chE
         fbiS7OwSswxFVXrkEU6UKr1mqbmQpHxGn22gH9BIdO5QEVMc0RgjL59UynI5dcY5FtnH
         hw52BRoBbGMxdRU8q/PQ40ZN+SbNGeT8gV+Qc5VfrRpJ9lhtbIX8ZVXkP7DLTRoAy5aI
         f+kuwNOmiN42X2ht/lvDZ0KIpPGAK180OAUbbI2L7ViuOVhjCZIqqubjXmFU2e8hM7oU
         KATp+sQmazZcooRiZr5VRqr+dn3BVG830OC43fHnvNia4GcpfJJVKgEWkYHwww40fSy+
         fYfQ==
X-Gm-Message-State: AJcUuketdDRf0WbVIh2UsJfKlrTYdP0zoH/lJQt07dCxz3RFTZZeplpB
        PsxDgdj0CPBJcyQJKwEftuBmYTDPKRw9EQ==
X-Google-Smtp-Source: ALg8bN4YTszNZ682R/hXnevfdcm1ltys4llJlQzp+m2FkGa5iRAdITFrlzsfdhFHqP8eVvt/u3k4vA==
X-Received: by 2002:a17:902:b494:: with SMTP id y20mr21294702plr.178.1547851536468;
        Fri, 18 Jan 2019 14:45:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g136sm7242097pfb.154.2019.01.18.14.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:45:35 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:45:34 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: base: Add frequency constraint
 infrastructure
Message-ID: <20190118224534.GC261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
 <20190118010305.GX261387@google.com>
 <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:32:34PM +0530, Viresh Kumar wrote:
> On 17-01-19, 17:03, Matthias Kaehlcke wrote:
> > On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> > > +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> > > +		       enum fc_event event)
> > > +{
> > > +	mutex_lock(&fcs->lock);
> > > +
> > > +	if (_fcs_update(fcs, freq, event)) {
> > > +		if (fcs->callback)
> > > +			schedule_work(&fcs->work);
> > 
> > IIUC the constraints aren't applied until the callback is executed. I
> > wonder if a dedicated workqueue should be used instead of the system
> > one, to avoid longer delays from other kernel entities that might
> > 'misbehave'. Especially for thermal constraints we want a quick
> > response.
> 
> I thought the system workqueue should be fast enough, it contains
> multiple threads which can all run in parallel and service this work.

Ok, I was still stuck at the old one thread per CPU model, where a
slow work would block other items in the same workqueue until it
finishes execution. After reading a bit through
Documentation/core-api/workqueue.rst I agree that a system workqueue
is probably fast enough. It might be warranted though to use
system_highpri_wq here.

Cheers

Matthias
