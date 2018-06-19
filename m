Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E19C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3172075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3172075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757134AbeFSJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:47:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41390 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757105AbeFSJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:47:19 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so19827791wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOqdzx8JvKt04nMMfEEg7WjmjaALe+bxCwuJYwj1Mko=;
        b=Ug2bnlYsvKgThDbYls7JiIaObSPhE3OFQJHlxX4EHChAQOG1vCAzcCsQtutVhshktl
         VBI+BYUrzGw5cMTqCSOl+CplWWYQ5ZJ7tvAeiYhjDSReWoIp/Ety9b6QZ4Yx8sDyDR+U
         WezJg0BhZpPEwVZzgDA0r1npjYO7jsZZ5MlvZ9AT9UGpi05jaGPRo+gfjfL3c0tikWur
         auWgd69vkRjxzDioWUPkXpiYg10R/UQdRqXhyh/IHLWB+Eu89Yld53cQmH/3zQgMiAl4
         RIWBzqOTO1yc7ofs0RqwrMM05KyvNB87u06qPVBaBpYh7FqAf72XdrbeFruXIJU4YXjs
         chrQ==
X-Gm-Message-State: APt69E3EAhRJ9gAutbJYGijsMC7Y5qhBarjJmoJEK3vpXfTakCQfhwvi
        b7v2o/wZLUFsbqQp3MgRo80AEA==
X-Google-Smtp-Source: ADUXVKKpul+832MaW3YzMT7OhjZpyLx4XmESj1HCm6xN/VWQdZ3QnZaAm4+MyAuD4QlKHgsGG7Sgxw==
X-Received: by 2002:adf:9dc9:: with SMTP id q9-v6mr13944993wre.12.1529401637946;
        Tue, 19 Jun 2018 02:47:17 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id n17-v6sm16650203wrs.96.2018.06.19.02.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 02:47:17 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:47:14 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Message-ID: <20180619094714.GA13617@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
 <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 10:40, Quentin Perret wrote:
> Hi Pavan,
> 
> On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:

[...]

> > There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> > Should we worry about it? I don't know what is the usecase for changing the
> > cpu_scale from user space.
> 
> This is something I've been wondering as well. TBH, I'm not sure what to
> do in this case. And I'm not sure to know what is the use-case either.
> Debugging purpose I assume ?
> 
> Juri, did you have a specific use-case for this feature when the
> arch_topology driver was first introduced ? Or was it just to align
> with the existing arm/arm64 code ?

It was requested (IIRC) because DT might have bogus values and not be
easily modifiable. So, this is another way to get things right for your
platform at runtime.
