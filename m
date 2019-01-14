Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC298C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx7GtVQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfANPfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:35:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40348 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfANPfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:35:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so10305446plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zv//+Tp0QCDUNk5kZM/nH1I5nH8DrgiobvosD6lRqE0=;
        b=Jx7GtVQgEtZ+9z59B6ny0qeLFx4O2vSlGJwzrpZvxfjdk4JW2BacKzOWdLVvljFnGz
         PkhMBguHPazdl+IBe8I/Wa+4KG47mKE5h11hrYuY1s4dtl0MrwkZJaJwiZLT7YgZV6PP
         HXOv4IZyX7siAHJb5MbVh9tmNDtVuHgWYhY48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zv//+Tp0QCDUNk5kZM/nH1I5nH8DrgiobvosD6lRqE0=;
        b=gr5Ic4ckeuov6eF7F2P8uj/8p0oGgr5Kx4BiKhXia3HAfZW7LOn1ukMKOOPUPzpOJX
         8VKauxYdUxaQp3725oIvQP8fAsiNKeUyEHOGwCf2U/mk62q4kq1spS9uisFoZP82QgIV
         P6ACRQNL+6yWmeUy0/k17l2S0uwuvCDWtqkKK+Z9Xl4wGVj5ykVlRtZQumTQYi5YLDk2
         jPFPr3kHbnWviV8wIwqX+I2QoDe3SS7K7OtRabK7qzOGLVMLSXp9qnqGaMm929N0aZiD
         vn6Dkj717oxxXwp9fr1EscKAgNKvddVPe7kPB+1Jl/RfhdFEbPhhc0H3W4tq+U0tYIcq
         OnKA==
X-Gm-Message-State: AJcUukfVEUX1f4QDgeCD4gwweXCoP062kKkOuPXagdEyykHInBTelNJk
        VdWeVJ2Q/tgM8Bp2Cc3UeK/jFA==
X-Google-Smtp-Source: ALg8bN6p1W/cKb94//sk7nCpmvlfkO65K9GW0nmiT0qOw473oCKUNGk3rBn9Z1ky5F0CplZvGqyJDQ==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr26069590plg.61.1547480113152;
        Mon, 14 Jan 2019 07:35:13 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k186sm958664pge.13.2019.01.14.07.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 07:35:12 -0800 (PST)
Date:   Mon, 14 Jan 2019 08:35:09 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     saiprakash.ranjan@codeaurora.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190114153509.GA29374@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111184643.GA22691@xps15>
 <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 06:21:00PM +0530, saiprakash.ranjan@codeaurora.org wrote:
> Hi Mathieu,
> 
> > > +
> > > +	etm@7040000 {
> > > +		compatible = "arm,coresight-etm4x", "arm,primecell";
> > > +		arm,primecell-periphid = <0x000bb95d>;
> > 
> > I'm a little curious as to why you need to bypass the normal AMBA bus
> > discovery
> > method by forcing the peripheral ID.  Tracers don't show up the way
> > other
> > coresight devices do at boot time?
> > 
> 
> Yes on some Qcom SoC's like SDM845 and also on some previous ones, for
> ETM(only) amba bus discovery method fails because of wrong pid read from the
> registers. So we have to force this primecell peripheral ids to probe etm.

Ok, if that is the case please add a comment to explain the situation.
Otherwise someone will assuredly ask again in the future.

Mathieu


> 
> - Sai
> 
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> Code Aurora Forum, hosted by The Linux Foundation
