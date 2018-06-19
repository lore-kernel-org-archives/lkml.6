Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70F8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6948A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLZGpnCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6948A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937571AbeFSKeH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:34:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37008 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937412AbeFSKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:34:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so9718088pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQIW3eYKYiZ4Ir/3cW1wLzjfpb0v0fa0D6xMM+r4BHo=;
        b=PLZGpnCO52DIeZPtC8pcsqWxiq6fSXUkg8UlA3ukXpJ50W4jkp3mLj7+KtJ7yCheJP
         TT7QsUqhC51Bv3qgOlsdh4db7llvIbJzBoZzOhozlkqlEJGsmdj41Du1v6H8adez2mQT
         C0rwlMEycsscTD+5HyvuMW7vlQ0CZImR45ecc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQIW3eYKYiZ4Ir/3cW1wLzjfpb0v0fa0D6xMM+r4BHo=;
        b=dSa7WaUX2rQTw3QcF2lngOrn/r5JMq86jq3H6zvzJXWFuG91Qpmps5hQ0s0nCLLFMH
         ut/tCB5J3k4jntWZxkfkgMcFqyeSn7xDShAx8BYRZTyAeVcbzqTHrChYFhCHJGvc9J2p
         LQrkuOnaW44fV4nqLkFQAFngLcWn9Ra2Yrle1jiTcl+v3hGe1a8bPOtR6a4uLFr1hQ+r
         ytqsnzxuXcJgNtnq6ZFltuyQUBHx6N1SUqSUxdtMmWuipyAo5ARj4atT8/38zSPpNUaH
         Jy6nnwhpcwFafWaa+WeaQboDC5qR9sMiAzJKryzVg2xs5h7JH48Z5gfAfb7ke01fGR9v
         bOMw==
X-Gm-Message-State: APt69E0rV5DauNk9sF1im0tPonDvI3d43rSbnvKsNuwVPQ7/8MQEnQll
        b7RRvL/JrqbjnaRWQS6QCGUamg==
X-Google-Smtp-Source: ADUXVKKNe0wzk6tOold+B80pZlmB3cQwtAdXcvK4GF39UZXy/l44/7Z8RjkAmr8WjHFOPIsM2ArY4A==
X-Received: by 2002:a62:d653:: with SMTP id r80-v6mr17554077pfg.54.1529404444191;
        Tue, 19 Jun 2018 03:34:04 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id h78-v6sm35476839pfh.141.2018.06.19.03.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 03:34:03 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:04:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180619103401.s3grdcm2hq6kx2pm@vireshk-i7>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
 <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
 <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
 <20180619085407.nmos7tix77vnaqre@vireshk-i7>
 <82d0646e-8dd7-43ba-6b5d-b772e57e865d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d0646e-8dd7-43ba-6b5d-b772e57e865d@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 15:55, Taniya Das wrote:
> Yes, Viresh, earlier code was updating the table frequency as I was marking
> the table frequency INVALID.
> 	if (core_count != c->max_cores)	
> 		c->table[i].frequency = CPUFREQ_ENTRY_INVALID;	
> 
> And thus I had to update the table frequency.
> 
> But now I have used the cur_freq instead and the table frequency is not
> touched.
> 	if (core_count != c->max_cores)
> 		cur_freq = CPUFREQ_ENTRY_INVALID;

Unless I am reading your versions incorrectly, they behave differently.

Until V2, if core_count wasn't equal to max_cores then the frequency was getting
marked as INVALID straight away in the table itself. Now if the next freq is
also same then you abort and overwrite the previous one as valid, but otherwise
it remains INVALID for ever. And this last thing doesn't happen anymore.

So if in your table there are few frequency entries which aren't repeating, but
the core_count != max_cores for some of them, they remain valid in the newer
versions.

-- 
viresh
