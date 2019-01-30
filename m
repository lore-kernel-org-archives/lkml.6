Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80412C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423BB20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlP5kjTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfA3F14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:27:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34136 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfA3F14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:27:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so10551473plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7Tb2eMDUcedcm8UHdt5wKVRrqj7a3CTmiIevFZzDaI=;
        b=DlP5kjTUU8/0AM2zwKtHHnlvguViPwWOuy39NnanzgMuF+eiJu8p13/q388zMiFOmx
         O/MjYBl7dh+rfoyjtksEA1V2LBOLxpgwCfBBaDzs6ZbJdV0nmze2o7RYrRbrVauq8pOw
         3f2Y5zlEEWo5+XB2ArCUAWAmaP8Jx497QLAV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7Tb2eMDUcedcm8UHdt5wKVRrqj7a3CTmiIevFZzDaI=;
        b=AhmKYQtcLcDV3js73vFTmQxtRt0VAR1n8CFvBpuN5PR9vdCf8VFE11dIAU50Ha0LJG
         MDTAtrAo7cmfacPFnnTA+MYCkoukQZRhKDy8/5RRzj+tkbselHMKWHJafkw2DJ6c6oxQ
         uFq9/5ZJvXeLeUfZH0xDP0VWEwXtW/E+YBKwuGuRq8zdLI/bg4/Ksn5aLdwlpmfYLfZN
         mW7hDsGRJEQNJE6VlQQ/ClRKe1vgn+SCEije7HgZY7jyw/NrDC6B6f1lMV5ipxX7LsI8
         pf/lGQNHqgWN76xTt4/PX30on5JdxGKkizSeDjEGdACH41WU7VF3Ip/pmvAwA2vxFkG5
         VgRg==
X-Gm-Message-State: AJcUukficO+grP4CpF2GN+VRKgHDUhmg+4ZPvNsmTxCgmG/u6nhS4Wie
        RHKHL4itDS+vFfycSLrZC5OvHA==
X-Google-Smtp-Source: ALg8bN7j+KJxxXT3zNAPsMgKYkgAlZMtWKTeiyxiRG0ZSHCWphQBb8cBBXTdGElk13EgPpXnpXkZ+g==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr28538881plk.40.1548826075731;
        Tue, 29 Jan 2019 21:27:55 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 24sm1857730pfl.32.2019.01.29.21.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 21:27:54 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:57:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com" 
        <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Juri Lelli <juri.lelli@gmail.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Message-ID: <20190130052752.v2zujifnkm3o7krf@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain>
 <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
 <20190118123900.GJ14385@localhost.localdomain>
 <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
 <CA+mqd+7EqERei8eekAsVxa_bJUYETyO3T76L8Q_sV=C9rwiy3g@mail.gmail.com>
 <20190128140441.yetyx7hgtdoyk4mn@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128140441.yetyx7hgtdoyk4mn@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 14:04, Qais Yousef wrote:
> But we have no way to enforce this, no? I'm thinking if frequency can be
> constrained in PM QoS framework, then we will end up with some drivers that
> think it's a good idea to use it and potentially end up breaking this "should
> not work against schedutil and similar".
> 
> Or did I miss something?
> 
> My point is that if we introduce something too generic we might end up
> encouraging more users and end up with a complex set of rules/interactions and
> lose some determinism. But I could be reading too much into it :-)

People are free to use notifiers today as well and there is nobody
stopping them. A new framework/layer may actually make them more
accountable as we can easily record which all entities have requested
to impose a freq-limit on CPUs.

-- 
viresh
