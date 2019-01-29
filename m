Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23173C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E802921473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZoE2FPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfA2NgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:36:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44100 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfA2NgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so9337824plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qxi6QSw+j9dxu434FQ4Eohm/D/kYWlWKSoDoWJIFfSQ=;
        b=LZoE2FPmISmtfs+I7I9xm3NRRErollRnEo43E64ov7MSBLi2iBTAWKPHtpeDS4dOuQ
         noiK5ttdgOdd6OJFOBoPQDx5w8PLEQyhTCBLodiAPNRIxyd4achKz9PBUtrLQoH9amKm
         Vq60w2C0qg0T0LERlwpjLBbpOv7sOvs96dYkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qxi6QSw+j9dxu434FQ4Eohm/D/kYWlWKSoDoWJIFfSQ=;
        b=UOSlmzbQPg1VruYGy9M4VDhKO+8+rYWt5PHVZ6v8KBbMYCKOmLD8p/A8UacXEtbvKq
         OYKcTG5+l/WVF5mZIfmBGwfOiBrC2Qqps20UHOsXpSnLq+5fg/K8NxBIywjNgSVpLK4p
         NkYJ2iQhuRFBgcKFzAqMUi+eEBKE1b0uzvSm2a0fRFzmXRwFgEZsitOIVGK5FnILq52P
         WSy6MOsmVNwAJWZ6LrRm5Dvmu15WAtnGSBKKzrqqbGiHEx6yo6ZakXSJCHfoK1tYUr8g
         jUj49cTJcf6d6SkZp2eKrGHY5h3P8CzdPDE62pT0nWePb8+K/HqxU4wBs/bMGHbqJT+F
         ds1g==
X-Gm-Message-State: AJcUukdqZNeBE0s/bwHaZz7HnR+WHJCuqLcESPLL3zj6lbb/btnoCzM3
        1H+glMRsrZoZ2ad3wKEtckwX5g==
X-Google-Smtp-Source: ALg8bN6gSIamczhNwlqEy6ToE+aC3NqQ2fPU2pzlYAV8lmJdPBhb3vhtAlKujyVckazpUeMoMejsqw==
X-Received: by 2002:a17:902:b40d:: with SMTP id x13mr26412540plr.237.1548768973317;
        Tue, 29 Jan 2019 05:36:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id b7sm48660638pfa.52.2019.01.29.05.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:36:12 -0800 (PST)
Date:   Tue, 29 Jan 2019 21:36:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
Message-ID: <20190129133605.GB16669@leoy-ThinkPad-X240s>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190129132528.GA16669@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129132528.GA16669@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:25:28PM +0800, Leo Yan wrote:
> On Tue, Jan 29, 2019 at 12:44:03AM +0530, Sai Prakash Ranjan wrote:
> > Add UCI table and a helper macro for coresight CPU debug
> > module. This patch adds the UCI entries for Krypo CPUs
> > found on MSM8996 which shares the same PIDs as ETMs.
> > 
> > Without this, below error is observed on MSM8996:
> > 
> > [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> > [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> > [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> > [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> > [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> > [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> > [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> > [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> > [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> > [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> > [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> > [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
> > 
> > Also add a helper macro to make adding CPU PIDs easier
> > similar to ETM4X driver.
> > 
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Looks good to me and tested on my Hikey board (though I cannot test
> for a device with UCI ID):
> 
> Reviewed-and-tested-by: Leo Yan <leo.yan@linaro.org>

I just now found if apply this patch onto coresight next branch [1],
it will conflict with patch 'coresight: cpu-debug: Support for CA73
CPUs' [2].  Sorry if introduce regression by this.

Hi Mathieu, could you confirm should apply this patch onto to coresight
next branch?

[...]

Thanks,
Leo Yan

[1] https://git.linaro.org/kernel/coresight.git/log/?h=next
[2] https://git.linaro.org/kernel/coresight.git/commit/?h=next&id=14420b405d03cd160b5ace283693ce5b1cf273fa
