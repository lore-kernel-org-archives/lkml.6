Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B559C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D27520857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdWcz4Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D27520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeKHP1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:27:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35329 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:27:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so9019997plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 21:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7rdw6ENS7RfMp4BEmNrzEq9epXNfIReDvF0uMdN41s=;
        b=gdWcz4XqLFtUKTSot1Y9Vjf8CfupRQkn1F5q5iC3nSZZXSegke9LcjqcsmpOOMDWyB
         PnsXScxHAUxAIlV3rT/51SdSMx7Tozc3jlS/ZyNJAf+xwbg9fgWdyjsndHe1evWUu2WS
         ENd0Etfazd15tdvWdtw/ER9975MK04UovKyTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7rdw6ENS7RfMp4BEmNrzEq9epXNfIReDvF0uMdN41s=;
        b=EZ9ha08PVpbn0zFcibpoMSN9o0a3p10x8IINj6KilvNd4jYcXOQrE5SYxbytFRyJ1d
         y8lmwT54w8JH3HbgkkzxbNAsbFpk30taagpcQa1Tz9x35kPgNaAY+Q+Q06KLr69dR47C
         vVtB1c2IDn+sRJ04pYk9oRCGwp/lsj9zsc4wZrShESODBQT8b+fFsAm4Ceyj2OSew5lb
         79i9WzYQxXp3mf366Ai5kGJCZlGBRb3bqJiaM+Kum3Qzvdi8LH/dpCY1iUBrz5IwP4xF
         EJ7DDyMy84h5WQyKo9VW2hUNGsSuxbuQ2bd7nzUHOz163oKrhFtRvAeN07QhbX96wglz
         bNAw==
X-Gm-Message-State: AGRZ1gKW+u0lRKs2soPk+Dvnwobg0beuadeoYn2sj8CQUBmZ6NoAiktZ
        pf6W4XPmxvc96vi6TWszVDsTyA==
X-Google-Smtp-Source: AJdET5e0DQVhE2453Ej4bueWiAGKHwVdTBkbazlRt1hk8UyOrA8cfi9SBiQHMO6o94+kRsq0lF644A==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6-v6mr3295080plq.31.1541656444008;
        Wed, 07 Nov 2018 21:54:04 -0800 (PST)
Received: from localhost ([122.172.167.71])
        by smtp.gmail.com with ESMTPSA id i88-v6sm4659748pfi.66.2018.11.07.21.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 21:54:03 -0800 (PST)
Date:   Thu, 8 Nov 2018 11:24:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        d-gerlach@ti.com, t-kristo@ti.com
Subject: Re: [PATCH 1/2] opp: ti-opp-supply: Dynamically update u_volt_min
Message-ID: <20181108055401.btrixinlqcfh22du@vireshk-i7>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
 <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-18, 10:04, Keerthy wrote:
> The voltage range (min, max) provided in the device tree is from
> the data manual and is pretty big, catering to a wide range of devices.
> On a i2c read/write failure the regulator_set_voltage_triplet function
> falls back to set voltage between min and max. The min value from Device
> Tree can be lesser than the optimal value and in that case that can lead
> to a hang or crash. Hence set the u_volt_min dynamically to the optimal
> voltage value.

And why shouldn't we fix the DT for this ?

-- 
viresh
