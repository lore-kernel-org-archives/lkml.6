Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BECC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA25920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA25920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJPVhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:37:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeJPVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:37:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so25621822wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4y/FV5ULAiX9E5VTGl1UX33BFZt7Sw86vT2QEBhx/0=;
        b=rKIt/hoRrsvo+Fd3CVcfrYaufA29DfANyvUSa2ee/OYwLCAeTc0KJmL7FJ1hOjiS1E
         EV9D3ThL4oGTUHD0afZvvgwf+lF3bHBsN54E5XFvW0DDJMR+SMiGLaT+2YJkYd3jBT+s
         sq0Y6QPIRzrWyDtiB5RpcBkmkZID6n+E3gUCXbRt8EKBOGpMSZA9/fSU1PCByuEsGh+B
         U6//6goWT5cKn9e9f7C0fJNL5Obx9K5qAyPOpwirdIjvxV9OUIKd67hteIGlXw13DoF/
         sP5ONRAgTZVYh7o1wmfjXpxhrH+6apFy+OeGd+DFttFoFuTtvOUhtupKxF059JxNiSMo
         uDaA==
X-Gm-Message-State: ABuFfogv5ZS9ILikp0jhi03SX1zxZOnNz+2GxXSll2NddxQ6mWj5rtIh
        6X52pNe1uoVxla5ju+aSCMKYZQ==
X-Google-Smtp-Source: ACcGV60EhDNHxbO4PltUobFB1H9ISiXHQrBMEaQvIWuu1wo1AUlkYfyQ51zR+WXNXc2LCUj4qrQ/RA==
X-Received: by 2002:a5d:4b84:: with SMTP id b4-v6mr19503135wrt.168.1539697600506;
        Tue, 16 Oct 2018 06:46:40 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id v184-v6sm10260119wme.3.2018.10.16.06.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 06:46:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:46:36 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v8 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Message-ID: <20181016134636.GE9130@localhost.localdomain>
References: <20181016101513.26919-1-quentin.perret@arm.com>
 <20181016101513.26919-11-quentin.perret@arm.com>
 <20181016125058.GD9130@localhost.localdomain>
 <20181016133451.w2y3gwj2c56cvy5c@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016133451.w2y3gwj2c56cvy5c@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 14:36, Quentin Perret wrote:
> Hi,
> 
> On Tuesday 16 Oct 2018 at 14:50:58 (+0200), Juri Lelli wrote:
> > Hi,
> > 
> > On 16/10/18 11:15, Quentin Perret wrote:
> > 
> > [...]
> > 
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index cc02050fd0c4..481309a11174 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -466,6 +466,17 @@ static struct ctl_table kern_table[] = {
> > >  		.extra1		= &one,
> > >  	},
> > >  #endif
> > > +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > > +	{
> > > +		.procname	= "sched_energy_aware",
> > > +		.data		= &sysctl_sched_energy_aware,
> > > +		.maxlen		= sizeof(unsigned int),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= sched_energy_aware_handler,
> > > +		.extra1		= &zero,
> > > +		.extra2		= &one,
> > > +	},
> > > +#endif
> > 
> > Doesn't this need to be documented in Documentation/sysctl/kernel.txt?
> 
> Right, that'd be a good practice indeed. What do you think about the
> patch below ?

LGTM.

> > Also, do we want a kernel parameter as well to be able to disable this
> > at boot?
> 
> Yeah, why not. But I guess we could always add that later if need be ?

Sure. Works with me.

Thanks,

- Juri
