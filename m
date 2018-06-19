Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF99DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C88B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTsCOrGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C88B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937365AbeFSJ7m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:59:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42721 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbeFSJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:59:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so9673157pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TAOibbleze+/LQDwj9BZ6f4OmyLBjl0h0AbHz31sXE=;
        b=MTsCOrGlM55Kt3Stt1BkXfKkAmqv3Vsu4QY+bSyL2AEZxqCaFWxQq202wTJIhx81DQ
         dxFoDjJqnQgQDa5gOciDRVACj4WlHi35PUJ+q2uzWqcyOHIcQV0Ft/z1HY5qUi6vLLS9
         kAbEEJFlpTdAd0i731Z/ul+XCkKvi77YMoM5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TAOibbleze+/LQDwj9BZ6f4OmyLBjl0h0AbHz31sXE=;
        b=tdmY9mq0khbHIXeuVajJ2g7rk2NjMx5I1Yo/nkcTcsxannDDtZoTIEIhFg+miIEqqG
         mGSe9hEH2hWHj1YEtjp20387eCd8/Egx5NkEgjxh1oOzrZ5vbjDVhellixIs8c9cZtoQ
         KjN2K873xQux/03t8XbRnVntAeIHk9UihIFCc07hNo8mzR/Zr8tqII5cwkGKf+hTzaEd
         j/woRo8GeARHMr1q+kdWpg88xSR5P5esSXvMGw6UT26+tZDjLBOQijmugzI9le2HQBo5
         I0zHt+xv/QahjPSKw4BcDun2FjLoAibNj6ZtXZVqiiyE1pWhquXUeth1N79c7lQIs8Ib
         pURg==
X-Gm-Message-State: APt69E0ihP8HZXgQjVy1O005sjJ5ybfLOTqrGmtrieSuGikMRWpj5C6v
        +7ah6axAPgz/hLkL+BxPj9ZrvQ==
X-Google-Smtp-Source: ADUXVKIvQfnq6yCagO126z8PzM5jMDz5I97dAu1x2srEAGQpjVMUAxr65S/Czbwuv1NbI1dWxSNSUg==
X-Received: by 2002:a63:b609:: with SMTP id j9-v6mr14390991pgf.335.1529402377948;
        Tue, 19 Jun 2018 02:59:37 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id h10-v6sm23874883pgc.28.2018.06.19.02.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 02:59:37 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:29:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: power: Add qcom rpmh power domain
 driver bindings
Message-ID: <20180619095935.ppcotralnwe3bb7p@vireshk-i7>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-6-rnayak@codeaurora.org>
 <ca7fd33a-5ecd-203e-4a83-09c4f1074c2e@codeaurora.org>
 <383ec081-d03b-5d71-3f28-9be31a3356d9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383ec081-d03b-5d71-3f28-9be31a3356d9@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-18, 11:56, Rajendra Nayak wrote:
> On 06/14/2018 03:42 AM, David Collins wrote:
> > Could you please add an example consumer DT node as well which uses
> > "SDM845 Power Domain Indexes" from qcom-rpmhpd.h?  It isn't clear how a
> > specific power domain (e.g. SDM845_CX) is specified from the consumer
> > side.  It also isn't clear how the consumer specifies a mapping for the
> > power domain levels that it will be using.
> 
> I can add an example consumer with a power-domains property pointing to
> the phandle and index (as is general practice)
> 
> For specifying the power domain levels, I am not quite sure what the approach
> we would use. One way is for consumers to use OPP bindings, but that wasn't
> liked by some and we now have plans to stuff it all within the clock driver code.

Even in that case the information should come from DT somehow. So the consumer
doesn't need an OPP table for itself, but it can/should have the "required-opps"
property which points to an entry in the genpd OPP table.

> In which case I expect we would just maintain internal mapping tables for clock
> frequencies/power domain levels so nothing comes in from DT, or maybe it will
> come in from DT, i just don't know.
> 
> I can certainly describe the OPP way a consumer could map to a power domain level,
> but I am not sure how the clock bindings if any would be at this point to handle this.

-- 
viresh
