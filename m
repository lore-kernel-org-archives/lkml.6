Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C1E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FlVKo4WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfBASQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:16:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBASQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:16:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so3594579plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92MOdog3g1rrw+f0J4sSvR6V++80ocs0no7dR7ocrno=;
        b=FlVKo4WP1AXLtLNweC08tJa5XVhzLfJgqqPfED848lSKiTYbhecepqtwhP87iyY8Zt
         6we/5ajnxrzWcT2zPEz1/+m8ngA+204ozijvxDZDtmP4vTJfz6jqeEcTubQmbGQdzYMh
         2qRjfHDEvux4nUnatffG6ZWyZo/cBI4EoCbbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92MOdog3g1rrw+f0J4sSvR6V++80ocs0no7dR7ocrno=;
        b=KdSUjSyP+HKSDIGZXoUt11/4wil6o5b/d//cUJElYCXVSQopVnLqPv8B7EZB+FE6Rf
         X+xpLlA1MTNxIFU4XyDItFn8DxGcbsi0ZjYk3FtmrJAvO7GcjE53uLcm+/xJLbSmBb40
         N4/UAmSegPToACs/t2JGt3Zwj99NtjXsnw4NGcy22z8M2Z+JhZVM3qiojC2vbaFxsUtS
         v/xhhi0G2n3nhHzLfT01NcYo97XP941f+Z6S7FC5pNWzKSBEEJORNxHc6UhcvqsJuhhh
         phGwLDzCC0kzro26GwWoOo3oHg3WZs8EOjnxXBnPMc4t5+5eHG7zYJwn+VRonjPU+dHp
         QM3Q==
X-Gm-Message-State: AJcUukciSlgi2F4N7t47O2AClFd8RXYe5nzA9o25o5LVWDXXePUpmdEt
        Bgn/xmAvcGm8x7u/MzU6pywnRw==
X-Google-Smtp-Source: ALg8bN4IDqSqlDP2zwoW0jr1vLZp93tJbSIl54f5/UrjpRB7BHhRFbG+L5T2RBbRyAsVRjzDiZZJVg==
X-Received: by 2002:a17:902:20c6:: with SMTP id v6mr40982572plg.156.1549044985773;
        Fri, 01 Feb 2019 10:16:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v190sm11060784pfv.26.2019.02.01.10.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:16:24 -0800 (PST)
Date:   Fri, 1 Feb 2019 10:16:24 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190201181624.GQ81583@google.com>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
 <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:09:53PM +0000, Quentin Perret wrote:
> Hi Sudeep,
> 
> On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> > On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > > +{
> > > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > > +	int ret, cpu = cpumask_first(cpus);
> > > +	struct device *cpu_dev;
> > > +	struct device_node *np;
> > > +	u32 cap;
> > > +
> > > +	cpu_dev = get_cpu_device(cpu);
> > > +	if (!cpu_dev)
> > > +		return;
> > > +
> > > +	np = of_node_get(cpu_dev->of_node);
> > > +	if (!np)
> > > +		return;
> > > +
> > 
> > Does it make sense to add the check for OPP count here. You need not pass
> > that as parameter. Just makes one less thing to check in new drivers adding
> > this support. Thoughts ?
> 
> Yeah Matthias had the same suggestion. I don't mind moving it here TBH.
> It's just that some users already do the opp count before calling this
> function, so I figured I could as well use that data instead of counting
> again.
> 
> But yeah, that's one less thing to worry about on the driver side so
> I'll move the OPP count in there for v4 and we'll see if people ask me
> to move it out to optimize things ;-)

From an API perspective it would be nice to get rid of the nr_opp
parameter, it seems somewhat arbitrary. Moving dev_pm_opp_get_opp_count()
from the drivers into dev_pm_opp_of_register_em() (instead of calling
it twice) also sounds good in general, as long as the error handling
doesn't become too messy. In the current version
dev_pm_opp_of_register_em() doesn't return a value, with the change it
would have to return one to catch an empty OPP table, and it needs
to be distinguished from other cases where the EM registration fails
but the cpufreq driver is still functional (e.g. no
'dynamic-power-coefficient'). Maybe return -ENOTSUPP in those cases?

Well, let's see how it looks like :)
