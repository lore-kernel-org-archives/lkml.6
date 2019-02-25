Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D666BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DC32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr+FDfO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBYJKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:10:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36099 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:09:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id k2so4218533plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHAbSUS+P+5f24kL/DzQ7EgofGLqa0YK/KJ7xMMErDg=;
        b=kr+FDfO8l32s+fgO+UM/JrYvaor8ctJbYS46X7tw/NqXdEZ6hrcwEulsY67l2wrx3I
         MGL4gNp7gJtNRS4l8qgk+P6TC1SUVeTUlDvBLZZZmjgGvemINVzLmfIZK+oB0YbfOsZH
         aVxEuRFgniELaKetCgjGP8Sd7MamoFw/eWSdHnRz9jONzt5tK/s0jmWAGvsWYd3uc137
         hrAPMw02E1989xCR6zpEdIBetrC1o2PbUZkgeDSLqOfej+RMdYabxH94oDxMwiJ4I2Yf
         57o/5+m5SK34q3WJOZ6zTQWO2U6MlyNuIeb/QGiLGbXZfbRkNf9FcjIG5iw3p6GkO/Qh
         YBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHAbSUS+P+5f24kL/DzQ7EgofGLqa0YK/KJ7xMMErDg=;
        b=sO2OR0S8U5nPbpcEZwhgeYq/a22qfEOh5eUb4sqOwCWyHBxNfrcZJY7T9yNW8TntJc
         cCttYnW1ug78o0NYZMtFI4o7QGIu/kHrDICTBhErFST//MQIhSr2czErPDA+mfhIaUGF
         5AXZMzXwxcyeGkl/uLWLZcKebeYHBIGVgRtzXJMdqoQwUpHLVgG5HoYkqlEC4FrJhfIT
         nLcabQCjGZZduTd2gzXDs4A256JOrrpDg+mDGxyDPF9l4CaNbY+7GJDn+2o7YzR5xNcd
         tMpbevgaYhLPYf7+uexbN3qOrqNGmXJAbRYSdS/VWOJLiSPrpqKu74nInD1wDlE7NeFE
         aM7Q==
X-Gm-Message-State: AHQUAua2ri5rcLEsJFcCxuE7qadu2E1oXI4/BzLUJFEYfRjo1tJcloi2
        VbzbUtx0FQ7SUi9FiIl16Z9Mjw==
X-Google-Smtp-Source: AHgI3IauvrZsPuytPTWfjkQhgxbDkVEQ9oxNwNJ5I/WxwJKLqdWBfUCkAsNdkAmJRWWOhYpFrU4lFA==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr19123197pln.117.1551085798738;
        Mon, 25 Feb 2019 01:09:58 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id k74sm21559732pfb.172.2019.02.25.01.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 01:09:57 -0800 (PST)
Date:   Mon, 25 Feb 2019 14:39:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190225090955.suq4jw26d2brkjha@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
 <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
 <20190225085847.yvrtmxtwvk725b7v@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225085847.yvrtmxtwvk725b7v@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-19, 08:58, Qais Yousef wrote:
> On 02/25/19 10:01, Viresh Kumar wrote:
> > > > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > > > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > > > +
> > > > +	if (min > new_policy->min)
> > > > +		new_policy->min = min;
> > > > +	if (max < new_policy->max)
> > > > +		new_policy->max = max;

> And this is why we need to check here if the PM QoS value doesn't conflict with
> the current min/max, right? Until the current notifier code is removed they
> could trip over each others.

No. The above if/else block is already removed as part of patch 5/5. It was
required because of conflict between userspace specific min/max and qos min/max,
which are migrated to use qos by patc 5/5.

The cpufreq notifier mechanism already lets users play with min/max and that is
already safe from conflicts.


> It would be nice to add a comment here about PM QoS managing and remembering
> values

I am not sure if that would add any value. Some documentation update may be
useful for people looking for details though, that I shall do after all the
changes get in and things become a bit stable.

> and that we need to be careful that both mechanisms don't trip over
> each others until this transient period is over.

The second mechanism will die very very soon once this is merged, migrating them
shouldn't be a big challenge AFAICT. I didn't attempt that because I didn't
wanted to waste time updating things in case this version also doesn't make
sense to others.

> I have a nit too. It would be nice to explicitly state this is
> CPU_{MIN,MAX}_FREQUENCY. I can see someone else adding {MIN,MAX}_FREQUENCY for
> something elsee (memory maybe?)

This is not CPU specific, but any device. The same interface shall be used by
devfreq as well, who wanted to use freq-constraints initially.

> Although I looked at the previous series briefly, but this one looks more
> compact and easier to follow, so +1 for that.

Thanks for looking into this Qais.

-- 
viresh
