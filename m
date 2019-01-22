Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1862520854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJhuLPZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAVHJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:09:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38405 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfAVHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:09:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so11311893pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oCVppQxmkZXSCO8DambkFCmORWpSe6DSUbLfn9f7gcU=;
        b=kJhuLPZhNYRktgvR8yDaVXOyiBae7j/vKLEnacYTouYXhPCuBPbNzGTnavVo/GEfX7
         SVD/+bv4xCPytnQyfQspFtZsVf686Q75D61mRYcU6lkAXN5CYnqqeswO7J++P+oOd6HO
         0QoQmclcsv7qsHR+nQ6z8BSj3w8Mg0OCY1KWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oCVppQxmkZXSCO8DambkFCmORWpSe6DSUbLfn9f7gcU=;
        b=XV5lQpRBN4saKDp50Aj0Qpf6pbUzsIK8JKwJWYagQE1eS5T8rtF89A9CY+AwExAdt8
         F3CPhy7vqJmXU/DtYDQ2Fvrm3tXRtXI/SPO0pJg61j51X3lHakSHRCrV/ar17h7bUEX4
         u7i/Kc6Nf0rHqRQXLKDrAbWZZ8XY+NdYjNRov68sybbVtY5hRunCqh8hOa0yjPjDfPZY
         Nu2gTr2rAdVeZEiA8UfVgwG6g7Tc01Kx2sE1jyylQ7bV/av8lm1pwX7dgjoHGHZfVWBX
         7RD2rjJx03nBvTsebgVcMwom6yyEqAQFBQtwtrQ5caBVneYAw3pezfrRAW9328AD6+Jr
         3Jyw==
X-Gm-Message-State: AJcUukdn8t6f4+0n8l5zvNkh9En5SeSOoyG1VTt086Td1DIErafKRol+
        7PXfUatNpN+jhj2TpbTcl15gfg==
X-Google-Smtp-Source: ALg8bN7kkmek6seVLK2nptpBQ/XDB6StfCbIA4g9k2PEUgV0czE8vCk8I96aPZ0PIDcbv/ysGjd05A==
X-Received: by 2002:a62:9913:: with SMTP id d19mr32395257pfe.107.1548140978910;
        Mon, 21 Jan 2019 23:09:38 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id z9sm36786541pfd.99.2019.01.21.23.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 23:09:38 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:39:36 +0530
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
Message-ID: <20190122070936.jsjvivzplfpdweck@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
 <20190118010305.GX261387@google.com>
 <20190118100234.kq37hc4ldujqvvrb@vireshk-i7>
 <20190118224534.GC261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118224534.GC261387@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-19, 14:45, Matthias Kaehlcke wrote:
> On Fri, Jan 18, 2019 at 03:32:34PM +0530, Viresh Kumar wrote:
> > On 17-01-19, 17:03, Matthias Kaehlcke wrote:
> > > On Fri, Jan 11, 2019 at 02:48:34PM +0530, Viresh Kumar wrote:
> > > > +static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
> > > > +		       enum fc_event event)
> > > > +{
> > > > +	mutex_lock(&fcs->lock);
> > > > +
> > > > +	if (_fcs_update(fcs, freq, event)) {
> > > > +		if (fcs->callback)
> > > > +			schedule_work(&fcs->work);
> > > 
> > > IIUC the constraints aren't applied until the callback is executed. I
> > > wonder if a dedicated workqueue should be used instead of the system
> > > one, to avoid longer delays from other kernel entities that might
> > > 'misbehave'. Especially for thermal constraints we want a quick
> > > response.
> > 
> > I thought the system workqueue should be fast enough, it contains
> > multiple threads which can all run in parallel and service this work.
> 
> Ok, I was still stuck at the old one thread per CPU model, where a
> slow work would block other items in the same workqueue until it
> finishes execution. After reading a bit through
> Documentation/core-api/workqueue.rst I agree that a system workqueue
> is probably fast enough. It might be warranted though to use
> system_highpri_wq here.

Is this really that high priority stuff ? I am not sure.

-- 
viresh
