Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22AD20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvtpsnKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAVRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:50:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42529 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:50:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so11382004pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J0lWivIqJSWPLJEIUEj0z08uyJuPVVlNV6NSc61Yen0=;
        b=jvtpsnKNpO1tYovFfMhDqz4FL2D8L3fYoEOkTadwHPmhkRiyhuBB6gC8qsIaq+WHRd
         Gr9Elf+M4jSvpb9eR+hYuoO9hIOL3n0tpk7poSeVu6jMtKe96JRqaRE/L00uhmQzYbfH
         nnrn/qO0Xi6UHGHUWdJmmsDO6mzC0DepC5nKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J0lWivIqJSWPLJEIUEj0z08uyJuPVVlNV6NSc61Yen0=;
        b=GjDVKhjIUXSfBXIEbvyyu/dvnc0WO8NwQrZv9dzPxYmnCXCv+1SALelMWXuZTxdbLN
         HRMhuufK0SZXCwqul18a8derQAH4+Z7cs8nQ7IoQ9VwPPX5TpfmDVboQatOsLo9EOGyc
         hg7PFW/ZIqft8S+Ruk+tWFD5fCYZCohZR+zJ8RsgJERK3esouKOuiBdhQnZ6s46J2BzH
         FO/QdD+tRUwXDaD+uEp8EjuriSOZ6y2xv/9/Rdfqvt3tz2D/USMo+uiUOuPsTqiAO3q8
         8IayzqziprtgtNnBR9ngmgzhETmdLhooq66P6AZ9Z7Es/2baS9TeTUQJDb98sZrBa0BS
         krYw==
X-Gm-Message-State: AJcUukdYI9vdAlpMJSB7O9auTG8QRoBFUjoBRcyaWIuBG5ObtIoHhlSc
        bA/EqkXGvTR7BdDrnDX2RPoXOA==
X-Google-Smtp-Source: ALg8bN62t3VmAOgxquLpwQZmC5AXlq4m9V2KlrwHVWDc41/nOIsB7D1p43ykhR0Jq0UrmK9+Cq7bug==
X-Received: by 2002:a63:d604:: with SMTP id q4mr32492081pgg.175.1548179443509;
        Tue, 22 Jan 2019 09:50:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u69sm28069187pfj.116.2019.01.22.09.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 09:50:42 -0800 (PST)
Date:   Tue, 22 Jan 2019 09:50:42 -0800
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
Message-ID: <20190122175042.GE261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
 <20190118010305.GX261387@google.com>
 <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
 <20190118224534.GC261387@google.com>
 <20190122070936.jsjvivzplfpdweck@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122070936.jsjvivzplfpdweck@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:39:36PM +0530, Viresh Kumar wrote:
> On 18-01-19, 14:45, Matthias Kaehlcke wrote:
> > On Fri, Jan 18, 2019 at 03:32:34PM +0530, Viresh Kumar wrote:
> > > On 17-01-19, 17:03, Matthias Kaehlcke wrote:
> > > > On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> > > > > +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> > > > > +		       enum fc_event event)
> > > > > +{
> > > > > +	mutex_lock(&fcs->lock);
> > > > > +
> > > > > +	if (_fcs_update(fcs, freq, event)) {
> > > > > +		if (fcs->callback)
> > > > > +			schedule_work(&fcs->work);
> > > > 
> > > > IIUC the constraints aren't applied until the callback is executed. I
> > > > wonder if a dedicated workqueue should be used instead of the system
> > > > one, to avoid longer delays from other kernel entities that might
> > > > 'misbehave'. Especially for thermal constraints we want a quick
> > > > response.
> > > 
> > > I thought the system workqueue should be fast enough, it contains
> > > multiple threads which can all run in parallel and service this work.
> > 
> > Ok, I was still stuck at the old one thread per CPU model, where a
> > slow work would block other items in the same workqueue until it
> > finishes execution. After reading a bit through
> > Documentation/core-api/workqueue.rst I agree that a system workqueue
> > is probably fast enough. It might be warranted though to use
> > system_highpri_wq here.
> 
> Is this really that high priority stuff ? I am not sure.

In terms of thermal it could be. But then again, thermal throttling is
driven by input from thermal sensors, which often are polled with
periods >= 100 ms rather than being interrupt driven, so the type of
workqueue wouldn't make a major difference here. I now think it should
be fine to use the normal workqueue unless problems are reported.
