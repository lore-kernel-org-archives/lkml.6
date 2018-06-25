Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D92C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0103F25700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4HVZBQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0103F25700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeFYJpr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:45:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34549 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFYJpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:45:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id y1-v6so231590pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TPbPev9gNiGgqm3rdjtPsPmNElKMSC2bmj+0MDLBRH0=;
        b=i4HVZBQg9nCwqcaOJy7DqkEnDq8PHg99oDLUvlkWfOls6oIdFZ9dgPnrhVrviX6WNV
         ZB59F8a97PCrp2euzCr1he1tBXdF/k6wcH4jHZlz6tCofdYkPCUaPJ2lkNECOiroor8O
         QPZ2mhuroHbo1+Aq6PxioLuul0bbnu4RFLWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPbPev9gNiGgqm3rdjtPsPmNElKMSC2bmj+0MDLBRH0=;
        b=gdburMJde7YBnHCljeiQ1HeXzw/oG0M5nwNMXmYlVZCRbf6W4nK5n74COZ1yyBVUjb
         wq1AaupAkD/G7rgvw8wpcPC5OwOWYqWVS5RA5dRUvDtvffF6txTTqhWInX22Iw2PU9qe
         fpy3lBU67ZU4V2OLlAPFceqJEC2Ce5o6Ew+wtS/fikW19WRw9r3OLzRdwQUByK5sxLVH
         qWr1sxV4dL8lz4KbQsfh7XENBGFChW4jkqs7hcV7hPR/LVC4EJcHovWNftR9KfQluECF
         YRerxmpVbWsZt3zXadbN5xL4iP3seJL0sITGCbZZ8fbf61qe4JpDfUbm2IHD5aC1b+Ok
         C01Q==
X-Gm-Message-State: APt69E3rveOELO7fOcjLv3HW6b7VtNRAxrpQy6W7/QBLgXe7FFbOd8Hr
        3t16Qc0UoBVry3a5gqGdoHAWhQ==
X-Google-Smtp-Source: ADUXVKILIVLU3H6KRCYX69Kjg1mzqzB5wMuHQd7Nc5IaYPaaJrunsdPiVUHhy77lqhR4H5Vedmzoeg==
X-Received: by 2002:a62:5c47:: with SMTP id q68-v6mr270025pfb.81.1529919942383;
        Mon, 25 Jun 2018 02:45:42 -0700 (PDT)
Received: from localhost ([122.172.108.70])
        by smtp.gmail.com with ESMTPSA id r188-v6sm27160339pgr.78.2018.06.25.02.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:45:41 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:15:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180625094539.7urkjlwddkcz64ve@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-18, 10:41, Rafael J. Wysocki wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> > +               if (per_cpu(idle_injection_device, cpu)) {
> > +                       pr_err("cpu%d is already registered\n", cpu);
> 
> If you print something like this, it should be clear what it is about
> and what piece of code it comes from as there will be no context
> around it it the log.

It should be good as we have this at the top.

#define pr_fmt(fmt) "ii_dev: " fmt


-- 
viresh
