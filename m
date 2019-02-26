Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845DE217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndDaqMz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBZCaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 21:30:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45453 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfBZCaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 21:30:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so5411289pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 18:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7SWs6AHlkoKZL84+QS5vhL33IlkH1Su2wgOZS/mNATw=;
        b=ndDaqMz00S7elCjbrTjkCpW+a1wm5OaMUy18WTk7lnAklR3W2pftVuBpQvmu5xux8V
         l4HDQreO3cf0VfRRSm9naYdc9PVtxpjhSyBjdC7d0/0yzGnCsAM7CXEaH9wIkrJjJjOY
         we2oGjjwvpWUSCLATGjF57zbF6DvMcNkIASOwJcISARgNdr85fEi8SYx2MueO1bxiRXI
         3ZnEU5YeAcLj1LMA8RQ0hbvFrpAX7O/YMcm3+BRiHxrZ9ZgzpHYdT8axgjKLSSt2lewG
         PxFf2m8x5IJkHFvEma/8n2OVsW57JhVObBMI9471HxzODeEF18/b0xuqJRjE64TGwiQz
         tfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7SWs6AHlkoKZL84+QS5vhL33IlkH1Su2wgOZS/mNATw=;
        b=gwQusPZH2/vdyLUL8ct1SuuEQ0U8db44eCHIE12K1nOh74nmXHwSX72aAqsIU3OgMd
         2/dMy+NvjoFJbCOz4QSGyOBb+XhjMV19qfUtaO3Tmn6s+H7d66NXzR3s4gUybamvNHTt
         9g40A/rUvK6C9rgJoTA8PVEfa76c4YjGdJ1LH6GSfghyH85ALxFHayq/HyShbnees2b+
         a5U+HCBvQnvKOPlGYxZSJMEDkTmo9+4ga1Zhr1XP2h2QiKkp7YRrqKgrjCwmK+gYUCjv
         cKnSCWUSGYEx+vIoVp9BRzMHbffgo50Yg71zw7Sn6Dyoc/8Ds9skbMaOFpTbGvk2u3Gn
         9R8w==
X-Gm-Message-State: AHQUAuYUy5WheyySi5nQK9erLCKQnTK1EO15mXFSHfsnM+jn1rxr8Ql8
        FHT3JdL/Ul13Rc/rPihQt6ipBA==
X-Google-Smtp-Source: AHgI3IaH8sFzTQfkE7Xii6ptj/T8owf3YZRfVjhpQKl/1tSyC6vgprT1wxACsYkalt/5pOk5aIwDWw==
X-Received: by 2002:a65:64c4:: with SMTP id t4mr18715324pgv.152.1551148220024;
        Mon, 25 Feb 2019 18:30:20 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id h2sm14356983pfo.163.2019.02.25.18.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 18:30:18 -0800 (PST)
Date:   Tue, 26 Feb 2019 08:00:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190226023016.ooyjsiopsyc6vg5s@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
 <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
 <20190225085847.yvrtmxtwvk725b7v@e107158-lin.cambridge.arm.com>
 <20190225090955.suq4jw26d2brkjha@vireshk-i7>
 <20190225121458.fvdiiumgyhhdardw@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225121458.fvdiiumgyhhdardw@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-19, 12:14, Qais Yousef wrote:
> On 02/25/19 14:39, Viresh Kumar wrote:
> > On 25-02-19, 08:58, Qais Yousef wrote:
> > > On 02/25/19 10:01, Viresh Kumar wrote:
> > > > > > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > > > > > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > > > > > +
> > > > > > +	if (min > new_policy->min)
> > > > > > +		new_policy->min = min;
> > > > > > +	if (max < new_policy->max)
> > > > > > +		new_policy->max = max;
> > 
> > > And this is why we need to check here if the PM QoS value doesn't conflict with
> > > the current min/max, right? Until the current notifier code is removed they
> > > could trip over each others.
> > 
> > No. The above if/else block is already removed as part of patch 5/5. It was
> > required because of conflict between userspace specific min/max and qos min/max,
> > which are migrated to use qos by patc 5/5.
> > 
> > The cpufreq notifier mechanism already lets users play with min/max and that is
> > already safe from conflicts.
> > 
> > 
> > > It would be nice to add a comment here about PM QoS managing and remembering
> > > values
> > 
> > I am not sure if that would add any value. Some documentation update may be
> > useful for people looking for details though, that I shall do after all the
> > changes get in and things become a bit stable.
> > 
> 
> Up to you. But not everyone is familiar with the code and a one line comment
> that points to where aggregation is happening would be helpful for someone
> scanning this code IMHO.

Okay, will add something then.

> > > and that we need to be careful that both mechanisms don't trip over
> > > each others until this transient period is over.
> > 
> > The second mechanism will die very very soon once this is merged, migrating them
> > shouldn't be a big challenge AFAICT. I didn't attempt that because I didn't
> > wanted to waste time updating things in case this version also doesn't make
> > sense to others.
> > 
> > > I have a nit too. It would be nice to explicitly state this is
> > > CPU_{MIN,MAX}_FREQUENCY. I can see someone else adding {MIN,MAX}_FREQUENCY for
> > > something elsee (memory maybe?)
> > 
> > This is not CPU specific, but any device. The same interface shall be used by
> > devfreq as well, who wanted to use freq-constraints initially.
> > 
> 
> I don't get that to be honest. I probably have to read more.
> 
> Is what you're saying that when applying a MIN_FREQUENCY constraint the same
> value will be applied to both cpufreq and devfreq? Isn't this too coarse?

Oh no. A constraint with QoS is added like this:

        dev_pm_qos_add_request(dev, req, DEV_PM_QOS_MIN_FREQUENCY, min);

Now dev here can be any device struct, CPU's or GPU's or anything else. All the
MIN freq requests are stored/processed per device and for a CPU in cpufreq all
we will see is MIN requests for the CPUs. And so the macro is required to be a
bit generic and shouldn't have CPU word within it.

Hope I was able to clarify your doubt a bit. Thanks.

-- 
viresh
