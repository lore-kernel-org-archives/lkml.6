Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2467CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B172145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQfj/e24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B172145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJSQHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:07:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:07:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id q6-v6so60594wrw.11;
        Fri, 19 Oct 2018 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=opCaYfrpEa/EVdz9pPkMNW4gQKrjrvAewXBnDKVtXAk=;
        b=QQfj/e24Z2NIT02hvXXy98nuqxff2JVQ76zjF+A9gNWg32LLMsHGZbUQ0tD/GNLG0m
         qAV4+EJVIJkreEswVB3reZST79/oFXVyhUJhxzvCFJO6YqdcNncs6bgUuM6KZkFzSVsm
         OwGKNGQHoLecXFDrbiV82lS+CrePbiMfazEJJatbs2NaWkuv/ty7ywCOkjmeLW+ZHEss
         jXLbvicVEeXNohvea9DuBmmBMiuhhVo+PX0UPLUiYeCZQ7Kw2K0Y7MWt7HWlZ2mJ1jyf
         4ZiUcuKiQ2EIol0KIPDuVE1juH6+tRUky3WELn7KJLlYUN+blGgO+fY0K51Ulmvy+sM7
         c1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=opCaYfrpEa/EVdz9pPkMNW4gQKrjrvAewXBnDKVtXAk=;
        b=n9PHy0oHoDC+JQv8+Xf9rQWXfyQASd3A4iCXjxTQU165Rt7EaRbr6EG+cuUlXv4nLs
         vknTulQHIWaGEFvByR3a+8bD52gbTBx3PbvXpXdeazUDzIjspyORl230HH5TU6Ay0aU6
         cL94ZUxntybE36GO80Fc2CtmNlFN4twv6BO/xBho5l3zZy1mSLe826RsHYUwx9Kj1HsK
         hFco/kcFfPFJfQiIlPMXuUMOq4lj9W6H9m/SRJ33cTfMLF/G8K6fJCFmoGMVTyqYKpAF
         gRgYwJerzSjzVoXSL1gmOUGUTuhNfdCKi1nCBrTCoF2gmt6iVnMdwfJeIEN60/fzk26b
         tp4A==
X-Gm-Message-State: ABuFfojUoSjsHhNWg1ZTciGdgFqLgbssKtyDd+tGTWD+8pkVgC5TjIoc
        g3fUEpzLhvFGFRhkio4KA2c=
X-Google-Smtp-Source: ACcGV60LzPTRcB2TOEVxmwDMfjU5l2M7tJVwORapw2jfyBw9ynQdspReazVT52ku2nf2lDHY6hGe3A==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr30685523wrx.315.1539936141913;
        Fri, 19 Oct 2018 01:02:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l195-v6sm2369480wmd.37.2018.10.19.01.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:02:20 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:02:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181019080218.GA35752@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
 <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com>
 <5BC8B226.2040109@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BC8B226.2040109@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> > Yeah, so I'd definitely suggest to not integrate this averaging into 
> > pelt.c in the fashion presented, because:
> > 
> >  - This couples your thermal throttling averaging to the PELT decay
> >    half-time AFAICS, which would break the other user every time the
> >    decay is changed/tuned.
>
> Let me pose the question in this manner. Today rt utilization, dl 
> utilization etc is tracked via PELT. The inherent idea is that, a cpu 
> has some capacity stolen by let us say rt task and so subtract the 
> capacity utilized by the rt task from cpu when calculating the 
> remaining capacity for a CFS task. Now, the idea behind thermal 
> pressure is that, the maximum available capacity of a cpu is limited 
> due to a thermal event, so take it out of the remaining capacity of a 
> cpu for a CFS task (at-least to start with). If utilization for rt 
> task, dl task etc is calculated via PELT and the capacity constraint 
> due to thermal event calculated by another averaging algorithm, there 
> can be some mismatch in the "capacity stolen" calculations, right? 
> Isnt't it better to track all the events that can limit the capacity of 
> a cpu via one algorithm ?

So what unifies RT and DL utilization is that those are all direct task 
loads independent of external factors.

Thermal load is more of a complex physical property of the combination of 
various internal and external factors: the whole system workload running 
(not just that single task), the thermal topology of the hardware, 
external temperatures, the hardware's and the governor's policy regarding 
thermal loads, etc. etc.

So while obviously when effective capacity of a CPU is calculated then 
these will all be subtracted from the maximum capacity of the CPU, but I 
think the thermal load metric and the averaging itself is probably 
dissimilar enough to not be calculated via the PELT half-life for 
example.

For example a reasonable future property would be match the speed of 
decay in the averaging to the observed speed of decay via temperature 
sensors? Most temperature sensors do a certain amount of averaging 
themselves as well - and some platforms might not expose temperatures at 
all, only 'got thermally throttled' / 'running at full speed' kind of 
feedback.

Anyway, this doesn't really impact the concept, it's an implementational 
detail, and much of this could be resolved if the averaging code in 
pelt.c was librarized a bit - and that's really what you did there in a 
fashion, I just think it should probably be abstracted out more clearly. 
(I have no clear implementational suggestions right now, other than 'try 
and see how it works out - it might be a bad idea'.)

Thanks,

	Ingo
