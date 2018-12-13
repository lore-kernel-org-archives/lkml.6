Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6786B20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp6jCjzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6786B20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeLMGiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38035 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeLMGix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so570353pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y2kHRCe58c9v46VIIcMa9fm4dQXvC8hNN00ujy31Qaw=;
        b=Pp6jCjzSOVArDoqkbLaWwwgOxbGhlp4LFZpghBSlTWS1qwpEZl3GiARupGL20HK4y6
         aSlS3p0+z6jSzVlQ82f9m8BaqX3UUo7vvIjd56dk5efmTzJdIfqHtU4t5F2TsLi9BiRg
         w565YsTqR9Z8Ozx0GL4yVG1vNwo1y/oCRcHg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2kHRCe58c9v46VIIcMa9fm4dQXvC8hNN00ujy31Qaw=;
        b=FdRXSnVsvlj7sxvt9WAsSeo/dMBUJKHv7+eAPJxy4ymTZSMvK/vIJLPbVmKezIHwMY
         2jLlNGgwFwDaX0i9zXVUwKiAKLtIAxYYJtUQA2slo4qKDwhaTGHO0tnpAnp42kaqu0Q0
         6sxkBSzqkBRD+tzLalSqbxBkR/QVGfElbgtZIsXAsSy2SWbYzqFyMXWhIIC+qcdgyhlt
         0oMl/xdi7LeT3JgLxRPdGBW8XHirUkH2MlkMsK/pa4vrKvdLTwCenDloPx2PUQVWnST7
         85Mxp0VDLJPIByLhNxRQQvQc6vS7foGTcKABqk0aC8+l883a1Ea7fH7+yfBYKW9j8DlA
         JtcQ==
X-Gm-Message-State: AA+aEWZy+wfcD+Q2JseIot9EEbYhy94+wvr+1DC7D4yIqBNaGCObadXA
        TpzT8WjSyRIOd1vSEELKXfpHbw==
X-Google-Smtp-Source: AFSGD/XOQuL/1A9Y4B3GFM15NdVwmsJ6P6av5X7hZyZH4lCR7UALhXSTine+KSFQh0rLj+I60Xz9wQ==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr20522058pgi.8.1544683133055;
        Wed, 12 Dec 2018 22:38:53 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id w185sm1188877pfb.135.2018.12.12.22.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 22:38:51 -0800 (PST)
Date:   Thu, 13 Dec 2018 12:08:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Fan <nick.fan@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Message-ID: <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544445372.3502.42.camel@mtksdaap41>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-18, 20:36, Nick Fan wrote:
> For the users who only use one supply, they can use
> dev_pm_opp_get_voltage to get the voltage data from an opp.
> But if the users who use more than one supply, they will need this API
> to get their voltage data from OPP.
> The users should know about the supply count while creating opp table by
> using dev_pm_opp_set_regulators function.
> By using this API, the users can get the voltages by using index to
> specify which supplies they want.
> 
> The following is a simple example to get multiple regulators by this
> API.
> for (i = 0; i < regulator_num; i++)
> 	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);

Fair enough. I couldn't find anything wrong with the patch. Will it be
possible to send this patch as part of a series which uses the new API
? So that we are sure of somebody using it eventually.

-- 
viresh
