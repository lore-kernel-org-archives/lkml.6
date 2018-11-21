Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BC22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsyye0PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BC22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKUP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:56:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39970 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeKUP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:56:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so3726638pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ctP0ZBSoxyr2kkgc9TV+y1f2DaOQ78Hgz26J7km817w=;
        b=dsyye0PMYRtntBuiDrX0Mg8zosiYpt+JyuOrIXl+V6MVvaaD+QYFquBkbXtF+zmG2k
         a6KRqzEGWaBav9cHh5YfDJ7VTCxaFZxJKgSMhDhpnlojR7F0wdMTzbRn5ib4JpKpRouD
         stshEu+dOgb1OmkjG39e5D6ornDp5ogkh/mn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ctP0ZBSoxyr2kkgc9TV+y1f2DaOQ78Hgz26J7km817w=;
        b=groYJb5lsjQeIkOvHRIbAOlutogh0qQEW4Ryv2gVjATsaC+R8xAGiXeNXjjckmvr9a
         SWP4g0KU9Vf66l6WElTefdfATU3UgLZaSrA2Iri2RdRznvVdGAnL3vtjFidNxDzbxzAt
         oItM4hRSqn5tagE8I4xpabUm8b1B/Ejbu07xcAo26odN/enbngMaaqD1om7s+9cvHoZ7
         SsqAbUplh/71hsGeu8g0XsBnCqtq0rNEr15VVX7KMj8FEPivgSYY2xasohE22YQ1k6kS
         CsM9RXQIIO+CnzDZf9x5WB1c8TCseD3XS2Q1ohHlrI59mwyBiL+km5FwvR/S1Nb2kxUz
         YDSg==
X-Gm-Message-State: AA+aEWbNy7kAk5psUKFkc/d4D39COdPNzf6x8cyDIpAN4Hmk855ZN1CQ
        Pb5znIuAzWoEvoeZTVKB32XElw==
X-Google-Smtp-Source: AFSGD/V5Ih6i/hxmfXYix1OM/GCAacyagWUGJno5ffVupipzdifAPaQnx7BrroNl5xG+CZO73I0j/w==
X-Received: by 2002:a63:df13:: with SMTP id u19mr4680613pgg.294.1542777801121;
        Tue, 20 Nov 2018 21:23:21 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id b62-v6sm52891682pfa.159.2018.11.20.21.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:23:20 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:53:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Message-ID: <20181121052318.ctenjncvdtvneynl@vireshk-i7>
References: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 05:08, Anson Huang wrote:
> +static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
> +{
> +	cpufreq_cooling_unregister(data->cdev);
> +	cpufreq_cpu_put(data->policy);
> +}
> +#else
> +static inline int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
> +{
> +	return 0;
> +}

And now that you are going to send V5, please add a blank line before
and after #else here.

-- 
viresh
