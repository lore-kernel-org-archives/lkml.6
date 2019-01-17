Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699D520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc4Oc2Pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfAQTvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:51:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43042 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfAQTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:51:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so4885517pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6DS9RQTA+4Ktfge5ckQFdetrHudMskS10urd1IsirZ8=;
        b=Pc4Oc2Pp9s7Nw6BYVsl7aeTy466/3vMUF+RtahMFXcW8B+rWX6Pi1v6wJYQ1KdwMzL
         BRcN+uubDtfqyUwxfPyOGwcjcugA015JpSvKVSkIbdp5CDQmpyWjGacMCwiWyGY6+ZLw
         nIna4elN/BRqkiH6nrQS+DL1DQ2QdqwQXO2jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6DS9RQTA+4Ktfge5ckQFdetrHudMskS10urd1IsirZ8=;
        b=JTSIMaLZNS+MfmgO+OAkBQq3rdlsLXCtI+Z+4oRkcXWywexWoPpv2lHiXGuUYUYQUX
         uWbXbUFltDaIm9tER7HQowmcld0Mwr8lSOaQNLgonl2Zatmh/s5cjEE/JpJZ1XMQgYoi
         XF+ArYP0u0NTHzKZFHvtrgb2+0YDewU/tetLFy9zNWEUE0yHT4nFhbrlfh1lZqjXhyih
         WFBDnmDIDMpPczbd8TzwCEs+ja6McJ4bX3eHC0VYUUt/LXkDNG6ZV+CChcjJ+7erViE5
         5nC4qBFI4w18FhgV5gNQWDS7BYzJS7bK3HcrlJ+uDMOTJWIW4RLp6Fblnf60MWzp64vN
         ecWg==
X-Gm-Message-State: AJcUukfPJD9/fLhfcKW7pJHJHd1/yeQ0lyg4veoxmM8FMQ8sLKebNhSv
        VIl0ITBiRYGvK1L5ZO9OYfHuaA==
X-Google-Smtp-Source: ALg8bN4yUaDo3Y1Qwr7QzVvI/i6OBW+8V9dF16/hOMTNEeu/jyDsdqx2yex9KgMtfY0hGMqSE6hzzQ==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr14500516pgd.305.1547754667432;
        Thu, 17 Jan 2019 11:51:07 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h8sm2517901pgv.27.2019.01.17.11.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 11:51:06 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:50:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
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
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190117195027.GA12955@builder>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190113072319.GB28907@builder>
 <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Jan 08:27 PST 2019, Sai Prakash Ranjan wrote:

> Hi Bjorn,
> 
> Thanks for the review. Please find my comments inline.
> 
> On 1/13/2019 12:53 PM, Bjorn Andersson wrote:
> > On Wed 09 Jan 09:46 PST 2019, Sai Prakash Ranjan wrote:
> > 
> > > Add coresight components found on Qualcomm SDM845 SoC.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > 
> > Hi Sai,
> > 
> > The content of this patch looks good, but please fold it into
> > sdm845.dtsi (keep the nodes sorted by address).
> > 
> 
> I had looked at the sample from hi6220 for coresight and
> decided to keep sdm845 coresight dtsi in separate file as it
> would look much cleaner than mixing it with main dtsi file.
> Also I guess it would make coresight topology more understandable
> if we keep it separately (plus there are about 400+ lines of coresight
> dt entries). Is there any reason for wanting coresight entries merged
> into sdm845.dtsi file? If you still prefer it, I can make the
> change in the next version.
> 

There seems to be some variations of this, but we try to keep everything
sorted in sdm845.dtsi to avoid having to jump around between the various
files. So please merge it into sdm845.dtsi (sorted by address).

Regards,
Bjorn

> > And mention below the --- that this depends on my AMBA bus pclk change
> > and include the URL:
> > 
> > https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> > 
> 
> I had mentioned this dependency in the cover letter. But I suppose
> I can mention it here as well.
> 
> Thanks,
> Sai
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
