Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3AC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5kUDPGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfAQGDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:03:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35301 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfAQGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:03:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so4292441pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLCch3I7PE6svC3w0vQLhPrZTpLsf/C1HXPIf6HKMoI=;
        b=i5kUDPGP2WFBaamSz0M4Avb7thCJ6wLTghQAMiT3ixrMR0oNCES2dW/ViW0KcCR/qr
         rqk6pN9pZDM7bpLdkf+55fXllk5xqa2x2+9FFGfEtl6ngBXuwTogMecKT+gWlZUIpX7V
         8mcYUiQUXZF4WoUWGdzvfGK/M39PzpeMlFs5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLCch3I7PE6svC3w0vQLhPrZTpLsf/C1HXPIf6HKMoI=;
        b=TeWrEus1TNnWToTFr9sQeUU6K+fcDJcqCTCWuJatDp1KN86oVQPuoNTPeexk4b1Iq2
         4POHYdG8vA5CS+8CYZUSuAAw0OLQNDw8PCn7Xqed8iTWmpQA4LYmAuOZa+9QYfM+B0p3
         Aj0y2yjaqPonpHfxTSFVuQ/x2djx43OznO8g2Fxlks/n9hWjSw4kYFuMq9bwGNt554OT
         5GSrIB9KVGjhbG35qZStM8SNE0uMql07c0n3Zg5fqP+OplEi9ZeItU7YVFKrilzAPApZ
         iqt/SlIC6/Nda/k8DDvhsBOckKIx3I62ct5+2aXeYMTBlQEEKrlAkVBpAcoFMos9mim3
         V4aQ==
X-Gm-Message-State: AJcUukdYP2q3Oe36rw5isowDdtJ3WWrOwcijpGOj/RdB3zQzi/DeC2li
        i7G0R4H9SQgg8u/7tnjCddJ6nQ==
X-Google-Smtp-Source: ALg8bN5R0xsCmLyoAAeEsPoEHHBO3QbWFUGyHLDWuYHYmxZbtoVbxtUyg7Z6c+lw81JU5FxWdIdZ+g==
X-Received: by 2002:a63:1321:: with SMTP id i33mr12475174pgl.380.1547704991167;
        Wed, 16 Jan 2019 22:03:11 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id u87sm1596719pfi.2.2019.01.16.22.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 22:03:10 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:33:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] [ALREADY QUEUED] cpufreq: qcom-hw: Move to
 device_initcall
Message-ID: <20190117060308.a72klvinblx64uuy@vireshk-i7>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <2ae45b9263f51a14a7f672f40da2193caf174971.1547458732.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae45b9263f51a14a7f672f40da2193caf174971.1547458732.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-19, 15:51, Amit Kucheria wrote:
> (Resent to allow people testing the series to test it easily)

Maybe just share your branch then, instead of sending this again ?

-- 
viresh
