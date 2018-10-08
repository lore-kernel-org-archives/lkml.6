Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3530C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAD320841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXMVi+hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAD320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJHRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:50:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32968 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeJHRuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:50:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so17391506ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmiqbgmK8EoYLj3SeauyZcH1JT3W5g9WcpTVgRMc4Lc=;
        b=UXMVi+hxGC4MTMChSHQx3Me4yJB8von6sN919P9vvWgl7UEjZrI6KVYrC0qJcgn29B
         zLW8Qe5aX1Fci6D85JJ0Kmhc+P/mr5l3IZQJdpZXCQZaelQCYAmbJqkIoWNzqi67X0No
         eunEmmzmfKsH809l730ap/fNsVqMi+1AKrvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmiqbgmK8EoYLj3SeauyZcH1JT3W5g9WcpTVgRMc4Lc=;
        b=qM+3jsC3E1DM/SUkyQIal15PbOxkn33qR35iMQ90R3hoQf2OyAp//blKxb4cZhacCx
         9o3iVtl2oEujCRaAggYIUojkDm6xd4Iwii/KCf854G0FIzCkrdKtkx3Yel42uEetfp1h
         lPlt5GSypLzPbVii38p+6DBl2sI+4+TRzcWGf9hgdcUxDmgefPdD5qdMFx/y650kLNeK
         TBNWkZNgJqeXluaGyy4zDK3qf4UZNL6aIPi4iRkunUj/Yg5y63WvI1rB/Sxp0eeiN51i
         7c9/TMT6linEakjC4aLaw4706FpgvtObhnCHM4Xb2hlYR3D37sym4z762/6XsXFh0UEU
         WH+g==
X-Gm-Message-State: ABuFfohwj+JfbTXYfo0dLEoyYmVPLD6KobPXH54NwgUz3CdDC36SS6Bv
        6W9ygCD2PJwS19x51jtv7Goj/Q==
X-Google-Smtp-Source: ACcGV60MX9w0w5zN+rbsP02/KH7IQVA3ENinwrGbevJsLOki38E3T1OxY5uFUf1lPH/aoJmxHr+slw==
X-Received: by 2002:a2e:1b15:: with SMTP id b21-v6mr12369042ljb.104.1538995139411;
        Mon, 08 Oct 2018 03:38:59 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 4-v6sm3559907lfp.87.2018.10.08.03.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 03:38:58 -0700 (PDT)
Date:   Mon, 8 Oct 2018 12:38:56 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20181008103856.GA10890@centauri.lan>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181008084012.GA23693@centauri.lan>
 <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:29:52PM +0530, Viresh Kumar wrote:
> On 08-10-18, 10:40, Niklas Cassel wrote:
> > > +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> > > +				"#freq-domain-cells", 0, &args);
> > 
> > Hello Taniya,
> > 
> > in your DT binding, you use
> > 
> > #freq-domains-cells = <1>
> > 
> > Yet here you parse for "#freq-domain-cells".
> 
> And what is the problem with that ? Or are you suggesting her to call
> of_parse_phandle_with_fixed_args() ?

Hello Viresh,

#freq-domain-cells != #freq-domains-cells

The code should parse for the exact same property name as stated in the
DT binding.

Kind regards,
Niklas
