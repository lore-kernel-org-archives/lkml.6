Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B79C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9940720855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrlgvsSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfARKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:02:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32857 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfARKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:02:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so6382476pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ValN1BOpskedAoOahnEwAFPQVOIvT1EFFmpRY0rd+Fg=;
        b=QrlgvsSF+dPED2XagkGVdbG0R8rU75wWTwXBSNkEnMq6i0bFNaKdTNgXhmk4zW2c3V
         2t3Z9ZMpNlOAIsm33BMaEMcCExP6SkFgbjbxSU5pPzUhZx2MlkuFqxrfk4+ZgkjDf7uW
         +uKLJMckWrw41gzwB3OGwjQmByyxrZwFlXNic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ValN1BOpskedAoOahnEwAFPQVOIvT1EFFmpRY0rd+Fg=;
        b=XeaZ1/n7L2bLU4OuJCa6pIqLOWYLrT01hR1e3Tgneu8ixUNZWw0Gvn5u1xfsXmtOFC
         6qKJJz8Vtkotw2J/mFomR01tcIErT1c8Vw6VMKzqDF/nJ3IkhShTGj3VqKOcJGJ6aSzz
         pxvZuomGfayPTcpNUwjTrE62H2JO6nEXv6B+5tP6PeExApNTksaZ5oNqFbLnwoJKdoFr
         KZc306JIXaxRtcJ3wzPX44UjvCJ+ex+CgzlxVv9Owcf3igvWU6i3x4Ts8mYfFIwP6suU
         6aXxT7nhuZlQ3oZeBCxxpA0L0jxVI2ierAJB8iQ8op1ZvyhKmw5DRUgOkU63hAJbYfNp
         2zXQ==
X-Gm-Message-State: AJcUukct4w3BYbI0/87pWEMWf84UOwdXKuprc5zBdrk9F+csbcetnM3N
        dqDd++Oe0gYiOGj2x3HZ81UeaA==
X-Google-Smtp-Source: ALg8bN6SmcMt5sLtNJKTA+ozwkFPqtwLMDuop3+Kb3anqeolghYM+jMItjyRFSsJvJpP1BSwlvSGIw==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr18932569pfm.253.1547805757139;
        Fri, 18 Jan 2019 02:02:37 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id s21sm6780433pfk.133.2019.01.18.02.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:02:36 -0800 (PST)
Date:   Fri, 18 Jan 2019 15:32:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: base: Add frequency constraint
 infrastructure
Message-ID: <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
 <20190118010305.GX261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118010305.GX261387@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 17:03, Matthias Kaehlcke wrote:
> On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> > +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> > +		       enum fc_event event)
> > +{
> > +	mutex_lock(&fcs->lock);
> > +
> > +	if (_fcs_update(fcs, freq, event)) {
> > +		if (fcs->callback)
> > +			schedule_work(&fcs->work);
> 
> IIUC the constraints aren't applied until the callback is executed. I
> wonder if a dedicated workqueue should be used instead of the system
> one, to avoid longer delays from other kernel entities that might
> 'misbehave'. Especially for thermal constraints we want a quick
> response.

I thought the system workqueue should be fast enough, it contains
multiple threads which can all run in parallel and service this work.

> > +
> > +	/* Find a CPU for which fcs already exists */
> > +	for_each_cpu(cpu, cpumask) {
> > +		cpu_dev = get_cpu_device(cpu);
> > +		if (unlikely(!cpu_dev))
> > +			continue;
> > +
> > +		if (unlikely(!first_cpu_dev))
> > +			first_cpu_dev = cpu_dev;
> 
> I'd expect setting the callback to be a one time/rare operation. Is
> there really any gain from cluttering this code with 'unlikely's?
> 
> There are other functions where it could be removed if the outcome is
> that it isn't needed/desirable in code that only runs sporadically.

I was looking to make the code as fast as possible and the use of
unlikely doesn't look that bad to me. Lets see what others have to say
on such a policy.

> > +	if (ret)
> > +		remove_cpumask_fcs(fcs, cpumask, cpu);
> 
> I think it would be clearer to pass -1 instead of 'cpu', as in
> freq_constraint_remove_cpumask_callback(), no need to backtrack and
> 'confirm' that the above for loop always stops at the last CPU in the
> cpumask (unless the function returns due to an error).

Okay.

-- 
viresh
