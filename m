Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7537CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459BE214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TICZge8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfBDI4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:56:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43134 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfBDI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:56:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so6439962pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 00:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZITswq+PZl+hT+AkV8ny0CAP70RkixQzrLExqBTeci0=;
        b=TICZge8ZZduMG+vyghNTMTR69k9rIKkDtmk72ZNtO1EEZJGr+cKTHLX6dq+usNOaZg
         KLcq1YKhXh6z2+wJy/CghiI9nx+OZv1CegSMO45ZNbOtXtQu/TK+ARzO7ORIZecvLmqq
         t6+++JT9uRZhQmhI6nk6seMSNCEf4lqmcSQR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZITswq+PZl+hT+AkV8ny0CAP70RkixQzrLExqBTeci0=;
        b=FMOV7+aGuu8tAE0eKyV1WYrt/BWPSnxxsRKMzfi+6dbutHgJpKNqFBomVu43nrElqa
         FzXhzao0SeZoCAPk5GXK3EtlsRuwO3mZ1aKM1afEfpWBYN0FDACSuCa3sxleQXR9WIJz
         p9FHH7t+3SQ3TKYf0uAAv/aLAPFHwLezmqCrJoAhYHLjgHmcuvT/skU02abFp64XQdEJ
         U7wwt0GGiLBsTx65Y1eVLFSZ9XZaSxx/lateNqxTh1+c+BqDu0kp9V3v7Cl+8JndRtTj
         fFtpvebwTplfwky3JBDw85tqtrqe7HLwoWLtPPffSdVasijEiHUs5zN+GLp/2d7J2J0Q
         DkbQ==
X-Gm-Message-State: AHQUAuZry5lpWZ/ba89bUxS/N6H32DEYUdjnKX8BiZupY8rVzAe613mY
        K0WuwHzV1PxZcdxQ8i/cdod3rg==
X-Google-Smtp-Source: AHgI3IaaGOTkz7mqDjIp5GgBb6N+vK2Q7FiSXm00PQ9vnjiLsB/nsZSvF2JG1+tUUpUVXb+0DxBq8w==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr11703285pgc.366.1549270571076;
        Mon, 04 Feb 2019 00:56:11 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b4sm8446230pgq.57.2019.02.04.00.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 00:56:09 -0800 (PST)
Date:   Mon, 4 Feb 2019 14:26:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, rjw@rjwysocki.net,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: tegra124: add missing of_node_put()
Message-ID: <20190204085607.7uax2zt7jve445cz@vireshk-i7>
References: <20190204074854.1538-1-tiny.windzz@gmail.com>
 <20190204081856.GD19087@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204081856.GD19087@ulmo>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-19, 09:18, Thierry Reding wrote:
> On Mon, Feb 04, 2019 at 02:48:54AM -0500, Yangtao Li wrote:
> > of_cpu_device_node_get() will increase the refcount of device_node,
> > it is necessary to call of_node_put() at the end to release the
> > refcount.
> > 
> > Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> > Cc: <stable@vger.kernel.org> # 4.4+
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > v2:
> > - move of_node_put() to the very end
> > ---
> >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>


Applied. Thanks.

-- 
viresh
